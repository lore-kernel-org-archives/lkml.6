Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeEOXFq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:05:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51550 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEOXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:05:45 -0400
X-Google-Smtp-Source: AB8JxZrStJURmq2H9i5YxmWvx9gCuLYpQ9YY3989XSjbLHzY1s0mEA9J6JnQgoqE8o7vJyeIv3/odXldriJ3jnEGKQ0=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble> <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
In-Reply-To: <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 16:05:33 -0700
Message-ID: <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Side note: doing some grepping, I find some other sequences that are a bit
scary, like this:

arch/x86/kernel/acpi/wakeup_32.S-.data
arch/x86/kernel/acpi/wakeup_32.S-ALIGN
arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_magic)     .long   0
arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_eip)       .long   0

so apparently people are using ENTRY() for data too (the same pattern
exists in wakeup_64.S).

So we end up having those odd 0x90 bytes (now 0xcc) in the data section as
"padding" between those two values. Crazy.

Not an actual problem, but it does show that people seem to be mis-using
ENTRY().

There that padding is actually entirely wrong. We do *not* want to pad
between those "saved_xyz" fields. I think those should use GLOBAL too.

Or lookie here:

arch/x86/kernel/head_32.S-# boot GDT descriptor (later on used by CPU#0):
arch/x86/kernel/head_32.S-      .word 0                         # 32 bit
align gdt_desc.address
arch/x86/kernel/head_32.S:ENTRY(early_gdt_descr)
arch/x86/kernel/head_32.S-      .word GDT_ENTRIES*8-1
arch/x86/kernel/head_32.S-      .long gdt_page                  /*
Overwritten for secondary CPUs */

where ENTRY() will actually screw up how the code says it wants to align
the address, but now it doesn't.

I wonder if there's some way to add a test for "ENTRY only works in a code
section"?

My grep was just me doing a visual scan, I might have missed something.

               Linus
