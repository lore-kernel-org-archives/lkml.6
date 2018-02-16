Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755773AbeBPPUR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:20:17 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34142 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBPPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:20:16 -0500
X-Google-Smtp-Source: AH8x225NxyQzapy0vIQowKmzbo/WNkfPRF/RMQSsfqhQxkmllu9eh0fwcccHDbo1UhhS9qldDymJTA==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D60)
In-Reply-To: <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
Date: Fri, 16 Feb 2018 07:20:13 -0800
Cc: Andy Lutomirski <luto@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <B6D05697-A525-4797-8DA1-F9B16EB7E44F@amacapital.net>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com> <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com> <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com> <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com> <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GFKKvY003569



>> On Feb 15, 2018, at 4:08 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> 
>> On Thu, Feb 15, 2018 at 3:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> 
>> It's possible we could get away with adding the prctl but making the
>> default be that only the bitness that matches the program being run is
>> allowed.  After all, it's possible that CRIU is literally the only
>> program that switches bitness using the GDT.  (DOSEMU2 definitely does
>> cross-bitness stuff, but it uses the LDT as far as I know.)  And I've
>> never been entirely sure that CRIU fully counts toward the Linux
>> "don't break ABI" guarantee.
> 
> Ugh.
> 
> There are just _so_ many reasons to dislike that.
> 
> It's not that I don't think we could try to encourage it, but this
> whole "security depends on it being in sync" seems really like a
> fundamentally bad design.

If we're going to do Nadav's thing, I think we have no choice.  We could say that Nadav's idea of turning off PTI for 32-bit is just too messy, though.

> 
>> Linus, how would you feel about, by default, preventing 64-bit
>> programs from long-jumping to __USER32_CS and vice versa?
> 
> How? It's a standard GDT entry. Are you going to start switching the
> GDT around every context switch?

That's the idea.  We already switch out three GDT entries for TLS.  Switching two more isn't going to kill us.

> 
> I *thought* that user space can just do a far jump on its own. But
> it's so long since I had to care that I may have forgotten all the
> requirements for going between "compatibility mode" and real long
> mode.
> 
> I just feel this all is a nightmare. I can see how you would want to
> think that compatibility mode doesn't need PTI, but at the same time
> it feels like a really risky move to do this.
> 
> I can see one thread being in compatibiilty mode, and another being in
> long mode, and sharing the address space. But even with just one
> thread, I'm not seeing how you keep user mode from going from
> compatibility mode to L mode with just a far jump.
> 
> But maybe you have some clever scheme in mind that guarantees that
> there are no issues, or maybe I've just forgotten all the details of
> long mode vs compat mode.

The clever scheme is that we have a new (maybe default) compat-and-i-mean-it mode that removes the DPL=3 L code segment from the GDT and prevents opportunistic SYSRET.
