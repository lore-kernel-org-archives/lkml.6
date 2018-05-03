Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeECFqL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 01:46:11 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:59183
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751224AbeECFqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 01:46:06 -0400
X-ASG-Debug-ID: 1525326355-093b7e542b2c15f0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <ard.biesheuvel@linaro.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2] efi/capsule-loader: Don't output reset log when reset flags are not set
Date: Thu, 3 May 2018 13:45:09 +0800
X-ASG-Orig-Subj: [PATCH v2] efi/capsule-loader: Don't output reset log when reset flags are not set
Message-ID: <1525326309-14627-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1525326355
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5299 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.50549
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It means firmware attempts to immediately process or launch the capsule
when reset flags in capsule header are not set. Moreover, reset is not
needed in this case. The current code will output log to indicate reset.

This patch adds a branch to avoid reset log output when the flags are not
set.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

Changes in v2:
  *Add EFI_CAPSULE_PERSIST_ACROSS_RESET check according to Ard's
   suggestion.
  
---
 drivers/firmware/efi/capsule-loader.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index e456f4602df1..344785ef8539 100644
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
+	if (cap_info->header.flags & EFI_CAPSULE_PERSIST_ACROSS_RESET)
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
