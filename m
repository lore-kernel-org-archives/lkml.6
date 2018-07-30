Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E189916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A252205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZ16V+mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A252205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG3Rl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:41:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34972 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeG3Rl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:41:29 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so12637967qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U04gvzZIH4nq8t0sikdcItNY74are8cfO7wsEHewwUw=;
        b=hZ16V+mRE6VpkYYJGJXjQ1EO0WFmabRXvW52RZZ3g5z1P3DiA8gZyiCI07dARUEGR3
         NrUXHKYxzfsItk0esUoaiH+8uAwPRkxqbMofYmH2LuWOvpptjz+XINEZGqCHaTTuuvXi
         hxADe34Fo2ZJTAbEVpZSKZ6ILGIlqiNoEHvG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U04gvzZIH4nq8t0sikdcItNY74are8cfO7wsEHewwUw=;
        b=f6jJ6DHLc3hgzgHtqeFo2WcpHZdHHW1SLsnY5mU6vgO8p3I/26hvWoHo7vqs1HjZyI
         ZT/41CW7tLbMjAVcARQS0tgNaKD94gQ8xviohkRmYxX+2cqrw/hDWuWsY3XlnrMoQEkJ
         glxmhPEBl9SkDwAcPkuiRmm3w+lPFvr+uFqVqL0HMj3SYAvHRp/XCE0pGfP992Qsggfc
         Rgopq9KEfzZLMKBUvBhd2l733g7THQFJmohG2aRdnX7Tb4nJAaELDJNW4e8f2Jwwo+0b
         EbC6dmLvc0GOLw7wLQqXkNq9YivG6ybIRT+9DDxTNhxlNy2FicpIoym/rYX+pc1H/v1K
         Er9Q==
X-Gm-Message-State: AOUpUlF/tb7MY+9s3aE3kPACT/n4P4c66563s+ZqHtAKq8ovyGefJ3vN
        sgbk0+tgIxDMUGi9YR26iDO/8gEHZxwdpg==
X-Google-Smtp-Source: AAOMgpd2p1KQUUWztvc2LHynkdg0LnP47ke2N1bYnwtqjQypdZ7bUJtsA+UgB32CNN1LDERoWNtXtQ==
X-Received: by 2002:ac8:32a:: with SMTP id q42-v6mr17315902qtg.343.1532966749204;
        Mon, 30 Jul 2018 09:05:49 -0700 (PDT)
Received: from mobile.celeiro.br ([138.204.25.60])
        by smtp.gmail.com with ESMTPSA id h68-v6sm7258974qkc.97.2018.07.30.09.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:05:48 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael.tinoco@linaro.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        shuah@kernel.org
Subject: [PATCH] selftests: membarrier: fix test by checking supported commands
Date:   Mon, 30 Jul 2018 13:05:43 -0300
Message-Id: <20180730160543.19056-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes membarrier_test compatible with older kernels (LTS) by checking if
the membarrier features exist before running the tests.

Link: https://bugs.linaro.org/show_bug.cgi?id=3771
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc: <stable@vger.kernel.org> #v4.17
---
 .../selftests/membarrier/membarrier_test.c    | 69 +++++++++++--------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 6793f8ecc8e7..b96caa096e2f 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -225,7 +225,14 @@ static int test_membarrier_global_expedited_success(void)
 
 static int test_membarrier(void)
 {
-	int status;
+	int supported, status;
+
+	supported = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (supported < 0) {
+		ksft_test_result_fail(
+			"sys_membarrier() failed to query supported cmds\n");
+		return supported;
+	}
 
 	status = test_membarrier_cmd_fail();
 	if (status)
@@ -236,21 +243,22 @@ static int test_membarrier(void)
 	status = test_membarrier_global_success();
 	if (status)
 		return status;
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
+
+	/* commit 22e4ebb975822833b083533035233d128b30e98f added this feature */
+	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED) {
+		status = test_membarrier_private_expedited_fail();
+		if (status)
+			return status;
+		status = test_membarrier_register_private_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_private_expedited_success();
+		if (status)
+			return status;
 	}
-	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+
+	/* commit 70216e18e519a54a2f13569e8caff99a092a92d6 added this feature */
+	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
 		status = test_membarrier_private_expedited_sync_core_fail();
 		if (status)
 			return status;
@@ -261,19 +269,24 @@ static int test_membarrier(void)
 		if (status)
 			return status;
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
+
+	/* commit c5f58bd58f432be5d92df33c5458e0bcbee3aadf added this feature */
+	if (supported & MEMBARRIER_CMD_GLOBAL_EXPEDITED) {
+		/*
+		 * It is valid to send a global membarrier from a non-registered
+		 * process.
+		 */
+		status = test_membarrier_global_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_register_global_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_global_expedited_success();
+		if (status)
+			return status;
+	}
+
 	return 0;
 }
 
-- 
2.18.0

