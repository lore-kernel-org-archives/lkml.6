Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeEAJWh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:22:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:4521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754594AbeEAJWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:22:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="224801617"
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
Subject: RE: [PATCH 7/9] iommu/vt-d: Calculate PTS value
Thread-Topic: [PATCH 7/9] iommu/vt-d: Calculate PTS value
Thread-Index: AQHT1fnwcLyQFaWZpkuEjijr82S/2aQapgow
Date: Tue, 1 May 2018 09:22:31 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE753A@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-8-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1523934202-21669-8-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDM2MTg3OGYtNDQ5MS00ZjZkLWEwMTItMDNkZWMxNjQ2NDVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJOZXBhZzFZUERKYTNDTzFUb1dRRzJRUWE4NGpQckl1M0FsbGJCcjFUQ2VSKzNkVlFUbzVuT04xdEc4Z0h5RGhqIn0=
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
> Calculate PTS (PASID Table Size) value for the extended
> context entry from the real size of the PASID table for
> a domain.
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
>  drivers/iommu/intel-iommu.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 99c643b..d4f9cea 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5146,22 +5146,16 @@ static void intel_iommu_put_resv_regions(struct device
> *dev,
> 
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  #define MAX_NR_PASID_BITS (20)
> -static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
> +static inline unsigned long intel_iommu_get_pts(struct dmar_domain *domain)
>  {
> -	/*
> -	 * Convert ecap_pss to extend context entry pts encoding, also
> -	 * respect the soft pasid_max value set by the iommu.
> -	 * - number of PASID bits = ecap_pss + 1
> -	 * - number of PASID table entries = 2^(pts + 5)
> -	 * Therefore, pts = ecap_pss - 4
> -	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
> -	 */
> -	if (ecap_pss(iommu->ecap) < 5)
> +	int pts;
> +
> +	pts = find_first_bit((unsigned long *)&domain->max_pasid,
> +			     MAX_NR_PASID_BITS);
> +	if (pts < 5)
>  		return 0;
> 
> -	/* pasid_max is encoded as actual number of entries not the bits */
> -	return find_first_bit((unsigned long *)&iommu->pasid_max,
> -			MAX_NR_PASID_BITS) - 5;
> +	return pts - 5;
>  }
> 
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev
> *sdev)
> @@ -5198,7 +5192,7 @@ int intel_iommu_enable_pasid(struct intel_iommu
> *iommu, struct intel_svm_dev *sd
>  		if (iommu->pasid_state_table)
>  			context[1].hi = (u64)virt_to_phys(iommu-
> >pasid_state_table);
>  		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
> -			intel_iommu_get_pts(iommu);
> +			intel_iommu_get_pts(domain);
> 
>  		wmb();
>  		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are
> both
> --
> 2.7.4
