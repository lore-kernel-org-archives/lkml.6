Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381FC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381FC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeK3JVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbeK3JVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20817DC8F4;
        Thu, 29 Nov 2018 22:14:51 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 312CC1712C;
        Thu, 29 Nov 2018 22:14:48 +0000 (UTC)
Date:   Thu, 29 Nov 2018 16:14:46 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129221446.qb7znvt7zprlbz77@treble>
References: <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
 <20181129164914.GA9027@hirez.programming.kicks-ass.net>
 <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
 <20181129171050.iio53bw67fbiwzud@treble>
 <20181129220148.GD11632@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129220148.GD11632@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Nov 2018 22:14:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:01:48PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 29, 2018 at 11:10:50AM -0600, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 08:59:31AM -0800, Andy Lutomirski wrote:
> 
> > > (like pointing IP at a stub that retpolines to the target by reading
> > > the function pointer, a la the unoptimizable version), then okay, I
> > > guess, with only a small amount of grumbling.
> > 
> > I tried that in v2, but Peter pointed out it's racy:
> > 
> >   https://lkml.kernel.org/r/20181126160217.GR2113@hirez.programming.kicks-ass.net
> 
> Ah, but that is because it is a global shared trampoline.
> 
> Each static_call has it's own trampoline; which currently reads
> something like:
> 
> 	RETPOLINE_SAFE
> 	JMP *key
> 
> which you then 'defuse' by writing an UD2 on. _However_, if you write
> that trampoline like:
> 
> 1:	RETPOLINE_SAFE
> 	JMP *key
> 2:	CALL_NOSPEC *key
> 	RET
> 
> and have the text_poke_bp() handler jump to 2 (a location you'll never
> reach when you enter at 1), it will in fact work I think. The trampoline
> is never modified and not shared between different static_call's.

But after returning from the function to the trampoline, how does it
return from the trampoline to the call site?  At that point there is no
return address on the stack.

-- 
Josh
