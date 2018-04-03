Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbeDCBuB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 21:50:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35460 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeDCBt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 21:49:59 -0400
X-Google-Smtp-Source: AIpwx4+ofz6+C5YnxH2gidyrfiyRNoeTuH/gZva/JGfmWKUCxxgFggiKRDbg634VBJxEfzzz1sJSjtzNOntB250Ru5A=
MIME-Version: 1.0
In-Reply-To: <20180402104148.m3hhkhjhdb5y7gyu@gmail.com>
References: <20180402104148.m3hhkhjhdb5y7gyu@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 18:49:58 -0700
X-Google-Sender-Auth: y9f3KYyYboKFQRlnbKR40OmFdag
Message-ID: <CA+55aFwWKLGKQmzAHKbfwtiqL-AmB2z8GKAO-dYeB1Oq-Q6uvA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v4.17
To: Ingo Molnar <mingo@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 3:41 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Use efi_switch_mm() on x86 instead of manipulating %cr3 directly

This seems to cause new warnings, both on my laptop and my desktop.
I'm surprised you don't see them.

Looks like this:

    WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/tlbflush.h:134
load_new_mm_cr3+0x114/0x170
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-02277-gbc16d4052f1a #1
    Hardware name: System manufacturer System Product Name/Z170-K,
BIOS 3301 02/08/2017
    RIP: 0010:load_new_mm_cr3+0x114/0x170
    RSP: 0000:ffffffff9b203e38 EFLAGS: 00010046
    RAX: 0000000000000000 RBX: ffffffff9b26f5a0 RCX: 0000000000000000
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9b20a000
    RBP: ffffffff9b203e90 R08: 0000000000000000 R09: 000000000f63eb29
    R10: ffffffff9b203ea8 R11: 00000000c3292018 R12: 0000000000000000
    R13: ffffffff9b2e1180 R14: 000000000001ee80 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff968df6c00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff968df6fff000 CR3: 00000004261e6002 CR4: 00000000000606b0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     switch_mm_irqs_off+0x267/0x590
     switch_mm+0xe/0x20
     efi_switch_mm+0x3e/0x50
     efi_enter_virtual_mode+0x43f/0x4da
     start_kernel+0x3bf/0x458
     secondary_startup_64+0xa5/0xb0

and the reason seems to be some oddity of secondary_startup() doing
this very early, because the warning is this:

        VM_WARN_ON_ONCE(!this_cpu_has(X86_FEATURE_PCID));

and obviously I *do* have X86_FEATURE_PCID on my machine, but
presumably that bit hasn't been set yet this early in the secondary
CPU boot.

The above is a pure guess from the call trace, maybe there's something
else going on.

Everything seems to *work* despite the warning, but this needs fixing.

                  Linus
