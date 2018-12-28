Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A062208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeL1GgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:36:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:32082 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeL1GgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:36:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 22:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,408,1539673200"; 
   d="scan'208";a="131208853"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2018 22:36:20 -0800
Message-ID: <5C25C5A5.4080706@intel.com>
Date:   Fri, 28 Dec 2018 14:41:41 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org, dgilbert@redhat.com
CC:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com, quintela@redhat.com,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com> <0661b05a-d9d0-d374-44e8-2583463e94c2@de.ibm.com> <de167161-b586-6aee-d6a5-a90d47bbe1d4@de.ibm.com> <e79b5c3d-aa89-6b99-00b1-c92c85fe214c@de.ibm.com>
In-Reply-To: <e79b5c3d-aa89-6b99-00b1-c92c85fe214c@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/2018 08:17 PM, Christian Borntraeger wrote:
>
> On 27.12.2018 12:59, Christian Borntraeger wrote:
>> On 27.12.2018 12:31, Christian Borntraeger wrote:
>>> This patch triggers random crashes in the guest kernel on s390 early during boot.
>>> No migration and no setting of the balloon is involved.
>>>
>> Adding Conny and Halil,
>>
>> As the QEMU provides no PAGE_HINT feature yet, this quick hack makes the
>> guest boot fine again:
>>
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 728ecd1eea305..aa2e1864c5736 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -492,7 +492,7 @@ static int init_vqs(struct virtio_balloon *vb)
>>                  callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>>          }
>>   
>> -       err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>> +       err = vb->vdev->config->find_vqs(vb->vdev, 3, //VIRTIO_BALLOON_VQ_MAX,
>>                                           vqs, callbacks, names, NULL, NULL);
>>          if (err)
>>                  return err;
>>
>>
>> To me it looks like that virtio_ccw_find_vqs will abort if any of the virtqueues
>> that it is been asked for does not exist (including the earlier ones).
>>
> This "hack" makes the random crashes go away, but the balloon interface itself
> does not work. (setting the value to anything will hang the guest).
> As patch 1 also modifies the main path, there seem to be additional issues, maybe
> endianess
>
> Looking at things like
>
> +		vb->cmd_id_received = VIRTIO_BALLOON_CMD_ID_STOP;
> +		vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
> +						  VIRTIO_BALLOON_CMD_ID_STOP);
> +		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
> +						  VIRTIO_BALLOON_CMD_ID_STOP);
>
>
> Why is cmd_id_received not using cpu_to_virtio32?
>

That conversion is only needed when we need to send the value to the device.
cmd_id_received doesn't need to be sent to the device.

Best,
Wei


