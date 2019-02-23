Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B95206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWz9+Aq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfBWIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:37:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBWIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4kMxVOsjHMsew8RNRO/ugrKjOAHdHQ2hpNyfdW1vu/c=; b=UWz9+Aq7w8WBS/KmrtuhyBnlo
        1uXLXa3HKKryzgHPG14sDmalHGhvWq3i3YJT0vvnv0micU+WxKsvGuRyqED/WJnjGkxB0mcNOWEED
        OusFFrQtVMc4EGjVMQ/GHzma+uqpOlljrMcoZ4CcLbyVDFXtqa78y19a4R3jksXAYGzSxRo69ia1x
        KQCMYyHxS95nL5JrfPpR+YzWG1K73gR05koEC4SrhzzasvZNdAtx7/3lu8kVt8X3ssShEymKVq2yj
        0+453GNpHusXbzMhveQMi4BmKI7qNoC0fmtwc63HbMgr3BbxHf1ylWcGwJmUjAv2MsuhiJLMEpv2/
        MRvsV+7vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxSnz-0004qx-Oo; Sat, 23 Feb 2019 08:37:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2019B20259708; Sat, 23 Feb 2019 09:37:06 +0100 (CET)
Date:   Sat, 23 Feb 2019 09:37:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190223083706.GE32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:55:25PM -0800, Andy Lutomirski wrote:
> On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:

> >   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC
> 
> Does objtool understand altinstr?

Yep, otherwise it would've never found any of the STAC/CLAC instructions
to begin with, they're all alternatives. The emitted code is all NOPs.

> If it understands that this is an
> altinstr associated with a not-actually-a-fuction (i.e. END not
> ENDPROC) piece of code, it could suppress this warning.

Using readelf on entry_64.o the symbol type appears to be STT_NOTYPE for
these 'functions', so yes, I can try and ignore this warning for those.

> > +#define AC_SAFE(func) \
> > +       static void __used __section(.discard.ac_safe) \
> > +               *__func_ac_safe_##func = func
> 
> Are we okay with annotating function *declarations* in a way that
> their addresses get taken whenever the declaration is processed?  It
> would be nice if we could avoid this.
> 
> I'm wondering if we can just change the code that does getreg() and
> load_gs_index() so it doesn't do it with AC set.  Also, what about
> paravirt kernels?  They'll call into PV code for load_gs_index() with
> AC set.

Fixing that code would be fine; but we need that annotation regardless,
read Linus' email a little further back, he wants things like
copy_{to,from}_user_unsafe().

Those really would need to be marked AC-safe, there's no inlining that.

That said, yes these annotations _suck_. But it's what we had and works,
I'm just copying it (from STACK_FRAME_NON_STANDARD).

That said; maybe we can do something like:

#define AC_SAFE(func)						\
	asm (".pushsection .discard.ac_safe_sym\n\t"		\
	     "999: .ascii \"" #func "\"\n\t"			\
	     ".popsection\n\t"					\
	     ".pushsection .discard.ac_safe\n\t"		\
	     _ASM_PTR " 999b\n\t"				\
	     ".popsection")

I just don't have a clue on how to read that in objtool; weak elf foo.
I'll see if I can make it work.
