Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756810AbeBPAnB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:43:01 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:42851 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeBPAm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:42:57 -0500
X-Google-Smtp-Source: AH8x2257I+w80Ov31a4ler90bW1cqwtvjE/SgCfX+ORdQPO9JJCQtM8QBu4i+KA9vkuHAN7VcSWyHKVQDBoKKRHAm4Q=
MIME-Version: 1.0
In-Reply-To: <B723A40E-EFA4-4CCE-80F6-65960213761F@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com> <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
 <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com> <B723A40E-EFA4-4CCE-80F6-65960213761F@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 16:42:55 -0800
X-Google-Sender-Auth: 7B3Y2pll6IrVRvoqPvZiUNg7WOc
Message-ID: <CA+55aFzNcbCxwimCokH2BPihc=vrusbz0NqCnHK3s4aUSLwe-A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@parallels.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 4:22 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>
> It is not too pretty, I agree, but it should do the work. There is only one
> problematic descriptor that can be used to switch from compatibility-mode to
> long-mode in the GDT (LDT descriptors always have the L-bit cleared).
> Changing the descriptor's present bit on context switch when needed can do
> the work.

Sure, I can see it working, but it's some really shady stuff, and now
the scheduler needs to save/restore/check one more subtle bit.

And if you get it wrong, things will happily work, except you've now
defeated PTI. But you'll never notice, because you won't be testing
for it, and the only people who will are the black hats.

This is exactly the "security depends on it being in sync" thing that
makes me go "eww" about the whole model. Get one thing wrong, and
you'll blow all the PTI code out of the water.

So now you tried to optimize one small case that most people won't
use, but the downside is that you may make all our PTI work (and all
the overhead for all the _normal_ cases) pointless.

                 Linus
