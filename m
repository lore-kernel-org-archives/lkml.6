Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E279920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E279920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbeGXT6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388366AbeGXT6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD8E7C04F4D1;
        Tue, 24 Jul 2018 18:50:59 +0000 (UTC)
Received: from t450s.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28E8319487;
        Tue, 24 Jul 2018 18:50:57 +0000 (UTC)
Date:   Tue, 24 Jul 2018 12:50:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
 device
Message-ID: <20180724125056.4ae477c9@t450s.home>
In-Reply-To: <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
        <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 24 Jul 2018 18:51:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018 14:09:24 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This patch adds the support to get the iommu device for a mediated
> device. The assumption is that each mediated device is a minimal
> assignable set of a physical PCI device. Hence, we should use the
> iommu device of the parent PCI device to manage the translation.

Hmm, is this absolutely a valid assumption?  I'm afraid there's an
assumption throughout this series that the only way an mdev device
could be interacting with the IOMMU is via S-IOV, but we could choose
today to make an mdev wrapper for any device, which might provide basic
RID granularity to the IOMMU.  So if I make an mdev wrapper for a PF
such that I can implement migration for that device, is it valid for
the IOMMU driver to flag me as an mdev device and base mappings on my
parent device?  Perhaps in this patch we can assume that the parent of
such an mdev device would be the PF backing it and that results in the
correct drhd, but in the next patch we start imposing the assumption
that because the device is an mdev, the only valid association is via
pasid, which I'd say is incorrect.
 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |  6 ++++++
>  drivers/iommu/intel-pasid.h | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 7d198ea..fc3ac1c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  	if (iommu_dummy(dev))
>  		return NULL;
>  
> +	if (dev_is_mdev(dev)) {
> +		dev = dev_mdev_parent(dev);
> +		if (WARN_ON(!dev_is_pci(dev)))
> +			return NULL;
> +	}
> +
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pf_pdev;
>  
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 518df72..46cde66 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -35,6 +35,22 @@ struct pasid_table {
>  	struct list_head	dev;		/* device list */
>  };
>  
> +static inline bool dev_is_mdev(struct device *dev)
> +{
> +	if (!dev)
> +		return false;
> +
> +	return !strcmp(dev->bus->name, "mdev");
> +}

I assume we're not using mdev_bus_type because mdev is a loadable
module and that symbol doesn't exist in this statically loaded driver,
but strcmp is a pretty ugly alternative.  Could we use symbol_get() so
that we can use mdev_bus_type?  Thanks,

Alex

> +
> +static inline struct device *dev_mdev_parent(struct device *dev)
> +{
> +	if (WARN_ON(!dev_is_mdev(dev)))
> +		return NULL;
> +
> +	return dev->parent;
> +}
> +
>  extern u32 intel_pasid_max_id;
>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
>  void intel_pasid_free_id(int pasid);

