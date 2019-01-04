Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62E42087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfADFJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:09:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:3862 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfADFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:09:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 21:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="112016898"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2019 21:09:00 -0800
Message-ID: <5C2EEBB3.3070109@intel.com>
Date:   Fri, 04 Jan 2019 13:14:27 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [virtio-dev] Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed
 implementation
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com> <1546493462-32244-2-git-send-email-wei.w.wang@intel.com> <20190103113228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190103113228-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 12:42 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 03, 2019 at 01:31:01PM +0800, Wei Wang wrote:
>> virtio-ccw has deadlock issues with reading config registers inside the
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 728ecd1..9a82a11 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
>>   {
>>   	struct virtio_balloon *vb = vdev->priv;
>>   	unsigned long flags;
>> -	s64 diff = towards_target(vb);
>> -
>> -	if (diff) {
>> -		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> -		if (!vb->stop_update)
>> -			queue_work(system_freezable_wq,
>> -				   &vb->update_balloon_size_work);
>> -		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> -	}
>>   
>> -	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> -		virtio_cread(vdev, struct virtio_balloon_config,
>> -			     free_page_report_cmd_id, &vb->cmd_id_received);
> There's one problem with this approach:
>
> previously updating the cmd_id_received here would immediately
> stop the report in send_free_pages.
>
> With this approach we are waiting for the wq to schedule,
> which might be blocked waiting for report to complete.
> So host can no longer quickly stop the report in progress.
>
> A simple work-around would be to set some kind of flag whenever there
> is a change interrupt, then have send_free_pages test it
> and re-read cmd_id_received.
>
> Needs to be an atomic I guess ...
>

Yes, sounds better..will update the patch.

Best,
Wei
