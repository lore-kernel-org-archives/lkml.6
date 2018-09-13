Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F69C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316AC20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316AC20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeIMLAn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:00:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:12510 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeIMLAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:00:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 22:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="scan'208";a="85570604"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2018 22:52:38 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 12 Sep 2018 22:52:38 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 12 Sep 2018 22:52:37 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.16]) with mapi id 14.03.0319.002;
 Thu, 13 Sep 2018 13:52:33 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH v2 06/12] iommu/vt-d: Add second level page table
 interface
Thread-Topic: [PATCH v2 06/12] iommu/vt-d: Add second level page table
 interface
Thread-Index: AQHUQAHwDWc2LNkyDUSjEMfaICr4mqTimnUAgAEJkYCAAPprAIAJKacQ
Date:   Thu, 13 Sep 2018 05:52:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301901@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
        <20180830013524.28743-7-baolu.lu@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C24@SHSMSX101.ccr.corp.intel.com>
        <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
 <20180907174328.GA95061@otc-nc-03>
In-Reply-To: <20180907174328.GA95061@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGJiMGU3MjMtMjVhYS00MmVjLThhYWEtZDJlMDI4M2M2ODk2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiODVjXC9OUnRkQXBaVUYxOFdyak5TN2R3cWs0OFJ3TnBkRzhPd01Sb3pVRWtLZXoxakRPMHZoNktGOEtIT29cL3NYIn0=
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

> From: Raj, Ashok
> Sent: Saturday, September 8, 2018 1:43 AM
> 
> On Fri, Sep 07, 2018 at 10:47:11AM +0800, Lu Baolu wrote:
> >
> > >>+
> > >>+	intel_pasid_clear_entry(dev, pasid);
> > >>+
> > >>+	if (!ecap_coherent(iommu->ecap)) {
> > >>+		pte = intel_pasid_get_entry(dev, pasid);
> > >>+		clflush_cache_range(pte, sizeof(*pte));
> > >>+	}
> > >>+
> > >>+	pasid_based_pasid_cache_invalidation(iommu, did, pasid);
> > >>+	pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
> > >>+
> > >>+	/* Device IOTLB doesn't need to be flushed in caching mode. */
> > >>+	if (!cap_caching_mode(iommu->cap))
> > >>+		pasid_based_dev_iotlb_cache_invalidation(iommu, dev,
> > >>pasid);
> > >
> > >can you elaborate, or point to any spec reference?
> > >
> >
> > In the driver, device iotlb doesn't get flushed in caching mode. I just
> > follow what have been done there.
> >
> > It also makes sense to me since only the bare metal host needs to
> > consider whether and how to flush the device iotlb.
> >
> 
> DavidW might remember, i think the idea was to help with cost
> of virtualization, we can avoid taking 2 exits vs handling
> it directly when we do iotlb flushing instead.
> 

OK, performance-wise it makes sense. though strictly speaking it
doesn't follow spec...

Thanks
Kevin
