Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3341120879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfAJRUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbfAJRUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:20:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3876C0C4297;
        Thu, 10 Jan 2019 17:20:12 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4364C600C3;
        Thu, 10 Jan 2019 17:20:06 +0000 (UTC)
Date:   Thu, 10 Jan 2019 11:20:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Message-ID: <20190110172004.wuh45xoafynfm2df@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 17:20:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:32:23AM +0000, Nadav Amit wrote:
> > @@ -714,14 +714,39 @@ void *text_poke(void *addr, const void *opcode, size_t len)
> > 	}
> > 	BUG_ON(!pages[0]);
> > 	local_irq_save(flags);
> > +
> > 	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
> > 	if (pages[1])
> > 		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
> > -	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
> > -	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
> > +
> > +	vaddr = fix_to_virt(FIX_TEXT_POKE0) + ((unsigned long)addr & ~PAGE_MASK);
> > +
> > +	/*
> > +	 * Use a single access where possible.  Note that a single unaligned
> > +	 * multi-byte write will not necessarily be atomic on x86-32, or if the
> > +	 * address crosses a cache line boundary.
> > +	 */
> > +	switch (len) {
> > +	case 1:
> > +		WRITE_ONCE(*(u8 *)vaddr, *(u8 *)opcode);
> > +		break;
> > +	case 2:
> > +		WRITE_ONCE(*(u16 *)vaddr, *(u16 *)opcode);
> > +		break;
> > +	case 4:
> > +		WRITE_ONCE(*(u32 *)vaddr, *(u32 *)opcode);
> > +		break;
> > +	case 8:
> > +		WRITE_ONCE(*(u64 *)vaddr, *(u64 *)opcode);
> > +		break;
> > +	default:
> > +		memcpy((void *)vaddr, opcode, len);
> > +	}
> > +
> 
> Even if Intel and AMD CPUs are guaranteed to run instructions from L1
> atomically, this may break instruction emulators, such as those that
> hypervisors use. They might not read instructions atomically if on SMP VMs
> when the VM's text_poke() races with the emulated instruction fetch.
> 
> While I can't find a reason for hypervisors to emulate this instruction,
> smarter people might find ways to turn it into a security exploit.

Interesting point... but I wonder if it's a realistic concern.  BTW,
text_poke_bp() also relies on undocumented behavior.

The entire instruction doesn't need to be read atomically; just the
32-bit call destination.  Assuming the hypervisor is x86-64, and it uses
a 32-bit access to read the call destination (which seems logical), the
intra-cacheline reads will be atomic, as stated in the SDM.

If the above assumptions are not true, and the hypervisor reads the call
destination non-atomically (which seems unlikely IMO), even then I don't
see how it could be realistically exploitable.  It would just oops from
calling a corrupt address.

-- 
Josh
