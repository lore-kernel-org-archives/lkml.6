Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE28ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC74C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC74C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGWFoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:44:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:61609 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbeGWFoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:44:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 21:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="59832512"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2018 21:44:48 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:45 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:45 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0319.002;
 Mon, 23 Jul 2018 12:44:43 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC PATCH 05/10] iommu/vt-d: Setup DMA remapping for mediated
 devices
Thread-Topic: [RFC PATCH 05/10] iommu/vt-d: Setup DMA remapping for mediated
 devices
Thread-Index: AQHUIYLXd6EUPwZe6E6ie1ZTfkhsV6ScNSlQ
Date:   Mon, 23 Jul 2018 04:44:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA1449@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-6-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1532239773-15325-6-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGRiMTU5MDQtZDAzZC00OWFiLWI0ODYtMTZhYTM5Y2UzNDJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaG5xRXBYb3I3VzVPTURmYW1pSTF5NWVnNkx6cEw1NGdiSG56azhcL1BPZ21sZ0JpSTJZclBtdkgzbFhORllWZ24ifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Sunday, July 22, 2018 2:09 PM
> 
> This configures the second level page table when external components request to
> allocate a domain for a mediated device.

I think it should be the time when adding a mediate device to the domain.

> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 73
> ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 57ccfc4..b6e9ea8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2569,8 +2569,9 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev)
>  		dev->archdata.iommu = info;
> 
> -	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
> -		bool pass_through;
> +	if (dev && sm_supported(iommu)) {
> +		bool pass_through = hw_pass_through &&
> +				domain_type_is_si(domain);
> 
>  		ret = intel_pasid_alloc_table(dev);
>  		if (ret) {
> @@ -2579,12 +2580,21 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  			return NULL;
>  		}
> 
> -		/* Setup the PASID entry for requests without PASID: */
> -		pass_through = hw_pass_through && domain_type_is_si(domain);
>  		spin_lock(&iommu->lock);
> -		intel_pasid_setup_second_level(iommu, domain, dev,
> -					       PASID_RID2PASID,
> -					       pass_through);
> +
> +		/* Setup the PASID entry for requests without PASID: */
> +		if (dev_is_pci(dev))
> +			intel_pasid_setup_second_level(iommu, domain, dev,
> +						       PASID_RID2PASID,

can domain->default_pasid be initialized to be PASID_RID2PASID if the domain
is not a domain used by mediated device?

> +						       pass_through);
> +		/* Setup the PASID entry for mediated devices: */
> +		else if (dev_is_mdev(dev))
> +			intel_pasid_setup_second_level(iommu, domain, dev,
> +						       domain->default_pasid,
> +						       false);
> +		else
> +			pr_err("Unsupported device %s\n", dev_name(dev));
> +
>  		spin_unlock(&iommu->lock);
>  	}
>  	spin_unlock_irqrestore(&device_domain_lock, flags); @@ -4937,6 +4947,32
> @@ static void domain_context_clear(struct intel_iommu *iommu, struct device
> *dev)
>  	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb,
> iommu);  }
> 
> +static void
> +iommu_flush_ext_iotlb(struct intel_iommu *iommu, u16 did, u32 pasid,

Per latest VT-d spec, its new name is pasid-based-iotlb. Pls update the naming
accordingly. :)

Regards,
Yi Liu

> +u64 gran) {
> +	struct qi_desc desc;
> +
> +	desc.high = 0;
> +	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +			QI_EIOTLB_GRAN(gran) | QI_EIOTLB_TYPE;
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +static void iommu_flush_pasid_dev_iotlb(struct intel_iommu *iommu,
> +					struct device *dev, int sid, int pasid) {
> +	struct qi_desc desc;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int qdep = pci_ats_queue_depth(pdev);
> +
> +	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;
> +	desc.high = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) | QI_DEV_EIOTLB_SIZE;
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  static void __dmar_remove_one_dev_info(struct device_domain_info *info)  {
>  	struct intel_iommu *iommu;
> @@ -4949,6 +4985,29 @@ static void __dmar_remove_one_dev_info(struct
> device_domain_info *info)
> 
>  	iommu = info->iommu;
> 
> +	if (dev_is_mdev(info->dev)) {
> +		struct dmar_domain *domain = info->domain;
> +		int did = domain->iommu_did[iommu->seq_id];
> +		int sid = info->bus << 8 | info->devfn;
> +		struct device *dev = info->dev;
> +
> +		intel_pasid_clear_entry(dev, domain->default_pasid);
> +
> +		/* Flush IOTLB including PASID Cache: */
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +
> +		/*
> +		 * Flush EIOTLB. The only way to flush global mappings within
> +		 * a PASID is to use QI_GRAN_ALL_ALL.
> +		 */
> +		iommu_flush_ext_iotlb(iommu, did, domain->default_pasid,
> +				      QI_GRAN_ALL_ALL);
> +
> +		/* Flush Dev TLB: */
> +		iommu_flush_pasid_dev_iotlb(iommu, dev_mdev_parent(dev), sid,
> +					    domain->default_pasid);
> +	}
> +
>  	if (info->dev) {
>  		iommu_disable_dev_iotlb(info);
>  		domain_context_clear(iommu, info->dev);
> --
> 2.7.4

