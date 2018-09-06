Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0ACC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DDB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DDB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIFHvH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:51:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:5691 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeIFHvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:51:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 20:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="81270503"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2018 20:17:55 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 20:17:54 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.240]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 11:17:52 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 08/12] iommu/vt-d: Pass pasid table to context mapping
Thread-Topic: [PATCH v2 08/12] iommu/vt-d: Pass pasid table to context
 mapping
Thread-Index: AQHUQAHyCLZbYhUF8Ey0UZ5yXAs9X6TioEYg
Date:   Thu, 6 Sep 2018 03:17:52 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C7A@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-9-baolu.lu@linux.intel.com>
In-Reply-To: <20180830013524.28743-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmIxMGMzNTItNTUxNi00Njc1LTg3OTUtOTkyZmQ2OWI2ZDA2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicnRXRXBqVWdVNGZIbjBtRWpGVWJYZUpRNkc1dGF4SFwvUUEyNE00TkU4N3lLUDRNM1lnQUx0aEtOWVR6Q2RsUVoifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, August 30, 2018 9:35 AM
> 
> So that the pasid related info, such as the pasid table and the
> maximum of pasid could be used during setting up scalable mode
> context.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel-iommu.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index c3bf2ccf094d..33642dd3d6ba 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1942,6 +1942,7 @@ static void domain_exit(struct dmar_domain
> *domain)
> 
>  static int domain_context_mapping_one(struct dmar_domain *domain,
>  				      struct intel_iommu *iommu,
> +				      struct pasid_table *table,
>  				      u8 bus, u8 devfn)
>  {
>  	u16 did = domain->iommu_did[iommu->seq_id];
> @@ -2064,6 +2065,7 @@ static int domain_context_mapping_one(struct
> dmar_domain *domain,
>  struct domain_context_mapping_data {
>  	struct dmar_domain *domain;
>  	struct intel_iommu *iommu;
> +	struct pasid_table *table;
>  };
> 
>  static int domain_context_mapping_cb(struct pci_dev *pdev,
> @@ -2072,25 +2074,31 @@ static int domain_context_mapping_cb(struct
> pci_dev *pdev,
>  	struct domain_context_mapping_data *data = opaque;
> 
>  	return domain_context_mapping_one(data->domain, data-
> >iommu,
> -					  PCI_BUS_NUM(alias), alias & 0xff);
> +					  data->table, PCI_BUS_NUM(alias),
> +					  alias & 0xff);
>  }
> 
>  static int
>  domain_context_mapping(struct dmar_domain *domain, struct device
> *dev)
>  {
> +	struct domain_context_mapping_data data;
> +	struct pasid_table *table;
>  	struct intel_iommu *iommu;
>  	u8 bus, devfn;
> -	struct domain_context_mapping_data data;
> 
>  	iommu = device_to_iommu(dev, &bus, &devfn);
>  	if (!iommu)
>  		return -ENODEV;
> 
> +	table = intel_pasid_get_table(dev);
> +
>  	if (!dev_is_pci(dev))
> -		return domain_context_mapping_one(domain, iommu, bus,
> devfn);
> +		return domain_context_mapping_one(domain, iommu,
> table,
> +						  bus, devfn);
> 
>  	data.domain = domain;
>  	data.iommu = iommu;
> +	data.table = table;
> 
>  	return pci_for_each_dma_alias(to_pci_dev(dev),
>  				      &domain_context_mapping_cb, &data);
> --
> 2.17.1

