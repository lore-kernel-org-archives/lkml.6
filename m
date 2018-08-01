Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E7320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E7320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbeHAUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:08:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404413AbeHATDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2BC8AFE8;
        Wed,  1 Aug 2018 16:59:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 085/336] selftests: filesystems: return Kselftest Skip code for skipped tests
Date:   Wed,  1 Aug 2018 18:47:00 +0200
Message-Id: <20180801165032.433126312@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

[ Upstream commit 7357dcf2ef2811156fdf223a9a27f73528934e1f ]

When devpts_pts test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative
result even when the test could not be run.

In another case, it returns pass for a skipped test reporting a false
postive.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/filesystems/devpts_pts.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -11,6 +11,7 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include "../kselftest.h"
 
 static bool terminal_dup2(int duplicate, int original)
 {
@@ -125,10 +126,12 @@ static int do_tiocgptpeer(char *ptmx, ch
 		if (errno == EINVAL) {
 			fprintf(stderr, "TIOCGPTPEER is not supported. "
 					"Skipping test.\n");
-			fret = EXIT_SUCCESS;
+			fret = KSFT_SKIP;
+		} else {
+			fprintf(stderr,
+				"Failed to perform TIOCGPTPEER ioctl\n");
+			fret = EXIT_FAILURE;
 		}
-
-		fprintf(stderr, "Failed to perform TIOCGPTPEER ioctl\n");
 		goto do_cleanup;
 	}
 
@@ -281,7 +284,7 @@ int main(int argc, char *argv[])
 	if (!isatty(STDIN_FILENO)) {
 		fprintf(stderr, "Standard input file desciptor is not attached "
 				"to a terminal. Skipping test\n");
-		exit(EXIT_FAILURE);
+		exit(KSFT_SKIP);
 	}
 
 	ret = unshare(CLONE_NEWNS);


