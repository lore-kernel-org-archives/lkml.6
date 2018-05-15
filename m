Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEOW31 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbeEOW30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:29:26 -0400
X-Google-Smtp-Source: AB8JxZof+fKjs8qBHYFAAo2psoM0H/VxEGZ1I633EFcTD2O492fJCqBD91EttHM3q1+WpH9G6HyW8sqNc5piptIeQNU=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <alpine.DEB.2.21.1805160009230.1605@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1805160009230.1605@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 15 May 2018 15:29:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWjMdTn8OyKgaydjK12sP8XKHtuXonEVnVHFPQ=jUtQLA@mail.gmail.com>
Message-ID: <CALCETrWjMdTn8OyKgaydjK12sP8XKHtuXonEVnVHFPQ=jUtQLA@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        tipbuild@zytor.com, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 3:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 16 May 2018, Alexey Dobriyan wrote:

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -338,6 +338,11 @@ END(ret_from_fork)
>          cmpl    $USER_RPL, %eax
>          jb      resume_kernel                   # not returning to v8086
or userspace

> +       /*
> +        * Jump over the alignment padding which is filled with int3
instructions
> +        */
> +       jmp     resume_userspace
> +
>   ENTRY(resume_userspace)

The problem is already solved, but NAK to this concept.  If we're going to
make ENTRY supply int3 alignment, then we need to avoid using ENTRY if we
fall through.  Jumping over the alignment is just silly.  The macro we
should use is GLOBAL.
