Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeA3JYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:24:08 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46254 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA3JYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:24:04 -0500
X-Google-Smtp-Source: AH8x2260Ahks/2qtrPh1dY2WJfl3mbCs6jID1X02QmpNUO4Vu8WnOawUE44dCie/+0PYkIBNIAOyTOidjftk0U0AkvE=
MIME-Version: 1.0
In-Reply-To: <cover.1517246437.git.dvyukov@google.com>
References: <cover.1517246437.git.dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 30 Jan 2018 10:23:42 +0100
Message-ID: <CACT4Y+YYyw8bz8TgCJPF3mvDuipzs53gsAcj+8rgC42H2y58vw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] x86, kasan: add KASAN checks to atomic operations
To: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 6:26 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> KASAN uses compiler instrumentation to intercept all memory accesses.
> But it does not see memory accesses done in assembly code.
> One notable user of assembly code is atomic operations. Frequently,
> for example, an atomic reference decrement is the last access to an
> object and a good candidate for a racy use-after-free.
>
> Atomic operations are defined in arch files, but KASAN instrumentation
> is required for several archs that support KASAN. Later we will need
> similar hooks for KMSAN (uninit use detector) and KTSAN (data race
> detector).
>
> This change introduces wrappers around atomic operations that can be
> used to add KASAN/KMSAN/KTSAN instrumentation across several archs,
> and adds KASAN checks to them.
>
> This patch uses the wrappers only for x86 arch. Arm64 will be switched
> later. And we also plan to instrument bitops in a similar way.
>
> Within a day it has found its first bug:
>
> BUG: KASAN: use-after-free in atomic_dec_and_test
> arch/x86/include/asm/atomic.h:123 [inline] at addr ffff880079c30158
> Write of size 4 by task syz-executor6/25698
> CPU: 2 PID: 25698 Comm: syz-executor6 Not tainted 4.10.0+ #302
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:344
>  atomic_dec_and_test arch/x86/include/asm/atomic.h:123 [inline]
>  put_task_struct include/linux/sched/task.h:93 [inline]
>  put_ctx+0xcf/0x110 kernel/events/core.c:1131
>  perf_event_release_kernel+0x3ad/0xc90 kernel/events/core.c:4322
>  perf_release+0x37/0x50 kernel/events/core.c:4338
>  __fput+0x332/0x800 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:245
>  task_work_run+0x197/0x260 kernel/task_work.c:116
>  exit_task_work include/linux/task_work.h:21 [inline]
>  do_exit+0xb38/0x29c0 kernel/exit.c:880
>  do_group_exit+0x149/0x420 kernel/exit.c:984
>  get_signal+0x7e0/0x1820 kernel/signal.c:2318
>  do_signal+0xd2/0x2190 arch/x86/kernel/signal.c:808
>  exit_to_usermode_loop+0x200/0x2a0 arch/x86/entry/common.c:157
>  syscall_return_slowpath arch/x86/entry/common.c:191 [inline]
>  do_syscall_64+0x6fc/0x930 arch/x86/entry/common.c:286
>  entry_SYSCALL64_slow_path+0x25/0x25
> RIP: 0033:0x4458d9
> RSP: 002b:00007f3f07187cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000007080c8 RCX: 00000000004458d9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000007080c8
> RBP: 00000000007080a8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f3f071889c0 R15: 00007f3f07188700
> Object at ffff880079c30140, in cache task_struct size: 5376
> Allocated:
> PID = 25681
>  kmem_cache_alloc_node+0x122/0x6f0 mm/slab.c:3662
>  alloc_task_struct_node kernel/fork.c:153 [inline]
>  dup_task_struct kernel/fork.c:495 [inline]
>  copy_process.part.38+0x19c8/0x4aa0 kernel/fork.c:1560
>  copy_process kernel/fork.c:1531 [inline]
>  _do_fork+0x200/0x1010 kernel/fork.c:1994
>  SYSC_clone kernel/fork.c:2104 [inline]
>  SyS_clone+0x37/0x50 kernel/fork.c:2098
>  do_syscall_64+0x2e8/0x930 arch/x86/entry/common.c:281
>  return_from_SYSCALL_64+0x0/0x7a
> Freed:
> PID = 25681
>  __cache_free mm/slab.c:3514 [inline]
>  kmem_cache_free+0x71/0x240 mm/slab.c:3774
>  free_task_struct kernel/fork.c:158 [inline]
>  free_task+0x151/0x1d0 kernel/fork.c:370
>  copy_process.part.38+0x18e5/0x4aa0 kernel/fork.c:1931
>  copy_process kernel/fork.c:1531 [inline]
>  _do_fork+0x200/0x1010 kernel/fork.c:1994
>  SYSC_clone kernel/fork.c:2104 [inline]
>  SyS_clone+0x37/0x50 kernel/fork.c:2098
>  do_syscall_64+0x2e8/0x930 arch/x86/entry/common.c:281
>  return_from_SYSCALL_64+0x0/0x7a
>
> Changes since v1:
>  - dropped "x86: remove unused atomic_inc_short()" patch
>    it is mailed separately
>  - rebased on top of tip/locking/core head
>  - other changes noted within individual patches
>
> Changes since v2:
>  - rebased on top of tip/locking/core head
>  - dropped a pervasive "x86: use long long for 64-bit atomic ops" commit,
>    instead use s64 type in wrappers
>  - added "x86: use s64* for old arg of atomic64_try_cmpxchg()" commit
>
> Changes since v3 are noted in individual commits.
>
> Changes since v4:
>  - rebased on tip/locking/core HEAD
>
> Changes since v5:
>  - rework cmpxchg* implementations so that we have less
>    code in macros and more code in functions

Some context.
This revives a half-year old patch. v5 of this was applied to
tip/locking/core, but then reverted due to a reported crash:
https://groups.google.com/d/msg/kasan-dev/ZJl66N7smmk/lJY99HmmAgAJ

The root cause was in the cmpxchg macros:

#define cmpxchg64(ptr, old, new)                       \
({                                                     \
       __typeof__(ptr) ____ptr = (ptr);                \
       kasan_check_write(____ptr, sizeof(*____ptr));   \
       arch_cmpxchg64(____ptr, (old), (new));          \
})

I had to introduce the new ____ptr variable, so that
kasan_check_write() and arch_cmpxchg64() don't evaluate ptr twice. But
there are multiple layers of macros and ____ptr ended up referring to
something else (to itself).

v6 changes cmpxchg macros to (as was suggested by Mark and Thomas):

static __always_inline unsigned long
cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
{
        kasan_check_write(ptr, size);
        switch (size) {
        case 1:
                return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
        case 2:
                return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
        case 4:
                return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
        case 8:
                BUILD_BUG_ON(sizeof(unsigned long) != 8);
                return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
        }
        BUILD_BUG();
        return 0;
}

#define cmpxchg(ptr, old, new)                                                \
({                                                                        \
        ((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),        \
                (unsigned long)(new), sizeof(*(ptr))));                        \
})

Otherwise the patch series were rebased without any conflicts (surprisingly).

There is now some duplication between cmpxchg_size, cmpxchg_local_size
and sync_cmpxchg_size, but I thought that employing more macros while
trying to resolve macro mess bugs is not the best idea.



> Tested:
>  - build/boot x86_64 defconfig
>  - build/boot x86_64 defconfig+KASAN
>  - build i686/powerpc defconfig
>
> Dmitry Vyukov (4):
>   locking/atomic: Add asm-generic/atomic-instrumented.h
>   x86: switch atomic.h to use atomic-instrumented.h
>   asm-generic: add KASAN instrumentation to atomic operations
>   asm-generic, x86: add comments for atomic instrumentation
>
>  arch/x86/include/asm/atomic.h             | 106 +++----
>  arch/x86/include/asm/atomic64_32.h        | 106 +++----
>  arch/x86/include/asm/atomic64_64.h        | 108 +++----
>  arch/x86/include/asm/cmpxchg.h            |  12 +-
>  arch/x86/include/asm/cmpxchg_32.h         |   8 +-
>  arch/x86/include/asm/cmpxchg_64.h         |   4 +-
>  include/asm-generic/atomic-instrumented.h | 476 ++++++++++++++++++++++++++++++
>  7 files changed, 652 insertions(+), 168 deletions(-)
>  create mode 100644 include/asm-generic/atomic-instrumented.h
>
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
