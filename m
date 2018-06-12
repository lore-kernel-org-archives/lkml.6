Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 576F2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF6620891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbeFLXsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:48:14 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43972 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934383AbeFLXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:48:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 4FF7F41EFD;
        Tue, 12 Jun 2018 23:48:12 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CvOIQa-vRD8M; Tue, 12 Jun 2018 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6086A41EEB;
        Tue, 12 Jun 2018 23:48:09 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: static_keys: return Kselftest Skip code for skipped tests
Date:   Tue, 12 Jun 2018 17:48:07 -0600
Message-Id: <20180612234807.28967-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When static_keys test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as a fail
by the Kselftest framework. This leads to false negative result even when
the test could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Added an explicit searches for test_static_key_base and test_static_keys
modules and return skip code if they aren't found to differentiate between
the failure to load the module condition and module not found condition.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 .../selftests/static_keys/test_static_keys.sh       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/static_keys/test_static_keys.sh b/tools/testing/selftests/static_keys/test_static_keys.sh
index 24cff498b31a..fc9f8cde7d42 100755
--- a/tools/testing/selftests/static_keys/test_static_keys.sh
+++ b/tools/testing/selftests/static_keys/test_static_keys.sh
@@ -2,6 +2,19 @@
 # SPDX-License-Identifier: GPL-2.0
 # Runs static keys kernel module tests
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n test_static_key_base; then
+	echo "static_key: module test_static_key_base is not found [SKIP]"
+	exit $ksft_skip
+fi
+
+if ! /sbin/modprobe -q -n test_static_keys; then
+	echo "static_key: module test_static_keys is not found [SKIP]"
+	exit $ksft_skip
+fi
+
 if /sbin/modprobe -q test_static_key_base; then
 	if /sbin/modprobe -q test_static_keys; then
 		echo "static_key: ok"
-- 
2.17.0

