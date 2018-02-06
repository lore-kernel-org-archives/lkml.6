Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeBFWsp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:48:45 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35588 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeBFWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:48:43 -0500
X-Google-Smtp-Source: AH8x225PRpvFpQBmxUqqlE+qbYeFrnjgkr0pAzZA+Sfvt7q7ytSH4HZPnYUVxKQLZiEmctis8iQ+fZQX5Kip2Fcamqs=
MIME-Version: 1.0
In-Reply-To: <20180206213202.GB2026@light.dominikbrodowski.net>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 14:48:42 -0800
X-Google-Sender-Auth: hwuzyh5rddIFCXS1m-isbl6ZkII
Message-ID: <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 1:32 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Same as is done for syscalls, interleave XOR with PUSH or MOV
> instructions for exceptions/interrupts, in order to minimize
> the cost of the additional instructions required for register
> clearing.

Side note: I would _really_ like to see

 (a) SAVE_{C,EXTRA}_REGS go away entirely, to be replaced by just SAVE_REGS.

     We never use them independently of each other any more.

 (b) Get rid of ALLOC_PT_GPREGS_ON_STACK entirely, and make SAVE_REGS
use pushq's instead of movs.

Doing (a) should be completely trivial.

Doing (b) looks like it needs _some_ care, because
ALLOC_PT_GPREGS_ON_STACK is not always done just before the SAVE_REGS,
the error entry code does it in in the early entry code. But honestly,
that seems mainly so that it can do

        testb   $3, CS(%rsp)                    /* If coming from
userspace, switch stacks */

before registers are saved, yet use the same CS offset as if they had
already been saved. So that _one_ stack offset in the 'idtentry' macro
would need to be fixed up.

There might be others that I don't see from just eyeballing, so it
does need some care, but wouldn't it be nice if *all* the entry code
could just use the same pushq sequences, and then put the xor's in
there?

The reason for that complexity is purely the system call fastpath case
that no longer exists, I think.

Am I missing something?

                Linus
