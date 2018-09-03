Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503FE20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYA3WhNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503FE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeICX0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:26:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38989 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:26:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so1536974qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyrAkbdTxxa3ClkGoVA5yH+SNiWoDA5n6lLT0UwsJZk=;
        b=VYA3WhNGoHDVqGsfSIMln4hO7DMrEWHQvSVP4oqv6NC8DWn8b1GShdavfNIEJZY6VQ
         eOBtIGl4wmQtc0e1O9XT+nLEJXL7ZvVUmtEJjFmivcMAjffPjwlzQpXqvYf6+GjEeQFI
         1QFKGIP+I4Q2l3xKtS8JleIPwF1g3E4gRYTYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyrAkbdTxxa3ClkGoVA5yH+SNiWoDA5n6lLT0UwsJZk=;
        b=bsleMVqN1VTqjOt1dQhSuSVpF+UpxdtIsH5z4X18CL2DotAI66zHzvIXiMfaU4TtMi
         snL/biw8kjJa8tihVBch6XzIwCyXSJmmKx1VW9ktH8sFwe3PYaOSi/LRLEPLMKdUngxl
         W7MEmELQ/0nRZLiwbN3yyYCI6DZI1yHbIAyWlu5TEKzXxKx16liibOhy28LdQzwQ12AX
         UqHoG0xUges+yCv65jWl1MhSPpHpVkGtv1qIUZrCc4hCWOVwuYVGHwM4VJUMt9ZIhCiq
         9aVYT6s2VBDfcB7RtDzU3k00eLAxfp+2+BiTKYix4prRX1cQ+QjieNQ425XIEx7ZcUIK
         RpmA==
X-Gm-Message-State: APzg51COPQzXq+DE4ibRYqTEAIuoAVaiYZ4RDU1cQKitCfUIlMLqDC7s
        +HtLS1WlRmoKHIxzVnrVJAp3cg==
X-Google-Smtp-Source: ANB0VdaAtZmoIZozLWHN2109CXtAGBExn9zUWrHpsyD7a4zkyuTIxf2SR3JAYs5W6E9smte2kVoYGg==
X-Received: by 2002:aed:237a:: with SMTP id i55-v6mr2224645qtc.263.1536001501351;
        Mon, 03 Sep 2018 12:05:01 -0700 (PDT)
Received: from mobile.celeiro.br ([168.181.50.182])
        by smtp.gmail.com with ESMTPSA id w12-v6sm12401563qtj.93.2018.09.03.12.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:05:00 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     shuah@kernel.org
Cc:     rafael.tinoco@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] selftests: membarrier: reorganized test for LTS supportability
Date:   Mon,  3 Sep 2018 16:04:57 -0300
Message-Id: <20180903190457.27088-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org>
References: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit re-organizes membarrier test, solving issues when testing
LTS kernels. Now, the code:

 - always run the same amount of tests (even on older kernels).
 - allows each test to succeed, fail or be skipped independently.
 - allows testing features even when explicitly unsupported (force=1).
 - able to consider different return codes for diff kernel versions.
 - checks false positive/negative by checking ret code and errno.
 - can be extended easily: to expand an array with commands.

Link: https://bugs.linaro.org/show_bug.cgi?id=3771
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 .../selftests/membarrier/membarrier_test.c    | 482 +++++++++---------
 1 file changed, 241 insertions(+), 241 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 6793f8ecc8e7..151bc8a944a3 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <linux/membarrier.h>
+#include <sys/utsname.h>
 #include <syscall.h>
 #include <stdio.h>
 #include <errno.h>
@@ -8,305 +9,304 @@
 
 #include "../kselftest.h"
 
-static int sys_membarrier(int cmd, int flags)
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + (c))
+
+struct memb_tests {
+	char testname[80];
+	int command;
+	int flags;
+	int exp_ret;
+	int exp_errno;
+	int enabled;
+	int force;
+	int force_exp_errno;
+	int above;
+	int bellow;
+};
+
+struct memb_tests mbt[] = {
+	{
+	 .testname = "cmd_fail\0",
+	 .command = -1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .enabled = 1,
+	 },
+	{
+	 .testname = "cmd_flags_fail\0",
+	 .command = MEMBARRIER_CMD_QUERY,
+	 .flags = 1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .enabled = 1,
+	 },
+	{
+	 .testname = "cmd_global_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	/*
+	 * PRIVATE EXPEDITED (forced)
+	 */
+	{
+	 .testname = "cmd_private_expedited_fail\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = -1,
+	 .exp_errno = EPERM,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 .bellow = KERNEL_VERSION(4, 10, 0),
+	 },
+	{
+	 .testname = "cmd_private_expedited_fail\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = -1,
+	 .exp_errno = EPERM,
+	 .force = 1,
+	 .force_exp_errno = EPERM,
+	 .above = KERNEL_VERSION(4, 10, 0),
+	 },
+	{
+	 .testname = "cmd_register_private_expedited_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 .testname = "cmd_private_expedited_success\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	 /*
+	  * PRIVATE EXPEDITED SYNC CORE
+	  */
+	{
+	 .testname = "cmd_private_expedited_sync_core_fail\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
+	 .flags = 0,
+	 .exp_ret = -1,
+	 .exp_errno = EPERM,
+	 },
+	{
+	 .testname = "cmd_register_private_expedited_sync_core_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	{
+	 .testname = "cmd_private_expedited_sync_core_success\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	/*
+	 * GLOBAL EXPEDITED
+	 * global membarrier from a non-registered process is valid
+	 */
+	{
+	 .testname = "cmd_global_expedited_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	{
+	 .testname = "cmd_register_global_expedited_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	{
+	 .testname = "cmd_global_expedited_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+};
+
+static void
+info_passed_ok(struct memb_tests test)
 {
-	return syscall(__NR_membarrier, cmd, flags);
+	ksft_test_result_pass("sys_membarrier(): %s succeeded.\n",
+			test.testname);
 }
 
-static int test_membarrier_cmd_fail(void)
+static void
+info_passed_unexpectedly(struct memb_tests test)
 {
-	int cmd = -1, flags = 0;
-	const char *test_name = "sys membarrier invalid command";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: command = %d, flags = %d. Should fail, but passed\n",
-			test_name, cmd, flags);
-	}
-	if (errno != EINVAL) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EINVAL, strerror(EINVAL),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: command = %d, flags = %d, errno = %d. Failed as expected\n",
-		test_name, cmd, flags, errno);
-	return 0;
+	ksft_test_result_fail("sys_membarrier(): %s passed unexpectedly. "
+			"ret = %d with errno %d were expected. (force: %d)\n",
+			test.testname, test.exp_ret, test.exp_errno,
+			test.force);
 }
 
-static int test_membarrier_flags_fail(void)
+static void
+info_failed_ok(struct memb_tests test)
 {
-	int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid flags";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EINVAL) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EINVAL, strerror(EINVAL),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d. Failed as expected\n",
-		test_name, flags, errno);
-	return 0;
+	ksft_test_result_pass("sys_membarrier(): %s failed as expected.\n",
+			test.testname);
 }
 
-static int test_membarrier_global_success(void)
+static void
+info_failed_not_ok(struct memb_tests test, int gotret, int goterr)
 {
-	int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n", test_name, flags);
-	return 0;
+	ksft_test_result_fail("sys_membarrier(): %s failed as expected. "
+			"ret = %d when expected was %d. "
+			"errno = %d when expected was %d. (force: %d)\n",
+			test.testname, gotret, test.exp_ret, goterr,
+			test.exp_errno, test.force);
 }
 
-static int test_membarrier_private_expedited_fail(void)
+static void
+info_failed_unexpectedly(struct memb_tests test, int gotret, int goterr)
 {
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EPERM) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EPERM, strerror(EPERM),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d\n",
-		test_name, flags, errno);
-	return 0;
+	ksft_test_result_fail("sys_membarrier(): %s failed unexpectedly. "
+			"Got ret = %d with errno %d. (force: %d)\n",
+			test.testname, gotret, goterr, test.force);
 }
 
-static int test_membarrier_register_private_expedited_success(void)
+static void
+info_skipped(struct memb_tests test)
 {
-	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
+	ksft_test_result_skip("sys_membarrier(): %s unsupported, "
+			"test skipped.\n", test.testname);
 }
 
-static int test_membarrier_private_expedited_success(void)
+static int test_get_kversion(void)
 {
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED";
+	char *temp;
+	int major, minor, rev;
+	struct utsname uts;
 
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
+	memset(&uts, 0, sizeof(struct utsname));
+	if (uname(&uts) < 0)
+		ksft_exit_fail_msg("sys_membarrier(): uname() failed\n");
 
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
+	temp = strtok((char *) &uts.release, ".");
+	if (temp == NULL)
+		ksft_exit_fail_msg("sys_membarrier(): kver parsing failed\n");
 
-static int test_membarrier_private_expedited_sync_core_fail(void)
-{
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not registered failure";
+	major = atoi(temp);
 
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EPERM) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EPERM, strerror(EPERM),
-			errno, strerror(errno));
-	}
+	temp = strtok(NULL, ".");
+	if (temp == NULL)
+		ksft_exit_fail_msg("sys_membarrier(): kver parsing failed\n");
 
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d\n",
-		test_name, flags, errno);
-	return 0;
-}
+	minor = atoi(temp);
 
-static int test_membarrier_register_private_expedited_sync_core_success(void)
-{
-	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE";
+	temp = strtok(NULL, ".");
+	if (temp == NULL)
+		ksft_exit_fail_msg("sys_membarrier(): kver parsing failed\n");
 
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
+	rev = atoi(temp);
 
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
+	return KERNEL_VERSION(major, minor, rev);
 }
 
-static int test_membarrier_private_expedited_sync_core_success(void)
+static int sys_membarrier(int cmd, int flags)
 {
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
+	return syscall(__NR_membarrier, cmd, flags);
 }
 
-static int test_membarrier_register_global_expedited_success(void)
+static void test_membarrier_tests(void)
 {
-	int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
+	int i, ret;
+	int kver = test_get_kversion();
 
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
+	for (i = 0; i < ARRAY_SIZE(mbt); i++) {
 
-static int test_membarrier_global_expedited_success(void)
-{
-	int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED";
+		if (mbt[i].bellow && kver > mbt[i].bellow)
+			continue;
 
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
+		if (mbt[i].above && kver < mbt[i].above)
+			continue;
 
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
+		if (mbt[i].enabled != 1 && mbt[i].force != 1) {
+			info_skipped(mbt[i]);
+			continue;
+		}
 
-static int test_membarrier(void)
-{
-	int status;
-
-	status = test_membarrier_cmd_fail();
-	if (status)
-		return status;
-	status = test_membarrier_flags_fail();
-	if (status)
-		return status;
-	status = test_membarrier_global_success();
-	if (status)
-		return status;
-	status = test_membarrier_private_expedited_fail();
-	if (status)
-		return status;
-	status = test_membarrier_register_private_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_private_expedited_success();
-	if (status)
-		return status;
-	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
-	if (status < 0) {
-		ksft_test_result_fail("sys_membarrier() failed\n");
-		return status;
-	}
-	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
-		status = test_membarrier_private_expedited_sync_core_fail();
-		if (status)
-			return status;
-		status = test_membarrier_register_private_expedited_sync_core_success();
-		if (status)
-			return status;
-		status = test_membarrier_private_expedited_sync_core_success();
-		if (status)
-			return status;
+		/* membarrier command should be evaluated */
+		ret = sys_membarrier(mbt[i].command, mbt[i].flags);
+
+		if (ret == mbt[i].exp_ret) {
+
+			if (ret >= 0)
+				info_passed_ok(mbt[i]);
+			else {
+				if (mbt[i].enabled == 1 && mbt[i].force != 1) {
+					if (errno != mbt[i].exp_errno) {
+						info_failed_not_ok(mbt[i], ret,
+								errno);
+					} else
+						info_failed_ok(mbt[i]);
+				} else {
+					if (errno != mbt[i].force_exp_errno) {
+						info_failed_not_ok(mbt[i], ret,
+								errno);
+					} else
+						info_failed_ok(mbt[i]);
+				}
+			}
+
+		} else {
+			if (mbt[i].enabled == 1 && mbt[i].force != 1) {
+				if (ret >= 0)
+					info_passed_unexpectedly(mbt[i]);
+				else {
+					info_failed_unexpectedly(mbt[i], ret,
+							errno);
+				}
+			} else {
+				if (errno == mbt[i].force_exp_errno)
+					info_failed_ok(mbt[i]);
+				else
+					info_failed_not_ok(mbt[i], ret, errno);
+			}
+		}
 	}
-	/*
-	 * It is valid to send a global membarrier from a non-registered
-	 * process.
-	 */
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_register_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
-	return 0;
 }
 
-static int test_membarrier_query(void)
+static int test_membarrier_prepare(void)
 {
-	int flags = 0, ret;
+	int i, ret;
 
-	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, flags);
+	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
 	if (ret < 0) {
 		if (errno == ENOSYS) {
 			/*
 			 * It is valid to build a kernel with
 			 * CONFIG_MEMBARRIER=n. However, this skips the tests.
 			 */
-			ksft_exit_skip(
-				"sys membarrier (CONFIG_MEMBARRIER) is disabled.\n");
+			ksft_exit_skip("sys_membarrier(): CONFIG_MEMBARRIER "
+					"is disabled.\n");
 		}
-		ksft_exit_fail_msg("sys_membarrier() failed\n");
+
+		ksft_exit_fail_msg("sys_membarrier(): cmd_query failed.\n");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mbt); i++) {
+		if ((mbt[i].command > 0) && (ret & mbt[i].command))
+			mbt[i].enabled = 1;
 	}
-	if (!(ret & MEMBARRIER_CMD_GLOBAL))
-		ksft_exit_skip(
-			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
 
-	ksft_test_result_pass("sys_membarrier available\n");
-	return 0;
+	ksft_test_result_pass("sys_membarrier(): cmd_query succeeded.\n");
 }
 
 int main(int argc, char **argv)
 {
 	ksft_print_header();
 
-	test_membarrier_query();
-	test_membarrier();
+	test_membarrier_prepare();
+	test_membarrier_tests();
 
 	return ksft_exit_pass();
 }
-- 
2.19.0.rc1

