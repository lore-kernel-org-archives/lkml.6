Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeEAJVv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:21:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:28895 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753848AbeEAJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:21:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="45856795"
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
Subject: RE: [PATCH 3/9] iommu/vt-d: Use global PASID for SVM usage
Thread-Topic: [PATCH 3/9] iommu/vt-d: Use global PASID for SVM usage
Thread-Index: AQHT1fnqIPBqjq3ZIkSseAz+rGXShqQao3rw
Date: Tue, 1 May 2018 09:21:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE7502@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-4-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1523934202-21669-4-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDA3ZGJiNWMtZjQyOC00MjlkLWFkODctYmY5YjA2NmI0NzdkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJvKzVabE13R2ZzRFNjXC92MVdSb0diY3JIMTVWU0ZhWllMS0ZEM2JtTUNiUmFBUGNxN3lDWkNjVXYrUTNnR2h5OCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Tuesday, April 17, 2018 11:03 AM
> This patch switches PASID management for SVM from per iommu idr to the global idr.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Looks good to me.
Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

Regards,
Yi Liu
> ---
>  drivers/iommu/intel-svm.c   | 22 +++++++++++-----------
>  include/linux/intel-iommu.h |  1 -
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> 983af0c..24d0ea1 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -26,6 +26,8 @@
>  #include <linux/interrupt.h>
>  #include <asm/page.h>
> 
> +#include "intel-pasid.h"
> +
>  #define PASID_ENTRY_P		BIT_ULL(0)
>  #define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
>  #define PASID_ENTRY_SRE		BIT_ULL(11)
> @@ -85,8 +87,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  				iommu->name);
>  	}
> 
> -	idr_init(&iommu->pasid_idr);
> -
>  	return 0;
>  }
> 
> @@ -102,7 +102,7 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
>  		free_pages((unsigned long)iommu->pasid_state_table, order);
>  		iommu->pasid_state_table = NULL;
>  	}
> -	idr_destroy(&iommu->pasid_idr);
> +
>  	return 0;
>  }
> 
> @@ -392,9 +392,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  			pasid_max = iommu->pasid_max;
> 
>  		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> -		ret = idr_alloc(&iommu->pasid_idr, svm,
> -				!!cap_caching_mode(iommu->cap),
> -				pasid_max - 1, GFP_KERNEL);
> +		ret = intel_pasid_alloc_id(svm,
> +					   !!cap_caching_mode(iommu->cap),
> +					   pasid_max - 1, GFP_KERNEL);
>  		if (ret < 0) {
>  			kfree(svm);
>  			kfree(sdev);
> @@ -410,7 +410,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				idr_remove(&svm->iommu->pasid_idr, svm->pasid);
> +				intel_pasid_free_id(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -460,7 +460,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  	if (!iommu || !iommu->pasid_table)
>  		goto out;
> 
> -	svm = idr_find(&iommu->pasid_idr, pasid);
> +	svm = intel_pasid_lookup_id(pasid);
>  	if (!svm)
>  		goto out;
> 
> @@ -485,7 +485,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  					svm->iommu->pasid_table[svm->pasid].val
> = 0;
>  					wmb();
> 
> -					idr_remove(&svm->iommu->pasid_idr,
> svm->pasid);
> +					intel_pasid_free_id(svm->pasid);
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm-
> >notifier, svm->mm);
> 
> @@ -520,7 +520,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
>  	if (!iommu || !iommu->pasid_table)
>  		goto out;
> 
> -	svm = idr_find(&iommu->pasid_idr, pasid);
> +	svm = intel_pasid_lookup_id(pasid);
>  	if (!svm)
>  		goto out;
> 
> @@ -618,7 +618,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
> 
>  		if (!svm || svm->pasid != req->pasid) {
>  			rcu_read_lock();
> -			svm = idr_find(&iommu->pasid_idr, req->pasid);
> +			svm = intel_pasid_lookup_id(req->pasid);
>  			/* It *can't* go away, because the driver is not permitted
>  			 * to unbind the mm while any page faults are outstanding.
>  			 * So we only need RCU to protect the internal idr code. */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h index
> 795717e..6b5ef6c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -418,7 +418,6 @@ struct intel_iommu {
>  	struct pasid_state_entry *pasid_state_table;
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> -	struct idr pasid_idr;
>  	u32 pasid_max;
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
> --
> 2.7.4
