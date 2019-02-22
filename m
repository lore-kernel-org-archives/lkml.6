Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB546C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E4F2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgCPuXO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfBVOer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:34:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nJdkNYi/qi4NG5QxXzDCAGS+dYvtcSmIKJb7xje0Fh8=; b=XgCPuXO6IkJQjjOL7Zi4MWgHm
        qdRdfTwIwWz3x4Ihgyn+9Rl0a3kv/fMrXf8Ru9ndgDNvhuxZA32ctG3t8EQNRezrcDD1tWLydcKP6
        So2964wk8UogUlMoXv87IJ8gi3z6HZffNpsHb9IfDqZO7alWjIpzXyHPpGWkAiezSZ0WFoeWXcy3i
        aBK2nzrocpCZVAj75S0lrQvSCuiMVvO8tmSpaU0gzAqeXFMYosQhHXpWooB+Ufsv2Q76m16n8uiFn
        ok3Xv+oUNwwF0NWAb/Ppv4MXgPTMUwiutAKBjFd64ChiH902XZaFqzW/68Mh3LQqzoU8ayOFqWkQe
        eip+th8LA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxBuQ-0000VA-HQ; Fri, 22 Feb 2019 14:34:38 +0000
Date:   Fri, 22 Feb 2019 06:34:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/9] vfio/mdev: Add iommu related member in mdev_device
Message-ID: <20190222143438.GA31016@infradead.org>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:19:25AM +0800, Lu Baolu wrote:
> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in VT-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds a new member in the struct mdev_device to
> indicate that the mediated device represented by mdev could
> be isolated and protected by attaching a domain to a device
> represented by mdev->iommu_device. It also adds a helper to
> add or set the iommu device.
> 
> * mdev_device->iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation, hence bypass IOMMU.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  1 +
>  include/linux/mdev.h             | 14 ++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0ee8aea..9be58d392d2b 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);

As said before, please make all new mdev/vfio exports EXPORT_SYMBOL_GPL
to fit the other exports in vfio.
