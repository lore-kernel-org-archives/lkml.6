Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226P+wdFyuDCG4UoBiOUEoY6b5HUSGjgsY8RD14N134xX+mbpnKLMbcPgsjCBWaPVxfErmAt
ARC-Seal: i=1; a=rsa-sha256; t=1518347551; cv=none;
        d=google.com; s=arc-20160816;
        b=z8YoIffAJQ9BawnQVOj8UfUbR/yaQHY1AHU7jzPjhfbcdVG/K5/e6FBC3QKiqwlqOk
         qI5HznelFCiYKWa4nGsFox2HZHJhumZSXRzN+C/c6TuOZPwiPgLZ4qbjmBzBVyTZjquc
         rUfAloFLzhWu3Mak/ZnxzN7sQ+LlHdvsZKyCHa8+Y9AmAoViO4kuxss1vOQO/R6wQumk
         zOuS+Ab861TiFpi0XZGkFyvJa13UZvaqmzhhQFocuHVdD5yK8MyKC9Q4s38rPjB5In77
         WqHrK1Q7qAOq4h5cff7KpMGn7B1X8TX1Fbt3ucpOAWOsEY7rJRaqg58ljPYQwuAfudWy
         8G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=B7wheE2fYYMngHIQU3IatYWViabydkGA3VGFzbXFZ/o=;
        b=Q5nSbqA7hRcxN6f5gyTwpJmAmqKKgzOkaFx/HA3fxOkN6Eiv2Ylt8ls/she8vnnJfH
         8WdPmfr9bPlzbeidV+gXIiBRZpsbmaSQ25r9GreyqrdJ9siRNblvbc5RJEgAdZ4K26OE
         Rq+XBxc+El9gd2zXAHrIXqsqcgMhh2/uoPAq6HSuac4adgDN6QVV9vNiMTyo2MdOBDoh
         cPwDVHktboMtjQnFXF21zwaDciLI0+npLz9l6/sKFzaWFj6kJouDrLDC/elT/xvTxRwK
         gb7TYiWhcnNTxBNux5dTV2CEnU578XcgL0j/TmK29E8O6RIKZzSh6l6gixLvP0y6bRLv
         2fMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeBKLLD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:03 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40610 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeBKLLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:02 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH] selftest/vDSO: fix O=
Date: Sun, 11 Feb 2018 11:59:50 +0100
Message-Id: <20180211105950.14720-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102802145440139?=
X-GMAIL-MSGID: =?utf-8?q?1592102802145440139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vDSO selftests ignored the O= or KBUILD_OUTPUT= parameters. Fix it.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/vDSO/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 3d5a62ff7d31..f5d7a7851e21 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../lib.mk
+
 ifndef CROSS_COMPILE
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -6,16 +8,14 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-TEST_PROGS := vdso_test vdso_standalone_test_x86
+TEST_PROGS := $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86
 
 all: $(TEST_PROGS)
-vdso_test: parse_vdso.c vdso_test.c
-vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
+$(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
-		-o vdso_standalone_test_x86
+		-o $@
 
-include ../lib.mk
-clean:
-	rm -fr $(TEST_PROGS)
+EXTRA_CLEAN := $(TEST_PROGS)
 endif
-- 
2.16.1

