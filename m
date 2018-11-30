Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558C92146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558C92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeLAEpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:45:49 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:32932 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:45:49 -0500
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 7047E602A3;
        Fri, 30 Nov 2018 17:35:48 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F2CAA51;
        Fri, 30 Nov 2018 17:35:45 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A33834C;
        Fri, 30 Nov 2018 17:35:45 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/1] selftests: watchdog: Add gettimeleft command line arg
Date:   Fri, 30 Nov 2018 10:35:41 -0700
Message-Id: <1543599341-29615-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command line argument to call and display the results
of ioctl WDIOC_GETTIMELEFT.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index c6bd9a6..dac907a 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:N";
+static const char sopts[] = "bdehp:t:Tn:NL";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -30,6 +30,7 @@
 	{"gettimeout",          no_argument, NULL, 'T'},
 	{"pretimeout",    required_argument, NULL, 'n'},
 	{"getpretimeout",       no_argument, NULL, 'N'},
+	{"gettimeleft",		no_argument, NULL, 'L'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -77,6 +78,7 @@ static void usage(char *progname)
 	printf(" -T, --gettimeout    Get the timeout\n");
 	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
 	printf(" -N, --getpretimeout Get the pretimeout\n");
+	printf(" -L, --gettimeleft   Get the time left until timer experies\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
@@ -180,6 +182,15 @@ int main(int argc, char *argv[])
 			else
 				printf("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
 			break;
+		case 'L':
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETTIMELEFT, &flags);
+			if (!ret)
+				printf("WDIOC_GETTIMELEFT returns %u seconds.\n", flags);
+			else
+				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
+			break;
+
 		default:
 			usage(argv[0]);
 			goto end;
-- 
1.8.3.1

