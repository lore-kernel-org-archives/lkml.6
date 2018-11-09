Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9077820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9077820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeKJGSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:18:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeKJGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:18:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6828E3DE04;
        Fri,  9 Nov 2018 20:36:28 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45F871019627;
        Fri,  9 Nov 2018 20:36:26 +0000 (UTC)
Date:   Fri, 9 Nov 2018 14:36:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20181109203624.ubfvpfunaydnjkjk@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
 <20181109152139.zig45f6gp24btfbc@treble>
 <20181109164137.5cngbfrkm4ihj4ra@treble>
 <20181109134241.5f4ce3be@gandalf.local.home>
 <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
 <20181109143703.5f2205bf@gandalf.local.home>
 <20181109194409.mnrzdee6gh4ujutm@treble>
 <20181109145918.28df6616@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109145918.28df6616@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 09 Nov 2018 20:36:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:59:18PM -0500, Steven Rostedt wrote:
> On Fri, 9 Nov 2018 13:44:09 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Fri, Nov 09, 2018 at 02:37:03PM -0500, Steven Rostedt wrote:
> > > On Fri, 9 Nov 2018 11:05:51 -0800
> > > Andy Lutomirski <luto@amacapital.net> wrote:
> > >   
> > > > > Not sure what Andy was talking about, but I'm currently implementing
> > > > > tracepoints to use this, as tracepoints use indirect calls, and are a
> > > > > prime candidate for static calls, as I showed in my original RFC of
> > > > > this feature.
> > > > > 
> > > > >     
> > > > 
> > > > Indeed.
> > > > 
> > > > Although I had assumed that tracepoints already had appropriate jump label magic.  
> > > 
> > > It does. But that's not the problem I was trying to solve. It's that
> > > tracing took a 8% noise dive with retpolines when enabled (hackbench
> > > slowed down by 8% with all the trace events enabled compared to all
> > > trace events enabled without retpoline). That is, normal users (those
> > > not tracinng) are not affected by trace events slowing down by
> > > retpoline. Those that care about performance when they are tracing, are
> > > affected by retpoline, quite drastically.
> > > 
> > > I'm doing another test run and measurements, to see how the unoptimized
> > > trampolines help, followed by the trampoline case.  
> > 
> > Are you sure you're using unoptimized?  Optimized is the default on
> > x86-64 (with my third patch).
> > 
> 
> Yes, because I haven't applied that third patch yet ;-)
> 
> Then I'll apply it and see how much that improves things.

Ah, good.  That will be interesting to see the difference between
optimized/unoptimized.

-- 
Josh
