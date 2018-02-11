Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225+q10Y3qnIn05aG6FE+1fn5JH4xSAk4+t7WwburpAIUvdm/QutL0kTc+q+2HPG3kFOU5aX
ARC-Seal: i=1; a=rsa-sha256; t=1518347532; cv=none;
        d=google.com; s=arc-20160816;
        b=tLopKkruEALQap7/seWzENKV71nMqzCiU22UxnuqliCW/zyMykU5+rRVpIgW3xxJWZ
         2qud+aZ5hHPDngU4Eftds9OsjcISxW6SPuF/vbo/XxxyQRcAediTmfYvozojQ5MkMDRZ
         SMfORzYHNqfp/B6QNeVDMkXkF9aQDHXK4hsv2wdikR95c607xGtcliRyWLcnypwelBHC
         yB0OryCF9MeSxFcrEcL/D3szQKCiCinTQEwVMulshGJIG5U1/D5PfT0YYI83FF6nFCIP
         cO8LO528i8F0V+xYnrFChYDDWEhpz6cGMGFdqL7bwX0jWzwyz8dveeCh0R7GcIxX64ZP
         SGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kR/qEqA1XHO9IsBrvU/4mC3Fuq3WoyhIo506rVSUnT4=;
        b=mQOeZj0kA1+5KPR+u5ANt3tny5hsAntNCdJQgfmDjSG4hKGpjODePQhjknTxFoGNzf
         BqG0OQKhQkT1Zy77SAlHICbY7jGAyJP7CXJjqUhcDz+r6qAE07iL6ttw4MrGiQkMnbxV
         ogmBJy4uul2OF2CeFAxjeD5L8fOj97LVO2to7H7Bm8ySlg8j6hoy2lZo9Q0YSTja1yqu
         Xaa3YJlCtAinHvJqE2+APmwyROzy8MOkOnYTYgDcGwvEcavoYNEiEqsyAhbufDVfmOmi
         pIzpQoEaTZjT3u+eiW8zGU8qKO+KjL/IV1AjZ49uTIBgV7C+PlOkpGQd6IM8TfxTpcDq
         wvjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeBKLL6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:58 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40652 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeBKLLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:04 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5/5] selftests/x86: disable tests requiring 32bit support on pure 64bit systems
Date: Sun, 11 Feb 2018 12:10:13 +0100
Message-Id: <20180211111013.16888-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211111013.16888-1-linux@dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102782491235930?=
X-GMAIL-MSGID: =?utf-8?q?1592102782491235930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ldt_gdt and ptrace_syscall selftests, even in their 64bit variant, use
hard-coded 32bit syscall numbers and call int $0x80. This will fail on
64bit systems with CONFIG_IA32_EMULATION disabled. Therefore, do not build
these tests if we cannot build 32bit binaries (which should be a good
approximation for CONFIG_IA32_EMULATION being enabled).

CC: Dmitry Safonov <dsafonov@virtuozzo.com>
CC: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/x86/Makefile | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 371ae715c506..d744991c0f4f 100644
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
-- 
2.16.1

