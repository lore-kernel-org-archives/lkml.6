Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDEJ43 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:56:29 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44200 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbeDEJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:53:41 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 0/8] use struct pt_regs based syscall calling for x86-64
Date: Thu,  5 Apr 2018 11:52:59 +0200
Message-Id: <20180405095307.3730-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,


On top of all the patches which remove in-kernel calls to syscall functions
merged in commit 642e7fd23353, it now becomes easy for achitectures to
re-define the syscall calling convention. For x86, this may be used to
merely decode those entries from struct pt_regs which are needed for a
specific syscall.

This approach avoids leaking random user-provided register content down
the call chain. Therefore, the seventh patch of this series extends the
register clearing in the entry path to a few more registers.

To exemplify: sys_recv() is a classic 4-parameter syscall. For this syscall,
the DEFINE_SYSCALL macro creates the following stub:

	asmlinkage long sys_recv(struct pt_regs *regs)
	{
		return SyS_recv(regs->di, regs->si, regs->dx, regs->r10);
	}

The assembly of that function then becomes, in slightly reordered fashion:

	<sys_recv>:
		callq	<__fentry__>

		/* decode regs->di, ->si, ->dx and ->r10 */
		mov	0x70(%rdi),%rdi
		mov	0x68(%rdi),%rsi
		mov	0x60(%rdi),%rdx
		mov	0x38(%rdi),%rcx

		[ SyS_recv() is inlined here by the compiler, as it is tiny ]
		/* clear %r9 and %r8, the 5th and 6th args */
		xor	%r9d,%r9d
		xor	%r8d,%r8d

		/* do the actual work */
		callq	__sys_recvfrom

		/* cleanup and return */
		cltq
		retq

For IA32_EMULATION and X32, additional care needs to be taken as they use
different registers to pass parameters to syscalls; vsyscalls need to be
modified to use this new calling convention as well.

This actual conversion of x86 syscalls is heavily based on a proof-of-concept
by Linus[*]. This patchset here differs, for example, as it provides a generic
config symbol ARCH_HAS_SYSCALL_WRAPPER, introduces <asm/syscall_wrapper.h>,
splits up the patch into several parts, and adds the actual register clearing.

	[*] Accessible at
	    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git WIP-syscall
	    It contains an additional patch
		x86: avoid per-cpu system call trampoline
	    which is not included in my series as it addresses a different
	    issue, but may be of interest to the x86 maintainers as well.

Compared to v4.16-rc5 baseline and on a random kernel config, these patches
(in combination with the large do-not-call-syscalls-in-the-kernel series)
lead to a minisculue increase in text (+0.005%) and data (+0.11%) size on a
pure 64bit system,

	    text	   data	   bss	     dec	    hex	filename
	18853337	9535476	938380	29327193	1bf7f59	vmlinux-orig
	18854227	9546100	938380	29338707	1bfac53	vmlinux,

with IA32_EMULATION and X32 enabled, the situation is just a little bit worse
for text size (+0.009%) and data (+0.38%) size.

	    text	   data	   bss	     dec	    hex	filename
	18902496	9603676	938444	29444616	1c14a08	vmlinux-orig
	18904136	9640604	938444	29483184	1c1e0b0 vmlinux.

The 64bit part of this series has worked flawlessly on my local system for a
few weeks. IA32_EMULATION and x32 has passed some basic testing as well, but
has not yet been tested as extensively as x86-64. Pure i386 kernels are left
as-is, as they use a different asmlinkage anyway.


Changes since the series sent out to linux-kernel on March 30th:

all patches:
- rebase on top of commit 642e7fd23353

several patches:
- further extend and fix commentary; spelling fixes (e.g., nospec, 64-bit,
  32-bit)

patch 3:
- do not clobber regs->dx on sys_getcpu() vsyscall

patch 5:
- rename __sys32_ia32_*() stubs to __sys_ia32_*()
- do not generate __sys_ia32_*() syscall table entries automatically, but
  have them explicitely in arch/x86/entry/syscalls/syscall_32.tbl
- this means that there is no need to redefine SYSCALL_DEFINE0
- rename compat_sys_*() to __compat_sys_ia32_*(), as the calling convention
  is different to "generic" compat_sys_*() [but see below]

patch 8: (your call...)
- introduce new patch 8: rename sys_*() to __sys_x86_*() -- while this
  avoids symbol space overlap per your request, it doesn't improve the
  code readibility by much. Moreover, if other architectures switch to
  this syscall calling convention, there is no real "default" calling
  convention any more. Therefore, I'd suggest *NOT* to apply this patch.

Thanks,
	Dominik

Dominik Brodowski (7):
  syscalls: introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER
  syscalls/x86: use struct pt_regs based syscall calling for 64-bit
    syscalls
  syscalls: prepare ARCH_HAS_SYSCALL_WRAPPER for compat syscalls
  syscalls/x86: use struct pt_regs based syscall calling for
    IA32_EMULATION and x32
  syscalls/x86: unconditionally enable struct pt_regs based syscalls on
    x86_64
  x86/entry/64: extend register clearing on syscall entry to lower
    registers
  syscalls/x86: rename struct pt_regs-based sys_*() to __sys_x86_*()

Linus Torvalds (1):
  x86: don't pointlessly reload the system call number

 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/calling.h               |   2 +
 arch/x86/entry/common.c                |  20 +-
 arch/x86/entry/entry_64.S              |   3 +-
 arch/x86/entry/entry_64_compat.S       |   6 +
 arch/x86/entry/syscall_32.c            |  15 +-
 arch/x86/entry/syscall_64.c            |   6 +-
 arch/x86/entry/syscalls/syscall_32.tbl | 724 +++++++++++++++++----------------
 arch/x86/entry/syscalls/syscall_64.tbl | 712 ++++++++++++++++----------------
 arch/x86/entry/vsyscall/vsyscall_64.c  |  18 +-
 arch/x86/include/asm/syscall.h         |   4 +
 arch/x86/include/asm/syscall_wrapper.h | 197 +++++++++
 arch/x86/include/asm/syscalls.h        |  17 +-
 include/linux/compat.h                 |  22 +
 include/linux/syscalls.h               |  25 +-
 init/Kconfig                           |  10 +
 kernel/sys_ni.c                        |  10 +
 kernel/time/posix-stubs.c              |  10 +
 18 files changed, 1054 insertions(+), 748 deletions(-)
 create mode 100644 arch/x86/include/asm/syscall_wrapper.h

-- 
2.16.3
