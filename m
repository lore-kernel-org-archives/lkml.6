Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF86C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfAOFit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:38:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50157 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfAOFis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:38:48 -0500
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0F5bmsP2381477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 14 Jan 2019 21:37:49 -0800
Subject: Re: [PATCH v3 0/6] Static calls
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
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
 <8ca16cca-101d-1d1b-b3da-c9727665fec8@zytor.com>
 <CALCETrVGoVbToA7Dw_mo_gojvFnS=vB=UJxQgDi_R00skSX8pg@mail.gmail.com>
 <dd57daf3-4762-07c3-e0be-2cbb605802e4@zytor.com>
Message-ID: <bd8e2753-e460-7641-5b52-e4cb9ab1fc10@zytor.com>
Date:   Mon, 14 Jan 2019 21:37:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dd57daf3-4762-07c3-e0be-2cbb605802e4@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 9:01 PM, H. Peter Anvin wrote:
> 
> This could be as simple as spinning for a limited time waiting for
> states 0 or 3 if we are not the patching CPU. It is also not necessary
> to wait for the mask to become zero for the first sync if we find
> ourselves suddenly in state 4.
> 

So this would look something like this for the #BP handler; I think this
is safe.  This uses the TLB miss on the write page intentionally to slow
down the loop a bit to reduce the risk of livelock.  Note that
"bp_write_addr" here refers to the write address for the breakpoint that
was taken.

	state = atomic_read(&bp_poke_state);
	if (state == 0)
		return 0;		/* No patching in progress */

recheck:
	clear bit in mask

	switch (state) {
		case 1:
		case 4:
			if (smp_processor_id() != bp_patching_cpu) {
				int retries = NNN;
				while (retries--) {
					invlpg
					if (*bp_write_addr != 0xcc)
						goto recheck;
					state = atomic_read(&bp_poke_state);
					if (state != 1 && state != 4)
						goto recheck;
				}
			}
			state = cmpxchg(&bp_poke_state, 1, 4);
			if (state != 1 && state != 4)
				goto recheck;
			atomic_write(bp_write_addr, bp_old_value);
			break;
		case 2:
			if (smp_processor_id() != bp_patching_cpu) {
				invlpg
				state = atomic_read(&bp_poke_state);
				if (state != 2)
					goto recheck;
			}
			complete patch sequence
			remove breakpoint
			break;

		case 3:
		case 0:
			/*
			 * If we are here, the #BP will go away on its
			 * own, or we will re-take it if it was a "real"
			 * breakpoint.
			 */
			break;
	}
	return 1;
