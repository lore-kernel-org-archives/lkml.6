Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422818AbeBPAIg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:08:36 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:36205 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422779AbeBPAIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:08:34 -0500
X-Google-Smtp-Source: AH8x224Ofy5lY7EPA4pDoU1oetK0qHrmNJuN1l5+ZG2M1a0HqZYkCQWfsbsWAW8jxzkdPOTelHwA3UFu7hS92utwmPo=
MIME-Version: 1.0
In-Reply-To: <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com> <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 16:08:33 -0800
X-Google-Sender-Auth: r4sVuEEF1Ws1YKbG6TiHwj9iYzU
Message-ID: <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>,
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

On Thu, Feb 15, 2018 at 3:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> It's possible we could get away with adding the prctl but making the
> default be that only the bitness that matches the program being run is
> allowed.  After all, it's possible that CRIU is literally the only
> program that switches bitness using the GDT.  (DOSEMU2 definitely does
> cross-bitness stuff, but it uses the LDT as far as I know.)  And I've
> never been entirely sure that CRIU fully counts toward the Linux
> "don't break ABI" guarantee.

Ugh.

There are just _so_ many reasons to dislike that.

It's not that I don't think we could try to encourage it, but this
whole "security depends on it being in sync" seems really like a
fundamentally bad design.

> Linus, how would you feel about, by default, preventing 64-bit
> programs from long-jumping to __USER32_CS and vice versa?

How? It's a standard GDT entry. Are you going to start switching the
GDT around every context switch?

I *thought* that user space can just do a far jump on its own. But
it's so long since I had to care that I may have forgotten all the
requirements for going between "compatibility mode" and real long
mode.

I just feel this all is a nightmare. I can see how you would want to
think that compatibility mode doesn't need PTI, but at the same time
it feels like a really risky move to do this.

I can see one thread being in compatibiilty mode, and another being in
long mode, and sharing the address space. But even with just one
thread, I'm not seeing how you keep user mode from going from
compatibility mode to L mode with just a far jump.

But maybe you have some clever scheme in mind that guarantees that
there are no issues, or maybe I've just forgotten all the details of
long mode vs compat mode.

               Linus
