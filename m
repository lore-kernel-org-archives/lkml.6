Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A128C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCBF278D9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCBF278D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755146AbeF2Rmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:42:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753523AbeF2Rmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F32F7818594D;
        Fri, 29 Jun 2018 17:42:43 +0000 (UTC)
Received: from redhat.com (ovpn-120-120.rdu2.redhat.com [10.10.120.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 126FE1D084;
        Fri, 29 Jun 2018 17:42:41 +0000 (UTC)
Date:   Fri, 29 Jun 2018 20:42:40 +0300
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
Subject: Re: [PATCH v3 02/20] virtio: pci-legacy: Validate queue pfn
Message-ID: <20180629204213-mutt-send-email-mst@kernel.org>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-3-git-send-email-suzuki.poulose@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 17:42:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 17:42:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:15:22PM +0100, Suzuki K Poulose wrote:
> Legacy PCI over virtio uses a 32bit PFN for the queue. If the
> queue pfn is too large to fit in 32bits, which we could hit on
> arm64 systems with 52bit physical addresses (even with 64K page
> size), we simply miss out a proper link to the other side of
> the queue.
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
>  drivers/virtio/virtio_pci_legacy.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2780886..c0d6987a 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -122,6 +122,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	struct virtqueue *vq;
>  	u16 num;
>  	int err;
> +	u64 q_pfn;
>  
>  	/* Select the queue we're interested in */
>  	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> @@ -141,9 +142,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (!vq)
>  		return ERR_PTR(-ENOMEM);
>  
> +	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> +	if (q_pfn >> 32) {
> +		dev_err(&vp_dev->pci_dev->dev, "virtio-pci queue PFN too large\n");
> +		err = -E2BIG;

Same comment here. Let's make it clear it's host not guest problem.

> +		goto out_del_vq;
> +	}
> +
>  	/* activate the queue */
> -	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> -		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +	iowrite32(q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>  
>  	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
>  
> @@ -160,6 +167,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  
>  out_deactivate:
>  	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +out_del_vq:
>  	vring_del_virtqueue(vq);
>  	return ERR_PTR(err);
>  }
> -- 
> 2.7.4
