Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeBGRBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:01:45 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36323 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754392AbeBGRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:01:43 -0500
X-Google-Smtp-Source: AH8x227RGM4Ew0w4lWu67efYMwPHRkJDTkb4QKEF1ng8EacRJmCH0tfx1ylgiuLp+/pekRegMFDItZYlgB3cc30YywQ=
MIME-Version: 1.0
In-Reply-To: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 09:01:42 -0800
X-Google-Sender-Auth: MHccQzpXKeT4MB7vQSwdXzvM23Y
Message-ID: <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
Subject: Re: [RFC 0/3] x86: Patchable constants
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17H1pt1008975

On Wed, Feb 7, 2018 at 6:59 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> This patchset introduces concept of patchable constants: constant values
> that can be adjusted at boot-time in response to system configuration or
> user input (kernel command-line).
>
> Patchable constants can replace variables that never changes at runtime
> (only at boot-time), but used in very hot path.

So I actually wanted something very close to this, but I think your
approach is much too simplistic.

You force all constants into a register, which means that the
resulting code is always going to be very far from non-optimal.

You also force a big "movabsq" instruction, which really is huge, and
almost never needed. Together with the "use a register", it just makes
for big code.

What I wanted was something that can take things like a shift by a
variable that is set once, and turn it into a shift by a boot-time
constant. Which means that you literally end up patching the 8-bit
immediate in the shift instruction itself.

In particular, was looking at the dcache hashing code, and (to quote
an old email of mine), what I wanted was to simplify the run-time
constant part of this:

│ mov $0x20,%ecx
│ sub 0xaf8bd5(%rip),%ecx # ffffffff81d34600 <d_hash_shift>
│ mov 0x8(%rsi),%r9
│ add %r14d,%eax
│ imul $0x9e370001,%eax,%eax
│ shr %cl,%eax

and it was the expression "32-d_hash_shift" that is really a constant,
and that sequence of

│ mov $0x20,%ecx
│ sub 0xaf8bd5(%rip),%ecx # ffffffff81d34600 <d_hash_shift>
│ shr %cl,%eax

should be just a single

│ shr $CONSTANT,%eax

at runtime.

Look - much smaller code, and register %rcx isn't used at all. And no
D$ miss on loading that constant (that is a constant depending on
boot-time setup only).

It's rather more complex, but it actually gives a much bigger win. The
code itself will be much better, and smaller.

The *infrastructure* for the code gets pretty hairy, though.

The good news is that the patch already existed to at least _some_
degree. Peter Anvin did it about 18 months ago.

It was not really pursued all the way because it *is* a lot of extra
complexity, and I think there was some other hold-up, but he did have
skeleton code for the actual replacement.

There was a thread on the x86 arch list with the subject line

    Disgusting pseudo-self-modifying code idea: "variable constants"

but I'm unable to actually find the patch. I know there was at least a
vert early prototype.

Adding hpa to the cc in the hope that he has some prototype code still
laying around..

                Linus
