Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89992175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBGVJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:09:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:54093 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfBGVJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:09:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 13:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="116081329"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.48])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2019 13:09:36 -0800
Date:   Thu, 7 Feb 2019 13:09:36 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables
 PASID.
Message-ID: <20190207210936.GH103220@otc-nc-03>
References: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 08:08:06PM +0000, David Woodhouse wrote:
> On Thu, 2019-02-07 at 10:44 -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Intel IOMMU Page Request Services (PRS) only works with devices which
> > supports/uses PASID. So enable PRI only if the device also enables
> > PASID support. For more details, Please check the implementation of PRQ
> > handler(prq_event_thread()) in intel-svm driver.
> > 
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Hm, that shouldn't be true. PRI and PASID support are orthogonal.
> 
> If we get a PRI request without PASID, we should currently report it as
> non-serviced which is the right thing to do. We can hook this up to KVM
> etc. to actually allow paging of guests with devices attached, *if* the
> devices attached to those guests support PRI.
> 
> Nothing fundamentally stops us using PRI without PASID support.

You are right.. they are completely orthogonal. We just don't have
a way to handle the page-requests for request without PASID's.

There are some of the vIOMMU work to pass the PRI to who owns
the device, and we can certainly relax it then. This is just to reflect
what support exists today. FWIW, even the native driver maybe be able
to resolve this if supported.

> 
> 


