Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46875C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C2924C67
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C2924C67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeGCIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:03:47 -0400
Received: from foss.arm.com ([217.140.101.70]:44904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754309AbeGCIDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:03:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B8718A;
        Tue,  3 Jul 2018 01:03:40 -0700 (PDT)
Received: from [10.37.8.137] (unknown [10.37.8.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05D13F5A0;
        Tue,  3 Jul 2018 01:03:36 -0700 (PDT)
Subject: Re: [PATCH v3 01/20] virtio: mmio-v1: Validate queue PFN
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
        Peter Maydel <peter.maydell@linaro.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
 <20180629200816-mutt-send-email-mst@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5124334c-b3c8-4c59-b652-d26ea1101807@arm.com>
Date:   Tue, 3 Jul 2018 09:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180629200816-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 06/29/2018 06:42 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 29, 2018 at 12:15:21PM +0100, Suzuki K Poulose wrote:
>> virtio-mmio with virtio-v1 uses a 32bit PFN for the queue.
>> If the queue pfn is too large to fit in 32bits, which
>> we could hit on arm64 systems with 52bit physical addresses
>> (even with 64K page size), we simply miss out a proper link
>> to the other side of the queue.
>>
>> Add a check to validate the PFN, rather than silently breaking
>> the devices.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydel <peter.maydell@linaro.org>
>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v2:
>>   - Change errno to -E2BIG
>> ---
>>   drivers/virtio/virtio_mmio.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 67763d3..82cedc8 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -397,9 +397,21 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>>   	/* Activate the queue */
>>   	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
>>   	if (vm_dev->version == 1) {
>> +		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
>> +
>> +		/*
>> +		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
>> +		 * that doesn't fit in 32bit, fail the setup rather than
>> +		 * pretending to be successful.
>> +		 */
>> +		if (q_pfn >> 32) {
>> +			dev_err(&vdev->dev, "virtio-mmio: queue address too large\n");
> 
> How about:
> 	"hypervisor bug: legacy virtio-mmio must not be used with more than 0x%llx Gigabytes of memory",
> 	0x1ULL << (32 - 30) << PAGE_SHIFT

nit : Do we need change "hypervisor" => "platform" ? Virtio is used by 
other tools (e.g, emulators) and not just virtual machines.

Suzuki
