Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtwgeuuPQC2mvuBBK2NrUioZHIR22qWuqrJBwHyCu2qoqz7w1U23S9xmhQ6O4QILnTAN29o
ARC-Seal: i=1; a=rsa-sha256; t=1520977752; cv=none;
        d=google.com; s=arc-20160816;
        b=BukGlcsoOrtceuoYpwjPypzSGkTsBuYckMN3P0av6sEJVkCxu2GVxD1Vr8JAETp2jP
         ID2f6/R9nVqnHRlbKaMVS+DczUokLLZRoo4MlzF06AgX3TxxNkX5P/XAIbhSkDaPxiTZ
         5eZO2W3EJTix43pzvSh53MpGHKUYM46sQDvd993XN5maI1oGMPgEwiNDowYMWwc/eIay
         osi6RBby+WRmfAyCicXXvH9SuVEujidsz6NzTz7UVyB46h9oK2w/9Pto4YJWzVFvrhsF
         9oC1W8KlrdUDPv3S65/eeooAUdv2oH/F/P9Luh9bdvEtiXf+Sbpih3kbi2dG6x2QQjPa
         SFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=xsxihR1H+cFemOB5HReZNwK0yPxt6YOzpSGCzoXa3tk=;
        b=VlDX46/RVGsEoq//Xv2+IhRUYBxsv9oJkGzSeCfjAKixAof7aLrPcvaso0x5LsdqqY
         ARwR2x0Cx0RvgX5ccLWjzIgj0DM/m1I7rIROneMq9cB7YScd2rOR/Do6ho9TIejxUF2A
         nbhX3UZAueM9u7Msb3jS7DQ3fKfbPihaLJKh7z8xNnsXqFM8x2B0HG0IjpgxTkpE1ldS
         SpNVyBODx5ZwOteR3N1H3hiLv1mUquTbc9U+gGGmHCLN917RURab+1fLXZLsw36oM+9a
         AGk7o7bizdMjvm20GCVfLDunq2B/25Je3mGl4rzQBTCu6sTZUyLLnrJOW2HzUvZPYfB/
         pRkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=DOYxu6CC;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=DOYxu6CC;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCMVsm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Mar 2018 17:48:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41420 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeCMVsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Mar 2018 17:48:41 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, bamv2005@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/*/Makefile: stop calling headers_install
Date: Tue, 13 Mar 2018 22:48:33 +0100
Message-Id: <20180313214833.14645-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860767723570881?=
X-GMAIL-MSGID: =?utf-8?q?1594860767723570881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Various tests should not call headers_install. Adding headers_install
as a prereq before building kselftests.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/Makefile      | 5 ++++-
 tools/testing/selftests/gpio/Makefile | 6 +-----
 tools/testing/selftests/vm/Makefile   | 4 ----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d73f7f0b180..5b8553654d6b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,13 +74,16 @@ endif
 export KSFT_TAP_LEVEL=`echo 1`
 
 export BUILD
-all:
+all: headers_install
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
 	done;
 
+headers_install:
+	make -C ../../.. headers_install
+
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..9ef4d751268b 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -21,11 +21,7 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES): ../../../gpio/gpio-utils.o
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index fdefa2295ddc..58759454b1d0 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,10 +25,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.11.0

