Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeBEWWV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:22:21 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:46788 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeBEWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:22:14 -0500
X-Google-Smtp-Source: AH8x226heLUa2xk9FWXO5DsiHj0vZ6/c8NWNL/9eCWVOYqTDVPSPAkPIwgFQ0c5R266ZvSx1iDzB3h8Ra9vGXn4GeMs=
MIME-Version: 1.0
In-Reply-To: <CALCETrV_7dxKAgwNyfDbvQ+0nTJG6NJqbKkngZyU-VPA3fvg8Q@mail.gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205115836.otnviqbae3pxjk5g@gmail.com> <CAPcyv4gyP4LAzS=8-ZNfy5gX=QHKK7VpGmeYXoP=rbe47kOg9A@mail.gmail.com>
 <CA+55aFyvGkuM33C8ki=5-11idWWK4tHKuPaSrSb0FPTaJmC_iQ@mail.gmail.com> <CALCETrV_7dxKAgwNyfDbvQ+0nTJG6NJqbKkngZyU-VPA3fvg8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 14:22:13 -0800
X-Google-Sender-Auth: lth1D3uAwK9LC0G1i7W90tygM1I
Message-ID: <CA+55aFyxgnVP1C3bgNDgX01NZi2x=FYjAw=YHAdn17ENS9P7bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Andy Lutomirski <luto@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:10 PM, Andy Lutomirski <luto@kernel.org> wrote:
> At the risk of over-optimizing a dead horse, what about:
>
> xorl %ebx, %ebx
> movq %ebx, %r10
> xorl %r11, %r11
> movq %ebx, %r12
>
> etc.
>
> We'll have a cycle of latency from xor to mov, but I'd be rather
> surprised if the CPU can't hide that.

Ugh. xor really is nice because it breaks all dependencies.

Really, it's much more likely that we can just hide the xors in the
pushes. Small, simple, easy.

But I'm not timing it.

               Linus
