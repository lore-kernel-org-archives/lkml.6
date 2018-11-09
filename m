Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C5AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6136A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6136A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeKJFTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeKJFTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:19:06 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA3C20855;
        Fri,  9 Nov 2018 19:37:04 +0000 (UTC)
Date:   Fri, 9 Nov 2018 14:37:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181109143703.5f2205bf@gandalf.local.home>
In-Reply-To: <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <20181109072811.GB86700@gmail.com>
        <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
        <20181109152139.zig45f6gp24btfbc@treble>
        <20181109164137.5cngbfrkm4ihj4ra@treble>
        <20181109134241.5f4ce3be@gandalf.local.home>
        <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 11:05:51 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > Not sure what Andy was talking about, but I'm currently implementing
> > tracepoints to use this, as tracepoints use indirect calls, and are a
> > prime candidate for static calls, as I showed in my original RFC of
> > this feature.
> > 
> >   
> 
> Indeed.
> 
> Although I had assumed that tracepoints already had appropriate jump label magic.

It does. But that's not the problem I was trying to solve. It's that
tracing took a 8% noise dive with retpolines when enabled (hackbench
slowed down by 8% with all the trace events enabled compared to all
trace events enabled without retpoline). That is, normal users (those
not tracinng) are not affected by trace events slowing down by
retpoline. Those that care about performance when they are tracing, are
affected by retpoline, quite drastically.

I'm doing another test run and measurements, to see how the unoptimized
trampolines help, followed by the trampoline case.

-- Steve
