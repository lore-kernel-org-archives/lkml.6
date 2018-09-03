Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463F220861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxuLEU5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463F220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeICGaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:30:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39057 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeICGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:30:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so20330335qtk.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fi9x/RisPL+D9C6t54Lc+QeKHTyACdZt1WFUW+fkak=;
        b=gxuLEU5CJrFvZsBNHuNXfF3mcQCbH8xdlg6+7KBNqGfZA89C/cE5J60hdI0g6ibtZb
         SSdaY+7TN1ySp7zIZEzuYf3+1x7GsGufT5ABCdWheCPFwihcFE1LYNKgKOrq8bSAE3MP
         tDdt2m9hoxErzScDDxVEX9hLnNg3ZTkmhqSJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fi9x/RisPL+D9C6t54Lc+QeKHTyACdZt1WFUW+fkak=;
        b=eB003Tbx0U5nPCd0K+6GK/NuUvNgdkJXxSOVyhpGvv1AMFZ+tJUIE7xEI32K9W9WNm
         ZpQapt0+tGIubtl4I+ogOXGXo6/7NTGGHf7NlJsXlE9x3C4aTIJiKa2c6SrfEj7b43z1
         W2UrXxSZl1HFHZLWwqOuDBxgspMsbVuhkCIErPBcfCOTmAQNyCpCRj91GWYGTpYYTSTX
         9xdH+/F58yZ0sPz3S74/1IVRnMz35d/cbVq7mZGflyloMRXRYSc7sAec3axNuelC3KIf
         O7z7ttJKuPvev1zWtybgremDZRhsuz9knoKdHj6llcki7gulOCsN/txPENFNP/Dzaxd+
         Dykw==
X-Gm-Message-State: APzg51DK/8ZS4yMbqq+KwIMJmpU/qlU9bsTfLK7wJ86c9L7AMfxDNRXw
        YAPdxMd+r9JiWUMTsXjTrW5A3g==
X-Google-Smtp-Source: ANB0VdagTl6SnR4KiNq5Qwwn3gca4nZ5rm07if2T4BB/xBnNsfAfSKdzyYczAGrnCAR+iRqTCs+YSw==
X-Received: by 2002:ac8:6715:: with SMTP id e21-v6mr25173091qtp.306.1535940747856;
        Sun, 02 Sep 2018 19:12:27 -0700 (PDT)
Received: from mobile.celeiro.br ([168.181.50.182])
        by smtp.gmail.com with ESMTPSA id d138-v6sm9369060qke.18.2018.09.02.19.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 19:12:27 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     shuah@kernel.org
Cc:     rafael.tinoco@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] membarrier_test: work in progress
Date:   Sun,  2 Sep 2018 23:12:23 -0300
Message-Id: <20180903021223.8216-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org>
References: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah,

This is a draft only. I will remove summary from the top, run checkers,
etc. Im thinking in replacing membarrier_test entirely with this code
(compatible to existing one). Right now, this code:

 - allows each test to succeed, fail or be skipped independently
 - allows each test to be tested even when not supported (force option)
 - considers false negatives and false positives on every case
 - can be extended easily

Right now, just to show as an example, it gives us:

TAP version 13
ok 1 sys_membarrier(): cmd_query succeeded.
ok 2 sys_membarrier(): bad_cmd failed as expected.
ok 3 sys_membarrier(): cmd_with_flags_set failed as expected.
ok 4 sys_membarrier(): cmd_global succeeded.
Pass 4 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..4

Are you okay with such move ? Only big TODO here is adding all covered
tests in the test array (easy move), testing all combinations with all
supported kernel versions (lab already ready) and suggesting it to you,
replacing membarrier_test.c.

PS: This is pretty close to how a LTP test would be, using their new
API, but, since it addresses your concerns and seems like a
simple/clean, code, I decided to suggest it as a replacement here (and
it also fixes the issue with this test and LTS kernels).
---
 tools/testing/selftests/membarrier/Makefile   |   2 +-
 .../selftests/membarrier/membarrier_test2.c   | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test2.c

diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index 02845532b059..3d44d4cd3a9d 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -1,6 +1,6 @@
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := membarrier_test
+TEST_GEN_PROGS := membarrier_test membarrier_test2
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/membarrier/membarrier_test2.c b/tools/testing/selftests/membarrier/membarrier_test2.c
new file mode 100644
index 000000000000..8fa1be6156fb
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test2.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include "../kselftest.h"
+/*
+	MEMBARRIER_CMD_QUERY
+		returns membarrier_cmd with supported features
+	MEMBARRIER_CMD_GLOBAL
+		returns 0
+		EINVAL = if nohz_full is enabled
+	MEMBARRIER_CMD_GLOBAL_EXPEDITED
+		returns 0
+	MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED
+		returns 0
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED
+		returns 0
+		EINVAL = if CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE is not enabled
+		EPERM  = if process did not register for PRIVATE_EXPEDITED
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED
+		returns 0
+		EINVAL = if CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE is not enabled
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE
+		returns 0
+		EINVAL = if CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE is not enabled
+		EPERM = if process did not register for PRIVATE_EXPEDITED
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
+		returns 0
+		EINVAL = if CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE is not enabled
+*/
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+struct memb_tests {
+	char testname[80];
+	int command;
+	int flags;
+	int exp_ret;
+	int exp_errno;
+	int supported;
+	int force;
+};
+
+struct memb_tests mbt[] = {
+	{
+	 .testname = "bad_cmd\0",
+	 .command = -1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .supported = 1,
+	 },
+	{
+	 .testname = "cmd_with_flags_set\0",
+	 .command = MEMBARRIER_CMD_QUERY,
+	 .flags = 1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .supported = 1,
+	 },
+	{
+	 .testname = "cmd_global\0",
+	 .command = MEMBARRIER_CMD_GLOBAL,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+};
+
+static void info_passed_ok(struct memb_tests test)
+{
+	ksft_test_result_pass("sys_membarrier(): %s succeeded.\n",
+			test.testname);
+}
+
+static void info_passed_unexpectedly(struct memb_tests test)
+{
+	ksft_test_result_fail("sys_membarrier(): %s passed unexpectedly. "
+			"ret = %d with errno %d were expected.\n",
+			test.testname, test.exp_ret, test.exp_errno);
+}
+
+static void info_failed_ok(struct memb_tests test)
+{
+	ksft_test_result_pass("sys_membarrier(): %s failed as expected.\n",
+			test.testname);
+}
+
+static void info_failed_not_ok(struct memb_tests test, int gotret, int goterr)
+{
+	ksft_test_result_fail("sys_membarrier(): %s failed as expected. "
+			"ret = %d when expected was %d. "
+			"errno = %d when expected was %d.\n",
+			test.testname, gotret, test.exp_ret, goterr,
+			test.exp_errno);
+}
+
+static void info_failed_unexpectedly(struct memb_tests test, int gotret, int goterr)
+{
+	ksft_test_result_fail("sys_membarrier(): %s failed unexpectedly. "
+			"Got ret = %d with errno %d.\n",
+			test.testname, gotret, goterr);
+}
+
+static void info_skipped(struct memb_tests test)
+{
+	ksft_test_result_skip("sys_membarrier(): %s unsupported, test skipped.\n",
+			test.testname);
+}
+
+static int sys_membarrier(int cmd, int flags)
+{
+	return syscall(__NR_membarrier, cmd, flags);
+}
+
+static void test_membarrier_tests(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(mbt); i++) {
+
+		if (mbt[i].supported != 1 && mbt[i].force != 1) {
+			info_skipped(mbt[i]);
+			continue;
+		}
+
+		/* membarrier command should be evaluated */
+		ret = sys_membarrier(mbt[i].command, mbt[i].flags);
+
+		if (ret == mbt[i].exp_ret) {
+
+			if (ret >= 0)
+				info_passed_ok(mbt[i]);
+			else {
+				if (errno != mbt[i].exp_errno)
+					info_failed_not_ok(mbt[i], ret, errno);
+				else
+					info_failed_ok(mbt[i]);
+			}
+
+		} else {
+			if (ret >= 0)
+				info_passed_unexpectedly(mbt[i]);
+			else
+				info_failed_unexpectedly(mbt[i], ret, errno);
+		}
+	}
+}
+
+static int test_membarrier_prepare(void)
+{
+	int i, ret;
+
+	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			ksft_exit_skip("sys_membarrier(): CONFIG_MEMBARRIER is disabled.\n");
+
+		ksft_exit_fail_msg("sys_membarrier(): cmd_query failed.\n");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mbt); i++) {
+		if ((mbt[i].command > 0) && (ret & mbt[i].command))
+			mbt[i].supported = 1;
+	}
+
+	ksft_test_result_pass("sys_membarrier(): cmd_query succeeded.\n");
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+
+	test_membarrier_prepare();
+	test_membarrier_tests();
+
+	return ksft_exit_pass();
+}
-- 
2.19.0.rc1

