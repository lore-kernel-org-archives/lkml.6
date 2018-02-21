Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226zbY6DX01geIIa9nKzubOoobzdb0QRe+crwx2eVZWNaFH/mBdRcG+5V+4fiG7BBgm/wTkV
ARC-Seal: i=1; a=rsa-sha256; t=1519218155; cv=none;
        d=google.com; s=arc-20160816;
        b=kq8TetdfDLIdbSchuWInAQ71/dbVJkehYS3Kn4NG87JfGRJBbHqsIsY2GOLuEtwdh8
         +jWteVW8DctD8LQumjmdTM8ggr8wbbNP83nfY9QRF5gxPAmvrlhq3eOCvuwm9C9V1xSy
         w/KZg2h8Yrj3o+07ydw66Bh9uzXGOpKA480ZYR4cR/ip1yEj+NeDBQCn+tlyEa8uBgNS
         rzl/F9NC3EUD7JAejcCkfNPOEOZ+xvsiFIpynU92kctTteRSeFwjm9WOO0rz7ffsO5ze
         EpXMjJQAomPRcBQ/Rml1dAygWHC0IZ220ynkYjunMz+iy/CeS6p0xpqWa8bmAPkWGVL0
         ji3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cMDC29GkbSDMk4jO4klZcguiAt21ZJg+Qp8vjbLRMJI=;
        b=lridyYB4mFqu2IqYunjbKOdMvdhr4ik8DOxuWWHY7VVsVUSvY6DRNYVP+va1nB95UX
         XnePaHRV0bJXMrUAtaQcIJLKZuQg0SuZ1dsn6NC98+88kiUyBQf8rCegzI1VOClL8/E/
         Nn0SuJFHfUO0904FsYGp3vNwzYPjHHDhmPz7ULaquz2U9dzu6A2VZbW14WpgUCmPbMf5
         hqEjoJt6yxoaiuts9TTYAVq8j3+XxL3hzC46D4UpKFW/lyPjuN/JicUpCnmznJ4Tu0h1
         PP0+E/lPz+AHK0h8F+UoVwTT+NtP5ULZAZnr1eMkZ55FPZLwK5BgQ6P/Z9T6VCCucb7w
         6+Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 072/167] selftests/x86: Disable tests requiring 32-bit support on pure 64-bit systems
Date: Wed, 21 Feb 2018 13:48:03 +0100
Message-Id: <20180221124528.441870850@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015696449113507?=
X-GMAIL-MSGID: =?utf-8?q?1593015696449113507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 9279ddf23ce78ff2676e8e8e19fec0f022c26d04 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/Makefile |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

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
 
@@ -23,10 +33,6 @@ BINARIES_64 := $(patsubst %,$(OUTPUT)/%,
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
 
-UNAME_M := $(shell uname -m)
-CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
-CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
-
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS += $(BINARIES_32)
