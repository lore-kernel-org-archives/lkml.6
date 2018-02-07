Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeBGUZC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:25:02 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36219 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754696AbeBGUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:24:59 -0500
X-Google-Smtp-Source: AH8x225SmA7TLZ7ePw5Diw0f6WOFC8QInGLThn0d70i9LPt2LnZyd57DvYyw1AVnNPooNeeD5lZB5Q==
Date: Wed, 07 Feb 2018 12:24:57 -0800 (PST)
X-Google-Original-Date: Wed, 07 Feb 2018 12:24:55 PST (-0800)
Subject: Re: [GIT PULL] RISC-V changes for 4.16
In-Reply-To: <mhng-e9711674-531a-4e02-949b-5c2ec3223849@palmer-si-x1c4>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, patches@groups.riscv.org
From: Palmer Dabbelt <palmer@sifive.com>
To: linux-kernel@vger.kernel.org
Message-ID: <mhng-a068afef-5892-4626-bc4b-dd7c7cee620c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-kernel, which I forgot.  Sorry!

On Wed, 07 Feb 2018 09:58:15 PST (-0800), Palmer Dabbelt wrote:
> The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:
>
>   Linux 4.15 (2018-01-28 13:20:33 -0800)
>
> are available in the git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.16-merge_window
> gpg: Signature made Tue 30 Jan 2018 07:16:17 PM PST
> gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
>
> for you to fetch changes up to 4889dec6c87d90619cc1e8436327b91f4bb0e467:
>
>   riscv: inline set_pgdir into its only caller (2018-01-30 19:16:17 -0800)
>
> ----------------------------------------------------------------
> RISC-V changes for 4.16
>
> This tag contains the fixes we'd like to target for the 4.16 merge
> window.  It's not as much as I was originally hoping to do but between
> glibc, the chip, and FOSDEM there just wasn't enough time to get
> everything put together.  As such, this merge window is essentially just
> going to be small changes.  This includes mostly cleanups:
>
> * A build fix failure to the audit test cases.  RISC-V doesn't have
>   renameat because the generic syscall ABI moved to renameat2 by the
>   time of our port.  The syscall audit test cases don't understand this,
>   so I added a trivial fix.  This went through mailing list review
>   during the 4.15 merge window, but nobody has picked it up so I think
>   it's best to just do this here.
> * The removal of our command-line argument processing code.  The
>   "mem_end" stuff was broken and the rest duplicated generic device tree
>   code.  The generic code was already being called.
> * Some unused/redundant code has been removed, including
>   __ARCH_HAVE_MMU, current_pgdir, and the initialization of init_mm.pgd.
> * SUM is disabled upon taking a trap, which means that user memory is
>   protected during traps taking inside copy_{to,from}_user().
> * The sptbr CSR has been renamed to satp in C code.  We haven't changed
>   the assembly code in order to maintain compatibility with binutils
>   2.29, which doesn't understand the new name.
>
> Additionally, we're adding some new features:
>
> * Basic ftrace support, thanks to Alan Kao!
> * Support for ZONE_DMA32.  This is necessary for all the normal reasons,
>   but also to deal with a deficiency in the Xilinx PCIe controller we're
>   using on our FPGA-based systems.  While the ZONE_DMA32 addition should
>   be sufficient for most uses, it doesn't complete the fix for the
>   Xilinx controller.
> * TLB shootdowns now only target the harts where they're necessary,
>   instead of applying to all harts in the system.
>
> These patches have all been sitting on our linux-next branch for a while
> now.  Due to time constraints this is all I feel comfortable submitting
> during the 4.16 merge window, hopefully we'll do better next time!
>
> ----------------------------------------------------------------
> Alan Kao (1):
>       riscv/ftrace: Add basic support
>
> Andrew Waterman (1):
>       RISC-V: Limit the scope of TLB shootdowns
>
> Christoph Hellwig (6):
>       riscv: disable SUM in the exception handler
>       riscv: add ZONE_DMA32
>       riscv: remove the unused current_pgdir function
>       riscv: don't read back satp in paging_init
>       riscv: rename sptbr to satp
>       riscv: inline set_pgdir into its only caller
>
> Michael Clark (1):
>       RISC-V: Remove duplicate command-line parsing logic
>
> Palmer Dabbelt (2):
>       audit: Avoid build failures on systems without renameat
>       RISC-V: Remove mem_end command line processing
>
> Tobias Klauser (2):
>       riscv: remove unused __ARCH_HAVE_MMU define
>       riscv: remove redundant unlikely()
>
>  arch/riscv/Kconfig                    |  10 +++
>  arch/riscv/include/asm/Kbuild         |   1 -
>  arch/riscv/include/asm/csr.h          |  14 ++--
>  arch/riscv/include/asm/ftrace.h       |  10 +++
>  arch/riscv/include/asm/mmu_context.h  |  17 ++---
>  arch/riscv/include/asm/tlbflush.h     |  20 +++---
>  arch/riscv/include/asm/unistd.h       |   1 -
>  arch/riscv/kernel/Makefile            |   7 ++
>  arch/riscv/kernel/entry.S             |   9 ++-
>  arch/riscv/kernel/ftrace.c            |  41 +++++++++++
>  arch/riscv/kernel/head.S              |   6 +-
>  arch/riscv/kernel/mcount.S            | 126 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c             |  44 +++---------
>  arch/riscv/kernel/vdso.c              |   2 +-
>  arch/riscv/mm/fault.c                 |   4 ++
>  arch/riscv/mm/init.c                  |  12 ++--
>  include/asm-generic/audit_dir_write.h |   2 +
>  17 files changed, 250 insertions(+), 76 deletions(-)
>  create mode 100644 arch/riscv/include/asm/ftrace.h
>  create mode 100644 arch/riscv/kernel/ftrace.c
>  create mode 100644 arch/riscv/kernel/mcount.S
