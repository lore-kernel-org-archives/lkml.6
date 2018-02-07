Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeBGRV5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:21:57 -0500
Received: from terminus.zytor.com ([65.50.211.136]:39117 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754231AbeBGRV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:21:56 -0500
Date: Wed, 07 Feb 2018 09:13:57 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com> <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC 0/3] x86: Patchable constants
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: the arch/x86 maintainers <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <5D7DF367-BFEF-49C5-93DF-5C19D887752A@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2018 9:01:42 AM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Wed, Feb 7, 2018 at 6:59 AM, Kirill A. Shutemov
><kirill.shutemov@linux.intel.com> wrote:
>> This patchset introduces concept of patchable constants: constant
>values
>> that can be adjusted at boot-time in response to system configuration
>or
>> user input (kernel command-line).
>>
>> Patchable constants can replace variables that never changes at
>runtime
>> (only at boot-time), but used in very hot path.
>
>So I actually wanted something very close to this, but I think your
>approach is much too simplistic.
>
>You force all constants into a register, which means that the
>resulting code is always going to be very far from non-optimal.
>
>You also force a big "movabsq" instruction, which really is huge, and
>almost never needed. Together with the "use a register", it just makes
>for big code.
>
>What I wanted was something that can take things like a shift by a
>variable that is set once, and turn it into a shift by a boot-time
>constant. Which means that you literally end up patching the 8-bit
>immediate in the shift instruction itself.
>
>In particular, was looking at the dcache hashing code, and (to quote
>an old email of mine), what I wanted was to simplify the run-time
>constant part of this:
>
>│ mov $0x20,%ecx
>│ sub 0xaf8bd5(%rip),%ecx # ffffffff81d34600 <d_hash_shift>
>│ mov 0x8(%rsi),%r9
>│ add %r14d,%eax
>│ imul $0x9e370001,%eax,%eax
>│ shr %cl,%eax
>
>and it was the expression "32-d_hash_shift" that is really a constant,
>and that sequence of
>
>│ mov $0x20,%ecx
>│ sub 0xaf8bd5(%rip),%ecx # ffffffff81d34600 <d_hash_shift>
>│ shr %cl,%eax
>
>should be just a single
>
>│ shr $CONSTANT,%eax
>
>at runtime.
>
>Look - much smaller code, and register %rcx isn't used at all. And no
>D$ miss on loading that constant (that is a constant depending on
>boot-time setup only).
>
>It's rather more complex, but it actually gives a much bigger win. The
>code itself will be much better, and smaller.
>
>The *infrastructure* for the code gets pretty hairy, though.
>
>The good news is that the patch already existed to at least _some_
>degree. Peter Anvin did it about 18 months ago.
>
>It was not really pursued all the way because it *is* a lot of extra
>complexity, and I think there was some other hold-up, but he did have
>skeleton code for the actual replacement.
>
>There was a thread on the x86 arch list with the subject line
>
>    Disgusting pseudo-self-modifying code idea: "variable constants"
>
>but I'm unable to actually find the patch. I know there was at least a
>vert early prototype.
>
>Adding hpa to the cc in the hope that he has some prototype code still
>laying around..
>
>                Linus

I am currently working on it much more comprehensive set of patches for extremely this. I am already much further ahead and support most operations.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
