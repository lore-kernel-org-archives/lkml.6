Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbeEAJWC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:22:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:32353 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753909AbeEAJV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:21:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="36542056"
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
Subject: RE: [PATCH 4/9] iommu/vt-d: Move device_domain_info to header
Thread-Topic: [PATCH 4/9] iommu/vt-d: Move device_domain_info to header
Thread-Index: AQHT1fnqgTZotpMCUUWJ8gtQJUM21KQao7jA
Date: Tue, 1 May 2018 09:21:56 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE7509@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-5-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1523934202-21669-5-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmVkMWUxMWMtNzI2OC00NjA5LWJiYjAtYjc0Mzg2MDk5ZDdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJCcytyaVpMd0ZJemNROTR3M0F6OUFCeGVMOHVJalhiQ2xZd05vdXdKT3hwNWphNVhCNmoycFd6RmxJK2djUjA5In0=
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
> This allows the per device iommu data to be accessed from other
> files.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good to me.
Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

Regards,
Yi Liu
> ---
>  drivers/iommu/intel-iommu.c | 62 +++--------------------------------------
>  include/linux/intel-iommu.h | 68
> +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 98c5ae9..caa0b5c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -381,60 +381,6 @@ static int hw_pass_through = 1;
>  	for (idx = 0; idx < g_num_of_iommus; idx++)		\
>  		if (domain->iommu_refcnt[idx])
> 
> -struct dmar_domain {
> -	int	nid;			/* node id */
> -
> -	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
> -					/* Refcount of devices per iommu */
> -
> -
> -	u16		iommu_did[DMAR_UNITS_SUPPORTED];
> -					/* Domain ids per IOMMU. Use u16 since
> -					 * domain ids are 16 bit wide according
> -					 * to VT-d spec, section 9.3 */
> -
> -	bool has_iotlb_device;
> -	struct list_head devices;	/* all devices' list */
> -	struct iova_domain iovad;	/* iova's that belong to this domain */
> -
> -	struct dma_pte	*pgd;		/* virtual address */
> -	int		gaw;		/* max guest address width */
> -
> -	/* adjusted guest address width, 0 is level 2 30-bit */
> -	int		agaw;
> -
> -	int		flags;		/* flags to find out type of domain */
> -
> -	int		iommu_coherency;/* indicate coherency of iommu access
> */
> -	int		iommu_snooping; /* indicate snooping control feature*/
> -	int		iommu_count;	/* reference count of iommu */
> -	int		iommu_superpage;/* Level of superpages supported:
> -					   0 == 4KiB (no superpages), 1 == 2MiB,
> -					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
> -	u64		max_addr;	/* maximum mapped address */
> -
> -	struct iommu_domain domain;	/* generic domain data structure for
> -					   iommu core */
> -};
> -
> -/* PCI domain-device relationship */
> -struct device_domain_info {
> -	struct list_head link;	/* link to domain siblings */
> -	struct list_head global; /* link to global list */
> -	u8 bus;			/* PCI bus number */
> -	u8 devfn;		/* PCI devfn number */
> -	u8 pasid_supported:3;
> -	u8 pasid_enabled:1;
> -	u8 pri_supported:1;
> -	u8 pri_enabled:1;
> -	u8 ats_supported:1;
> -	u8 ats_enabled:1;
> -	u8 ats_qdep;
> -	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> -	struct intel_iommu *iommu; /* IOMMU used by this device */
> -	struct dmar_domain *domain; /* pointer to domain */
> -};
> -
>  struct dmar_rmrr_unit {
>  	struct list_head list;		/* list of rmrr units	*/
>  	struct acpi_dmar_header *hdr;	/* ACPI header		*/
> @@ -631,7 +577,7 @@ static void set_iommu_domain(struct intel_iommu *iommu,
> u16 did,
>  		domains[did & 0xff] = domain;
>  }
> 
> -static inline void *alloc_pgtable_page(int node)
> +void *alloc_pgtable_page(int node)
>  {
>  	struct page *page;
>  	void *vaddr = NULL;
> @@ -642,7 +588,7 @@ static inline void *alloc_pgtable_page(int node)
>  	return vaddr;
>  }
> 
> -static inline void free_pgtable_page(void *vaddr)
> +void free_pgtable_page(void *vaddr)
>  {
>  	free_page((unsigned long)vaddr);
>  }
> @@ -725,7 +671,7 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
>  }
> 
>  /* This functionin only returns single iommu in a domain */
> -static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
> +struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>  {
>  	int iommu_id;
> 
> @@ -3500,7 +3446,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
>  	return iova_pfn;
>  }
> 
> -static struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
> +struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
>  {
>  	struct dmar_domain *domain, *tmp;
>  	struct dmar_rmrr_unit *rmrr;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6b5ef6c..a4463f0 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -31,6 +31,7 @@
>  #include <linux/list.h>
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/dmar.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -385,6 +386,50 @@ struct pasid_entry;
>  struct pasid_state_entry;
>  struct page_req_dsc;
> 
> +struct dmar_domain {
> +	int	nid;			/* node id */
> +
> +	unsigned int	iommu_refcnt[DMAR_UNITS_SUPPORTED];
> +					/* Refcount of devices per iommu */
> +
> +	u16		iommu_did[DMAR_UNITS_SUPPORTED];
> +					/*
> +					 * Domain ids per IOMMU. Use u16 since
> +					 * domain ids are 16 bit wide according
> +					 * to VT-d spec, section 9.3
> +					 */
> +
> +	bool has_iotlb_device;
> +	struct list_head devices;	/* all devices' list */
> +	struct iova_domain iovad;	/* iova's that belong to this domain */
> +
> +	struct dma_pte	*pgd;		/* virtual address */
> +	int		gaw;		/* max guest address width */
> +
> +	int		agaw;		/*
> +					 * adjusted guest address width,
> +					 * 0 is level 2 30-bit
> +					 */
> +
> +	int		flags;		/* flags to find out type of domain */
> +
> +	int		iommu_coherency;/* indicate coherency of iommu access
> */
> +	int		iommu_snooping; /* indicate snooping control feature*/
> +	int		iommu_count;	/* reference count of iommu */
> +	int		iommu_superpage;/*
> +					 * Level of superpages supported:
> +					 *  0 == 4KiB (no superpages),
> +					 *  1 == 2MiB, 2 == 1GiB,
> +					 *  3 == 512GiB, 4 == 1TiB
> +					 */
> +	u64		max_addr;	/* maximum mapped address */
> +
> +	struct iommu_domain domain;	/*
> +					 * generic domain data structure for
> +					 * iommu core
> +					 */
> +};
> +
>  struct intel_iommu {
>  	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
>  	u64 		reg_phys; /* physical address of hw register set */
> @@ -433,6 +478,24 @@ struct intel_iommu {
>  	u32		flags;      /* Software defined flags */
>  };
> 
> +/* PCI domain-device relationship */
> +struct device_domain_info {
> +	struct list_head link;	/* link to domain siblings */
> +	struct list_head global; /* link to global list */
> +	u8 bus;			/* PCI bus number */
> +	u8 devfn;		/* PCI devfn number */
> +	u8 pasid_supported:3;
> +	u8 pasid_enabled:1;
> +	u8 pri_supported:1;
> +	u8 pri_enabled:1;
> +	u8 ats_supported:1;
> +	u8 ats_enabled:1;
> +	u8 ats_qdep;
> +	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> +	struct intel_iommu *iommu; /* IOMMU used by this device */
> +	struct dmar_domain *domain; /* pointer to domain */
> +};
> +
>  static inline void __iommu_flush_cache(
>  	struct intel_iommu *iommu, void *addr, int size)
>  {
> @@ -459,6 +522,11 @@ extern int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu);
> 
>  extern int dmar_ir_support(void);
> 
> +struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
> +void *alloc_pgtable_page(int node);
> +void free_pgtable_page(void *vaddr);
> +struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
> +
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
>  extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
> --
> 2.7.4
