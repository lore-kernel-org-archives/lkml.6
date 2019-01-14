Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0B3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D112063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfANWzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:55:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54601 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfANWzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:55:36 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.82])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0EMsCZn2255335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 14 Jan 2019 14:54:13 -0800
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
 <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
 <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
Message-ID: <8ca16cca-101d-1d1b-b3da-c9727665fec8@zytor.com>
Date:   Mon, 14 Jan 2019 14:54:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this sequence ought to work (keep in mind we are already under a
mutex, so the global data is safe even if we are preempted):

	set up page table entries
	invlpg
	set up bp patching global data

	cpu = get_cpu()

	bp_old_value = atomic_read(bp_write_addr)

	do {
		atomic_write(&bp_poke_state, 1)

		atomic_write(bp_write_addr, 0xcc)

		mask <- online_cpu_mask - self
		send IPIs
		wait for mask = 0

	} while (cmpxchg(&bp_poke_state, 1, 2) != 1);

	patch sites, remove breakpoints after patching each one

	atomic_write(&bp_poke_state, 3);

	mask <- online_cpu_mask - self
	send IPIs
	wait for mask = 0

	atomic_write(&bp_poke_state, 0);

	tear down patching global data
	tear down page table entries



The #BP handler would then look like:

	state = cmpxchg(&bp_poke_state, 1, 4);
	switch (state) {
		case 1:
		case 4:
			invlpg
			cmpxchg(bp_write_addr, 0xcc, bp_old_value)
			break;
		case 2:
			invlpg
			complete patch sequence
			remove breakpoint
			break;
		case 3:
			/* If we are here, the #BP will go away on its own */
			break;
		case 0:
			/* No patching in progress!!! */
			return 0;
	}

	clear bit in mask
	return 1;

The IPI handler:

	clear bit in mask
	sync_core	/* Needed if multiple IPI events are chained */
