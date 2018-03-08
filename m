Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755631AbeCHJ63 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:58:29 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43897 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeCHJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:58:27 -0500
X-Google-Smtp-Source: AG47ELvstw9Q/uJCmarlTHMGIe1yyKjivY4Jk9PyVCGG6Fjf2VwKt5a9/DrWAAtvxoa0uLso7YwGAQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: sysfs: use put_device() instead of kfree()
Date: Thu,  8 Mar 2018 15:27:37 +0530
Message-Id: <416c89ec3cff87e842a0ff148df13bed35a44c46.1520502811.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pwm/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 83f2b0b..7c71cdb 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -273,7 +273,8 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	ret = device_register(&export->child);
 	if (ret) {
 		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		kfree(export);
+		put_device(&export->child);
+		export = NULL;
 		return ret;
 	}
 
-- 
1.9.1
