Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73C42C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2957F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2957F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeFLXWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:22:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:32877 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeFLXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:22:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D824722063;
        Tue, 12 Jun 2018 23:22:40 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L2NK0pwsjTTw; Tue, 12 Jun 2018 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id D37792202E;
        Tue, 12 Jun 2018 23:22:31 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: pstore: return Kselftest Skip code for skipped tests
Date:   Tue, 12 Jun 2018 17:22:30 -0600
Message-Id: <20180612232230.27864-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pstore_post_reboot test gets skipped because of unmet dependencies
and/or unsupported configuration, it returns 0 which is treated as a pass
by the Kselftest framework. This leads to false positive result even when
the test could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/pstore/pstore_post_reboot_tests | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
index 6ccb154cb4aa..22f8df1ad7d4 100755
--- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
+++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
@@ -7,13 +7,16 @@
 #
 # Released under the terms of the GPL v2.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 . ./common_tests
 
 if [ -e $REBOOT_FLAG  ]; then
     rm $REBOOT_FLAG
 else
     prlog "pstore_crash_test has not been executed yet. we skip further tests."
-    exit 0
+    exit $ksft_skip
 fi
 
 prlog -n "Mounting pstore filesystem ... "
-- 
2.17.0

