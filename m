Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D6520657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfANClf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:41:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43627 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfANClf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:41:35 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0E2eht61850475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 13 Jan 2019 18:40:43 -0800
Subject: Re: [PATCH v3 0/6] Static calls
From:   "H. Peter Anvin" <hpa@zytor.com>
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
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com>
Message-ID: <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
Date:   Sun, 13 Jan 2019 18:40:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/19 6:31 PM, H. Peter Anvin wrote:
> 
> static cpumask_t text_poke_cpumask;
> 
> static void text_poke_sync(void)
> {
> 	smp_wmb();
> 	text_poke_cpumask = cpu_online_mask;
> 	smp_wmb();	/* Should be optional on x86 */
> 	cpumask_clear_cpu(&text_poke_cpumask, smp_processor_id());
> 	on_each_cpu_mask(&text_poke_cpumask, text_poke_sync_cpu, NULL, false);
> 	while (!cpumask_empty(&text_poke_cpumask)) {
> 		cpu_relax();
> 		smp_rmb();
> 	}
> }
> 
> static void text_poke_sync_cpu(void *dummy)
> {
> 	(void)dummy;
> 
> 	smp_rmb();
> 	cpumask_clear_cpu(&poke_bitmask, smp_processor_id());
> 	/*
> 	 * We are guaranteed to return with an IRET, either from the
> 	 * IPI or the #BP handler; this provides serialization.
> 	 */
> }
> 

The invariants here are:

1. The patching routine must set each bit in the cpumask after each event
   that requires synchronization is complete.
2. The bit can be (atomically) cleared on the target CPU only, and only in a
   place that guarantees a synchronizing event (e.g. IRET) before it may
   reaching the poked instruction.
3. At a minimum the IPI handler and #BP handler needs to clear the bit. It
   *is* also possible to clear it in other places, e.g. the NMI handler, if
   necessary as long as condition 2 is satisfied.

	-hpa
