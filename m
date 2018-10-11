Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE1C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AAF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AAF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeJKUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:20:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJKUUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9752F5F724;
        Thu, 11 Oct 2018 12:53:06 +0000 (UTC)
Received: from treble (ovpn-122-227.rdu2.redhat.com [10.10.122.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8BF7A536;
        Thu, 11 Oct 2018 12:53:01 +0000 (UTC)
Date:   Thu, 11 Oct 2018 07:52:58 -0500
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
Message-ID: <20181011125258.ihsdmonepaoc5xtb@treble>
References: <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble>
 <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
 <20181010181605.arsyjxwdztztrjih@treble>
 <20181010181741.lc4l7kjvcmoxrw5b@treble>
 <CALCETrUZMmTDOh5-Mzyj1rk7Q82DgdQLinOfbzF4Sb7OC2aYMQ@mail.gmail.com>
 <20181011030738.wwy6grnss67txd2l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011030738.wwy6grnss67txd2l@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Oct 2018 12:53:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:07:38PM -0500, Josh Poimboeuf wrote:
> On Wed, Oct 10, 2018 at 02:13:22PM -0700, Andy Lutomirski wrote:
> > On Wed, Oct 10, 2018 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Oct 10, 2018 at 01:16:05PM -0500, Josh Poimboeuf wrote:
> > > > On Wed, Oct 10, 2018 at 11:03:43AM -0700, Andy Lutomirski wrote:
> > > > > > +#define DECLARE_STATIC_CALL(tramp, func)                               \
> > > > > > +       extern typeof(func) tramp;                                      \
> > > > > > +       static void __used __section(.discard.static_call_tramps)       \
> > > > > > +               *__static_call_tramp_##tramp = tramp
> > > > > > +
> > > > >
> > > > > Confused.  What's the __static_call_tramp_##tramp variable for?  And
> > > > > why is a DECLARE_ macro defining a variable?
> > > >
> > > > This is the magic needed for objtool to find all the call sites.
> > > >
> > > > The variable itself isn't needed, but the .discard.static_call_tramps
> > > > entry is.  Objtool reads that section to find out which function call
> > > > sites are targeted to a static call trampoline.
> > >
> > > To clarify: objtool reads that section to find out which functions are
> > > really static call trampolines.  Then it annotates all the instructions
> > > which call/jmp to those trampolines.  Those annotations are then read by
> > > the kernel.
> > >
> > 
> > Ah, right, and objtool runs on a per-object basis so it has no other
> > way to know what symbols are actually static calls.
> > 
> > There's another way to skin this cat, though:
> > 
> > extern typeof(func) __static_call_trampoline_##tramp;
> > #define tramp __static_call_trampoline_##tramp
> > 
> > And objtool could recognize it by name.  But, of course, you can't put
> > a #define in a macro.  But maybe there's a way to hack it up with a
> > static inline?

I went with something similar in the latest version.  It's less
surprising in a couple of ways:

- DECLARE_STATIC_CALL doesn't have the magic objtool definition.

- Call sites use the static_call() wrapper, which makes static calls
  clearly visible.


#define STATIC_CALL_TRAMP(key) ____static_call_tramp_##key
#define STATIC_CALL_PTR(key)   ____static_call_ptr_##key

#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
#define STATIC_CALL_PTR_STR(key) __stringify(STATIC_CALL_PTR(key))

#define DECLARE_STATIC_CALL(key, func)					\
	extern typeof(func)  STATIC_CALL_TRAMP(key);			\
	extern typeof(func) *STATIC_CALL_PTR(key)

#define DEFINE_STATIC_CALL(key, func)					\
	typeof(func) *STATIC_CALL_PTR(key) = func;			\
	asm(".pushsection .text, \"ax\"				\n"	\
	    ".align 4						\n"	\
	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
	    "jmpq *" STATIC_CALL_PTR_STR(key) "(%rip)		\n"	\
	    ".popsection					\n")

#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)

#define static_call_update(key, func)					\
({									\
	STATIC_CALL_PTR(key) = func;					\
	__static_call_update((void **)&STATIC_CALL_PTR(key));		\
})

-- 
Josh
