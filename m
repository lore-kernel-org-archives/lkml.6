Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeBEWLA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeBEWKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:10:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DD9217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x226klYH4pXFFLR3e/FLOOQCpsBAgPlz4AqWqqTS/HitZn7pmlnE4kJTDmO559Lome3SHeyNKjlP0qIadW2v64n4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyvGkuM33C8ki=5-11idWWK4tHKuPaSrSb0FPTaJmC_iQ@mail.gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205115836.otnviqbae3pxjk5g@gmail.com> <CAPcyv4gyP4LAzS=8-ZNfy5gX=QHKK7VpGmeYXoP=rbe47kOg9A@mail.gmail.com>
 <CA+55aFyvGkuM33C8ki=5-11idWWK4tHKuPaSrSb0FPTaJmC_iQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 5 Feb 2018 22:10:34 +0000
X-Gmail-Original-Message-ID: <CALCETrV_7dxKAgwNyfDbvQ+0nTJG6NJqbKkngZyU-VPA3fvg8Q@mail.gmail.com>
Message-ID: <CALCETrV_7dxKAgwNyfDbvQ+0nTJG6NJqbKkngZyU-VPA3fvg8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 9:58 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Feb 5, 2018 at 1:33 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On a suggestion from Arjan it also appears worthwhile to interleave
>> 'mov' with 'xor'. Perf stat says that this test gets 3.45 instructions
>> per cycle:
>
> Ugh.
>
> A "xor %reg/reg" is two bytes (three for the high regs due to REX
> prefix). A "mov $0" is 7 bytes because unlike most of the ALU ops,
> "mov" doesn't have a 8-bit expanding immediate.
>
> So replacing those xors with movq's will add at least four bytes per
> replacement.  So you may well end up adding an L1 cache miss.
>
> At which point "3.45 ipc" vs "2.88 ipc" is pretty much a non-issue.
>
> I suspect that a bigger win would be if you try to interleave those
> "xor" instructions with the "pushq" instructions in the entry code.
> Because those push instructions tend to be limited by the LSU store
> bandwidth, so you can probably put in xor instructions almost for free
> in there.
>

At the risk of over-optimizing a dead horse, what about:

xorl %ebx, %ebx
movq %ebx, %r10
xorl %r11, %r11
movq %ebx, %r12

etc.

We'll have a cycle of latency from xor to mov, but I'd be rather
surprised if the CPU can't hide that.
