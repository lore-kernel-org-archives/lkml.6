Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA810216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA810216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeI0WNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:13:20 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34051 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeI0WNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:13:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C406A41E17;
        Thu, 27 Sep 2018 15:54:24 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fxh9fY1frVwg; Thu, 27 Sep 2018 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 20D5F41DB7;
        Thu, 27 Sep 2018 15:54:13 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, jerry.hoemann@hpe.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-kselftest-next] selftests: watchdog: Fix ioctl SET* error paths to take oneshot exit path
Date:   Thu, 27 Sep 2018 09:54:12 -0600
Message-Id: <20180927155412.11433-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioctls for WDIOC_SETOPTIONS (WDIOS_DISABLECARD or WDIOS_ENABLECARD),
WDIOC_SETTIMEOUT, and WDIOC_SETPRETIMEOUT fail, the error path continues
to handler watchdog timer until user terminates it. When ioctl returns
error, it might not be safe to let the watchdog tick. The error could be
due an unsupported ioctl command or some other error.

Fix it to handle error paths as oneshot to stop the watchdog ticks and
exit right away.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index e0f1600dc1b3..c6bd9a68306b 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -123,16 +123,20 @@ int main(int argc, char *argv[])
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
 				printf("Watchdog card disabled.\n");
-			else
+			else {
 				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'e':
 			flags = WDIOS_ENABLECARD;
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
 				printf("Watchdog card enabled.\n");
-			else
+			else {
 				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'p':
 			ping_rate = strtoul(optarg, NULL, 0);
@@ -145,8 +149,10 @@ int main(int argc, char *argv[])
 			ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
 			if (!ret)
 				printf("Watchdog timeout set to %u seconds.\n", flags);
-			else
+			else {
 				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'T':
 			oneshot = 1;
@@ -161,8 +167,10 @@ int main(int argc, char *argv[])
 			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
 			if (!ret)
 				printf("Watchdog pretimeout set to %u seconds.\n", flags);
-			else
+			else {
 				printf("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'N':
 			oneshot = 1;
-- 
2.17.0

