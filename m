Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F2F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaKHFIl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F2F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeK0DeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:34:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeK0DeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=44aeCHeKySluNGD7M4jVwHCSxTCuoMjwIkcW4/8Nidk=; b=FaKHFIl8bsuEqOzSMl1jzS6py
        HclEQIXlxKLLmQJhRNELeO43u814KBfnZnooLEkPUTg9IRABpDdBAsDSYfc73nDreWg0s1d11aXNt
        O/y0TxRx4m8NzVUEcJYYfRAWmPs1XMgvgp3P9kQ3oHPgJTmnPk/KOncgs7VgFna1x6qmKyxPzU4Fh
        UL97DJxyeH5VNKsAmrvMQSL5Zq2Ui6r/m8pblasXa9xdw5rQ60XvXicHHGFLVODfL0ij3HB/6Js/G
        p0SgbVXQznnkwOSkUY8aMBimx+iZdaVqvWbFeUoTk6XZ+DcMIIQp360s9T8bhv7KOPjh1e8gMcjUF
        +WZDN3Jgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRJuu-0005xy-Pm; Mon, 26 Nov 2018 16:39:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E8E72029FD58; Mon, 26 Nov 2018 17:39:23 +0100 (CET)
Date:   Mon, 26 Nov 2018 17:39:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com,
        Jessica Yu <jeyu@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126163923.GT2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160837.GS2113@hirez.programming.kicks-ass.net>
 <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:11:05PM +0100, Ard Biesheuvel wrote:
> On Mon, 26 Nov 2018 at 17:08, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > > +void arch_static_call_defuse_tramp(void *site, void *tramp)
> > > +{
> > > +     unsigned short opcode = INSN_UD2;
> > > +
> > > +     mutex_lock(&text_mutex);
> > > +     text_poke((void *)tramp, &opcode, 2);
> > > +     mutex_unlock(&text_mutex);
> > > +}
> > > +#endif
> >
> > I would rather think that makes the trampoline _more_ dangerous, rather
> > than less so.
> >
> > My dictionary sayeth:
> >
> >   defuse: verb
> >
> >     - remove the fuse from (an explosive device) in order to prevent it
> >       from exploding.
> >
> >     - make (a situation) less tense or dangerous
> >
> > patching in an UD2 seems to do the exact opposite.
> 
> That is my fault.
> 
> The original name was 'poison' iirc, but on arm64, we need to retain
> the trampoline for cases where the direct branch is out of range, and
> so poisoning is semantically inaccurate.
> 
> But since you opened your dictionary anyway, any better suggestions? :-)

I was leaning towards: "prime", but I'm not entirely sure that works
with your case.
