Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F916C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0564624D62
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0564624D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933851AbeF2RmI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:42:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752934AbeF2RmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4A44818594D;
        Fri, 29 Jun 2018 17:42:05 +0000 (UTC)
Received: from redhat.com (ovpn-120-120.rdu2.redhat.com [10.10.120.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id A06B91D089;
        Fri, 29 Jun 2018 17:42:02 +0000 (UTC)
Date:   Fri, 29 Jun 2018 20:42:02 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
        Peter Maydel <peter.maydell@linaro.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 01/20] virtio: mmio-v1: Validate queue PFN
Message-ID: <20180629200816-mutt-send-email-mst@kernel.org>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 17:42:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 17:42:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:15:21PM +0100, Suzuki K Poulose wrote:
> virtio-mmio with virtio-v1 uses a 32bit PFN for the queue.
> If the queue pfn is too large to fit in 32bits, which
> we could hit on arm64 systems with 52bit physical addresses
> (even with 64K page size), we simply miss out a proper link
> to the other side of the queue.
> 
> Add a check to validate the PFN, rather than silently breaking
> the devices.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Peter Maydel <peter.maydell@linaro.org>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Change errno to -E2BIG
> ---
>  drivers/virtio/virtio_mmio.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 67763d3..82cedc8 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -397,9 +397,21 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	/* Activate the queue */
>  	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
>  	if (vm_dev->version == 1) {
> +		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
> +
> +		/*
> +		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
> +		 * that doesn't fit in 32bit, fail the setup rather than
> +		 * pretending to be successful.
> +		 */
> +		if (q_pfn >> 32) {
> +			dev_err(&vdev->dev, "virtio-mmio: queue address too large\n");

How about:
	"hypervisor bug: legacy virtio-mmio must not be used with more than 0x%llx Gigabytes of memory",
	0x1ULL << (32 - 30) << PAGE_SHIFT

> +			err = -E2BIG;
> +			goto error_bad_pfn;
> +		}
> +
>  		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> -		writel(virtqueue_get_desc_addr(vq) >> PAGE_SHIFT,
> -				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
>  	} else {
>  		u64 addr;
>  
> @@ -430,6 +442,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	return vq;
>  
> +error_bad_pfn:
> +	vring_del_virtqueue(vq);
>  error_new_virtqueue:
>  	if (vm_dev->version == 1) {
>  		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> -- 
> 2.7.4
