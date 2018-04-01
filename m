Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeDAUkS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:16 -0400
Subject: [PATCH 00/45] C++: Convert the kernel to C++
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:15 +0100
Message-ID: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are a series of patches to start converting the kernel to C++.  It
requires g++ v8.

What rocks:

 (1) Inline template functions, which makes implementation of things like
     cmpxchg() and get_user() much cleaner.

 (2) Inline overloaded functions, which makes implementation of things like
     static_branch_likely() cleaner.

 (3) Class inheritance.  For instance, all those inode wrappers that require
     the base inode struct to be included and that has to be accessed with
     something like:

	inode->vfs_inode.i_mtime

     when you could instead do:

	inode->i_mtime

What I would disallow:

 (1) new and delete.  There's no way to pass GFP_* flags in.

 (2) Constructors and destructors.  Nests of implicit code makes the code less
     obvious, and the replacement of static initialisation with constructor
     calls would make the code size larger.

 (3) Exceptions and RTTI.  RTTI would bulk the kernel up too much and
     exception handling is limited without it, and since destructors are not
     allowed, you still have to manually clean up after an error.

 (4) Operator overloading (except in special cases).

 (5) Function overloading (except in special inline cases).

 (6) STL (though some type trait bits are needed to replace __builtins that
     don't exist in g++).

 (7) 'class', 'private', 'namespace'.

 (8) 'virtual'.  Don't want virtual base classes, though virtual function
     tables might make operations tables more efficient.

Issues:

 (1) Need spaces inserting between strings and symbols.

 (2) Direct assignment of pointers to/from void* isn't allowed by C++, though
     g++ grudgingly permits it with -fpermissive.  I would imagine that a
     compiler option could easily be added to hide the error entirely.

 (3) Need gcc v8+ to statically initialise an object of any struct that's not
     really simple (e.g. if it's got an embedded union).

 (4) Symbol length.  Really need to extern "C" everything to reduce the size
     of the symbols stored in the kernel image.  This shouldn't be a problem
     if out-of-line function overloading isn't permitted.

So far, it gets as far as compiling init/main.c to a .o file.

Seriously, though...

Apart from the cleaner inline functions allowed by templating, I'm not sure
there's a lot of the C++ language that we would want to use in the kernel
unless we want to go for more advanced classes implementing interesting types.

We could, for example, wrap things like userspace pointers, __be numbers,
ioport addresses and control access to them that way, but I don't know that it
gains a whole load that sparse doesn't give us.

And finally, doing this did find a few minor things that can be fixed.

David
---
David Howells (45):
      Use UINT_MAX, not -1, to represent an invalid UID, GID or project ID
      Fix exception_enter() return value
      Fix loop var in be32_to_cpu_array() and cpu_to_be32_array()
      Fix use of ACPI_COMPANION_SET()
      C++: Set compilation as C++ for .c files
      C++: Do some basic C++ type definition
      C++: Define a header with some C++ type traits for type checking
      C++: Implement abs() as an inline template function
      C++: x86: Fix the x86 syscall table production for C++
      C++: x86: Turn xchg(), xadd() & co. into inline template functions
      C++: x86: Turn cmpxchg() & co. into inline template functions
      C++: x86: Turn cmpxchg_double() & co. into inline template functions
      C++: x86: Turn cmpxchg64() & co. into inline template functions
      C++: x86: Turn put_user(), get_user() & co. into inline template functions
      C++: Need space between string and symbol
      C++: Disable VERIFY_OCTAL_PERMISSIONS() for the moment
      C++: Turn READ_ONCE(), WRITE_ONCE() & co. into inline template functions
      C++: Turn RCU accessors into inline template functions
      C++: Turn ktime_add/sub_ns() into inline template functions
      C++: init/main: Constify pointers
      C++: Set the type of atomic64_t to s64
      C++: Define apic_intr_mode after the enum definition, not before
      C++: Don't do "extern asmlinkage"
      C++: Fix BUILD_BUG_ON_ZERO()
      C++: Fix void variables
      C++: Can't have variable/member names the same as typedef names
      C++: Disable __same_type() for the moment
      C++: Move ctx_state enum out of struct context_tracking
      C++: Move the print_line_t enum before first use
      C++: Include linux/hrtimer.h from linux/timer.h
      C++: Avoid using 'compl' and 'and' as names
      C++: __to_fd() needs to reduce the size of v for struct fd::flags
      C++: Move irqchip_irq_state enum
      C++: Fix up use of LIST_POISON*
      C++: Fix static_branch_likely/unlikely()
      C++: Fix kernfs_type() int->enum
      C++: Fix page_zonenum() int->enum
      C++: mutex_trylock_recursive_enum() int->enum
      C++: Fix spinlock initialisation
      C++: Fix sema_init()
      C++: Cast in bitops
      C++: Hide C++ keywords
      C++: Don't need to declare struct pgd_t after typedef
      C++: Can't declare unsized-array in struct cgroup
      C++: Move initcall_level_names[] to __initdata section


 Makefile                               |   13 -
 arch/x86/Makefile                      |    2 
 arch/x86/entry/syscalls/Makefile       |    8 
 arch/x86/entry/syscalls/syscallhdr.pl  |   73 ++++
 arch/x86/entry/syscalls/syscalltbl.pl  |   95 +++++
 arch/x86/include/asm/alternative.h     |   10 -
 arch/x86/include/asm/apic.h            |    2 
 arch/x86/include/asm/arch_hweight.h    |    4 
 arch/x86/include/asm/atomic.h          |    2 
 arch/x86/include/asm/atomic64_64.h     |   12 -
 arch/x86/include/asm/cmpxchg.h         |  430 +++++++++++-----------
 arch/x86/include/asm/cmpxchg_64.h      |   28 +
 arch/x86/include/asm/hw_irq.h          |   38 +-
 arch/x86/include/asm/percpu.h          |   94 ++---
 arch/x86/include/asm/perf_event.h      |    2 
 arch/x86/include/asm/processor.h       |    2 
 arch/x86/include/asm/special_insns.h   |    2 
 arch/x86/include/asm/tlbflush.h        |    1 
 arch/x86/include/asm/uaccess.h         |  630 +++++++++++++++++---------------
 arch/x86/include/asm/uaccess_64.h      |   66 +--
 arch/x86/kernel/asm-offsets_32.c       |    1 
 arch/x86/kernel/asm-offsets_64.c       |    1 
 arch/x86/purgatory/Makefile            |    2 
 include/asm-generic/bitops/le.h        |   32 +-
 include/asm-generic/sections.h         |    2 
 include/linux/acpi.h                   |    2 
 include/linux/backing-dev-defs.h       |    4 
 include/linux/blkdev.h                 |   86 ++--
 include/linux/build_bug.h              |    5 
 include/linux/byteorder/generic.h      |    4 
 include/linux/cgroup-defs.h            |    2 
 include/linux/compat.h                 |    2 
 include/linux/compiler-c++.h           |   54 +++
 include/linux/compiler-gcc.h           |    5 
 include/linux/compiler.h               |   93 +----
 include/linux/compiler_types.h         |    2 
 include/linux/context_tracking.h       |    4 
 include/linux/context_tracking_state.h |   14 -
 include/linux/cpumask.h                |    4 
 include/linux/crypto.h                 |    4 
 include/linux/elevator.h               |   82 ++--
 include/linux/file.h                   |    2 
 include/linux/interrupt.h              |   10 -
 include/linux/irq.h                    |    1 
 include/linux/irqflags.h               |   10 +
 include/linux/jump_label.h             |   41 +-
 include/linux/kernel.h                 |   35 --
 include/linux/kernfs.h                 |    2 
 include/linux/ktime.h                  |   12 +
 include/linux/list.h                   |    8 
 include/linux/list_bl.h                |    4 
 include/linux/list_nulls.h             |    2 
 include/linux/lockdep.h                |    2 
 include/linux/mm.h                     |    2 
 include/linux/mutex.h                  |    5 
 include/linux/page-flags.h             |    3 
 include/linux/poison.h                 |    6 
 include/linux/printk.h                 |    4 
 include/linux/projid.h                 |    2 
 include/linux/rculist.h                |    4 
 include/linux/rculist_bl.h             |    2 
 include/linux/rcupdate.h               |  124 ++++--
 include/linux/sched/task.h             |    2 
 include/linux/semaphore.h              |    5 
 include/linux/spinlock.h               |    2 
 include/linux/spinlock_types.h         |    4 
 include/linux/start_kernel.h           |    2 
 include/linux/stddef.h                 |   12 -
 include/linux/sysctl.h                 |    6 
 include/linux/timer.h                  |    1 
 include/linux/trace_events.h           |   16 -
 include/linux/types.h                  |   16 +
 include/linux/uidgid.h                 |    4 
 init/main.c                            |    4 
 scripts/checksyscalls.sh               |    2 
 tools/power/cpupower/Makefile          |    1 
 tools/virtio/Makefile                  |    2 
 77 files changed, 1269 insertions(+), 1010 deletions(-)
 create mode 100644 arch/x86/entry/syscalls/syscallhdr.pl
 create mode 100644 arch/x86/entry/syscalls/syscalltbl.pl
 create mode 100644 include/linux/compiler-c++.h
