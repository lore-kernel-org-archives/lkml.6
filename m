Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeERSuZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:50:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40330 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:50:24 -0400
X-Google-Smtp-Source: AB8JxZosgP6Bfav10NIouesZf6qFLDGE3PPaYAZnjJvSikgnhjgrVv9+hxSZikZlTZQ5cX1TjzUZvDrse2krUilApfs=
MIME-Version: 1.0
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
In-Reply-To: <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 11:50:12 -0700
Message-ID: <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: Peter Anvin <hpa@zytor.com>
Cc: namit@vmware.com, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:34 AM <hpa@zytor.com> wrote:

> On May 18, 2018 11:25:32 AM PDT, Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> Unfortunately gcc doesn't guarantee that global assembly inlines will
appear at the top of the file.

Yeah. It really would be better to do the "asm version of -inline".

We already do something like that for real *.S files on some architectures
(because their assembly really wants it, eg

  arch/arm/Makefile:
    KBUILD_AFLAGS +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include
asm/unified.h -msoft-float

but I do want to point out that KBUILD_AFLAGS is *not* used for
compiler-generated assembly, only for actual *.S files.

Sadly, I don't actually know any way to make gcc call the 'as' phase with
particular options. We can use "-Wa,xyzzy" to pass in xyzzy to the
assembler, but there is no "-include" option for GNU as afaik.

Can you perhaps define a macro symbol for "--defsym"? Probably not.

                       Linus
