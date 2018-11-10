Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD81C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BFF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BFF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeKJWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbeKJWyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:54:19 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B399720854;
        Sat, 10 Nov 2018 13:09:19 +0000 (UTC)
Date:   Sat, 10 Nov 2018 08:09:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Message-ID: <20181110080917.29af5d66@vmware.local.home>
In-Reply-To: <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
        <20181109133337.63487e3a@gandalf.local.home>
        <20181109193505.5p5iddrtgpk2cpb4@treble>
        <20181109145746.0037da3f@gandalf.local.home>
        <20181109203459.wbftlkxcvfnwo2bm@treble>
        <20181110001023.57f27312@vmware.local.home>
        <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 12:58:08 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:


> > The complaint is on:
> >
> >         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
> >
> > And the previous definition is on:
> >
> >         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
> >  
> 
> Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
> ensure that symbols with static linkage are not optimized away, but
> since the reference is from a header file, the symbol should have
> external linkage anyway.

I applied the following change and it compiled fine:

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 90b580b95303..5f8a0f0e77be 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -108,8 +108,6 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
 #define DECLARE_STATIC_CALL(key, func)					\
 	extern struct static_call_key key;				\
 	extern typeof(func) STATIC_CALL_TRAMP(key);			\
-	/* Preserve the ELF symbol so objtool can access it: */		\
-	__ADDRESSABLE(key)
 
 #define DEFINE_STATIC_CALL(key, _func)					\
 	DECLARE_STATIC_CALL(key, _func);				\
@@ -117,7 +115,9 @@ extern void arch_static_call_poison_tramp(unsigned long insn);
 		.func = _func,						\
 		.site_mods = LIST_HEAD_INIT(key.site_mods),		\
 	};								\
-	ARCH_STATIC_CALL_TEMPORARY_TRAMP(key)
+	ARCH_STATIC_CALL_TEMPORARY_TRAMP(key);				\
+	/* Preserve the ELF symbol so objtool can access it: */		\
+	__ADDRESSABLE(key)
 
 #define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)

Thanks!
 
-- Steve
