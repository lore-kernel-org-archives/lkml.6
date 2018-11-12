Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00400C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9C216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="al0LhlCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9C216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbeKLP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbeKLP0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:26:34 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0183F223CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542000897;
        bh=edNjwfl6DjLQ/ViI74m6jOCSqKOuP8oJ5IqQwsPa6M0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=al0LhlCgl1kuOpq7IXGQP6hfJWae2IQs/bv8jpeai6s5oZfHghSDcUafkeuX/R55a
         cQXwkcRizI6+Imu/Hm/kuq2vHxg8vIIkp+j9QPy68OiqpbnjnVJAH17ca+f1noYKHv
         ubjZuCiKRlDuWQ/qshqz5mR7MlN6WtLRIVKASf2U=
Received: by mail-wm1-f48.google.com with SMTP id w7-v6so7146388wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:34:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gJoS/bPlHzO8F5SOn69EqmLPOMuu716XfmFzvDooQFe1aKZ1tJl
        VmBkqM+lKwjfG8laSLJYjNXzJcT9/RTJQs9lmOX8QA==
X-Google-Smtp-Source: AJdET5d8SawewvIPiQVjH3irXCD3rL3cfmiOsEhZN1Vi/oCiNwTWx+HH7GIs6K+pzTE38Db8+rgarKVrUbOSEzRxg3Q=
X-Received: by 2002:a1c:410a:: with SMTP id o10-v6mr6561587wma.19.1542000895301;
 Sun, 11 Nov 2018 21:34:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble> <20181112050241.GB28219@gmail.com>
In-Reply-To: <20181112050241.GB28219@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 11 Nov 2018 21:34:42 -0800
X-Gmail-Original-Message-ID: <CALCETrUBptKGkDGx7a29mX=aj6E5bGCV2eJHgVRz6ymBgoSPZg@mail.gmail.com>
Message-ID: <CALCETrUBptKGkDGx7a29mX=aj6E5bGCV2eJHgVRz6ymBgoSPZg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:02 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > > > - I'm not sure about the objtool approach.  Objtool is (currently)
> > > >   x86-64 only, which means we have to use the "unoptimized" version
> > > >   everywhere else.  I may experiment with a GCC plugin instead.
> > >
> > > I'd prefer the objtool approach. It's a pretty reliable first-principles
> > > approach while GCC plugin would have to be replicated for Clang and any
> > > other compilers, etc.
> >
> > The benefit of a plugin is that we'd only need two of them: GCC and
> > Clang.  And presumably, they'd share a lot of code.
> >
> > The prospect of porting objtool to all architectures is going to be much
> > more of a daunting task (though we are at least already considering it
> > for some arches).
>
> Which architectures would benefit from ORC support the most?
>
> I really think that hard reliance on GCC plugins is foolish - but maybe
> Clang's plugin infrastructure is a guarantee that it remains a sane and
> usable interface.
>
> > > I'd be very happy with a demonstrated paravirt optimization already -
> > > i.e. seeing the before/after effect on the vmlinux with an x86 distro
> > > config.
> > >
> > > All major Linux distributions enable CONFIG_PARAVIRT=y and
> > > CONFIG_PARAVIRT_XXL=y on x86 at the moment, so optimizing it away as much
> > > as possible in the 99.999% cases where it's not used is a primary
> > > concern.
> >
> > For paravirt, I was thinking of it as more of a cleanup than an
> > optimization.  The paravirt patching code already replaces indirect
> > branches with direct ones -- see paravirt_patch_default().
> >
> > Though it *would* reduce the instruction footprint a bit, as the 7-byte
> > indirect calls (later patched to 5-byte direct + 2-byte nop) would
> > instead be 5-byte direct calls to begin with.
>
> Yes.

It would be a huge cleanup IMO -- the existing PVOP call stuff is
really quite ugly IMO.  Also, the existing stuff tries to emulate the
semantics of passing parameters of unknown types using asm
constraints, and I just don't believe that GCC does what we want it to
do.  In general, passing the *value* of a pointer to asm doesn't seem
to convince gcc that the pointed-to value is used by the asm, and this
makes me nervous.  See commit 715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
as an example of this.  In a similar vein, the existing PVOP calls
have a "memory" clobber, and that's not free.
