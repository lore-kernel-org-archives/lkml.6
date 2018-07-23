Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3728ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DF820875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DF820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeGWFnv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:43:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:47789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeGWFnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:43:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 21:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="247991579"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2018 21:44:34 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Mon, 23 Jul 2018 12:44:31 +0800
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
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Topic: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Index: AQHUIYLUWW+rmljvH0aNyiLLdWIbJaScJaUQ
Date:   Mon, 23 Jul 2018 04:44:30 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjk1M2RkNmItODlhZi00Y2U0LWI2OTAtMGNjMjk1MjlhMjgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU1pleFJEVlh6eGhPQys4Z1dSMlNJSHYzcjZvd1VTYWdKQkRJNHJVeTFObVwvTU9ZcHZcL0FiQ1JESTFqZnpHWEF1In0=
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
> With the Intel IOMMU supporting PASID granularity isolation and protection, a
> mediated device could be isolated and protected by an IOMMU unit. We need to
> allocate a new group instead of a PCI group.

Existing vfio mdev framework also allocates an iommu group for mediate device.

mdev_probe()
  |_ mdev_attach_iommu()
       |_ iommu_group_alloc()

IMHO, this patch actually do a wrapper to the group allocation API. The reason is: it
is not necessary to apply the group allocation rules when the allocation is for mediated
device. Instead, just allocate a new one for it. :)

Thanks,
Yi Liu
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 3ede34a..57ccfc4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5276,6 +5276,17 @@ static void intel_iommu_put_resv_regions(struct device
> *dev,
>  	}
>  }
> 
> +static struct iommu_group *intel_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	if (dev_is_mdev(dev))
> +		return iommu_group_alloc();
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev
> *sdev)  { @@ -5370,7 +5381,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.remove_device		= intel_iommu_remove_device,
>  	.get_resv_regions	= intel_iommu_get_resv_regions,
>  	.put_resv_regions	= intel_iommu_put_resv_regions,
> -	.device_group		= pci_device_group,
> +	.device_group		= intel_iommu_device_group,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>  };
> 
> --
> 2.7.4

