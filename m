Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC1CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86A2208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86A2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeGMJIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:08:44 -0400
Received: from foss.arm.com ([217.140.101.70]:59906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeGMJIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:08:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 611011682;
        Fri, 13 Jul 2018 01:55:02 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A9A3F5AD;
        Fri, 13 Jul 2018 01:54:58 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] virtio: pci-legacy: Validate queue pfn
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        cdall@kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, ard.biesheuvel@linaro.org,
        peter.maydell@linaro.org, kristina.martsenko@arm.com,
        mark.rutland@arm.com, Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-3-git-send-email-suzuki.poulose@arm.com>
 <20180327170823-mutt-send-email-mst@kernel.org>
 <20180713004545-mutt-send-email-mst@kernel.org>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0e475b0c-5c38-ef37-3c87-486f418c609e@arm.com>
Date:   Fri, 13 Jul 2018 09:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713004545-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/18 01:36, Michael S. Tsirkin wrote:
> On Tue, Mar 27, 2018 at 05:11:04PM +0300, Michael S. Tsirkin wrote:
>> On Tue, Mar 27, 2018 at 02:15:12PM +0100, Suzuki K Poulose wrote:
>>> Legacy PCI over virtio uses a 32bit PFN for the queue. If the
>>> queue pfn is too large to fit in 32bits, which we could hit on
>>> arm64 systems with 52bit physical addresses (even with 64K page
>>> size), we simply miss out a proper link to the other side of
>>> the queue.
>>>
>>> Add a check to validate the PFN, rather than silently breaking
>>> the devices.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <cdall@kernel.org>
>>> Cc: Peter Maydel <peter.maydell@linaro.org>
>>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/virtio/virtio_pci_legacy.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>>> index 2780886..4b84a75 100644
>>> --- a/drivers/virtio/virtio_pci_legacy.c
>>> +++ b/drivers/virtio/virtio_pci_legacy.c
>>> @@ -122,6 +122,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>>>   	struct virtqueue *vq;
>>>   	u16 num;
>>>   	int err;
>>> +	u64 q_pfn;
>>>   
>>>   	/* Select the queue we're interested in */
>>>   	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
>>> @@ -141,9 +142,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>>>   	if (!vq)
>>>   		return ERR_PTR(-ENOMEM);
>>>   
>>> +	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
>>> +	if (q_pfn >> 32) {
>>> +		dev_err(&vp_dev->pci_dev->dev, "virtio-pci queue PFN too large\n");
>>> +		err = -ENOMEM;
>>
>> ENOMEM seems wrong here. E2BIG?
>>
>>> +		goto out_del_vq;
>>> +	}
>>> +
>>>   	/* activate the queue */
>>> -	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
>>> -		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>>> +	iowrite32((u32)q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>>
>> Is the cast really necessary here?
>>
>>>   
>>>   	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
>>>   
>>> @@ -160,6 +167,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>>>   
>>>   out_deactivate:
>>>   	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>>> +out_del_vq:
>>>   	vring_del_virtqueue(vq);
>>>   	return ERR_PTR(err);
>>>   }
>>> -- 
>>> 2.7.4

Michael,

> 
> Ping are you going to address and repost, or should I drop this?

This was addressed and reposted as v3, which needs a minor update to the
error message as mentioned here [0]. I will post the fixed version today.

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/588398.html

Thanks
Suzuki
