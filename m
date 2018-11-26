Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE820659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BE820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeK0DjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:39:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbeK0DjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:39:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A53C6307DAA3;
        Mon, 26 Nov 2018 16:44:37 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C69985C229;
        Mon, 26 Nov 2018 16:44:33 +0000 (UTC)
Date:   Mon, 26 Nov 2018 10:44:31 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Message-ID: <20181126164431.o2y65t3nbhyl2shn@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160837.GS2113@hirez.programming.kicks-ass.net>
 <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
 <20181126163923.GT2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181126163923.GT2113@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Nov 2018 16:44:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:39:23PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 26, 2018 at 05:11:05PM +0100, Ard Biesheuvel wrote:
> > On Mon, 26 Nov 2018 at 17:08, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > > > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > > > +void arch_static_call_defuse_tramp(void *site, void *tramp)
> > > > +{
> > > > +     unsigned short opcode = INSN_UD2;
> > > > +
> > > > +     mutex_lock(&text_mutex);
> > > > +     text_poke((void *)tramp, &opcode, 2);
> > > > +     mutex_unlock(&text_mutex);
> > > > +}
> > > > +#endif
> > >
> > > I would rather think that makes the trampoline _more_ dangerous, rather
> > > than less so.
> > >
> > > My dictionary sayeth:
> > >
> > >   defuse: verb
> > >
> > >     - remove the fuse from (an explosive device) in order to prevent it
> > >       from exploding.
> > >
> > >     - make (a situation) less tense or dangerous
> > >
> > > patching in an UD2 seems to do the exact opposite.
> > 
> > That is my fault.
> > 
> > The original name was 'poison' iirc, but on arm64, we need to retain
> > the trampoline for cases where the direct branch is out of range, and
> > so poisoning is semantically inaccurate.
> > 
> > But since you opened your dictionary anyway, any better suggestions? :-)
> 
> I was leaning towards: "prime", but I'm not entirely sure that works
> with your case.

Maybe we should just go back to "poison", along with a comment that it
will not necessarily be poisoned for all arches.  I think "poison" at
least describes the intent, if not always the implementation.

-- 
Josh
