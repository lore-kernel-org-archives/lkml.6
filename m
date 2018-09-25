Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD749C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D6520657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D6520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIYX2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:28:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44319 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:28:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0Q-00054A-Vj; Tue, 25 Sep 2018 11:20:15 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0A-0001uD-GQ; Tue, 25 Sep 2018 11:20:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Sep 2018 19:19:03 +0200
Message-Id: <20180925171906.19683-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
X-XM-SPF: eid=1g4r0A-0001uD-GQ;;;mid=<20180925171906.19683-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19a64/8XlXpdOp3iR2djkjp6ORaKEoYXzY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 3/6] signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the defintion of struct siginfo so that the array padding
struct siginfo to SI_MAX_SIZE can be placed in a union along side of
the rest of the struct siginfo members.  The result is that we no
longer need the __ARCH_SI_PREAMBLE_SIZE or SI_PAD_SIZE definitions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/include/uapi/asm/siginfo.h   |   1 -
 arch/arm64/include/uapi/asm/Kbuild      |   1 +
 arch/arm64/include/uapi/asm/siginfo.h   |  24 ---
 arch/ia64/include/uapi/asm/siginfo.h    |   2 -
 arch/mips/include/uapi/asm/siginfo.h    |  11 --
 arch/parisc/include/uapi/asm/Kbuild     |   1 +
 arch/parisc/include/uapi/asm/siginfo.h  |  11 --
 arch/powerpc/include/uapi/asm/Kbuild    |   1 +
 arch/powerpc/include/uapi/asm/siginfo.h |  18 ---
 arch/riscv/include/uapi/asm/Kbuild      |   1 +
 arch/riscv/include/uapi/asm/siginfo.h   |  24 ---
 arch/s390/include/uapi/asm/Kbuild       |   1 +
 arch/s390/include/uapi/asm/siginfo.h    |  17 ---
 arch/sparc/include/uapi/asm/siginfo.h   |   1 -
 arch/x86/include/uapi/asm/siginfo.h     |   2 -
 include/uapi/asm-generic/siginfo.h      | 187 ++++++++++++------------
 kernel/signal.c                         |   3 -
 17 files changed, 99 insertions(+), 207 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/siginfo.h
 delete mode 100644 arch/parisc/include/uapi/asm/siginfo.h
 delete mode 100644 arch/powerpc/include/uapi/asm/siginfo.h
 delete mode 100644 arch/riscv/include/uapi/asm/siginfo.h
 delete mode 100644 arch/s390/include/uapi/asm/siginfo.h

diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
index db3f0138536f..6e1a2af2f962 100644
--- a/arch/alpha/include/uapi/asm/siginfo.h
+++ b/arch/alpha/include/uapi/asm/siginfo.h
@@ -2,7 +2,6 @@
 #ifndef _ALPHA_SIGINFO_H
 #define _ALPHA_SIGINFO_H
 
-#define __ARCH_SI_PREAMBLE_SIZE		(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
 
 #include <asm-generic/siginfo.h>
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 198afbf0688f..6c5adf458690 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -19,3 +19,4 @@ generic-y += swab.h
 generic-y += termbits.h
 generic-y += termios.h
 generic-y += types.h
+generic-y += siginfo.h
diff --git a/arch/arm64/include/uapi/asm/siginfo.h b/arch/arm64/include/uapi/asm/siginfo.h
deleted file mode 100644
index 574d12f86039..000000000000
--- a/arch/arm64/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_SIGINFO_H
-#define __ASM_SIGINFO_H
-
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-
-#include <asm-generic/siginfo.h>
-
-#endif
diff --git a/arch/ia64/include/uapi/asm/siginfo.h b/arch/ia64/include/uapi/asm/siginfo.h
index 52b5af424511..796af1ccaa7e 100644
--- a/arch/ia64/include/uapi/asm/siginfo.h
+++ b/arch/ia64/include/uapi/asm/siginfo.h
@@ -9,8 +9,6 @@
 #define _UAPI_ASM_IA64_SIGINFO_H
 
 
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-
 #include <asm-generic/siginfo.h>
 
 #define si_imm		_sifields._sigfault._imm	/* as per UNIX SysV ABI spec */
diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 262504bd59a5..c34c7eef0a1c 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -14,17 +14,6 @@
 #define __ARCH_SIGEV_PREAMBLE_SIZE (sizeof(long) + 2*sizeof(int))
 #undef __ARCH_SI_TRAPNO /* exception code needs to fill this ...  */
 
-/*
- * Careful to keep union _sifields from shifting ...
- */
-#if _MIPS_SZLONG == 32
-#define __ARCH_SI_PREAMBLE_SIZE (3 * sizeof(int))
-#elif _MIPS_SZLONG == 64
-#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
-#else
-#error _MIPS_SZLONG neither 32 nor 64
-#endif
-
 #define __ARCH_HAS_SWAPPED_SIGINFO
 
 #include <asm-generic/siginfo.h>
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index 286ef5a5904b..adb5c64831c7 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += kvm_para.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
+generic-y += siginfo.h
diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/include/uapi/asm/siginfo.h
deleted file mode 100644
index 4a1062e05aaf..000000000000
--- a/arch/parisc/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _PARISC_SIGINFO_H
-#define _PARISC_SIGINFO_H
-
-#if defined(__LP64__)
-#define __ARCH_SI_PREAMBLE_SIZE   (4 * sizeof(int))
-#endif
-
-#include <asm-generic/siginfo.h>
-
-#endif
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 1a6ed5919ffd..a658091a19f9 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += poll.h
 generic-y += resource.h
 generic-y += sockios.h
 generic-y += statfs.h
+generic-y += siginfo.h
diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include/uapi/asm/siginfo.h
deleted file mode 100644
index 1d51d9b88221..000000000000
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-#ifndef _ASM_POWERPC_SIGINFO_H
-#define _ASM_POWERPC_SIGINFO_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifdef __powerpc64__
-#    define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-#endif
-
-#include <asm-generic/siginfo.h>
-
-#endif	/* _ASM_POWERPC_SIGINFO_H */
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 7e91f4850475..5511b9918131 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -26,3 +26,4 @@ generic-y += swab.h
 generic-y += termbits.h
 generic-y += termios.h
 generic-y += types.h
+generic-y += siginfo.h
diff --git a/arch/riscv/include/uapi/asm/siginfo.h b/arch/riscv/include/uapi/asm/siginfo.h
deleted file mode 100644
index f96849aac662..000000000000
--- a/arch/riscv/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- * Copyright (C) 2016 SiFive, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_SIGINFO_H
-#define __ASM_SIGINFO_H
-
-#define __ARCH_SI_PREAMBLE_SIZE	(__SIZEOF_POINTER__ == 4 ? 12 : 16)
-
-#include <asm-generic/siginfo.h>
-
-#endif
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index e364873e0d10..dc38a90cf091 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -18,3 +18,4 @@ generic-y += shmbuf.h
 generic-y += sockios.h
 generic-y += swab.h
 generic-y += termbits.h
+generic-y += siginfo.h
\ No newline at end of file
diff --git a/arch/s390/include/uapi/asm/siginfo.h b/arch/s390/include/uapi/asm/siginfo.h
deleted file mode 100644
index 6984820f2f1c..000000000000
--- a/arch/s390/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/siginfo.h"
- */
-
-#ifndef _S390_SIGINFO_H
-#define _S390_SIGINFO_H
-
-#ifdef __s390x__
-#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
-#endif
-
-#include <asm-generic/siginfo.h>
-
-#endif
diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 6c820ea0813b..68bdde4c2a2e 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -4,7 +4,6 @@
 
 #if defined(__sparc__) && defined(__arch64__)
 
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #define __ARCH_SI_BAND_T int
 
 #endif /* defined(__sparc__) && defined(__arch64__) */
diff --git a/arch/x86/include/uapi/asm/siginfo.h b/arch/x86/include/uapi/asm/siginfo.h
index b3d157957177..6642d8be40c4 100644
--- a/arch/x86/include/uapi/asm/siginfo.h
+++ b/arch/x86/include/uapi/asm/siginfo.h
@@ -7,8 +7,6 @@
 typedef long long __kernel_si_clock_t __attribute__((aligned(4)));
 #  define __ARCH_SI_CLOCK_T		__kernel_si_clock_t
 #  define __ARCH_SI_ATTRIBUTES		__attribute__((aligned(8)))
-# else /* x86-64 */
-#  define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 # endif
 #endif
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 1811b8101937..cb3d6c267181 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -10,18 +10,7 @@ typedef union sigval {
 	void __user *sival_ptr;
 } sigval_t;
 
-/*
- * This is the size (including padding) of the part of the
- * struct siginfo that is before the union.
- */
-#ifndef __ARCH_SI_PREAMBLE_SIZE
-#define __ARCH_SI_PREAMBLE_SIZE	(3 * sizeof(int))
-#endif
-
 #define SI_MAX_SIZE	128
-#ifndef SI_PAD_SIZE
-#define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
-#endif
 
 /*
  * The default "si_band" type is "long", as specified by POSIX.
@@ -40,96 +29,108 @@ typedef union sigval {
 #define __ARCH_SI_ATTRIBUTES
 #endif
 
-typedef struct siginfo {
-	int si_signo;
-#ifndef __ARCH_HAS_SWAPPED_SIGINFO
-	int si_errno;
-	int si_code;
-#else
-	int si_code;
-	int si_errno;
-#endif
-
-	union {
-		int _pad[SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			__kernel_pid_t _pid;	/* sender's pid */
-			__kernel_uid32_t _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			__kernel_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			sigval_t _sigval;	/* same as below */
-			int _sys_private;       /* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			__kernel_pid_t _pid;	/* sender's pid */
-			__kernel_uid32_t _uid;	/* sender's uid */
-			sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			__kernel_pid_t _pid;	/* which child */
-			__kernel_uid32_t _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			__ARCH_SI_CLOCK_T _utime;
-			__ARCH_SI_CLOCK_T _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
-		struct {
-			void __user *_addr; /* faulting insn/memory ref. */
+union __sifields {
+	/* kill() */
+	struct {
+		__kernel_pid_t _pid;	/* sender's pid */
+		__kernel_uid32_t _uid;	/* sender's uid */
+	} _kill;
+
+	/* POSIX.1b timers */
+	struct {
+		__kernel_timer_t _tid;	/* timer id */
+		int _overrun;		/* overrun count */
+		sigval_t _sigval;	/* same as below */
+		int _sys_private;       /* not to be passed to user */
+	} _timer;
+
+	/* POSIX.1b signals */
+	struct {
+		__kernel_pid_t _pid;	/* sender's pid */
+		__kernel_uid32_t _uid;	/* sender's uid */
+		sigval_t _sigval;
+	} _rt;
+
+	/* SIGCHLD */
+	struct {
+		__kernel_pid_t _pid;	/* which child */
+		__kernel_uid32_t _uid;	/* sender's uid */
+		int _status;		/* exit code */
+		__ARCH_SI_CLOCK_T _utime;
+		__ARCH_SI_CLOCK_T _stime;
+	} _sigchld;
+
+	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
+	struct {
+		void __user *_addr; /* faulting insn/memory ref. */
 #ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
+		int _trapno;	/* TRAP # which caused the signal */
 #endif
 #ifdef __ia64__
-			int _imm;		/* immediate value for "break" */
-			unsigned int _flags;	/* see ia64 si_flags */
-			unsigned long _isr;	/* isr */
+		int _imm;		/* immediate value for "break" */
+		unsigned int _flags;	/* see ia64 si_flags */
+		unsigned long _isr;	/* isr */
 #endif
 
 #define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
 			      sizeof(short) : __alignof__(void *))
-			union {
-				/*
-				 * used when si_code=BUS_MCEERR_AR or
-				 * used when si_code=BUS_MCEERR_AO
-				 */
-				short _addr_lsb; /* LSB of the reported address */
-				/* used when si_code=SEGV_BNDERR */
-				struct {
-					char _dummy_bnd[__ADDR_BND_PKEY_PAD];
-					void __user *_lower;
-					void __user *_upper;
-				} _addr_bnd;
-				/* used when si_code=SEGV_PKUERR */
-				struct {
-					char _dummy_pkey[__ADDR_BND_PKEY_PAD];
-					__u32 _pkey;
-				} _addr_pkey;
-			};
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
+		union {
+			/*
+			 * used when si_code=BUS_MCEERR_AR or
+			 * used when si_code=BUS_MCEERR_AO
+			 */
+			short _addr_lsb; /* LSB of the reported address */
+			/* used when si_code=SEGV_BNDERR */
+			struct {
+				char _dummy_bnd[__ADDR_BND_PKEY_PAD];
+				void __user *_lower;
+				void __user *_upper;
+			} _addr_bnd;
+			/* used when si_code=SEGV_PKUERR */
+			struct {
+				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
+				__u32 _pkey;
+			} _addr_pkey;
+		};
+	} _sigfault;
+
+	/* SIGPOLL */
+	struct {
+		__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+		int _fd;
+	} _sigpoll;
+
+	/* SIGSYS */
+	struct {
+		void __user *_call_addr; /* calling user insn */
+		int _syscall;	/* triggering system call number */
+		unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
+	} _sigsys;
+};
 
-		/* SIGSYS */
-		struct {
-			void __user *_call_addr; /* calling user insn */
-			int _syscall;	/* triggering system call number */
-			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
+#ifndef __ARCH_HAS_SWAPPED_SIGINFO
+#define __SIGINFO 			\
+struct {				\
+	int si_signo;			\
+	int si_errno;			\
+	int si_code;			\
+	union __sifields _sifields;	\
+}
+#else
+#define __SIGINFO 			\
+struct {				\
+	int si_signo;			\
+	int si_code;			\
+	int si_errno;			\
+	union __sifields _sifields;	\
+}
+#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+
+typedef struct siginfo {
+	union {
+		__SIGINFO;
+		int _si_pad[SI_MAX_SIZE/sizeof(int)];
+	};
 } __ARCH_SI_ATTRIBUTES siginfo_t;
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index e445b0a63faa..debb485a76db 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3963,9 +3963,6 @@ __weak const char *arch_vma_name(struct vm_area_struct *vma)
 
 void __init signals_init(void)
 {
-	/* If this check fails, the __ARCH_SI_PREAMBLE_SIZE value is wrong! */
-	BUILD_BUG_ON(__ARCH_SI_PREAMBLE_SIZE
-		!= offsetof(struct siginfo, _sifields._pad));
 	BUILD_BUG_ON(sizeof(struct siginfo) != SI_MAX_SIZE);
 
 	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC);
-- 
2.17.1

