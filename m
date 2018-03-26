Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtZhdhyJwiCg9T6V2LuEICYOFkd4wEf0mJXqMNmZojfzJ5233InwSSn/zX5tn/syfYtopvp
ARC-Seal: i=1; a=rsa-sha256; t=1522056849; cv=none;
        d=google.com; s=arc-20160816;
        b=fI9z7npEGhWSC/zF1xrAV4ZDFH8Qx/zXruaT2XHfsPatAV1yp3AC2KLA5ikMoFaHE2
         LwPKra8w7TkH+jGsJyDORlN0U3/sWFS1DKUpQXPySLVjeGPqfLtNvuqsKECRkfd7yNJq
         A04gxwWvOR0qCS70+UhHiavpo87oxTsogPDzuirVHle02qflruk5jTAt1uUrnRaLEDcb
         CiURLcOjkkEOrqtT1IOT1x6bLJHKpnEvWcVcUWgfVinwf4EFBe3I93CXtvbcJj6Kf+TJ
         aMyje4Hqs3P9pOBEphVpWzrlKVso47Zl7nKCMeP0YCPKmnyus15n2MsMR0g52kNay1lg
         mf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fwnzjM5P/yK6t3U0EVnAilA2exlnGb1h8aDsGR0J/lY=;
        b=wKNpDLMZ5ruqsHgSZyY2uWp5CPZ9Z7ZoBdt0hx+zwW2bgfRPsFrIXHaN/+jk3lY1YX
         0RKHH70W93SyfiTekr8EZywXEzFuWsJIjgtb82xJARZbl6WLJuH4n8Qga1mn8TXzluVj
         BVIzsg2DP2npBxfYUMDbHJyBKbXFkufKbI6ZQcKP01vrXqLI5/8XAGEEkw7PR1Geie+k
         3fk5fdAWmJDB4rjnXeo2aHlvAdRZT8Gn+GwvN2UNudnCCOsy6LGhS8Az053gd7lz6MbL
         hb0rWxtm90PYKTGs29ePV9f/VCGf75ZbyABM23ej2MZhbvo7K9tCPOV01twv2K+yqs9h
         PGQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCZJdS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 05:33:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:43803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbeCZJdQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 05:33:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="36851588"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 3/4] kselftest: install sanitized kernel headers before compiling
Date: Mon, 26 Mar 2018 17:23:27 +0800
Message-Id: <1522056208-4004-4-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992282498628027?=
X-GMAIL-MSGID: =?utf-8?q?1595992282498628027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

There are test cases that require kernel headers. Some of this
cases has put the dependency check into individual Makefiles,
but some not. Let's sync the kernel headers at top level
Makefile to avoid compiling errors like below.

make[1]: Entering directory '/home/changbin/work/linux/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test
membarrier_test.c: In function ‘test_membarrier_global_success’:
membarrier_test.c:64:12: error: ‘MEMBARRIER_CMD_GLOBAL’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
            ^
membarrier_test.c:64:12: note: each undeclared identifier is reported only once for each function it appears in
membarrier_test.c: In function ‘test_membarrier_private_expedited_fail’:
membarrier_test.c:80:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_register_private_expedited_success’:
membarrier_test.c:103:12: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_private_expedited_success’:
membarrier_test.c:120:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_private_expedited_sync_core_fail’:
membarrier_test.c:137:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_register_private_expedited_sync_core_success’:
membarrier_test.c:160:12: error: ‘MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_private_expedited_sync_core_success’:
membarrier_test.c:177:12: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_register_global_expedited_success’:
membarrier_test.c:194:12: error: ‘MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier_global_expedited_success’:
membarrier_test.c:211:12: error: ‘MEMBARRIER_CMD_GLOBAL_EXPEDITED’ undeclared (first use in this function)
  int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
            ^
membarrier_test.c: In function ‘test_membarrier’:
membarrier_test.c:253:15: error: ‘MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE’ undeclared (first use in this function)
  if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
               ^
membarrier_test.c: In function ‘test_membarrier_query’:
membarrier_test.c:296:14: error: ‘MEMBARRIER_CMD_GLOBAL’ undeclared (first use in this function)
  if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
              ^
../lib.mk:109: recipe for target '/home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test' failed
make[1]: *** [/home/changbin/work/linux/tools/testing/selftests/membarrier//membarrier_test] Error 1
make[1]: Leaving directory '/home/changbin/work/linux/tools/testing/selftests/membarrier'

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7916aa2..656b674 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -67,13 +67,16 @@ ifndef BUILD
 endif
 
 export BUILD
-all:
+all: headers_install
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
 	done;
 
+headers_install:
+	make -C ../../../ headers_install
+
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-- 
2.7.4

