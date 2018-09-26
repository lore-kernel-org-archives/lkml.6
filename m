Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C83C004D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309BA21527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309BA21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeI0DiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:38:13 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:54497 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0DiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:38:12 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id DC97BBD;
        Wed, 26 Sep 2018 21:23:18 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 5418E4B;
        Wed, 26 Sep 2018 21:23:18 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     shuah@kernel.org, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [V3 PATCH 2/2] selftests: watchdog: Add gettimeout and get|set pretimeout
Date:   Wed, 26 Sep 2018 15:23:09 -0600
Message-Id: <1537996989-13092-3-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
References: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command line arguments to call ioctl WDIOC_GETTIMEOUT,
WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 33 +++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 8429186..e29bc71 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:";
+static const char sopts[] = "bdehp:t:Tn:N";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -27,6 +27,9 @@
 	{"help",                no_argument, NULL, 'h'},
 	{"pingrate",      required_argument, NULL, 'p'},
 	{"timeout",       required_argument, NULL, 't'},
+	{"gettimeout",          no_argument, NULL, 'T'},
+	{"pretimeout",    required_argument, NULL, 'n'},
+	{"getpretimeout",       no_argument, NULL, 'N'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -71,9 +74,13 @@ static void usage(char *progname)
 	printf(" -h, --help          Print the help message\n");
 	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
 	printf(" -t, --timeout=T     Set timeout to T seconds\n");
+	printf(" -T, --gettimeout    Get the timeout\n");
+	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
+	printf(" -N, --getpretimeout Get the pretimeout\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
+	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
 }
 
 int main(int argc, char *argv[])
@@ -135,6 +142,30 @@ int main(int argc, char *argv[])
 			else
 				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
 			break;
+		case 'T':
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
+			if (!ret)
+				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
+			else
+				printf("WDIOC_GETTIMEOUT error '%s'\n", strerror(errno));
+			break;
+		case 'n':
+			flags = strtoul(optarg, NULL, 0);
+			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
+			if (!ret)
+				printf("Watchdog pretimeout set to %u seconds.\n", flags);
+			else
+				printf("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
+			break;
+		case 'N':
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
+			if (!ret)
+				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
+			else
+				printf("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
+			break;
 		default:
 			usage(argv[0]);
 			goto end;
-- 
1.8.3.1

