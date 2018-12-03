Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1841CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4F22082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4F22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLCNpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:45:19 -0500
Received: from 8bytes.org ([81.169.241.247]:51232 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeLCNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:45:19 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4E013402; Mon,  3 Dec 2018 14:44:13 +0100 (CET)
Date:   Mon, 3 Dec 2018 14:44:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Message-ID: <20181203134411.lejlkbnagxml54ro@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128035449.10226-3-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Wed, Nov 28, 2018 at 11:54:39AM +0800, Lu Baolu wrote:
> @@ -2482,12 +2482,13 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev)
>  		dev->archdata.iommu = info;
>  
> -	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> +	/* PASID table is mandatory for a PCI device in scalable mode. */
> +	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {

This will also allocate a PASID table if the device does not support
PASIDs, right? Will the table not be used in that case or will the
device just use the fallback PASID? Isn't it better in that case to have
no PASID table?

> @@ -143,18 +143,20 @@ int intel_pasid_alloc_table(struct device *dev)
>  		return -ENOMEM;
>  	INIT_LIST_HEAD(&pasid_table->dev);
>  
> -	size = sizeof(struct pasid_entry);
> -	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
> -	order = get_order(size * count);
> +	if (info->pasid_supported)
> +		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
> +				  intel_pasid_max_id);
> +
> +	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> +	order = size ? get_order(size) : 0;
>  	pages = alloc_pages_node(info->iommu->node,
> -				 GFP_ATOMIC | __GFP_ZERO,
> -				 order);
> +				 GFP_ATOMIC | __GFP_ZERO, order);

This is a simple data structure allocation path, does it need
GFP_ATOMIC?



	Joerg

