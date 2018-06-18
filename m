Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FE7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4693620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4693620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936945AbeFRKSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:18:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:26855 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933852AbeFRKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:18:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 03:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="50188052"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 03:18:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A9E03F8; Mon, 18 Jun 2018 13:18:28 +0300 (EEST)
Date:   Mon, 18 Jun 2018 13:18:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 10/17] x86/mm: Implement prep_encrypted_page() and
 arch_free_page()
Message-ID: <20180618101828.hxp2dw3fmfxwk2ka@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-11-kirill.shutemov@linux.intel.com>
 <36997c9c-73c0-1d9d-6251-10315a4158f0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36997c9c-73c0-1d9d-6251-10315a4158f0@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:26:10PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > prep_encrypted_page() also takes care about zeroing the page. We have to
> > do this after KeyID is set for the page.
> 
> This is an implementation detail that has gone unmentioned until now but
> has impacted at least half a dozen locations in previous patches.  Can
> you rectify that, please?

It was mentioned in commit message of 04/17.

> > +void prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
> > +{
> > +	int i;
> > +
> > +	/*
> > +	 * The hardware/CPU does not enforce coherency between mappings of the
> > +	 * same physical page with different KeyIDs or encrypt ion keys.
> 
> What are "encrypt ion"s? :)

:P

> > +	 * We are responsible for cache management.
> > +	 *
> > +	 * We flush cache before allocating encrypted page
> > +	 */
> > +	clflush_cache_range(page_address(page), PAGE_SIZE << order);
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
> 
> /* All pages coming out of the allocator should have KeyID 0 */
> 

Okay.

> > +		lookup_page_ext(page)->keyid = keyid;
> > +		/* Clear the page after the KeyID is set. */
> > +		if (zero)
> > +			clear_highpage(page);
> > +	}
> > +}
> 
> How expensive is this?

It just shifts cost of zeroing from page allocator here. It should not
have huge effect.

> > +void arch_free_page(struct page *page, int order)
> > +{
> > +	int i;
> > 
> 
> 	/* KeyId-0 pages were not used for MKTME and need no work */
> 
> ... or something

Okay.

> > +	if (!page_keyid(page))
> > +		return;
> 
> Is page_keyid() optimized so that all this goes away automatically when
> MKTME is compiled out or unsupported?

If MKTME is not enabled compile-time, this translation unit doesn't
compile at all.

I have not yet optimized for run-time unsupported case. I'll optimized it
based on performance measurements.

> > +	for (i = 0; i < (1 << order); i++) {
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);
> > +		lookup_page_ext(page)->keyid = 0;
> > +	}
> > +
> > +	clflush_cache_range(page_address(page), PAGE_SIZE << order);
> > +}
> 
> 
> 
> 

-- 
 Kirill A. Shutemov
