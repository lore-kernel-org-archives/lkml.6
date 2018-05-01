Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeEAJW1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:22:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:32039 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754603AbeEAJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="36542118"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 6/9] iommu/vt-d: Allocate and free pasid table
Thread-Topic: [PATCH 6/9] iommu/vt-d: Allocate and free pasid table
Thread-Index: AQHT1fnvS+LhzZjO8kOcgdOkYYKLtaQapZCQ
Date: Tue, 1 May 2018 09:22:22 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE752C@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-7-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1523934202-21669-7-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTg5Yjc3ZDEtNmJjOS00NDNkLWE4NjgtYWU0ZTM0MTk3YWZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJCRFhFRER0dHN1bWV1QWRnTUo3SlQ4d3dwU1lrRW1KM3MzR05ZQ0NVUWdTdDVGRXlcL2dLRGlBdHVhS1QxWEkwZiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> This patch allocates PASID table for a domain at the time when
> it is being created (if any devices using this domain supports
> PASID feature), and free it when the domain is freed.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 13 +++++++++++++
>  drivers/iommu/intel-svm.c   |  8 --------
>  include/linux/intel-iommu.h | 10 ++++++++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index caa0b5c..99c643b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2460,6 +2460,18 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  		dev->archdata.iommu = info;
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> 
> +	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> +		if (pasid_enabled(iommu)) {
> +			size_t size, count;
> +
> +			size = sizeof(struct pasid_entry);
> +			count = min_t(int,
> +				      pci_max_pasids(to_pci_dev(dev)),
> +				      intel_pasid_max_id);
> +			ret = intel_pasid_alloc_table(dev, size, count);

No check for the return value?

> +		}
> +	}
> +
>  	if (dev && domain_context_mapping(domain, dev)) {
>  		pr_err("Domain context map for %s failed\n", dev_name(dev));
>  		dmar_remove_one_dev_info(domain, dev);
> @@ -4826,6 +4838,7 @@ static void dmar_remove_one_dev_info(struct
> dmar_domain *domain,
>  	unsigned long flags;
> 
>  	spin_lock_irqsave(&device_domain_lock, flags);
> +	intel_pasid_free_table(dev);
>  	info = dev->archdata.iommu;
>  	__dmar_remove_one_dev_info(info);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 24d0ea1..3abc94f 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -34,14 +34,6 @@
> 
>  static irqreturn_t prq_event_thread(int irq, void *d);
> 
> -struct pasid_entry {
> -	u64 val;
> -};
> -
> -struct pasid_state_entry {
> -	u64 val;
> -};
> -
>  int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  {
>  	struct page *pages;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index bee7a3f..08e5811 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -382,8 +382,14 @@ enum {
>  #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
> 
> -struct pasid_entry;
> -struct pasid_state_entry;
> +struct pasid_entry {
> +	u64 val;
> +};
> +
> +struct pasid_state_entry {
> +	u64 val;
> +};
> +
>  struct page_req_dsc;
> 
>  struct dmar_domain {

Overall, this patch looks good to me. But need to fix the comment above.

Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

Regards,
Yi Liu
