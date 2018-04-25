Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDYDLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:11:14 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:58209
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751150AbeDYDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:11:10 -0400
X-ASG-Debug-ID: 1524625867-093b7e10b3114b70001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <ard.biesheuvel@linaro.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] efi/capsule-loader: Don't output reset log when header flags is not set
Date: Wed, 25 Apr 2018 11:10:06 +0800
X-ASG-Orig-Subj: [PATCH] efi/capsule-loader: Don't output reset log when header flags is not set
Message-ID: <1524625806-23133-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1524625867
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4863 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.50256
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It means firmware attempts to immediately process or launch the capsule
when flags in capsule header is not set. Moreover, reset is not needed
in this case. Current code will output log to indicate reset.

This patch adds a branch to avoid reset log output when the flags is not
set.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/firmware/efi/capsule-loader.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index e456f4602df1..a63b8e5bde23 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -134,10 +134,15 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 
 	/* Indicate capsule binary uploading is done */
 	cap_info->index = NO_FURTHER_WRITE_ACTION;
-	pr_info("Successfully upload capsule file with reboot type '%s'\n",
-		!cap_info->reset_type ? "RESET_COLD" :
-		cap_info->reset_type == 1 ? "RESET_WARM" :
-		"RESET_SHUTDOWN");
+
+	if (cap_info->header.flags)
+		pr_info("Successfully upload capsule file with reboot type '%s'\n",
+			!cap_info->reset_type ? "RESET_COLD" :
+			cap_info->reset_type == 1 ? "RESET_WARM" :
+			"RESET_SHUTDOWN");
+	else
+		pr_info("Successfully upload, process and launch capsule file\n");
+
 	return 0;
 }
 
-- 
1.8.3.1
