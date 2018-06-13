Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A1A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5D12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5D12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934974AbeFMATh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:19:37 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44816 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933126AbeFMATf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:19:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 5511E40EE4;
        Wed, 13 Jun 2018 00:19:34 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UkMNuzcKWHR0; Wed, 13 Jun 2018 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 5B16B40E67;
        Wed, 13 Jun 2018 00:19:25 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     mcgrof@kernel.org, keescook@chromium.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: sysctl: return Kselftest Skip code for skipped tests
Date:   Tue, 12 Jun 2018 18:19:24 -0600
Message-Id: <20180613001924.30082-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysctl test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative result
even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Changed return code to kselftest skip code in skip error legs that check
requirements and module probe test error leg.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ec232c3cfcaa..584eb8ea780a 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -14,6 +14,9 @@
 
 # This performs a series tests against the proc sysctl interface.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 TEST_NAME="sysctl"
 TEST_DRIVER="test_${TEST_NAME}"
 TEST_DIR=$(dirname $0)
@@ -41,7 +44,7 @@ test_modprobe()
                echo "$0: $DIR not present" >&2
                echo "You must have the following enabled in your kernel:" >&2
                cat $TEST_DIR/config >&2
-               exit 1
+               exit $ksft_skip
        fi
 }
 
@@ -98,28 +101,30 @@ test_reqs()
 	uid=$(id -u)
 	if [ $uid -ne 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! which perl 2> /dev/null > /dev/null; then
 		echo "$0: You need perl installed"
-		exit 1
+		exit $ksft_skip
 	fi
 	if ! which getconf 2> /dev/null > /dev/null; then
 		echo "$0: You need getconf installed"
-		exit 1
+		exit $ksft_skip
 	fi
 	if ! which diff 2> /dev/null > /dev/null; then
 		echo "$0: You need diff installed"
-		exit 1
+		exit $ksft_skip
 	fi
 }
 
 function load_req_mod()
 {
-	trap "test_modprobe" EXIT
-
 	if [ ! -d $DIR ]; then
+		if ! modprobe -q -n $TEST_DRIVER; then
+			echo "$0: module $TEST_DRIVER not found [SKIP]"
+			exit $ksft_skip
+		fi
 		modprobe $TEST_DRIVER
 		if [ $? -ne 0 ]; then
 			exit
@@ -765,6 +770,7 @@ function parse_args()
 test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
+test_modprobe
 load_req_mod
 
 trap "test_finish" EXIT
-- 
2.17.0

