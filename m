Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCFDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD492082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD492082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLGSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:01:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLGSBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14DA8309E978;
        Fri,  7 Dec 2018 18:01:46 +0000 (UTC)
Received: from redhat.com (ovpn-124-251.rdu2.redhat.com [10.10.124.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 31B355C1A1;
        Fri,  7 Dec 2018 18:01:45 +0000 (UTC)
Date:   Fri, 7 Dec 2018 13:01:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com
Subject: Re: [PATCH 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
Message-ID: <20181207125951-mutt-send-email-mst@kernel.org>
References: <1544168081-13205-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544168081-13205-1-git-send-email-dongli.zhang@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 07 Dec 2018 18:01:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:34:41PM +0800, Dongli Zhang wrote:
> VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/virtio/virtio_pci_legacy.c | 6 ++++--
>  include/uapi/linux/virtio_pci.h    | 2 --
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index de062fb..eff9ddc 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -52,7 +52,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	void __iomem *ioaddr = vp_dev->ioaddr +
> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
> +			offset;
>  	u8 *ptr = buf;
>  	int i;
>  
> @@ -67,7 +68,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	void __iomem *ioaddr = vp_dev->ioaddr +
> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
> +			offset;
>  	const u8 *ptr = buf;
>  	int i;
>

I agree that VIRTIO_PCI_CONFIG_OFF is a better interface. So above looks
fine.
  
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 90007a1..2070232 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -78,8 +78,6 @@
>  /* The remaining space is defined by each driver as the per-driver
>   * configuration space */
>  #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
> -/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
> -#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
>  
>  /* Virtio ABI version, this must match exactly */
>  #define VIRTIO_PCI_ABI_VERSION		0

This might break some userspace builds, I don't see why we should bother
removing it. Any reason?


> -- 
> 2.7.4
