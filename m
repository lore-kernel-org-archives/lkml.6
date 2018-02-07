Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeBGRFF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:05:05 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:52175 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeBGRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:05:04 -0500
X-Google-Smtp-Source: AH8x227OTfs0Dcp8qnlgiq9CI5Vi39cHCqUm1JMns9Itl2epyT0WJI3tasN8h+fyFyuILoncoUs9IrVmU02ZiwLWJHA=
MIME-Version: 1.0
In-Reply-To: <20180207151854.GB10945@tassilo.jf.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net> <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
 <20180206235402.GN30338@tassilo.jf.intel.com> <CA+55aFzRMn6+tFFkAbMT_iDcMphDZFU9+OALEn+ecqa7=RqvUA@mail.gmail.com>
 <20180207151854.GB10945@tassilo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 09:05:03 -0800
X-Google-Sender-Auth: WkyqEX4Qvpd73NtX53kNhvyx-bw
Message-ID: <CA+55aFzM8ynf4m-X6EPS10gxNqsKPN_8mGucGHvBp8H+OkgW3g@mail.gmail.com>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
To: Andi Kleen <ak@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 7:18 AM, Andi Kleen <ak@linux.intel.com> wrote:
>
> Fast path saves more than just register saving.  I changed the fast path
> to save all registers in my earlier clearregs branches

I know. I saw your patches. And I went "Eww".

> It is still quite a bit faster than all the slow stuff the C do_syscall
> code does (e.g. reloading all the arguments, setting up unnecessary
> frame pointers etc.).
>
> Just take a look at the disassembly of that function. It's really
> not very optimized.

Actually, only the argument reloading _really_ annoys me in do_syscall().

And I do think we should be able to fix that fairly easily by moving
it into the SYSCALLx() macros - at least for 64-bit (32-bit has nasty
issues with 64-bit arguments).

The other thing we need to do is to just pass down the system call
number as an argument instead of reloading it.

         Linus
