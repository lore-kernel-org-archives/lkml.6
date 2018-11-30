Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D415AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEFD20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEFD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLAFtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:49:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:49:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 202AA3086268;
        Fri, 30 Nov 2018 18:39:21 +0000 (UTC)
Received: from treble (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02FE1600C9;
        Fri, 30 Nov 2018 18:39:18 +0000 (UTC)
Date:   Fri, 30 Nov 2018 12:39:17 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181130183917.hxmti5josgq4clti@treble>
References: <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble>
 <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 30 Nov 2018 18:39:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:42:26AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 29, 2018 at 12:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > Alternatively, we could actually emulate call instructions like this:
> > >
> > > void __noreturn jump_to_kernel_pt_regs(struct pt_regs *regs, ...)
> > > {
> > >   struct pt_regs ptregs_copy = *regs;
> > >   barrier();
> > >   *(unsigned long *)(regs->sp - 8) = whatever;  /* may clobber old
> > > regs, but so what? */
> > >   asm volatile ("jmp return_to_alternate_ptregs");
> > > }
> > >
> > > where return_to_alternate_ptregs points rsp to the ptregs and goes
> > > through the normal return path.  It's ugly, but we could have a test
> > > case for it, and it should work fine.
> >
> > Is that really any better than my patch to create a gap in the stack
> > (modified for kernel space #BP only)?
> >
> 
> I tend to prefer a nice local hack like mine over a hack that further
> complicates the entry in general.  This is not to say I'm thrilled by
> my idea either.

They're both mucking with the location of the pt_regs.  The above code
just takes that fact and hides it in the corner and hopes that there are
no bugs lurking there.

Even with the CPL check, the "gap" code is simple and self-contained
(see below).  The kernel pt_regs can already be anywhere on the stack so
there should be no harm in moving them.

AFAICT, all the other proposed options seem to have major issues.

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce25d84023c0..f487f7daed6c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -876,7 +876,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 create_gap=1
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -896,6 +896,18 @@ ENTRY(\sym)
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
 
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	.if \create_gap == 1
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_no_gap_\@
+	.rept 6
+	pushq 5*8(%rsp)
+	.endr
+	UNWIND_HINT_IRET_REGS offset=8
+.Lfrom_usermode_no_gap_\@:
+	.endif
+#endif
+
 	.if \paranoid
 	call	paranoid_entry
 	.else
@@ -1126,7 +1138,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0
+idtentry int3			do_int3			has_error_code=0	create_gap=1
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN_PV
