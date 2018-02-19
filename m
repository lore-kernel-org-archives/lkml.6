Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeBSJgl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:36:41 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43013 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeBSJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:36:39 -0500
X-Google-Smtp-Source: AH8x224HnPTnUPLIjlUrrN3Zfzb+YtkuAOtwt6rnvknOSaj4SfO2gay2DHuISNQGr/Ky21iOXr1SNA==
Date: Mon, 19 Feb 2018 10:36:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180219093635.su3hqx5bn2jibnoi@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <c77b3da9-136d-9988-119f-e94c86fd34a3@linux.intel.com>
 <1518808600.7876.49.camel@infradead.org>
 <66f94cb1-8160-56e0-680c-2e847ae05893@linux.intel.com>
 <20180217102616.vcwatxsgj2vunlew@gmail.com>
 <20180219092017.GN25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219092017.GN25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Feb 17, 2018 at 11:26:16AM +0100, Ingo Molnar wrote:
> > Note that PeterZ was struggling with intermittent boot hangs yesterday as well, 
> > which hangs came and went during severeal (fruitless) bisection attempts. Then at 
> > a certain point the hangs went away altogether.
> > 
> > The symptoms for both his and your hangs are consistent with an alignment 
> > dependent bug.
> 
> Mine would consistently hang right after
> 
>   "Freeing SMP alternatives memory: 44K"
> 
> At one point I bisected it to commit:
> 
>   a06cc94f3f8d ("x86/build: Drop superfluous ALIGN from the linker script")

So, just to make sure this commit had no effect: I cannot really see anything 
wrong with that commit, it does a single substantial change, which is to remove 
this explicit alignment:

                . = ALIGN(8);
                TEXT_TEXT

which seems fine to me, since it expanded to:

                . = ALIGN(8);
                ALIGN_FUNCTION();                                       \
		...

which expanded to:

                . = ALIGN(8);
		. = ALIGN(8);
		...

... which duplication the commit removed.

... where all the relevant defitions of TEXT_TEXT and ALIGN_FUNCTION are 
unconditional and not overriden anywhere for arch/x86 builds.

I.e. the commit is a NOP AFAICS.

Thanks,

	Ingo
