Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48466C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A320A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2A320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeHWLs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:48:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbeHWLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:48:28 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A74FC74;
        Thu, 23 Aug 2018 08:19:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 024/217] selftests: sysctl: return Kselftest Skip code for skipped tests
Date:   Thu, 23 Aug 2018 09:52:17 +0200
Message-Id: <20180823075506.641358092@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit c7db6ffb831fd36a03485a0d88b1e505378975ad ]

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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/sysctl/sysctl.sh |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

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


