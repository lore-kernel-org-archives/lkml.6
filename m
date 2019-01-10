Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7506EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1192173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfAJQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfAJQ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:28:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84007C0BF2A2;
        Thu, 10 Jan 2019 16:28:15 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8254427C5B;
        Thu, 10 Jan 2019 16:28:12 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:28:10 -0600
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
Subject: Re: [PATCH v3 3/6] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20190110162810.fgrmezgecvbekloe@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <30f0713894a415f13e0f0ea3d40595416db2f6d7.1547073843.git.jpoimboe@redhat.com>
 <B4C5F8DE-5337-47F1-AD59-93B375A323C2@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B4C5F8DE-5337-47F1-AD59-93B375A323C2@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 16:28:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:16:34AM +0000, Nadav Amit wrote:
> > On Jan 9, 2019, at 2:59 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> 
> <snip>
> 
> > +
> > +void __ref arch_static_call_transform(void *site, void *tramp, void *func)
> > +{
> > +	s32 dest_relative;
> > +	unsigned char opcode;
> > +	void *(*poker)(void *, const void *, size_t);
> > +	void *insn = tramp;
> > +
> > +	mutex_lock(&text_mutex);
> > +
> > +	/*
> > +	 * For x86-64, a 32-bit cross-modifying write to a call destination is
> > +	 * safe as long as it's within a cache line.
> > +	 */
> > +	opcode = *(unsigned char *)insn;
> > +	if (opcode != 0xe8 && opcode != 0xe9) {
> > +		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
> > +			  opcode, insn);
> > +		goto done;
> > +	}
> > +
> > +	dest_relative = (long)(func) - (long)(insn + CALL_INSN_SIZE);
> > +
> > +	poker = early_boot_irqs_disabled ? text_poke_early : text_poke;
> > +	poker(insn + 1, &dest_relative, sizeof(dest_relative));
> > +
> > +done:
> > +	mutex_unlock(&text_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_static_call_transform);
> 
> Err… I was rewriting __jump_label_transform(), so if this code duplication can
> be avoided, this would be great.
> 
> (See https://lkml.org/lkml/2018/11/14/72 )

I don't see much code duplication, because __jump_label_transform() uses
text_poke_bp(), whereas this uses text_poke().

It's true they both fall back to text_poke_early(), but I don't see any
opportunities for sharing code there, unless we decide to go back to
using breakpoints.

-- 
Josh
