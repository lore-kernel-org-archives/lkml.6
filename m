Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D97ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD2B20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD2B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeGWFoF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:44:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:10147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbeGWFoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:44:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 21:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="58966608"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2018 21:44:26 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:20 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Mon, 23 Jul 2018 12:44:17 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
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
Subject: RE: [RFC PATCH 02/10] iommu/vt-d: Alloc domain for a mediated device
Thread-Topic: [RFC PATCH 02/10] iommu/vt-d: Alloc domain for a mediated
 device
Thread-Index: AQHUIYLSuqdXhsaqjEWyMfpXdXyTxaScJKYA
Date:   Mon, 23 Jul 2018 04:44:16 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA1432@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2YyZjFmZjktOTExZC00ZTIzLWI4MjktMWVjNTdjNGY4NjUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSk9jVXJmOHdWMHZUWENGcEptTDlZRUNxWjdxMEV1TUVXNkRcL2VVaEFCc2hmeEg2a3RGSWZoakk1VDhLMmVZNTEifQ==
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
> The PASID-granular 2nd level address translation makes it possible to isolate and
> protect a mediated device exposed by a real device which support PCI PASID

"support" -> "supports"

> features. This patch adds support to allocate a domain for a mediated device. A
> default pasid value will be allocated as well for the mediated device. This will be used

This is not accurate, it is "a default pasid value will be allocated for the domain, and the
mdev will be configed to use this pasid when it is added to this domain"

Regards,
Yi Liu

> by the mediated device attached to this domain for non-SVM DMA transactions.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-  include/linux/intel-iommu.h
> |  5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> fc3ac1c..3ede34a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1926,6 +1926,9 @@ static void domain_exit(struct dmar_domain *domain)
>  	domain_remove_dev_info(domain);
>  	rcu_read_unlock();
> 
> +	if (domain->default_pasid > 0)
> +		intel_pasid_free_id(domain->default_pasid);
> +
>  	/* destroy iovas */
>  	put_iova_domain(&domain->iovad);
> 
> @@ -2519,11 +2522,23 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  		}
>  	}
> 
> +	if (dev && dev_is_mdev(dev) && domain->default_pasid <= 0) {
> +		int max = intel_pasid_get_dev_max_id(dev_mdev_parent(dev));
> +
> +		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> +							     max, GFP_KERNEL);
> +		if (domain->default_pasid < 0) {
> +			free_devinfo_mem(info);
> +			return NULL;
> +		}
> +	}
> +
>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	if (dev)
>  		found = find_domain(dev);
> 
> -	if (!found) {
> +	/* A mediated device never has an DMA alias. Ignore searching. */
> +	if (!found && !dev_is_mdev(dev)) {
>  		struct device_domain_info *info2;
>  		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus,
> devfn);
>  		if (info2) {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h index
> 7efc632..9f5dcf6 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -423,6 +423,11 @@ struct dmar_domain {
>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
> 
> +	int		default_pasid;	/*
> +					 * The default pasid used for non-SVM
> +					 * traffic on mediated devices.
> +					 */
> +
>  	struct iommu_domain domain;	/* generic domain data structure for
>  					   iommu core */
>  };
> --
> 2.7.4

