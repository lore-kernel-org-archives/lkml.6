Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2421721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGRgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:36:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:2626 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGRgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:36:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 09:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="141533042"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2019 09:35:59 -0800
Date:   Thu, 7 Feb 2019 09:36:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207173600.GA15682@agluck-desk>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207140131.GB32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:01:31PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 07, 2019 at 11:50:52AM +0000, Linus Torvalds wrote:
> > If you re-generate the canonical address in __cpa_addr(), now we'll
> > actually have the real virtual address around for a lot of code-paths
> > (pte lookup etc), which was what people wanted to avoid in the first
> > place.
> 
> Note that it's an 'unsigned long' address, not an actual pointer, and
> (afaict) non of the code paths use it as a pointer. This _should_ avoid
> the CPU from following said pointer and doing a deref on it.

The type doesn't matter. You want to avoid having the
true value in the register as long as possible. Ideal
spot would be the instruction before the TLB is flushed.

The speculative issue is that any branch you encounter
while you have the address in a register may be mispredicted.
You might also get a bogus hit in the branch target cache
and speculatively jump into the weeds. While there you
could find an instruction that loads using that register, and
even though it is speculative and the instruction won't
retire, a machine check log will be created in a bank (no
machine check is signalled).

Once the TLB is updated, you are safe. A speculative
access to an uncached address will not load or log anything.

-Tony
