Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A85213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A85213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeK3GCD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeK3GCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:02:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE362082F;
        Thu, 29 Nov 2018 18:55:38 +0000 (UTC)
Date:   Thu, 29 Nov 2018 13:55:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129135536.7d8abe61@gandalf.local.home>
In-Reply-To: <60A06EF9-C301-4705-A32C-5E77E2D9DA9C@amacapital.net>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
        <20181126175624.bruqfbkngbucpvxr@treble>
        <20181126200801.GW2113@hirez.programming.kicks-ass.net>
        <20181126212628.4apztfazichxnt7r@treble>
        <20181127084330.GX2113@hirez.programming.kicks-ass.net>
        <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
        <20181129094210.GC2131@hirez.programming.kicks-ass.net>
        <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
        <20181129143853.GO2131@hirez.programming.kicks-ass.net>
        <20181129163342.tp5wlfcyiazwwyoh@treble>
        <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
        <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
        <20181129121307.12393c57@gandalf.local.home>
        <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
        <20181129124404.2fe55dd0@gandalf.local.home>
        <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
        <60A06EF9-C301-4705-A32C-5E77E2D9DA9C@amacapital.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 10:00:48 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > 
> > Of course, another option is to just say "we don't do the inline case,
> > then", and only ever do a call to a stub that does a "jmp"
> > instruction.  
> 
> That’s not a terrible idea.

It was the implementation of my first proof of concept that kicked off
this entire idea, where others (Peter and Josh) thought it was better
to modify the calls themselves. It does improve things.

Just a reminder of the benchmarks of enabling all tracepoints (which
use indirect jumps) and running hackbench:

  No RETPOLINES:
            1.4503 +- 0.0148 seconds time elapsed  ( +-  1.02% )

  baseline RETPOLINES:
            1.5120 +- 0.0133 seconds time elapsed  ( +-  0.88% )

  Added direct calls for trace_events:
            1.5239 +- 0.0139 seconds time elapsed  ( +-  0.91% )

  With static calls:
            1.5282 +- 0.0135 seconds time elapsed  ( +-  0.88% )

  With static call trampolines:
           1.48328 +- 0.00515 seconds time elapsed  ( +-  0.35% )

  Full static calls:
           1.47364 +- 0.00706 seconds time elapsed  ( +-  0.48% )


  Adding Retpolines caused a 1.5120 / 1.4503 = 1.0425 ( 4.25% ) slowdown

  Trampolines made it into 1.48328 / 1.4503 = 1.0227 ( 2.27% ) slowdown

The above is the stub with the jmp case.

  With full static calls 1.47364 / 1.4503 = 1.0160 ( 1.6% ) slowdown

Modifying the calls themselves does have an improvement (and this is
much greater of an improvement when I had debugging enabled).

Perhaps it's not worth the effort, but again, we do have control of
what uses this. It's not a total free-for-all.

Full results here:

  http://lkml.kernel.org/r/20181126155405.72b4f718@gandalf.local.home

Although since lore.kernel.org seems to be having issues:

  https://marc.info/?l=linux-kernel&m=154326714710686


-- Steve
