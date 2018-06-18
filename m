Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF419C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C25208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C25208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935558AbeFRKHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:07:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:35644 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935167AbeFRKHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:07:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 03:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="50186109"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 03:07:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D6FF2F8; Mon, 18 Jun 2018 13:07:21 +0300 (EEST)
Date:   Mon, 18 Jun 2018 13:07:21 +0300
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
Message-ID: <20180618100721.qvm4maovfhxbfoo7@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-10-kirill.shutemov@linux.intel.com>
 <169af1d8-7fb6-5e1a-4f34-0150570018cc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169af1d8-7fb6-5e1a-4f34-0150570018cc@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:20:10PM +0000, Dave Hansen wrote:
> > +int page_keyid(const struct page *page)
> > +{
> > +	if (mktme_status != MKTME_ENABLED)
> > +		return 0;
> > +
> > +	return lookup_page_ext(page)->keyid;
> > +}
> > +EXPORT_SYMBOL(page_keyid);
> 
> Please start using a proper X86_FEATURE_* flag for this.  It will give
> you all the fancy static patching that you are missing by doing it this way.

There's no MKTME CPU feature.

Well, I guess we can invent syntactic one or just use static key directly.

Let's see how it behaves performance-wise before optimizing this.

-- 
 Kirill A. Shutemov
