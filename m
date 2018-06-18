Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A020850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27A020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934438AbeFRNdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:33:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:5448 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933585AbeFRNdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:33:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 06:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="60125222"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2018 06:33:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CE679FA; Mon, 18 Jun 2018 16:33:12 +0300 (EEST)
Date:   Mon, 18 Jun 2018 16:33:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 15/17] x86/mm: Implement sync_direct_mapping()
Message-ID: <20180618133312.kb6j25jvf6dr7dvh@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-16-kirill.shutemov@linux.intel.com>
 <41c9db7f-2277-4403-5556-df56b686d5c8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c9db7f-2277-4403-5556-df56b686d5c8@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:41:21PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> >  arch/x86/include/asm/mktme.h |   6 +
> >  arch/x86/mm/init_64.c        |   6 +
> >  arch/x86/mm/mktme.c          | 444 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 456 insertions(+)
> 
> Can we not do any better than 400 lines of new open-coded pagetable
> hacking?

It's not pretty, but I don't see much options.

I first tried to modify routines that initialize/modify/remove parts of
direct mapping to keep all per-KeyID direct mappings in sync from start.
But it didn't really fly. We need to initialize direct mapping very early
when we don't have a way to allocated page in a usual way. We have very
limited pool of pre-allocated pages to allocate page tables from and it's
not able to satisfy demand for multiple direct mappings.

So I had to go with syncing it later on. When we have working page
allocator.

Regarding open-codeness, we need to walk two subtrees in lock steps.
I don't see how get mm/pagewalk.c to work in such use case. (And I don't
really like callback-based pagewalker.)

-- 
 Kirill A. Shutemov
