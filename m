Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18574C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0A62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0A62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeIGW3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:29:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:9706 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbeIGW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:29:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 10:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="261623139"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2018 10:43:27 -0700
Date:   Fri, 7 Sep 2018 10:43:28 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Add second level page table
 interface
Message-ID: <20180907174328.GA95061@otc-nc-03>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-7-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C24@SHSMSX101.ccr.corp.intel.com>
 <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:47:11AM +0800, Lu Baolu wrote:
> 
> >>+
> >>+	intel_pasid_clear_entry(dev, pasid);
> >>+
> >>+	if (!ecap_coherent(iommu->ecap)) {
> >>+		pte = intel_pasid_get_entry(dev, pasid);
> >>+		clflush_cache_range(pte, sizeof(*pte));
> >>+	}
> >>+
> >>+	pasid_based_pasid_cache_invalidation(iommu, did, pasid);
> >>+	pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
> >>+
> >>+	/* Device IOTLB doesn't need to be flushed in caching mode. */
> >>+	if (!cap_caching_mode(iommu->cap))
> >>+		pasid_based_dev_iotlb_cache_invalidation(iommu, dev,
> >>pasid);
> >
> >can you elaborate, or point to any spec reference?
> >
> 
> In the driver, device iotlb doesn't get flushed in caching mode. I just
> follow what have been done there.
> 
> It also makes sense to me since only the bare metal host needs to
> consider whether and how to flush the device iotlb.
> 

DavidW might remember, i think the idea was to help with cost
of virtualization, we can avoid taking 2 exits vs handling
it directly when we do iotlb flushing instead.

the other optimization was to only do devtlb flushing when you unmap 
since when establish not-present to present there is no need to 
flush devtlb at that point.
