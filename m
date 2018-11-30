Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B246B2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1OOS1qGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B246B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeLADwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeLADwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:52:35 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94D72147D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543596161;
        bh=Xdu8CSMMhpHTJYPKAGfZoFnMfbGtGPIK7wVSfna4YyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1OOS1qGMMLWYs35wxfIih4SkkhASbVuTDPGrLzp8wzEaYyWlgMIgP3gGS4VKp3crw
         e9A7Yj/TCgtWeXCS8o0JFTTFzgAsGiQ127VP2YB2RkL1pCuB4fYCsxMyAesF9NA20q
         Z2QjBDfcIi0yjZHQqss4VIf5yI/1QT/2IX4EzHpQ=
Received: by mail-wr1-f53.google.com with SMTP id v13so5909491wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:42:40 -0800 (PST)
X-Gm-Message-State: AA+aEWZv3OrKB2STSWnRPbf7Jf9iVb5QQXgjMCAudhNa5WcVfBffnJ9R
        xWBEBujt0zEOLg260tHI0EiIvf9gRggYm+iBW5Wj/w==
X-Google-Smtp-Source: AFSGD/VBRZzQU0EoDTIz1IucLqF2DeaZxyv5J/UMmXglTDraH1/dI0j4fB1zdWKP0HR0do8YhONJ5gWaAwmRYKDof78=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr5429175wrm.309.1543596159325;
 Fri, 30 Nov 2018 08:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20181129121307.12393c57@gandalf.local.home> <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com> <20181129202452.56f4j2wdct6qbaqo@treble>
In-Reply-To: <20181129202452.56f4j2wdct6qbaqo@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 08:42:26 -0800
X-Gmail-Original-Message-ID: <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
Message-ID: <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Nov 29, 2018 at 12:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > Alternatively, we could actually emulate call instructions like this:
> >
> > void __noreturn jump_to_kernel_pt_regs(struct pt_regs *regs, ...)
> > {
> >   struct pt_regs ptregs_copy = *regs;
> >   barrier();
> >   *(unsigned long *)(regs->sp - 8) = whatever;  /* may clobber old
> > regs, but so what? */
> >   asm volatile ("jmp return_to_alternate_ptregs");
> > }
> >
> > where return_to_alternate_ptregs points rsp to the ptregs and goes
> > through the normal return path.  It's ugly, but we could have a test
> > case for it, and it should work fine.
>
> Is that really any better than my patch to create a gap in the stack
> (modified for kernel space #BP only)?
>

I tend to prefer a nice local hack like mine over a hack that further
complicates the entry in general.  This is not to say I'm thrilled by
my idea either.
