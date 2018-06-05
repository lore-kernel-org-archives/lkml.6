Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeFERWt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:22:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55603 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeFERWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:22:48 -0400
X-Google-Smtp-Source: ADUXVKI5+GNOsDmdB6bAqVRnoVzzq9khWpIEGDT36wCg2FfoylWdg7lPopg1YJJ+j5zVTRqn5D8c1w==
Date: Tue, 5 Jun 2018 20:22:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
Message-ID: <20180605172243.GA2059@avx2>
References: <20180604122132.GA3337@gmail.com>
 <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605150514.GA31065@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 05:05:14PM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, Jun 4, 2018 at 5:21 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >  - __clear_user() micro-optimization (Alexey Dobriyan)
> > 
> > Was this actually tested?
> 
> I'm not sure - Alexey?
> 
> > I think one reason people avoided the constant was that on some
> > microarchitecture it ended up being a separate uop just for the
> > constant generation, because it wouldn't fit in a single uop.

> Ok, fair point and agreed - if Alexey sends some measurements to back the change 
> I'll keep this, otherwise queue up a revert.

Tested? :^) I had P4 maybe ~15(?) years ago.

godbolt.org earliest compiler is 4.1.2 and it generates "movb [r32], imm8"
with "-m32 -O2 -march=pentium4" for simple memset-style loop
if it counts for something.

Actually I think __clear_user should be rewritten in C with assembly.
It's biggest user is probably ELF loader and those partial page .bss
clears should be noticeable.
