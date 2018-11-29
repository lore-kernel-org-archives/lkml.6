Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6541C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C142145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CigctvPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeK3JJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:09:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nnUFPnghpca8In58LsdPdpVcgQqunkEM/siKs1BTDsk=; b=CigctvPCzWin4tqwwoEXk034G
        jjb128xluho8bbNR8oi6Ncp2L+UG3+YpG2uB5yNo4qSnCuHmxZwlhLS7wPECWuhnx+NGRr92r9N1q
        cL8bNvhHHrKlfvZ3x8fSZX+nGbDUbfao6yY+6zq4C8AkOhV+Y0RNSrUMVnftiQNCGGeH5NBYmcUOp
        UwWyduW7WfZqu5GRlvcFa7018168nxbuwwWsiLEeERYbaZIWolBSB7zcyKjH4NCATYmuk8WYcf1lG
        aJbPAflQDTK+HBoXnrHAwtZYKVAA9Gf8XREtaWts95xHhpZdC7ODFUET0Qo15oa5I87dsfqrMD3is
        I8FApzxvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSUNb-0005vp-5w; Thu, 29 Nov 2018 22:01:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51F6E2029FD58; Thu, 29 Nov 2018 23:01:48 +0100 (CET)
Date:   Thu, 29 Nov 2018 23:01:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <20181129220148.GD11632@hirez.programming.kicks-ass.net>
References: <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
 <20181129164914.GA9027@hirez.programming.kicks-ass.net>
 <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
 <20181129171050.iio53bw67fbiwzud@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129171050.iio53bw67fbiwzud@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:10:50AM -0600, Josh Poimboeuf wrote:
> On Thu, Nov 29, 2018 at 08:59:31AM -0800, Andy Lutomirski wrote:

> > (like pointing IP at a stub that retpolines to the target by reading
> > the function pointer, a la the unoptimizable version), then okay, I
> > guess, with only a small amount of grumbling.
> 
> I tried that in v2, but Peter pointed out it's racy:
> 
>   https://lkml.kernel.org/r/20181126160217.GR2113@hirez.programming.kicks-ass.net

Ah, but that is because it is a global shared trampoline.

Each static_call has it's own trampoline; which currently reads
something like:

	RETPOLINE_SAFE
	JMP *key

which you then 'defuse' by writing an UD2 on. _However_, if you write
that trampoline like:

1:	RETPOLINE_SAFE
	JMP *key
2:	CALL_NOSPEC *key
	RET

and have the text_poke_bp() handler jump to 2 (a location you'll never
reach when you enter at 1), it will in fact work I think. The trampoline
is never modified and not shared between different static_call's.
