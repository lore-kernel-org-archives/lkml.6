Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeBFIs6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:48:58 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38294 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeBFIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:48:51 -0500
X-Google-Smtp-Source: AH8x227yJUiZ5KCXC7fYcKDvx5VJJCBlayq6oIx/WraIzhrYy+KIUNM/mk2gvGNF+h8l0yeSgB2wiA==
Date: Tue, 6 Feb 2018 09:48:47 +0100
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
Message-ID: <20180206084847.6lzfnumwlf3ehmvh@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
 <20180205162659.kimgef6dkskc6quq@gmail.com>
 <20180205200550.mhimujp7wltuwzod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205200550.mhimujp7wltuwzod@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> [...] so I implemented a real, per function register usage tracking.
> 
> For the x86 defconfig kernel the results are:
> 
>   r11: used in   1704 fns, not used in  43310 fns, usage ratio:    3.8%
>   r10: used in   3809 fns, not used in  41205 fns, usage ratio:    8.5%
>   r15: used in   6599 fns, not used in  38415 fns, usage ratio:   14.7%
>    r9: used in   8120 fns, not used in  36894 fns, usage ratio:   18.0%
>   r14: used in   9243 fns, not used in  35771 fns, usage ratio:   20.5%
>    r8: used in  12614 fns, not used in  32400 fns, usage ratio:   28.0%
>   r13: used in  12708 fns, not used in  32306 fns, usage ratio:   28.2%
>   r12: used in  17144 fns, not used in  27870 fns, usage ratio:   38.1%
>   rbp: used in  23289 fns, not used in  21725 fns, usage ratio:   51.7%
>   rcx: used in  23897 fns, not used in  21117 fns, usage ratio:   53.1%
>   rbx: used in  29226 fns, not used in  15788 fns, usage ratio:   64.9%
>   rdx: used in  33205 fns, not used in  11809 fns, usage ratio:   73.8%
>   rsi: used in  35415 fns, not used in   9599 fns, usage ratio:   78.7%
>   rdi: used in  40628 fns, not used in   4386 fns, usage ratio:   90.3%
>   rax: used in  43120 fns, not used in   1894 fns, usage ratio:   95.8%

So here's the next (and probably final) chapter of x86-64 register allocation 
statistics: out of curiosity I let this analysis run overnight on all 4 kernel 
configs, to see the register usage patterns of the distro and allyesconfig kernels 
as well.

Here's all the per function register allocation probabilities in a single table:

  REG      allnoconfig       localconfig      distroconfig      allyesconfig
  --------------------------------------------------------------------------
  rax:           94.6%             95.8%             94.3%             96.2%
  rbx:           46.9%             64.9%             67.6%             90.4%
  rcx:           47.8%             53.1%             57.9%             52.7%
  rdx:           66.0%             73.8%             76.0%             74.3%
  rbp:           36.2%             51.7%             55.5%             81.5%
  rsi:           64.8%             78.7%             81.3%             85.0%
  rdi:           79.9%             90.3%             92.1%             94.3%
   r8:           21.9%             28.0%             31.9%             29.7%
   r9:           13.9%             18.0%             20.4%             18.3%
  r10:            9.3%              8.5%              8.4%              4.7%
  r11:            4.9%              3.8%              4.5%              1.6%
  r12:           25.6%             38.1%             42.4%             69.3%
  r13:           18.3%             28.2%             31.5%             57.1%
  r14:           13.3%             20.5%             22.8%             46.1%
  r15:            9.3%             14.7%             16.4%             36.6%

These numbers underline the overall conclusions that we have reached so far:

 - We should clear all of R10-R15 in syscalls and R8-R15 in parameter-less
   entries (IRQs, NMIs, exceptions, etc.) - like the latest series from Dan does.

 - We should probably strive to clear R8-R9 for system calls that don't use it -
   which is ~98% of them. In particular R9 with its comparatively low (~20%)
   allocation probability could survive deep into the kernel: 5-deep call chains
   still have a ~30% chance to have R9 intact - and call chains as deep as 10 
   could still realistically have a ~10% residual probability to have R9 intact.
   We don't do this yet.

 - Smaller kernels are statistically easier to attack via Spectre, as long as the
   gadget is present in the smaller kernel. In particular heavily stripped down
   64-bit kernels might be attackable via R8-R9 (21%,14%) and also RBP (36%) to a 
   certain degree. This means that the RBP clearing introduced by this series is 
   very much relevant: because RBP is not part of the C function call calling 
   arguments ABI its allocation frequency is much lower than that of other GP 
   registers. Unfortunately R8/R9 values will survive through system calls, 
   because we restore them in do_syscall_64().

There's a somewhat surprising pattern as well: the register allocation probability 
of R10 and R11 _decreases_ as the kernel gets more complex. For all other 
registers the allocation probability increases with increasing kernel complexity, 
which is intuitive: larger functions with higher register pressure will use more 
registers.

So this result is counter-intuitive - my best guess is that it's some sort of GCC 
register allocation artifact. Here's the comparison of the code generation of a 
distro versus an allyesconfig kernel:

  #                             distro-config        allyesconfig
  #
  # nr of =y .config options:            4871                9553
  # nr of functions:                   190477              249340
  # nr of instructions:              10329411            20223765
  # nr of register uses:             16907185            33413619
  #
  # instructions per function:             54                  81
  #
  #
  # r10 used in:                        15404 fns           11300 fns
  # r10 not used in:                   167714 fns          228114 fns
  # r10 usage ratio:                      8.4%                4.7%
  #
  # r11 used in:                         8224 fns            3876 fns
  # r11 not used in:                   174894 fns          235538 fns
  # r11 usage ratio:                     4.5%                 1.6%

I don't know which kernel option (out of thousands) causes R10/R11 to be used much 
less frequently in a significantly larger kernel.

Note that even the absolute count of functions with R10/R11 use decreases in the 
allyesconfig kernel, so I don't think it can be caused by the extra 
instrumentation bloat of features like CONFIG_GCOV_KERNEL=y.

The basic inlining and optimization settings are the same and neither has 
branch-instrumentation enabled:

  #                           distro-config       allyesconfig
  #
  CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y       CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
  CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y            CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set        # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
  CONFIG_OPTIMIZE_INLINING=y                      CONFIG_OPTIMIZE_INLINING=y

  CONFIG_BRANCH_PROFILE_NONE=y                    CONFIG_BRANCH_PROFILE_NONE=y

While no-one will build and boot an allyesconfig kernel (other than me), the 
numbers are still indicative: we should keep in mind the possibility that a Linux 
distro enabling seemingly benign non-default kernel options can lower the 
allocation probability of R10/R11 significantly.

Thanks,

	Ingo
