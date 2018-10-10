Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E529C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5262087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5262087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJKBje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKBje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:39:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A226536A5E6;
        Wed, 10 Oct 2018 18:16:15 +0000 (UTC)
Received: from treble (ovpn-124-83.rdu2.redhat.com [10.10.124.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D260680D8C;
        Wed, 10 Oct 2018 18:16:12 +0000 (UTC)
Date:   Wed, 10 Oct 2018 13:16:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181010181605.arsyjxwdztztrjih@treble>
References: <20181006121211.GA5663@hirez.programming.kicks-ass.net>
 <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net>
 <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble>
 <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 10 Oct 2018 18:16:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:03:43AM -0700, Andy Lutomirski wrote:
> > +#define DECLARE_STATIC_CALL(tramp, func)                               \
> > +       extern typeof(func) tramp;                                      \
> > +       static void __used __section(.discard.static_call_tramps)       \
> > +               *__static_call_tramp_##tramp = tramp
> > +
> 
> Confused.  What's the __static_call_tramp_##tramp variable for?  And
> why is a DECLARE_ macro defining a variable?

This is the magic needed for objtool to find all the call sites.

The variable itself isn't needed, but the .discard.static_call_tramps
entry is.  Objtool reads that section to find out which function call
sites are targeted to a static call trampoline.

> > +#define DEFINE_STATIC_CALL(tramp, func)                                        \
> > +       DECLARE_STATIC_CALL(tramp, func);                               \
> > +       asm(".pushsection .text, \"ax\"                         \n"     \
> > +           ".align 4                                           \n"     \
> > +           ".globl " #tramp "                                  \n"     \
> > +           ".type " #tramp ", @function                        \n"     \
> > +           #tramp ":                                           \n"     \
> > +           "jmp " #func "                                      \n"     \
> 
> I think this would be nicer as an indirect call that gets patched to a
> direct call so that the update mechanism works even before it's
> initialized.  (Currently static_branch blows up horribly if you try to
> update one too early, and that's rather annoying IMO.)

Yeah, that would be better.  It would also allow trampoline function
pointers to work, which I think you mentioned elsewhere.  And then I
shouldn't trample this code in __static_call_update() -- that was
already kind of nasty anyway.

> Also, I think you're looking for "jmp.d32", which is available in
> newer toolchains.  For older toolchains, you could use .byte 0xe9 or
> you could use a different section (I think) to force a real 32-bit
> jump.

Good idea.

> > +void __init static_call_init(void)
> > +{
> > +       struct static_call_entry *entry;
> > +       unsigned long insn, tramp, func;
> > +       unsigned char insn_opcode, tramp_opcode;
> > +       s32 call_dest;
> > +
> > +       for (entry = __start_static_call_table;
> > +            entry < __stop_static_call_table; entry++) {
> > +
> > +               insn = (long)entry->insn + (unsigned long)&entry->insn;
> > +               tramp = (long)entry->tramp + (unsigned long)&entry->tramp;
> > +
> > +               insn_opcode = *(unsigned char *)insn;
> > +               if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
> > +                       WARN_ONCE(1, "unexpected static call insn opcode %x at %pS",
> > +                                 insn_opcode, (void *)insn);
> > +                       continue;
> > +               }
> > +
> > +               tramp_opcode = *(unsigned char *)tramp;
> > +               if (tramp_opcode != 0xeb && tramp_opcode != 0xe9) {
> > +                       WARN_ONCE(1, "unexpected trampoline jump opcode %x at %ps",
> > +                                tramp_opcode, (void *)tramp);
> > +                       continue;
> > +               }
> > +
> > +               if (tramp_opcode == 0xeb)
> > +                       func = *(s8 *)(tramp + 1) + (tramp + 2);
> 
> I realize you expect some instances of 0xeb due to the assembler
> messing you up (see above), but this seems a bit too permissive, since
> a 0xeb without the appropriate set of NOPs is going to explode.  And:

Yep.

> > +               else
> > +                       func = *(s32 *)(tramp + 1) + (tramp + 5);
> > +
> > +               call_dest = (long)(func) - (long)(insn + 5);
> > +
> > +               printk("static_call_init: poking %lx at %lx\n", (unsigned long)call_dest, (insn+1));
> > +
> > +               text_poke_early((void *)(insn + 1), &call_dest, 4);
> 
> If you really are going to rewrite an 8-bit jump to a 32-bit jump, I
> think you need to actually patch the opcode byte :)

Oops :-)

-- 
Josh
