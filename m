Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeBEUGD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:06:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46270 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeBEUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:05:55 -0500
X-Google-Smtp-Source: AH8x227ZovQGzcYipU3sKX/b6VOi7B0bT0q5nQ86m1MoPdikxM2asT+z+sBwITEdbkP/hscgwlX2+Q==
Date: Mon, 5 Feb 2018 21:05:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205200550.mhimujp7wltuwzod@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
 <20180205162659.kimgef6dkskc6quq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205162659.kimgef6dkskc6quq@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Btw., to underline these arguments, here's some statistical data about actual 
> register usage the x86 kernel.

So this caveat was bothering me:

> List of caveats/notes:
> 
> Note #4:
>   The 'avg uses per fn' number is over-estimates the real uses per function,
>   because I counted total number of uses, not rounded down to a per function 
>   register usage heat-map. I believe this does not change the _ordering_ of the 
>   register usage histograms, so it's a valid simplification.

as averaging all uses over the functions over-estimates the per function usage of 
registers significantly, so I implemented a real, per function register usage 
tracking.

For the x86 defconfig kernel the results are:

  r11: used in   1704 fns, not used in  43310 fns, usage ratio:    3.8%
  r10: used in   3809 fns, not used in  41205 fns, usage ratio:    8.5%
  r15: used in   6599 fns, not used in  38415 fns, usage ratio:   14.7%
   r9: used in   8120 fns, not used in  36894 fns, usage ratio:   18.0%
  r14: used in   9243 fns, not used in  35771 fns, usage ratio:   20.5%
   r8: used in  12614 fns, not used in  32400 fns, usage ratio:   28.0%
  r13: used in  12708 fns, not used in  32306 fns, usage ratio:   28.2%
  r12: used in  17144 fns, not used in  27870 fns, usage ratio:   38.1%
  rbp: used in  23289 fns, not used in  21725 fns, usage ratio:   51.7%
  rcx: used in  23897 fns, not used in  21117 fns, usage ratio:   53.1%
  rbx: used in  29226 fns, not used in  15788 fns, usage ratio:   64.9%
  rdx: used in  33205 fns, not used in  11809 fns, usage ratio:   73.8%
  rsi: used in  35415 fns, not used in   9599 fns, usage ratio:   78.7%
  rdi: used in  40628 fns, not used in   4386 fns, usage ratio:   90.3%
  rax: used in  43120 fns, not used in   1894 fns, usage ratio:   95.8%

As a comparison, here's the previous estimate:

  # nr of =y .config options:  1255
  # nr of functions:           45490
  # nr of instructions:        1963956
  # nr of register uses:       3183680

  register | # of uses | avg uses per fn
  --------------------------------------
      %r11 |     11608 |       0.3
      %r10 |     23398 |       0.5
      %r9  |     37431 |       0.8
      %r8  |     56140 |       1.2
      %r15 |     77468 |       1.7
      %r14 |     89285 |       2.0
      %r13 |    111665 |       2.5
      %r12 |    151977 |       3.3
      %rcx |    166425 |       3.7
      %rsi |    226536 |       5.0
      %rbp |    238286 |       5.2
      %rdi |    306709 |       6.7
      %rdx |    313569 |       6.9
      %rbx |    349496 |       7.7
      %rax |    728036 |      16.0

The ordering of the registers is similar, but it's not the same - and the actual 
percentages changed drastically.

In particular R10 and R11 are used only in a small minority of the functions:

  r11: used in   1704 fns, not used in  43310 fns, usage ratio:    3.8%
  r10: used in   3809 fns, not used in  41205 fns, usage ratio:    8.5%

and if deeper inside the kernel a Spectre-gadget uses R10 or R11 then chances are 
high that user-space R10/R11 values will be passed through to it without 
disturbance from other C functions.

So I think these numbers increase the urgency of clearing R10/R11 as well.

Note that this too is still only a statistical estimate, the _real_ impact could 
only be judged if we created a call graph of the whole kernel, with 100% coverage, 
and analyzed register use through this tree.

The other registers:

  r15: used in   6599 fns, not used in  38415 fns, usage ratio:   14.7%
   r9: used in   8120 fns, not used in  36894 fns, usage ratio:   18.0%
  r14: used in   9243 fns, not used in  35771 fns, usage ratio:   20.5%
   r8: used in  12614 fns, not used in  32400 fns, usage ratio:   28.0%
  r13: used in  12708 fns, not used in  32306 fns, usage ratio:   28.2%
  r12: used in  17144 fns, not used in  27870 fns, usage ratio:   38.1%

R12-R15 will be cleared with tis patchset, so that angle should be handled, which 
leaves us:

   r9: used in   8120 fns, not used in  36894 fns, usage ratio:   18.0%
   r8: used in  12614 fns, not used in  32400 fns, usage ratio:   28.0%

These are arguments #5 and #6 of the x86-64 C calling convention ABI. In practice 
they will be overwritten in many code paths - especially they will be overwritten 
in some of the richer ABIs of Linux: ioctls, socketcalls and the other high level 
demux system calls.

R8 is also spontaneously used by GCC once a function's size grows about ~130 
instructions. For R9 the average threshold is about ~160 instructions.

Thanks,

	Ingo
