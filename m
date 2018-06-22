Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B4DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851AD2451A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851AD2451A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeFVPkO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:40:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:27028 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933938AbeFVPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:40:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 08:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="scan'208";a="49761932"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2018 08:39:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2A04B143; Fri, 22 Jun 2018 18:39:50 +0300 (EEST)
Date:   Fri, 22 Jun 2018 18:39:50 +0300
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
Message-ID: <20180622153949.sjfdaeax6exfzxx2@black.fi.intel.com>
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

I've tried the approach, but it doesn't fit here.

We enable MKTME relatively late during boot process -- after page_ext as
page_keyid() depends on it. Enabling it earlier would make page_keyid()
return garbage.

By the time page_ext initialized, CPU features is already handled and
setup_force_cpu_cap() doesn't do anything.

I've implemented the enabling with static key instead.

-- 
 Kirill A. Shutemov
