Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5055C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885F420664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G98QwTpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885F420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK0D2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeK0D2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:28:24 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFB520873
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543250028;
        bh=F9X8gSPYU5g00qTFKiQY44TvB1nBdMyerdBa5kRWdyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G98QwTpY90n7UuDLCqaYdkeCLxgKdXVMfIchSGGE+XbGj9vPT6ujRYz27toZ13TUb
         yhcunWYxRhk1QgZCOkDesXodK/W7suxmvBJ+x9d4j7p2JfkvXJT9BOvldlYGcyvnw5
         E7iO+UqXMLm0PI1pJgY24e84wAXb/tMlkgh6oyKs=
Received: by mail-wm1-f42.google.com with SMTP id s11so19247950wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:33:47 -0800 (PST)
X-Gm-Message-State: AGRZ1gIkJLuviGSljTc8a7xhVqAVZwdMf3c2OqXreQKzYOnFZH04TkCg
        ensGz/4ptUpfGydiMENxEcvNdG7hzZgTZd8ZUXJn6Q==
X-Google-Smtp-Source: AJdET5e0sG1wxP4kRg+Hg3EGbhjzmJqDCd5pDexrRqR/fpvF+Uykr00HgNq18mrh1AFKx17GhA4VQ+fEe898G+wHGcQ=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr23683909wme.108.1543250026204;
 Mon, 26 Nov 2018 08:33:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160837.GS2113@hirez.programming.kicks-ass.net> <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Nov 2018 08:33:33 -0800
X-Gmail-Original-Message-ID: <CALCETrX3YJSkjsza9RZWC9E7sDjyoOp_=on0MOTsMTBrYPOiSQ@mail.gmail.com>
Message-ID: <CALCETrX3YJSkjsza9RZWC9E7sDjyoOp_=on0MOTsMTBrYPOiSQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 8:11 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
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

Release?  Finish?
