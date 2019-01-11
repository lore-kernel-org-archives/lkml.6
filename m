Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1045C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F1D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547168180;
	bh=xasxS/8z9Dmxu4txV11KFeQOiTthQE5c/dGewPZVGbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2m2vBaK0MONlMwt0bo40lZvPGayqLnv4b+nznyknc4FJp2ulVwUGOYTp06MHj4k9V
	 mhQ4He8qalwCAAbalKz6gd3y/fkIf2g+q/B66m3/a5nOAbo2uDVTzGzAbHht/w3JzY
	 wWsVGUEM0XMtAxQ/G0TNyO6eqzPZYKEI67yZ412I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfAKA4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfAKA4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:56:18 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876932183F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547168176;
        bh=xasxS/8z9Dmxu4txV11KFeQOiTthQE5c/dGewPZVGbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K20Ar9ZX/UwR4X3iPBf4/F6qFeTtXl4GKr/tO0cdFhiGRotg32nzkXik+kbjhnriQ
         X/pRmRK28Y3hfJ8PW9HWwtrYgWGvHU8efnuWNpLzbG121nopVt4yQSt85FRluBawQ7
         Yf+i1Qy/VHgRG125Mq6s9Ch7j8BpHovLBLIfucwE=
Received: by mail-wr1-f48.google.com with SMTP id t27so13419694wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:56:16 -0800 (PST)
X-Gm-Message-State: AJcUukfxlLJRW2GWsQHZHgI6JA6rzIEckqzAJxkyybMBz6Mq0Z5Qi0d+
        UfbcOTzqBVbSAxklKq+k2CaHVudMZfjmxtcceMyv1g==
X-Google-Smtp-Source: ALg8bN5LgudrZBf41FVlbMpNWdRuq3/QfBgFdCuVLOLvYff0SG/MPGtD6KRRg9DLQcnklx93OMnI7Y5FdQBpYBbspts=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr10786034wri.199.1547168174960;
 Thu, 10 Jan 2019 16:56:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Jan 2019 16:56:02 -0800
X-Gmail-Original-Message-ID: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
Message-ID: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 10, 2019 at 12:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > Right, emulating a call instruction from the #BP handler is ugly,
> > because you have to somehow grow the stack to make room for the return
> > address.  Personally I liked the idea of shifting the iret frame by 16
> > bytes in the #DB entry code, but others hated it.
>
> Yeah, I hated it.
>
> But I'm starting to think it's the simplest solution.
>
> So still not loving it, but all the other models have had huge issues too.
>

Putting my maintainer hat on:

I'm okay-ish with shifting the stack by 16 bytes.  If this is done, I
want an assertion in do_int3() or wherever the fixup happens that the
write isn't overlapping pt_regs (which is easy to implement because
that code has the relevant pt_regs pointer).  And I want some code
that explicitly triggers the fixup when a CONFIG_DEBUG_ENTRY=y or
similar kernel is built so that this whole mess actually gets
exercised.  Because the fixup only happens when a
really-quite-improbable race gets hit, and the issues depend on stack
alignment, which is presumably why Josh was able to submit a buggy
series without noticing.

BUT: this is going to be utterly gross whenever anyone tries to
implement shadow stacks for the kernel, and we might need to switch to
a longjmp-like approach if that happens.

--Andy
