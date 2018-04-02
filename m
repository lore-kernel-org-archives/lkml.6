Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeDBGCq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:02:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42693 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeDBGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:02:44 -0400
X-Google-Smtp-Source: AIpwx4+5qSpG78UBplTorrtNfNq8+XrqS8w/bhz+4QZq1xxxcskPtuGLtF2xJ2sTzHHRyOj/zjPAxg==
Date: Mon, 2 Apr 2018 14:01:24 +0800
From: Greentime Hu <green.hu@gmail.com>
To: arnd@arndb.de, green.hu@gmail.com, linux-kernel@vger.kernel.org,
        greentime@andestech.com, torvalds@linux-foundation.org
Subject: [GIT PULL] Andes(nds32) Port for Linux 4.17
Message-ID: <20180402060123.GB12733@app09>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-4.17

for you to fetch changes up to 6fc61ee69433e7e0433cabd36f78bb5fb3b26524:

  nds32: To use the generic dump_stack() (2018-03-16 15:45:23 +0800)

----------------------------------------------------------------
This tag contains the core nds32 Linux port(including interrupt controller
driver and timer driver), which has been through 7 rounds of review on mailing
list.

It is able to boot to shell and passes most LTP-2017 testsuites in nds32 AE3XX
platform.
Total Tests: 1901
Total Skipped Tests: 618
Total Failures: 78

Copied below is the ChangeLog that contains the history of this patch set:
Changes in v7:
 - Update cpu binding document to add "andestech,nds32v3" as fallback
 - Remove unnecessary configs of arch/nds32/Kconfig
 - Use GENERIC_CALIBRATE_DELAY
 - Add more help texts for minimum CPU type config
 - Update defconfig because of Kconfig changed and bug fixed
 - Move early_trap_init() declaration to nds32.h
 - Refine dma.c
 - Remove apply_relocate() in module.c and include <linux/moduleloader.h> to catch it
 - Add do_kernel_restart() in machine_restart()
 - Clean up setup.c to remove CONFIG_VGA_CONSOLE and some extern declaration functions
 - Add negative dependency for VGA_CONSOLE on nds32
 - Refine ptrace.c and arch/nds32/include/asm/ptrace.h
 - Refine syscall restart flow and arch/nds32/kernel/signal.c
 - Fix a bug in VDSO
 - Remove the handling for kernel code unaligned accessing
 - Add a description for unaligned access handling in git commit message.
 - Rebase to v4.16-rc1
 - Replace ACCESS_ONCE with READ_ONCE
 - Replace atomic_long_dec(&mm->nr_ptes) with mm_dec_nr_ptes(mm)
 - Remove print_symbol(%s) with printk(%pS)
 - Add bpf_perf_event.h
 - Remove init_stack and init_thread_info

Changes in v6:
 - Refine naming for atl2c
 - Refine ae3xx.dts
 - Remove CONFIG_TIMER_ATCPIT100 in defconfig
 - Refine elf.h
 - Fix a vdso bug
 - Separate arch patchset and timer patchset
 - To select TIMER_OF in drivers/clocksource/Kconfig instead of arch/nds32/Kconfig

Changes in v5:
 - Remove __NR__llseek  and sys_mmap()
 - Add a comment to explain that we don't have clocksource cycle counter in the CPU
 - Add volatile in iounmap()
 - Fix typo Featuretures to Features
 - Replace CPU_CACHE_NONALIASING with !CPU_CACHE_ALIASING
 - Fix a endian bug when we try to get val = of_get_property(cpu,"clock-frequency", NULL)
 - Add screen_info to fix the building error when CONFIG_ VGA_CONSOLE is enabled
 - Remove unnecessary msync()
 - Add depends on !64BIT || BROKEN for faraday Kconfig because the descriptor only supports 32bit
 - Add atl2c binding document
 - Remove unnecessary include headers
 - Fix a vector table bug. It placed wrong vector handlers for 2 exceptions.
 - Fix a vdso bug. It may encounter TLB multi-hit exception because we accidently set it as a global page.
 - Add proper isb and barrier after some cache operations
 - Fix a bug in system call restart flow. $r0 ~ $r5 does not be recovered before restarting system call
 - Fix the build errors for OpenRISC and SPARC because io.h changed.
 - Update ae3xx.dts to support atl2c.

Changes in v4:
 - Add atcpit100 timer driver due to it include vdso implementations and sent
   them together with nds32 may help reviewer to review.
 - Update ae3xx.dts for atcpit100 clock setting and remove vdso settings.
 - To get cycle counter register by timer driver instead of dts.
 - Use "depends on NDS32 || COMPILE_TEST" in atcpit100 driver because it is needed for nds32 vdso
 - Update defconfig becasue kconfig rename from CONFIG_CLKSRC_ATCPIT100 to CONFIG_TIMER_ATCPIT100
 - Remove ag101p.dts because we are not yet ready for ag101p platform.
 - Update copyright style to SPDX-License-Identifier
 - Include <linux/uaccess.h> instead of <asm/uaccess.h>
 - Add local_irq_save()/local_irq_restore() to protect SR_TLB_VPN in update_mmu_cache().
 - Update cpu_dcache_inval_all implementation to make sure all level cache are writeback.

Changes in v3:
 - Use arch's io.h instead of generic one
 - Add andestech-boards binding document
 - Update nds32/cpus.txt binding document
 - Remove atcpit100 timer drivers
 - Select NO_BOOTMEM and delete HAVE_MEMBLOCK_NODE_MAP
 - make CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN are dependent
 - Add cpu type to select HWZOL/CPU_CACHE_ALIASING
 - Change CPU_CACHE_NONALIASING to CPU_CACHE_ALIASING
 - Remove bootarg from device tree script
 - Update ag101p.dts and ae3xx.dts for correct board name.
 - Clear and simplify defconfig
 - Implement L2C_R_REG/ L2C_W_REG with readl/writel instead of __raw_readl/__raw_writel for endian save
 - Remove early_init_dt_add_memory_arch/early_init_dt_alloc_memory_arch to use the generic ones
 - Refine devicetree.c
 - Fix bug https://lkml.kernel.org/r/1499782590-31366-1-git-send-ema...
 - Refine irqchip/irq-ativic32.c implementations
 - Add COMPILE_TEST in drivers/net/ethernet/faraday/Kconfig
 - Refine cache operations
 - Add CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS
 - Fix ZERO_PAGE define
 - Remove SA_RESTORER
 - Remove uapi/asm/signal.h
 - Redefine user_pt_regs
 - Remove spinlock.h
 - Remove __ARCH_WANT_RENAMEAT and __ARCH_WANT_SYSCALL_OFF_T from unistd.h
 - Remove set_fs(USER_DS) because flush_old_exec() will do this setting
 - Replace in_atomic() with faulthandler_disabled()
 - Add barrier.h
 - Select COMMON_CLK
 - Add clk_pll in dts
 - Add of_clk_init() in arch/nds32/kernel/time.c

Changes in v2:
 - Set GENERIC_CALIBRATE_DELAY default n
 - Add earlycon support
 - Remove earlyprintk
 - Add CPU_BIG_ENDIAN, CPU_LITTLE_ENDIAN support
 - Refine unalignment access exception handler
 - Add VMSPLIT support
 - Use only one defconfig
 - Change interrupt-cells from 2 to 1
 - Refine andestech cpu names in bindings/nds32/cpus.txt
 - Get clock frequency in dts because fpga bitmap doesn't include this feature
 - Update MAINTAINERS for bindings
 - Remove unused configs in Kconfig
 - Refine device tree scripts
 - Refine coding style
 - Use generic ioremap_nocache
 - Remove L2CC_PA_BASE define and its codes in head.S. It will be moved to bootloader.
 - Set PHYS_OFFSET to 0x0 instead of CONFIG_MEMORY_START
 - Remove unused macros
 - Simplify cpu_cache_* API
 - Change __asm__ __volatile__ to asm volatile
 - Refine uaccess.h
 - Remove unused/deprecated syscall
 - Use generic posix_types.h
 - Remove arch_trace_hardirqs_on/arch_trace_hardirqs_off
 - Fix bug of restart syscall
 - Refine syscall implementations
 - Use IS_ENABLED to replace ifdef as possible
 - Remove device_initcall(nds32_device_probe)
 - Refine vdso implementations
 - Refine copy_from_user()/copy_to_user()/clear_user()/get_user()/memmove()/memcpy()
 - Refine ioremap.c
 - Refine irq-ativic32.c
 - Fix a bug of earlycon.c
 - Export ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 - Add atcpit100 driver

----------------------------------------------------------------
Greentime Hu (41):
      openrisc: add ioremap_nocache declaration before include asm-generic/io.h and sync ioremap prototype with it.
      xtensa: add ioremap_nocache declaration before include asm-generic/io.h.
      asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
      earlycon: add reg-offset to physical address before mapping
      drivers/video/concole: add negative dependency for VGA_CONSOLE on nds32
      nds32: Assembly macros and definitions
      nds32: Kernel booting and initialization
      nds32: Exception handling
      nds32: MMU definitions
      nds32: MMU initialization
      nds32: MMU fault handling and page table management
      nds32: Cache and TLB routines
      nds32: Process management
      nds32: IRQ handling
      nds32: Atomic operations
      nds32: Device specific operations
      nds32: DMA mapping API
      nds32: ELF definitions
      nds32: System calls handling
      nds32: VDSO support
      nds32: Signal handling support
      nds32: Library functions
      nds32: Debugging support
      nds32: L2 cache support
      nds32: Loadable modules
      nds32: Generic timers support
      nds32: Device tree support
      nds32: Miscellaneous header files
      nds32: defconfig
      nds32: Build infrastructure
      MAINTAINERS: Add nds32
      dt-bindings: nds32 CPU Bindings
      dt-bindings: nds32 L2 cache controller Bindings
      dt-bindings: nds32 SoC Bindings
      dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
      irqchip: Andestech Internal Vector Interrupt Controller driver
      net: faraday add nds32 support.
      nds32: fix building failed if using older version gcc.
      nios2: add ioremap_nocache declaration before include asm-generic/io.h.
      nds32: fix building failed if using elf toolchain.
      nds32: To use the generic dump_stack()

Rick Chen (3):
      clocksource/drivers/atcpit100: Add andestech atcpit100 timer
      clocksource/drivers/atcpit100: VDSO support
      dt-bindings: timer: Add andestech atcpit100 timer binding doc

 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt |  19 +++
 Documentation/devicetree/bindings/nds32/andestech-boards                      |  40 +++++
 Documentation/devicetree/bindings/nds32/atl2c.txt                             |  28 +++
 Documentation/devicetree/bindings/nds32/cpus.txt                              |  38 +++++
 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt         |  33 ++++
 MAINTAINERS                                                                   |  11 ++
 arch/nds32/Kconfig                                                            | 103 +++++++++++
 arch/nds32/Kconfig.cpu                                                        | 174 +++++++++++++++++++
 arch/nds32/Makefile                                                           |  67 ++++++++
 arch/nds32/boot/Makefile                                                      |  15 ++
 arch/nds32/boot/dts/Makefile                                                  |   8 +
 arch/nds32/boot/dts/ae3xx.dts                                                 |  85 ++++++++++
 arch/nds32/configs/defconfig                                                  | 104 ++++++++++++
 arch/nds32/include/asm/Kbuild                                                 |  55 ++++++
 arch/nds32/include/asm/assembler.h                                            |  39 +++++
 arch/nds32/include/asm/barrier.h                                              |  15 ++
 arch/nds32/include/asm/bitfield.h                                             | 963 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/cache.h                                                |  12 ++
 arch/nds32/include/asm/cache_info.h                                           |  13 ++
 arch/nds32/include/asm/cacheflush.h                                           |  44 +++++
 arch/nds32/include/asm/current.h                                              |  12 ++
 arch/nds32/include/asm/delay.h                                                |  39 +++++
 arch/nds32/include/asm/dma-mapping.h                                          |  14 ++
 arch/nds32/include/asm/elf.h                                                  | 171 +++++++++++++++++++
 arch/nds32/include/asm/fixmap.h                                               |  29 ++++
 arch/nds32/include/asm/futex.h                                                | 103 +++++++++++
 arch/nds32/include/asm/highmem.h                                              |  65 +++++++
 arch/nds32/include/asm/io.h                                                   |  83 +++++++++
 arch/nds32/include/asm/irqflags.h                                             |  36 ++++
 arch/nds32/include/asm/l2_cache.h                                             | 137 +++++++++++++++
 arch/nds32/include/asm/linkage.h                                              |  11 ++
 arch/nds32/include/asm/memory.h                                               | 105 ++++++++++++
 arch/nds32/include/asm/mmu.h                                                  |  12 ++
 arch/nds32/include/asm/mmu_context.h                                          |  68 ++++++++
 arch/nds32/include/asm/module.h                                               |  11 ++
 arch/nds32/include/asm/nds32.h                                                |  81 +++++++++
 arch/nds32/include/asm/page.h                                                 |  67 ++++++++
 arch/nds32/include/asm/pgalloc.h                                              |  96 +++++++++++
 arch/nds32/include/asm/pgtable.h                                              | 409 ++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/proc-fns.h                                             |  44 +++++
 arch/nds32/include/asm/processor.h                                            | 103 +++++++++++
 arch/nds32/include/asm/ptrace.h                                               |  77 +++++++++
 arch/nds32/include/asm/shmparam.h                                             |  19 +++
 arch/nds32/include/asm/string.h                                               |  17 ++
 arch/nds32/include/asm/swab.h                                                 |  35 ++++
 arch/nds32/include/asm/syscall.h                                              | 188 ++++++++++++++++++++
 arch/nds32/include/asm/syscalls.h                                             |  13 ++
 arch/nds32/include/asm/thread_info.h                                          |  76 +++++++++
 arch/nds32/include/asm/tlb.h                                                  |  28 +++
 arch/nds32/include/asm/tlbflush.h                                             |  47 +++++
 arch/nds32/include/asm/uaccess.h                                              | 283 ++++++++++++++++++++++++++++++
 arch/nds32/include/asm/unistd.h                                               |   6 +
 arch/nds32/include/asm/vdso.h                                                 |  24 +++
 arch/nds32/include/asm/vdso_datapage.h                                        |  36 ++++
 arch/nds32/include/asm/vdso_timer_info.h                                      |  14 ++
 arch/nds32/include/uapi/asm/Kbuild                                            |  29 ++++
 arch/nds32/include/uapi/asm/auxvec.h                                          |  12 ++
 arch/nds32/include/uapi/asm/byteorder.h                                       |  13 ++
 arch/nds32/include/uapi/asm/cachectl.h                                        |  14 ++
 arch/nds32/include/uapi/asm/param.h                                           |  11 ++
 arch/nds32/include/uapi/asm/ptrace.h                                          |  25 +++
 arch/nds32/include/uapi/asm/sigcontext.h                                      |  60 +++++++
 arch/nds32/include/uapi/asm/unistd.h                                          |  11 ++
 arch/nds32/kernel/Makefile                                                    |  23 +++
 arch/nds32/kernel/asm-offsets.c                                               |  28 +++
 arch/nds32/kernel/atl2c.c                                                     |  64 +++++++
 arch/nds32/kernel/cacheinfo.c                                                 |  49 ++++++
 arch/nds32/kernel/devtree.c                                                   |  19 +++
 arch/nds32/kernel/dma.c                                                       | 477 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/ex-entry.S                                                  | 157 +++++++++++++++++
 arch/nds32/kernel/ex-exit.S                                                   | 184 ++++++++++++++++++++
 arch/nds32/kernel/ex-scall.S                                                  |  98 +++++++++++
 arch/nds32/kernel/head.S                                                      | 188 ++++++++++++++++++++
 arch/nds32/kernel/irq.c                                                       |   9 +
 arch/nds32/kernel/module.c                                                    | 278 ++++++++++++++++++++++++++++++
 arch/nds32/kernel/nds32_ksyms.c                                               |  31 ++++
 arch/nds32/kernel/process.c                                                   | 208 +++++++++++++++++++++++
 arch/nds32/kernel/ptrace.c                                                    | 119 +++++++++++++
 arch/nds32/kernel/setup.c                                                     | 363 +++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/signal.c                                                    | 324 +++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/stacktrace.c                                                |  47 +++++
 arch/nds32/kernel/sys_nds32.c                                                 |  50 ++++++
 arch/nds32/kernel/syscall_table.c                                             |  17 ++
 arch/nds32/kernel/time.c                                                      |  11 ++
 arch/nds32/kernel/traps.c                                                     | 430 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/vdso.c                                                      | 230 +++++++++++++++++++++++++
 arch/nds32/kernel/vdso/Makefile                                               |  82 +++++++++
 arch/nds32/kernel/vdso/datapage.S                                             |  21 +++
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh                                    |  15 ++
 arch/nds32/kernel/vdso/gettimeofday.c                                         | 270 +++++++++++++++++++++++++++++
 arch/nds32/kernel/vdso/note.S                                                 |  11 ++
 arch/nds32/kernel/vdso/sigreturn.S                                            |  19 +++
 arch/nds32/kernel/vdso/vdso.S                                                 |  18 ++
 arch/nds32/kernel/vdso/vdso.lds.S                                             |  75 ++++++++
 arch/nds32/kernel/vmlinux.lds.S                                               |  57 +++++++
 arch/nds32/lib/Makefile                                                       |   3 +
 arch/nds32/lib/clear_user.S                                                   |  42 +++++
 arch/nds32/lib/copy_from_user.S                                               |  45 +++++
 arch/nds32/lib/copy_page.S                                                    |  37 ++++
 arch/nds32/lib/copy_template.S                                                |  69 ++++++++
 arch/nds32/lib/copy_to_user.S                                                 |  45 +++++
 arch/nds32/lib/memcpy.S                                                       |  30 ++++
 arch/nds32/lib/memmove.S                                                      |  70 ++++++++
 arch/nds32/lib/memset.S                                                       |  33 ++++
 arch/nds32/lib/memzero.S                                                      |  18 ++
 arch/nds32/mm/Makefile                                                        |   7 +
 arch/nds32/mm/alignment.c                                                     | 576 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/cacheflush.c                                                    | 322 +++++++++++++++++++++++++++++++++++
 arch/nds32/mm/extable.c                                                       |  16 ++
 arch/nds32/mm/fault.c                                                         | 410 ++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/highmem.c                                                       |  79 +++++++++
 arch/nds32/mm/init.c                                                          | 277 ++++++++++++++++++++++++++++++
 arch/nds32/mm/ioremap.c                                                       |  62 +++++++
 arch/nds32/mm/mm-nds32.c                                                      |  90 ++++++++++
 arch/nds32/mm/mmap.c                                                          |  73 ++++++++
 arch/nds32/mm/proc.c                                                          | 533 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/tlb.c                                                           |  50 ++++++
 arch/nios2/include/asm/io.h                                                   |   1 +
 arch/openrisc/include/asm/io.h                                                |   3 +-
 arch/sparc/include/asm/io_32.h                                                |   5 -
 arch/sparc/kernel/ioport.c                                                    |   4 +-
 arch/xtensa/include/asm/io.h                                                  |   1 +
 drivers/clocksource/Kconfig                                                   |   9 +
 drivers/clocksource/Makefile                                                  |   1 +
 drivers/clocksource/timer-atcpit100.c                                         | 266 +++++++++++++++++++++++++++++
 drivers/irqchip/Makefile                                                      |   1 +
 drivers/irqchip/irq-ativic32.c                                                | 107 ++++++++++++
 drivers/net/ethernet/faraday/Kconfig                                          |   8 +-
 drivers/tty/serial/earlycon.c                                                 |   3 +-
 drivers/video/console/Kconfig                                                 |   2 +-
 include/asm-generic/io.h                                                      |  18 +-
 131 files changed, 11866 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
 create mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards
 create mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 create mode 100644 arch/nds32/Kconfig
 create mode 100644 arch/nds32/Kconfig.cpu
 create mode 100644 arch/nds32/Makefile
 create mode 100644 arch/nds32/boot/Makefile
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/configs/defconfig
 create mode 100644 arch/nds32/include/asm/Kbuild
 create mode 100644 arch/nds32/include/asm/assembler.h
 create mode 100644 arch/nds32/include/asm/barrier.h
 create mode 100644 arch/nds32/include/asm/bitfield.h
 create mode 100644 arch/nds32/include/asm/cache.h
 create mode 100644 arch/nds32/include/asm/cache_info.h
 create mode 100644 arch/nds32/include/asm/cacheflush.h
 create mode 100644 arch/nds32/include/asm/current.h
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/dma-mapping.h
 create mode 100644 arch/nds32/include/asm/elf.h
 create mode 100644 arch/nds32/include/asm/fixmap.h
 create mode 100644 arch/nds32/include/asm/futex.h
 create mode 100644 arch/nds32/include/asm/highmem.h
 create mode 100644 arch/nds32/include/asm/io.h
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/include/asm/l2_cache.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/asm/memory.h
 create mode 100644 arch/nds32/include/asm/mmu.h
 create mode 100644 arch/nds32/include/asm/mmu_context.h
 create mode 100644 arch/nds32/include/asm/module.h
 create mode 100644 arch/nds32/include/asm/nds32.h
 create mode 100644 arch/nds32/include/asm/page.h
 create mode 100644 arch/nds32/include/asm/pgalloc.h
 create mode 100644 arch/nds32/include/asm/pgtable.h
 create mode 100644 arch/nds32/include/asm/proc-fns.h
 create mode 100644 arch/nds32/include/asm/processor.h
 create mode 100644 arch/nds32/include/asm/ptrace.h
 create mode 100644 arch/nds32/include/asm/shmparam.h
 create mode 100644 arch/nds32/include/asm/string.h
 create mode 100644 arch/nds32/include/asm/swab.h
 create mode 100644 arch/nds32/include/asm/syscall.h
 create mode 100644 arch/nds32/include/asm/syscalls.h
 create mode 100644 arch/nds32/include/asm/thread_info.h
 create mode 100644 arch/nds32/include/asm/tlb.h
 create mode 100644 arch/nds32/include/asm/tlbflush.h
 create mode 100644 arch/nds32/include/asm/uaccess.h
 create mode 100644 arch/nds32/include/asm/unistd.h
 create mode 100644 arch/nds32/include/asm/vdso.h
 create mode 100644 arch/nds32/include/asm/vdso_datapage.h
 create mode 100644 arch/nds32/include/asm/vdso_timer_info.h
 create mode 100644 arch/nds32/include/uapi/asm/Kbuild
 create mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h
 create mode 100644 arch/nds32/include/uapi/asm/cachectl.h
 create mode 100644 arch/nds32/include/uapi/asm/param.h
 create mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 create mode 100644 arch/nds32/include/uapi/asm/sigcontext.h
 create mode 100644 arch/nds32/include/uapi/asm/unistd.h
 create mode 100644 arch/nds32/kernel/Makefile
 create mode 100644 arch/nds32/kernel/asm-offsets.c
 create mode 100644 arch/nds32/kernel/atl2c.c
 create mode 100644 arch/nds32/kernel/cacheinfo.c
 create mode 100644 arch/nds32/kernel/devtree.c
 create mode 100644 arch/nds32/kernel/dma.c
 create mode 100644 arch/nds32/kernel/ex-entry.S
 create mode 100644 arch/nds32/kernel/ex-exit.S
 create mode 100644 arch/nds32/kernel/ex-scall.S
 create mode 100644 arch/nds32/kernel/head.S
 create mode 100644 arch/nds32/kernel/irq.c
 create mode 100644 arch/nds32/kernel/module.c
 create mode 100644 arch/nds32/kernel/nds32_ksyms.c
 create mode 100644 arch/nds32/kernel/process.c
 create mode 100644 arch/nds32/kernel/ptrace.c
 create mode 100644 arch/nds32/kernel/setup.c
 create mode 100644 arch/nds32/kernel/signal.c
 create mode 100644 arch/nds32/kernel/stacktrace.c
 create mode 100644 arch/nds32/kernel/sys_nds32.c
 create mode 100644 arch/nds32/kernel/syscall_table.c
 create mode 100644 arch/nds32/kernel/time.c
 create mode 100644 arch/nds32/kernel/traps.c
 create mode 100644 arch/nds32/kernel/vdso.c
 create mode 100644 arch/nds32/kernel/vdso/Makefile
 create mode 100644 arch/nds32/kernel/vdso/datapage.S
 create mode 100755 arch/nds32/kernel/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/nds32/kernel/vdso/gettimeofday.c
 create mode 100644 arch/nds32/kernel/vdso/note.S
 create mode 100644 arch/nds32/kernel/vdso/sigreturn.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.lds.S
 create mode 100644 arch/nds32/kernel/vmlinux.lds.S
 create mode 100644 arch/nds32/lib/Makefile
 create mode 100644 arch/nds32/lib/clear_user.S
 create mode 100644 arch/nds32/lib/copy_from_user.S
 create mode 100644 arch/nds32/lib/copy_page.S
 create mode 100644 arch/nds32/lib/copy_template.S
 create mode 100644 arch/nds32/lib/copy_to_user.S
 create mode 100644 arch/nds32/lib/memcpy.S
 create mode 100644 arch/nds32/lib/memmove.S
 create mode 100644 arch/nds32/lib/memset.S
 create mode 100644 arch/nds32/lib/memzero.S
 create mode 100644 arch/nds32/mm/Makefile
 create mode 100644 arch/nds32/mm/alignment.c
 create mode 100644 arch/nds32/mm/cacheflush.c
 create mode 100644 arch/nds32/mm/extable.c
 create mode 100644 arch/nds32/mm/fault.c
 create mode 100644 arch/nds32/mm/highmem.c
 create mode 100644 arch/nds32/mm/init.c
 create mode 100644 arch/nds32/mm/ioremap.c
 create mode 100644 arch/nds32/mm/mm-nds32.c
 create mode 100644 arch/nds32/mm/mmap.c
 create mode 100644 arch/nds32/mm/proc.c
 create mode 100644 arch/nds32/mm/tlb.c
 create mode 100644 drivers/clocksource/timer-atcpit100.c
 create mode 100644 drivers/irqchip/irq-ativic32.c
