Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeBLCKW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:10:22 -0500
Received: from [198.137.202.136] ([198.137.202.136]:56335 "EHLO mail.zytor.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932237AbeBLCKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:10:21 -0500
Date: Sun, 11 Feb 2018 04:14:45 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-29469471c10759d81b699aa0b9f02d9a71071be5@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dsafonov@virtuozzo.com, linux@dominikbrodowski.net, luto@kernel.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dsafonov@virtuozzo.com, linux@dominikbrodowski.net, luto@kernel.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org
In-Reply-To: <20180211111013.16888-6-linux@dominikbrodowski.net>
References: <20180211111013.16888-6-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] selftests/x86: Disable tests requiring 32-bit
 support on pure 64-bit systems
Git-Commit-ID: 29469471c10759d81b699aa0b9f02d9a71071be5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  29469471c10759d81b699aa0b9f02d9a71071be5
Gitweb:     https://git.kernel.org/tip/29469471c10759d81b699aa0b9f02d9a71071be5
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 12:10:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:24:47 +0100

selftests/x86: Disable tests requiring 32-bit support on pure 64-bit systems

The ldt_gdt and ptrace_syscall selftests, even in their 64-bit variant, use
hard-coded 32-bit syscall numbers and call "int $0x80".

This will fail on 64-bit systems with CONFIG_IA32_EMULATION=y disabled.

Therefore, do not build these tests if we cannot build 32-bit binaries
(which should be a good approximation for CONFIG_IA32_EMULATION=y being enabled).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-6-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/Makefile | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 371ae71..d744991 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -5,16 +5,26 @@ include ../lib.mk
 
 .PHONY: all all_32 all_64 warn_32bit_failure clean
 
-TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_syscall test_mremap_vdso \
-			check_initial_reg_state sigreturn ldt_gdt iopl mpx-mini-test ioperm \
+UNAME_M := $(shell uname -m)
+CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
+CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
+
+TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
+			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
 			protection_keys test_vdso test_vsyscall
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
+# Some selftests require 32bit support enabled also on 64bit systems
+TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
-TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
+TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY) $(TARGETS_C_32BIT_NEEDED)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
+ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),11)
+TARGETS_C_64BIT_ALL += $(TARGETS_C_32BIT_NEEDED)
+endif
+
 BINARIES_32 := $(TARGETS_C_32BIT_ALL:%=%_32)
 BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 
@@ -23,10 +33,6 @@ BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
 
-UNAME_M := $(shell uname -m)
-CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
-CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
-
 define gen-target-rule-32
 $(1) $(1)_32: $(OUTPUT)/$(1)_32
 .PHONY: $(1) $(1)_32
