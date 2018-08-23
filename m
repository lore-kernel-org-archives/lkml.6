Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC09C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CC22147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CC22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeHWMIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbeHWMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:33 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F33D6941;
        Thu, 23 Aug 2018 08:39:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 026/324] selftests: pstore: return Kselftest Skip code for skipped tests
Date:   Thu, 23 Aug 2018 09:51:32 +0200
Message-Id: <20180823074957.185709924@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit 856e7c4b619af622d56b3b454f7bec32a170ac99 ]

When pstore_post_reboot test gets skipped because of unmet dependencies
and/or unsupported configuration, it returns 0 which is treated as a pass
by the Kselftest framework. This leads to false positive result even when
the test could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/pstore/pstore_post_reboot_tests |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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


