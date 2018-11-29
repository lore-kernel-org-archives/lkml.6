Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ECC20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ECC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeK3Djp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:39:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16357 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbeK3Djo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:39:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB4109F75D;
        Thu, 29 Nov 2018 16:33:47 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94E2368377;
        Thu, 29 Nov 2018 16:33:44 +0000 (UTC)
Date:   Thu, 29 Nov 2018 10:33:42 -0600
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
Message-ID: <20181129163342.tp5wlfcyiazwwyoh@treble>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181129143853.GO2131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Nov 2018 16:33:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:38:53PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 29, 2018 at 05:37:39AM -0800, Andy Lutomirski wrote:
> > 
> > 
> > > On Nov 29, 2018, at 1:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > On Wed, Nov 28, 2018 at 10:05:54PM -0800, Andy Lutomirski wrote:
> > > 
> > >>>> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
> > >>>> +{
> > >>>> +    struct static_call_bp_data *data = _data;
> > >>>> +
> > >>>> +    /*
> > >>>> +     * For inline static calls, push the return address on the stack so the
> > >>>> +     * "called" function will return to the location immediately after the
> > >>>> +     * call site.
> > >>>> +     *
> > >>>> +     * NOTE: This code will need to be revisited when kernel CET gets
> > >>>> +     *       implemented.
> > >>>> +     */
> > >>>> +    if (data->ret) {
> > >>>> +        regs->sp -= sizeof(long);
> > >>>> +        *(unsigned long *)regs->sp = data->ret;
> > >>>> +    }
> > >> 
> > >> You can’t do this.  Depending on the alignment of the old RSP, which
> > >> is not guaranteed, this overwrites regs->cs.  IRET goes boom.
> > > 
> > > I don't get it; can you spell that out?
> > > 
> > > The way I understand it is that we're at a location where a "E8 - Near
> > > CALL" instruction should be, and thus RSP should be the regular kernel
> > > stack, and the above simply does "PUSH ret", which is what that CALL
> > > would've done too.
> > > 
> > 
> > int3 isn’t IST anymore, so the int3 instruction conditionally
> > subtracts 8 from RSP and then pushes SS, etc. So my email was
> > obviously wrong wrt “cs”, but you’re still potentially overwriting the
> > int3 IRET frame.
> 
> ARGH!..
> 
> can't we 'fix' that again? The alternative is moving that IRET-frame and
> fixing everything up, which is going to be fragile, ugly and such
> things more.
> 
> Commit d8ba61ba58c8 ("x86/entry/64: Don't use IST entry for #BP stack")
> doesn't list any strong reasons for why it should NOT be an IST.

This seems to work...

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce25d84023c0..184523447d35 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -876,7 +876,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 create_gap=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -891,6 +891,12 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
+	.if \create_gap == 1
+	.rept 6
+	pushq 5*8(%rsp)
+	.endr
+	.endif
+
 	.if \paranoid == 1
 	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
@@ -1126,7 +1132,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0
+idtentry int3			do_int3			has_error_code=0	create_gap=1
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN_PV
