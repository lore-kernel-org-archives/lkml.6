Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032255AbeBOAZm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:25:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeBOAZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:25:40 -0500
Date: Wed, 14 Feb 2018 16:25:11 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-4105c69703cdeba76f384b901712c9397b04e9c2@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux@dominikbrodowski.net, torvalds@linux-foundation.org,
        dsafonov@virtuozzo.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, luto@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, dsafonov@virtuozzo.com, luto@kernel.org,
        peterz@infradead.org
In-Reply-To: <20180211111013.16888-5-linux@dominikbrodowski.net>
References: <20180211111013.16888-5-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86: Do not rely on "int $0x80" in
 single_step_syscall.c
Git-Commit-ID: 4105c69703cdeba76f384b901712c9397b04e9c2
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

Commit-ID:  4105c69703cdeba76f384b901712c9397b04e9c2
Gitweb:     https://git.kernel.org/tip/4105c69703cdeba76f384b901712c9397b04e9c2
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Tue, 13 Feb 2018 09:13:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:48 +0100

selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled). To keep the "Set TF and check int80"
test running on 64-bit installs with CONFIG_IA32_EMULATION=y enabled, build
this test only if we can also build 32-bit binaries (which should be a
good approximation for that).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/Makefile              | 2 ++
 tools/testing/selftests/x86/single_step_syscall.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 91fbfa8..73b8ef6 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -30,11 +30,13 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS += $(BINARIES_32)
+EXTRA_CFLAGS += -DCAN_BUILD_32
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
 TEST_PROGS += $(BINARIES_64)
+EXTRA_CFLAGS += -DCAN_BUILD_64
 endif
 
 all_32: $(BINARIES_32)
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index a48da95..ddfdd63 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -119,7 +119,9 @@ static void check_result(void)
 
 int main()
 {
+#ifdef CAN_BUILD_32
 	int tmp;
+#endif
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
@@ -139,12 +141,13 @@ int main()
 		      : : "c" (post_nop) : "r11");
 	check_result();
 #endif
-
+#ifdef CAN_BUILD_32
 	printf("[RUN]\tSet TF and check int80\n");
 	set_eflags(get_eflags() | X86_EFLAGS_TF);
 	asm volatile ("int $0x80" : "=a" (tmp) : "a" (SYS_getpid)
 			: INT80_CLOBBERS);
 	check_result();
+#endif
 
 	/*
 	 * This test is particularly interesting if fast syscalls use
