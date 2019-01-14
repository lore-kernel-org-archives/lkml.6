Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEBA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfANCdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:33:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35867 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfANCdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:33:03 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0E2VOgp1848340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 13 Jan 2019 18:31:25 -0800
Subject: Re: [PATCH v3 0/6] Static calls
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
 <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com>
Date:   Sun, 13 Jan 2019 18:31:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 11:39 AM, Jiri Kosina wrote:
> On Fri, 11 Jan 2019, hpa@zytor.com wrote:
> 
>> I still don't see why can't simply spin in the #BP handler until the 
>> patch is complete.
> 
> I think this brings us to the already discussed possible deadlock, when 
> one CPU#0 is in the middle of text_poke_bp(), CPU#1 is spinning inside 
> spin_lock_irq*(&lock) and CPU#2 hits the breakpont while holding that very 
> 'lock'.
> 
> Then we're stuck forever, because CPU#1 will never handle the pending 
> sync_core() IPI (it's not NMI).
> 
> Or have I misunderstood what you meant?
> 

OK, I was thinking about this quite a while ago, and even started hacking on
it, but apparently I managed to forget some key details.

Specifically, you do *not* want to use the acknowledgment of the IPI as the
blocking condition, so don't use a waiting IPI.

Instead, you want a CPU bitmap (or percpu variable) that the IPI handler
clears.  When you are spinning in the IPI handler, you *also* need to clear
that bit.  Doing so is safe even in the case of batched updates, because you
are guaranteed to execute an IRET before you get to patched code.

So the synchronization part of the patching routine becomes:

static cpumask_t text_poke_cpumask;

static void text_poke_sync(void)
{
	smp_wmb();
	text_poke_cpumask = cpu_online_mask;
	smp_wmb();	/* Optional on x86 */
	cpumask_clear_cpu(&text_poke_cpumask, smp_processor_id());
	on_each_cpu_mask(&text_poke_cpumask, text_poke_sync_cpu, NULL, false);
	while (!cpumask_empty(&text_poke_cpumask)) {
		cpu_relax();
		smp_rmb();
	}
}

static void text_poke_sync_cpu(void *dummy)
{
	(void)dummy;

	smp_rmb();
	cpumask_clear_cpu(&poke_bitmask, smp_processor_id());
	/*
	 * We are guaranteed to return with an IRET, either from the
	 * IPI or the #BP handler; this provides serialization.
	 */
}

The spin routine then needs add a call to do something like this. By
(optionally) not comparing to a specific breakpoint address we allow for
batching, but we may end up spinning on a breakpoint that is not actually a
patching breakpoint until the patching is done.

int poke_int3_handler(struct pt_regs *regs)
{
	/* In the current handler, but shouldn't be needed... */
	smp_rmb();

	if (likely(!atomic_read(bp_patching_in_progress)))
		return 0;

	if (user_mode(regs) unlikely(!user_mode(regs) &&
	    atomic_read(&bp_patching_in_progress)) {
		text_poke_sync();
		regs->ip--;
		return 1;	/* May end up retaking the trap */
	} else {
		return 0;
	}
}

Unless I'm totally mistaken, the worst thing that will happen with this code
is that it may end up taking a harmless spurious IPI at a later time.

	-hpa
