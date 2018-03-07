Return-Path: <kernel-hardening-return-12205-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsMEEVCD8YRYwWXp1x/GOx6NyjY1UdeSMMur6J+Q3tCZgY5BiV4XdeYEXERs7FJ+5sEIC+t
ARC-Seal: i=1; a=rsa-sha256; t=1520449976; cv=none;
        d=google.com; s=arc-20160816;
        b=08wTvU6EmgDz52LvFlmJqOBTcdd5nAe4NTqpsZyZeaLR4eQPVqR/dk8MMuX7bX1fk/
         9SweeCkJZ/crSVbAuiqHh5x9K8OmgvEamumHg10KnFbMFnvrpHUjZwM9ADJIS1VP1Wrc
         BeoiVlhg3EZSh6i2Kc7fdBVZ+ASVkAw0P9sM/RlOUwczPkS/hqMWxqI7iYJCo/WH18V9
         6KmE/jvuAngIMHse6QBaPRG1vk6HM306OUEzpOCdAOmwNk/3Opz5bSCUuW/5wXFOPW4P
         o8Df3Qh091jIKhClWuVB+b/7hlwT+Fu7Wr3zmw0bnHM5T3G7TsHFrrqCwRwdgqUI2blh
         czSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Mh9aXhHJ9Iv4UXXA5aWchP9+BYXwfYei+wXSdLFttfg=;
        b=mYTKBKxdtj/PO6o1pGUpUvPf7Sa6zCD4SsVzjtMQHfgKw7e3yJYKibgbQXBnkUjndm
         EW2bMDZZZg1DMbirBw7H3NfnZYayoIZ7zdeHK6pfF4SF9J3nRhLSfQaMWToJbwd02Iqs
         EV+V6bZNra8aXSMn4QCGlOyZkzN9AfzfVyzRFeg4HrMC6Rl6jm9J6aOscZAIOJwGzUt4
         NxfVSpSJtudtB8FiAY8Pn2MiWY1/+wSOSoJScsy+xYUArTtr9A2YY3kHQLGPOWEBH+Bn
         Wk1P6ZJTzgU7UekSWw/TpkLoBVogJduSuMqN9nlwF8RCSRHf1VyBIileOMRENduT79XV
         5Kxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12205-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12205-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12205-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12205-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2FF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/vsyscall/64: Drop "native" vsyscalls
Date: Wed,  7 Mar 2018 11:12:27 -0800
Message-Id: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594307354733708248?=
X-GMAIL-MSGID: =?utf-8?q?1594307354733708248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since Linux 3.2, vsyscalls have been deprecated and slow.  From 3.2
on, Linux had three vsyscall modes: "native", "emulate", and "none".

"emulate" is the default.  All known user programs work correctly in
emulate mode, but vsyscalls turn into page faults and are emulated.
This is very slow.  In "native" mode, the vsyscall page is easily
usable as an exploit gadget, but vsyscalls are a bit faster -- they
turn into normal syscalls.  (This is in contrast to vDSO functions,
which can be much faster than syscalls.)  In "none" mode, there are
no vsyscalls.

For all practical purposes, "native" was really just a chicken bit
in case something went wrong with the emulation.  It's been over six
years, and nothing has gone wrong.  Delete it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig                            | 11 +----------
 arch/x86/entry/vsyscall/vsyscall_64.c       | 16 +++-------------
 arch/x86/include/asm/pgtable_types.h        |  2 --
 tools/testing/selftests/x86/test_vsyscall.c | 11 ++++++-----
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..0fa71a78ec99 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2307,7 +2307,7 @@ choice
 	  it can be used to assist security vulnerability exploitation.
 
 	  This setting can be changed at boot time via the kernel command
-	  line parameter vsyscall=[native|emulate|none].
+	  line parameter vsyscall=[emulate|none].
 
 	  On a system with recent enough glibc (2.14 or newer) and no
 	  static binaries, you can say None without a performance penalty
@@ -2315,15 +2315,6 @@ choice
 
 	  If unsure, select "Emulate".
 
-	config LEGACY_VSYSCALL_NATIVE
-		bool "Native"
-		help
-		  Actual executable code is located in the fixed vsyscall
-		  address mapping, implementing time() efficiently. Since
-		  this makes the mapping executable, it can be used during
-		  security vulnerability exploitation (traditionally as
-		  ROP gadgets). This configuration is not recommended.
-
 	config LEGACY_VSYSCALL_EMULATE
 		bool "Emulate"
 		help
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 577fa8adb785..8560ef68a9d6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -42,10 +42,8 @@
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
 
-static enum { EMULATE, NATIVE, NONE } vsyscall_mode =
-#if defined(CONFIG_LEGACY_VSYSCALL_NATIVE)
-	NATIVE;
-#elif defined(CONFIG_LEGACY_VSYSCALL_NONE)
+static enum { EMULATE, NONE } vsyscall_mode =
+#ifdef CONFIG_LEGACY_VSYSCALL_NONE
 	NONE;
 #else
 	EMULATE;
@@ -56,8 +54,6 @@ static int __init vsyscall_setup(char *str)
 	if (str) {
 		if (!strcmp("emulate", str))
 			vsyscall_mode = EMULATE;
-		else if (!strcmp("native", str))
-			vsyscall_mode = NATIVE;
 		else if (!strcmp("none", str))
 			vsyscall_mode = NONE;
 		else
@@ -139,10 +135,6 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 
 	WARN_ON_ONCE(address != regs->ip);
 
-	/* This should be unreachable in NATIVE mode. */
-	if (WARN_ON(vsyscall_mode == NATIVE))
-		return false;
-
 	if (vsyscall_mode == NONE) {
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall attempted with vsyscall=none");
@@ -370,9 +362,7 @@ void __init map_vsyscall(void)
 
 	if (vsyscall_mode != NONE) {
 		__set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
-			     vsyscall_mode == NATIVE
-			     ? PAGE_KERNEL_VSYSCALL
-			     : PAGE_KERNEL_VVAR);
+			     PAGE_KERNEL_VVAR);
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 246f15b4e64c..acfe755562a6 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -174,7 +174,6 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
 #define __PAGE_KERNEL_RX		(__PAGE_KERNEL_EXEC & ~_PAGE_RW)
 #define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_NOCACHE)
-#define __PAGE_KERNEL_VSYSCALL		(__PAGE_KERNEL_RX | _PAGE_USER)
 #define __PAGE_KERNEL_VVAR		(__PAGE_KERNEL_RO | _PAGE_USER)
 #define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
@@ -206,7 +205,6 @@ enum page_cache_mode {
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_VSYSCALL	__pgprot(__PAGE_KERNEL_VSYSCALL | _PAGE_ENC)
 #define PAGE_KERNEL_VVAR	__pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
 
 #define PAGE_KERNEL_IO		__pgprot(__PAGE_KERNEL_IO)
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index be81621446f0..0b4f1cc2291c 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -450,7 +450,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 		num_vsyscall_traps++;
 }
 
-static int test_native_vsyscall(void)
+static int test_emulation(void)
 {
 	time_t tmp;
 	bool is_native;
@@ -458,7 +458,7 @@ static int test_native_vsyscall(void)
 	if (!vtime)
 		return 0;
 
-	printf("[RUN]\tchecking for native vsyscall\n");
+	printf("[RUN]\tchecking that vsyscalls are emulated\n");
 	sethandler(SIGTRAP, sigtrap, 0);
 	set_eflags(get_eflags() | X86_EFLAGS_TF);
 	vtime(&tmp);
@@ -474,11 +474,12 @@ static int test_native_vsyscall(void)
 	 */
 	is_native = (num_vsyscall_traps > 1);
 
-	printf("\tvsyscalls are %s (%d instructions in vsyscall page)\n",
+	printf("[%s]\tvsyscalls are %s (%d instructions in vsyscall page)\n",
+	       (is_native ? "FAIL" : "OK"),
 	       (is_native ? "native" : "emulated"),
 	       (int)num_vsyscall_traps);
 
-	return 0;
+	return is_native;
 }
 #endif
 
@@ -498,7 +499,7 @@ int main(int argc, char **argv)
 	nerrs += test_vsys_r();
 
 #ifdef __x86_64__
-	nerrs += test_native_vsyscall();
+	nerrs += test_emulation();
 #endif
 
 	return nerrs ? 1 : 0;
-- 
2.14.3
