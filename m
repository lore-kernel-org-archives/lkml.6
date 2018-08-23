Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145E2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E145E2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeHWLaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:30:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeHWLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:30:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1F06C18;
        Thu, 23 Aug 2018 08:01:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 007/130] selftests: user: return Kselftest Skip code for skipped tests
Date:   Thu, 23 Aug 2018 09:52:03 +0200
Message-Id: <20180823074927.779377920@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit d7d5311d4aa9611fe1a5a851e6f75733237a668a ]

When user test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative result
even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run. Add an explicit check
for module presence and return skip code if module isn't present.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/user/test_user_copy.sh |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/tools/testing/selftests/user/test_user_copy.sh
+++ b/tools/testing/selftests/user/test_user_copy.sh
@@ -1,6 +1,13 @@
 #!/bin/sh
 # Runs copy_to/from_user infrastructure using test_user_copy kernel module
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n test_user_copy; then
+	echo "user: module test_user_copy is not found [SKIP]"
+	exit $ksft_skip
+fi
 if /sbin/modprobe -q test_user_copy; then
 	/sbin/modprobe -q -r test_user_copy
 	echo "user_copy: ok"


