Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFCM1b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeFCM12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>, Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
        damian <damian.tometzki@icloud.com>
Subject: [PATCH 00/29] objtool sync up for the stable 4.9.y tree
Date: Sun,  3 Jun 2018 14:26:23 +0200
Message-Id: <20180603122652.17453-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are pros and cons of dealing with tools in the kernel directory.
The pros are the fact that development happens fast, and new features
can be added to the kernel and the tools at the same times.  The cons
are when dealing with backported kernel patches, it can be necessary to
backport parts of the tool changes as well.

For 4.9.y so far, we have backported individual patches.  That quickly
breaks down when there are minor differences between how backports were
handled, so grabbing 40+ patch long series can be difficult, not
impossible, but really frustrating to attempt.

To help mitigate this mess, this patch series works to sync up the
objtool code with the version that is currently in 4.14.47.  This
required a number of objtool old patches to be backported, a single big
"sync the world" patch, and a lot of include file updates to get
everything all working properly as well as some minor fixes for build
warnings.

And at the end of this series, is a set of backported objtool patches
for gcc-8 that was the main reason this whole patch series was created.
They applied just fine, being the identical version that goes into the
4.14.y stable tree, so it feels like the backport was successful.

This has survivied my limited testing, and as the codebase is identical
to 4.14.47, I'm pretty comfortable dropping this big change in here in
4.9.y.  Hopefully all goes well...

If anyone has any objections to this patch series, or finds anything I
messed up on, please let me know.

thanks,

greg k-h

Arnaldo Carvalho de Melo (11):
  tools include: Introduce linux/compiler-gcc.h
  tools include: Adopt __compiletime_error
  tools include: Introduce atomic_cmpxchg_{relaxed,release}()
  tools include: Add UINT_MAX def to kernel.h
  tools include: Adopt kernel's refcount.h
  tools include uapi: Grab copies of stat.h and fcntl.h
  tools include: Introduce linux/bug.h, from the kernel sources
  tools include: Adopt __same_type() and __must_be_array() from the
    kernel
  tools include: Move ARRAY_SIZE() to linux/kernel.h
  tools include: Drop ARRAY_SIZE() definition from linux/hashtable.h
  tools include: Include missing headers for fls() and types in
    linux/log2.h

Greg Kroah-Hartman (4):
  objtool: sync up with the 4.14.47 version of objtool
  perf/tools: header file sync up
  objtool: header file sync-up
  x86/xen: Add unwind hint annotations to xen_setup_gdt

Jiri Olsa (3):
  tools lib: Add for_each_clear_bit macro
  perf tools: Force fixdep compilation at the start of the build
  perf tools: Move headers check into bash script

Josh Poimboeuf (8):
  objtool: Improve detection of BUG() and other dead ends
  objtool: Move checking code to check.c
  objtool: Support GCC 8's cold subfunctions
  objtool: Support GCC 8 switch tables
  objtool: Detect RIP-relative switch table references
  objtool: Detect RIP-relative switch table references, part 2
  objtool: Fix "noreturn" detection for recursive sibling calls
  objtool, x86: Add several functions and files to the objtool whitelist

Matthew Wilcox (2):
  tools: add more bitmap functions
  radix tree test suite: Remove types.h

Michael S. Tsirkin (1):
  tools: enable endian checks for all sparse builds

 arch/x86/crypto/Makefile                      |    2 +
 arch/x86/crypto/sha1-mb/Makefile              |    2 +
 arch/x86/crypto/sha256-mb/Makefile            |    2 +
 arch/x86/include/asm/orc_types.h              |  107 +
 arch/x86/include/asm/unwind_hints.h           |  103 +
 arch/x86/kernel/Makefile                      |    1 +
 arch/x86/kernel/acpi/Makefile                 |    2 +
 arch/x86/kernel/kprobes/opt.c                 |    9 +-
 arch/x86/kernel/reboot.c                      |    2 +
 arch/x86/kernel/vmlinux.lds.S                 |    1 +
 arch/x86/kvm/svm.c                            |    2 +
 arch/x86/kvm/vmx.c                            |    3 +
 arch/x86/lib/msr-reg.S                        |    8 +-
 arch/x86/net/Makefile                         |    2 +
 arch/x86/platform/efi/Makefile                |    1 +
 arch/x86/power/Makefile                       |    2 +
 arch/x86/xen/Makefile                         |    3 +
 arch/x86/xen/enlighten.c                      |    5 +-
 include/linux/compiler-gcc.h                  |   13 +-
 kernel/kexec_core.c                           |    4 +-
 tools/arch/arm/include/uapi/asm/kvm.h         |   13 +
 tools/arch/arm64/include/uapi/asm/kvm.h       |    6 +
 tools/arch/powerpc/include/uapi/asm/kvm.h     |    1 +
 tools/arch/s390/include/uapi/asm/kvm.h        |    5 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   44 +-
 .../arch/x86/include/asm/disabled-features.h  |    7 +-
 .../arch/x86/include/asm/required-features.h  |    3 +-
 tools/include/asm-generic/bitops.h            |    1 +
 tools/include/asm-generic/bitops/__ffz.h      |   12 +
 tools/include/asm-generic/bitops/find.h       |   28 +
 tools/include/linux/atomic.h                  |    6 +
 tools/include/linux/bitmap.h                  |   26 +
 tools/include/linux/bitops.h                  |    5 +
 tools/include/linux/bug.h                     |   10 +
 tools/include/linux/compiler-gcc.h            |   21 +
 tools/include/linux/compiler.h                |   23 +-
 tools/include/linux/hashtable.h               |    4 -
 tools/include/linux/kernel.h                  |    7 +
 tools/include/linux/log2.h                    |    3 +
 tools/include/linux/refcount.h                |  151 ++
 tools/include/linux/spinlock.h                |    5 +
 tools/include/linux/types.h                   |    5 +-
 tools/include/uapi/asm-generic/mman-common.h  |    5 +
 tools/include/uapi/linux/bpf.h                |   51 +
 tools/include/uapi/linux/fcntl.h              |   67 +
 tools/include/uapi/linux/stat.h               |   45 +
 tools/lib/find_bit.c                          |   25 +
 tools/objtool/Build                           |    4 +
 .../Documentation/stack-validation.txt        |  195 +-
 tools/objtool/Makefile                        |   35 +-
 tools/objtool/arch.h                          |   66 +-
 tools/objtool/arch/x86/Build                  |   10 +-
 tools/objtool/arch/x86/decode.c               |  407 ++-
 .../arch/x86/{insn => include/asm}/inat.h     |    2 +-
 .../x86/{insn => include/asm}/inat_types.h    |    0
 .../arch/x86/{insn => include/asm}/insn.h     |    2 +-
 .../objtool/arch/x86/include/asm/orc_types.h  |  107 +
 tools/objtool/arch/x86/{insn => lib}/inat.c   |    2 +-
 tools/objtool/arch/x86/{insn => lib}/insn.c   |    4 +-
 .../arch/x86/{insn => lib}/x86-opcode-map.txt |    0
 .../x86/{insn => tools}/gen-insn-attr-x86.awk |    0
 tools/objtool/builtin-check.c                 | 1297 +---------
 tools/objtool/builtin-orc.c                   |   68 +
 tools/objtool/builtin.h                       |    6 +
 tools/objtool/cfi.h                           |   55 +
 tools/objtool/check.c                         | 2209 +++++++++++++++++
 tools/objtool/check.h                         |   82 +
 tools/objtool/elf.c                           |  326 ++-
 tools/objtool/elf.h                           |   23 +-
 tools/objtool/objtool.c                       |   12 +-
 tools/objtool/orc.h                           |   30 +
 tools/objtool/orc_dump.c                      |  213 ++
 tools/objtool/orc_gen.c                       |  221 ++
 tools/objtool/special.c                       |    6 +-
 tools/objtool/sync-check.sh                   |   29 +
 tools/objtool/warn.h                          |   10 +
 tools/perf/MANIFEST                           |    6 +
 tools/perf/Makefile.perf                      |  144 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |    7 +-
 tools/perf/check-headers.sh                   |   61 +
 tools/perf/util/util.h                        |    2 -
 81 files changed, 4802 insertions(+), 1692 deletions(-)
 create mode 100644 arch/x86/include/asm/orc_types.h
 create mode 100644 arch/x86/include/asm/unwind_hints.h
 create mode 100644 tools/include/asm-generic/bitops/__ffz.h
 create mode 100644 tools/include/linux/bug.h
 create mode 100644 tools/include/linux/compiler-gcc.h
 create mode 100644 tools/include/linux/refcount.h
 create mode 100644 tools/include/linux/spinlock.h
 create mode 100644 tools/include/uapi/linux/fcntl.h
 create mode 100644 tools/include/uapi/linux/stat.h
 rename tools/objtool/arch/x86/{insn => include/asm}/inat.h (99%)
 rename tools/objtool/arch/x86/{insn => include/asm}/inat_types.h (100%)
 rename tools/objtool/arch/x86/{insn => include/asm}/insn.h (99%)
 create mode 100644 tools/objtool/arch/x86/include/asm/orc_types.h
 rename tools/objtool/arch/x86/{insn => lib}/inat.c (99%)
 rename tools/objtool/arch/x86/{insn => lib}/insn.c (99%)
 rename tools/objtool/arch/x86/{insn => lib}/x86-opcode-map.txt (100%)
 rename tools/objtool/arch/x86/{insn => tools}/gen-insn-attr-x86.awk (100%)
 create mode 100644 tools/objtool/builtin-orc.c
 create mode 100644 tools/objtool/cfi.h
 create mode 100644 tools/objtool/check.c
 create mode 100644 tools/objtool/check.h
 create mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/orc_dump.c
 create mode 100644 tools/objtool/orc_gen.c
 create mode 100644 tools/objtool/sync-check.sh
 create mode 100644 tools/perf/check-headers.sh

-- 
2.17.1
