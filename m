Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A554C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7002147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBGSkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:40:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:8635 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBGSkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:40:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="116048121"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2019 10:40:21 -0800
Date:   Thu, 7 Feb 2019 10:40:21 -0800
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
Message-ID: <20190207184021.GA17049@agluck-desk>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net>
 <20190207173600.GA15682@agluck-desk>
 <20190207175720.GE32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207175720.GE32511@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:57:20PM +0100, Peter Zijlstra wrote:
> Something like so then? AFAICT CLFLUSH will also #GP if feed it crap.

Correct. CFLUSH will also #GP on a non-canonical address.

> -		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
> +		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));


> -			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
> +			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);

Looks like as close as you can get without being crazy. Many/most
of the apparent function calls here are going to be inlined. So
likely safe.

Tried it out and it works!

So:

Tested-by: Tony Luck <tony.luck@intel.com>

Thanks

-Tony
