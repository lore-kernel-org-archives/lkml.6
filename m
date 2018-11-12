Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AA20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8AA20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeKLM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:58:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeKLM6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D7763082E4D;
        Mon, 12 Nov 2018 03:07:27 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D801974D;
        Mon, 12 Nov 2018 03:07:24 +0000 (UTC)
Date:   Sun, 11 Nov 2018 21:07:22 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181112030722.da5cxslvlmdgttsw@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home>
 <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home>
 <20181109203459.wbftlkxcvfnwo2bm@treble>
 <20181110001023.57f27312@vmware.local.home>
 <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
 <20181110080917.29af5d66@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181110080917.29af5d66@vmware.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 12 Nov 2018 03:07:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 08:09:17AM -0500, Steven Rostedt wrote:
> On Sat, 10 Nov 2018 12:58:08 +0100
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> 
> > > The complaint is on:
> > >
> > >         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
> > >
> > > And the previous definition is on:
> > >
> > >         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
> > >  
> > 
> > Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
> > ensure that symbols with static linkage are not optimized away, but
> > since the reference is from a header file, the symbol should have
> > external linkage anyway.

Yes, DECLARE needs the __ADDRESSABLE.  In the case where DECLARE
is used, but DEFINE is not, GCC strips the symbol.

> I applied the following change and it compiled fine:
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 90b580b95303..5f8a0f0e77be 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -108,8 +108,6 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
>  #define DECLARE_STATIC_CALL(key, func)					\
>  	extern struct static_call_key key;				\
>  	extern typeof(func) STATIC_CALL_TRAMP(key);			\
> -	/* Preserve the ELF symbol so objtool can access it: */		\
> -	__ADDRESSABLE(key)
>  
>  #define DEFINE_STATIC_CALL(key, _func)					\
>  	DECLARE_STATIC_CALL(key, _func);				\
> @@ -117,7 +115,9 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
>  		.func = _func,						\
>  		.site_mods = LIST_HEAD_INIT(key.site_mods),		\
>  	};								\
> -	ARCH_STATIC_CALL_TEMPORARY_TRAMP(key)
> +	ARCH_STATIC_CALL_TEMPORARY_TRAMP(key);				\
> +	/* Preserve the ELF symbol so objtool can access it: */		\
> +	__ADDRESSABLE(key)
>  
>  #define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)

Adding __ADDRESSABLE to the DEFINE macro doesn't do any good.  By
definition, the key is defined in the .o file, so the symbol already
exists.

The issue you're seeing is really an issue with the __ADDRESSABLE macro
not creating unique symbol names.  This should fix it:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 06396c1cf127..4bb73fd918b5 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -282,7 +282,7 @@ unsigned long read_word_at_a_time(const void *addr)
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(".discard.addressable") __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__addressable_##sym) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
