Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEOX3M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:29:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37543 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeEOX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:29:10 -0400
X-Google-Smtp-Source: AB8JxZqjLlHz+8XYNw/LByQ467vIFgc7xkx8xHb2Wx4i099vmP4iEhXtGYE2SGQZr6k7asDh/IlX2Mri2RvNQOKb9kY=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <CA+55aFy6_fJkmuWDZC=d_WE+_oYHtXXCbb=R31jyC1qDKZ8HJw@mail.gmail.com>
 <20180515225028.GA21902@avx2> <20180515225845.GB21902@avx2>
In-Reply-To: <20180515225845.GB21902@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 16:28:58 -0700
Message-ID: <CA+55aFySWuQvnJ=27GUbz+h=Jop6F2TYFqnALAaeXXiPivLtqQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Pad assembly functions with INT3 instructions
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 3:58 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>          jb      resume_kernel                   # not returning to v8086
or userspace
> -
> -ENTRY(resume_userspace)

I went back in history, and we used to have multiple "jmp resume_userspace"
including even the vm86.c code (in a different file) doing that, so there
*used* to be a reason for this being a global symbol (and yes, we had a
fall-through to that global symbol even in those days).

That said, I also look at "resume_kernel". There's no reason to make that
globally visible afaik. It looks local to entry_32.S, and should look like
restore_all rather than resume_userspace.

So we probably should remove the ENTRY() for that too, and just make it be

          ALIGN
         resume_kernel:

instead?

I guess the reason for removing that other ENTRY() is different from this
case, though..

                Linus
