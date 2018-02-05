Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeBEQ1M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:27:12 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37517 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:27:04 -0500
X-Google-Smtp-Source: AH8x224q8RQKxxg8SQ+v/92kEjuVYRH98bECiIKjRF5qjw7GDdjvnCVfJSNDHBGrCTsxt8TUXmVltw==
Date: Mon, 5 Feb 2018 17:26:59 +0100
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
Message-ID: <20180205162659.kimgef6dkskc6quq@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [...]
> 
> But as the commit message says, the system call argument registers are
> also likely to be aggressively clobbered unless used, since the low
> registers are preferred for code generation (smaller code, and many of
> them are special anyway in various ways and have forced uses for
> shifts, function arguments, or just are special in general like %rax).
> 
> So the actual argument registers tend to not be an issue anyway.

Btw., to underline these arguments, here's some statistical data about actual 
register usage the x86 kernel.

I picked the latest upstream kernel and did a statistical analysis of the 
disassembly of an 'allyesconfig' 64-bit build.

Here is the histogram of GP register usage, ordered by a calculated "average 
per-function usage ratio" (last column):

  # nr of =y .config options:  9553
  # nr of functions:           249340
  # nr of instructions:        20223765
  # nr of register uses:       33413619

  register | # of uses | avg uses per fn
  --------------------------------------
      %r11 |     21564 |       0.1
      %r10 |     65499 |       0.3
      %r9  |    162040 |       0.6
      %r8  |    292779 |       1.2
      %rcx |    860528 |       3.5
      %r15 |   1414816 |       5.7
      %r14 |   1597952 |       6.4
      %rsi |   1636660 |       6.6
      %rdx |   1798109 |       7.2
      %r13 |   1829557 |       7.3
      %r12 |   2301476 |       9.2
      %rbp |   3156682 |      12.7
      %rbx |   4451880 |      17.9
      %rdi |   4747951 |      19.0
      %rax |   5370191 |      21.5

Here is the same histogram for a distro kernel (Fedora) config based build, with 
all =m modules changed to =y and thus built into the vmlinux for easier analysis:

  # nr of =y .config options:  4871
  # nr of functions:           190477
  # nr of instructions:        10329411
  # nr of register uses:       16907185

  register | # of uses | avg uses per fn
  --------------------------------------
      %r11 |     64135 |       0.3
      %r10 |    113366 |       0.6
      %r9  |    196269 |       1.0
      %r8  |    314812 |       1.7
      %r15 |    404789 |       2.1
      %r14 |    461266 |       2.4
      %r13 |    569654 |       3.0
      %r12 |    763973 |       4.0
      %rcx |    920477 |       4.8
      %rbp |   1161700 |       6.1
      %rsi |   1257150 |       6.6
      %rdi |   1625617 |       8.5
      %rdx |   1667365 |       8.8
      %rbx |   1739660 |       9.1
      %rax |   3826187 |      20.1

Finally here's the histogram of a 'defconfig' build - which should be 
representative of 'device specific kernel builds':

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

(Note the various caveats listed further below.)

These three builds I believe provide representative members of a wide spectrum of 
kernel options used in practice: from everything-enabled, through distro-enabled 
to device-specific minimal kernels.

There's a consistent pattern in these histograms: the least used registers are 
R11, R10, R9 and R8. Registers R12-R15 are used almost as frequently as some of 
the GP registers (!).

In practice R11-R10 is probably the most vulnerable ones to attack: their use is 
at least 1-2 orders of magnitude less common than that of the more common general 
purpose registers.

So I submit that we should probably extend the register clearing/sanitization to 
R10 and R11 as well, because while they are technically caller-saved and freely 
clobberable, in practice they don't get clobbered all that often and there might 
be various code paths into complex system calls where these R10/R11 values survive 
just fine and can be used in Spectre gadgets.

Thanks,

	Ingo

P.S.:

List of caveats/notes:

Note #1:
  I collapsed all 32-bit register users which zero-extend by default.
  I did not collapse 8 and 16 bit uses as they don't automatically clobber the 
  higher bits. )

Note #2:
  This histogram does not make a distinction between read and write uses of 
  registers.

Note #3:
  I did not include implicit register clobbering, only those registers that are 
  explicitly listed in the disassembly. In the overwhelming majority of cases the 
  affected registers are listed though, so the real numbers should be very close
  though.

Note #4:
  The 'avg uses per fn' number is over-estimates the real uses per function,
  because I counted total number of uses, not rounded down to a per function 
  register usage heat-map. I believe this does not change the _ordering_ of the 
  register usage histograms, so it's a valid simplification.
