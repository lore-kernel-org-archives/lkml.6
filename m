Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD0A2457E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD0A2457E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeGDFX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:23:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751826AbeGDFX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5552840AC6DE;
        Wed,  4 Jul 2018 05:23:26 +0000 (UTC)
Received: from [10.72.12.45] (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB4562026D76;
        Wed,  4 Jul 2018 05:23:21 +0000 (UTC)
Subject: Re: [PATCH net-next 8/8] vhost: event suppression for packed ring
To:     Wei Xu <wexu@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-9-git-send-email-jasowang@redhat.com>
 <20180704041352.GA9287@wei-ubt>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <493c3a3e-e088-d6fb-1da4-cda8bfb34400@redhat.com>
Date:   Wed, 4 Jul 2018 13:23:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704041352.GA9287@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 05:23:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 05:23:26 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月04日 12:13, Wei Xu wrote:
> On Tue, Jul 03, 2018 at 01:38:04PM +0800, Jason Wang wrote:
>> This patch introduces support for event suppression. This is done by
>> have a two areas: device area and driver area. One side could then try
>> to disable or enable (delayed) notification from other side by using a
>> boolean hint or event index interface in the areas.
>>
>> For more information, please refer Virtio spec.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++----
>>   drivers/vhost/vhost.h |  10 ++-
>>   2 files changed, 185 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 0f3f07c..cccbc82 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1115,10 +1115,15 @@ static int vq_access_ok_packed(struct vhost_virtqueue *vq, unsigned int num,
>>   			       struct vring_used __user *used)
>>   {
>>   	struct vring_desc_packed *packed = (struct vring_desc_packed *)desc;
>> +	struct vring_packed_desc_event *driver_event =
>> +		(struct vring_packed_desc_event *)avail;
>> +	struct vring_packed_desc_event *device_event =
>> +		(struct vring_packed_desc_event *)used;
>>   
>> -	/* TODO: check device area and driver area */
>>   	return access_ok(VERIFY_READ, packed, num * sizeof(*packed)) &&
>> -	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed));
>> +	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed)) &&
> R/W parameter doesn't make sense to most architectures and the comment in x86
> says WRITE is a superset of READ, is it possible to converge them here?
>
> /**
>   * access_ok: - Checks if a user space pointer is valid
>   * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
>   *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
>   *        to write to a block, it is always safe to read from it.
>   * @addr: User space pointer to start of block to check
>   * @size: Size of block to check
>   *
>   * Context: User context only. This function may sleep if pagefaults are
>   *          enabled.
>   *
>   * Checks if a pointer to a block of memory in user space is valid.
>   *
>   * Returns true (nonzero) if the memory block may be valid, false (zero)
>   * if it is definitely invalid.
>   *
>   * Note that, depending on architecture, this function probably just
>   * checks that the pointer is in the user space range - after calling
>   * this function, memory access functions may still return -EFAULT.
>   */
> #define access_ok(type, addr, size)
> ......
>
> Thanks,
> Wei
>

Well, this is a question that beyond the scope of this patch.

My understanding is we should keep it unless type was meaningless on all 
archs.

Thanks

