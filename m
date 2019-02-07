Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA01F2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBGSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:46:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:38884 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfBGSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:46:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="114479477"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 10:46:06 -0800
Date:   Thu, 7 Feb 2019 10:46:06 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20190207184606.GB17049@agluck-desk>
References: <20181224231106.GA27438@gmail.com>
 <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
 <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net>
 <20190207173600.GA15682@agluck-desk>
 <20190207175720.GE32511@hirez.programming.kicks-ass.net>
 <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:07:28AM -0800, Andy Lutomirski wrote:
> Joining this thread late...
> 
> This is all IMO rather crazy.  How about we fiddle with CR0 to turn off
> the cache, then fiddle with page tables, then turn caching on?  Or, heck,
> see if there’s some chicken bit we can set to improve the situation
> while we’re in the MCE handler.

> Also, since I don’t really want
> to dig into the code to answer this, how exactly do we do a broadcast TLB
> flush from MCE context?  We’re super-duper-atomic, and locks might be
> held on various CPUs.  Shouldn’t we be telling the cpa code to skip
> the flush and then just have the MCE code do a full flush manually?
> The MCE code has already taken over all CPUs on non-LMCE systems.

MCE code doesn't do this while still in MCE context. You helped
restructure this code so the recovery bits happen after we call

	ist_begin_non_atomic(regs);

on just the CPU that hit the error (in the broadcast case we've
let the other out of MCE jail by this point).

So there is a small window where we know the broken page is still
mapped WB in the kernel 1:1 map. But we just live dangerously for
a few more microseconds until we can fix the map.

> Or, better yet, get Intel to fix the hardware. A failed speculative
> access while already in MCE context should just be ignored.

Good idea.

-Tony
