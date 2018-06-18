Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B482086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeFRNOI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:14:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:58147 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932843AbeFRNOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:14:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 06:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="49863550"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2018 06:14:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 891D7FA; Mon, 18 Jun 2018 16:14:05 +0300 (EEST)
Date:   Mon, 18 Jun 2018 16:14:05 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 09/17] x86/mm: Implement page_keyid() using page_ext
Message-ID: <20180618131405.ohpxk6sr4zogqmzn@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-10-kirill.shutemov@linux.intel.com>
 <169af1d8-7fb6-5e1a-4f34-0150570018cc@intel.com>
 <20180618100721.qvm4maovfhxbfoo7@black.fi.intel.com>
 <7fab87eb-7b6d-6995-b6c6-46c0fd049d2a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fab87eb-7b6d-6995-b6c6-46c0fd049d2a@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:54:29PM +0000, Dave Hansen wrote:
> On 06/18/2018 03:07 AM, Kirill A. Shutemov wrote:
> > On Wed, Jun 13, 2018 at 06:20:10PM +0000, Dave Hansen wrote:
> >>> +int page_keyid(const struct page *page)
> >>> +{
> >>> +	if (mktme_status != MKTME_ENABLED)
> >>> +		return 0;
> >>> +
> >>> +	return lookup_page_ext(page)->keyid;
> >>> +}
> >>> +EXPORT_SYMBOL(page_keyid);
> >> Please start using a proper X86_FEATURE_* flag for this.  It will give
> >> you all the fancy static patching that you are missing by doing it this way.
> > There's no MKTME CPU feature.
> 
> Right.  We have tons of synthetic features that have no basis in the
> hardware CPUID feature.
> 
> > Well, I guess we can invent syntactic one or just use static key directly.
> 
> Did you mean synthetic?

Right.

> > Let's see how it behaves performance-wise before optimizing this.
> 
> It's not an optimization, it's how we do things in arch/x86, and it has
> a *ton* of optimization infrastructure behind it that you get for free
> if you use it.
> 
> I'm just trying to save Thomas's tired fingers from having to say the
> same thing in a week or two when he looks at this.

Okay, I'll look into this.

-- 
 Kirill A. Shutemov
