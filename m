Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2259H+pok6ym9hP/yrXaq5TbCXtTTqSZ9uqEQoIw5VAyZDVsM7B+TfsQvXF0/G+10WHUwJb5
ARC-Seal: i=1; a=rsa-sha256; t=1518347512; cv=none;
        d=google.com; s=arc-20160816;
        b=0qUPYLitg3WUA/+/BVCW/ksWeS6f0WXrP/1Tr7CBloXGqbUei3K9ZmdMxBMLk0bT0k
         dibqGgE74TxwwqtTkX1infxkQx1KAxsKbCmbAjSYJ2SQ/pLeAu+hDSv2dQTbHbC2zivS
         hhcxf3yt3MpuEeq8RC2MgeMCywTotzSRQnd0VhKAKFdUpPPcwb5NfTLnPhQ+PHuzpDaa
         L0Jyn4hvDv1+fMqLaviLitfmC1dGwPS1TUMEoZyBl2tyD9lWeu11y6Lv0LrnlGupi09A
         ujpPB8R4NfclDvufRghfFNm+lKRY5erzAPUbRhgfbG/L2y5cvbV3/hpxdoorMLebHuEm
         U2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2QXxFqDIsx9ieUyI+9R43D2iOcPO+6Yo10jk8MzsMeE=;
        b=eLwU2J/ZLSmU+WprDmry4AgN0ozOYumUz5He9K9ruvEyF7tQLVbgArB/AvJwiLLyLI
         V60385B4XuLO6SaVm3EN3OvpC8Dqp14ic18QvgFqUhllQn86pDNj7jDrBqWZ1yymRzQp
         +xc4Tn4F9HRRUgrtnyrim1yv1C1xzJYEtWHNObG+U9UfDph5X+SmjrWUJKd5E6sHeXUR
         aDY/db7jVFOJ3gB3jzFuwMHVMIveAfWaFnqhbfHKqdhElNB3iEnnArpuQ/O66QSXeegX
         igJLpNVeFkZHXbdBODq3SkqF+X0mUacYqDjzM7sgSA7IyBkdy39isxuQscXFa9Nmfwdz
         zBLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeBKLLU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40662 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeBKLLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:05 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4/5] selftests/x86: do not rely on int $0x80 in single_step_syscall.c
Date: Sun, 11 Feb 2018 12:10:12 +0100
Message-Id: <20180211111013.16888-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211111013.16888-1-linux@dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102762145572824?=
X-GMAIL-MSGID: =?utf-8?q?1592102762145572824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 64bit builds, we should not rely on int $0x80 working (it only does if
CONFIG_IA32_EMULATION is enabled). To keep the "Set TF and check int80"
test running on 64bit installs with CONFIG_IA32_EMULATION enabled, build
this test only if we can also build 32bit binaries (which should be a
good approximation for that).

CC: Dmitry Safonov <dsafonov@virtuozzo.com>
CC: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/x86/Makefile              | 2 ++
 tools/testing/selftests/x86/single_step_syscall.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index ce2615a2d105..371ae715c506 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -40,12 +40,14 @@ endef
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS += $(BINARIES_32)
+EXTRA_CFLAGS += -DCAN_BUILD_32
 $(foreach t,$(TARGETS_C_32BIT_ALL),$(eval $(call gen-target-rule-32,$(t))))
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
 TEST_PROGS += $(BINARIES_64)
+EXTRA_CFLAGS += -DCAN_BUILD_64
 $(foreach t,$(TARGETS_C_64BIT_ALL),$(eval $(call gen-target-rule-64,$(t))))
 endif
 
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index a48da95c18fd..ddfdd635de16 100644
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
-- 
2.16.1

