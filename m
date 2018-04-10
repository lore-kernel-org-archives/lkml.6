Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeDJNox (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:44:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39876 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbeDJNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:44:50 -0400
X-Google-Smtp-Source: AIpwx4/tbpYZDt0DE4FhKJU3kLyPIuQqQ3Y5GUAbHB7wUvkyfwmvkuvktXgm8e/70GLMBEvncPNbMg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kvalo@codeaurora.org, davem@davemloft.net, gustavo@embeddedor.com,
        mingo@kernel.org, dhowells@redhat.com, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: wireless: cisco: airo: Replace mdelay with usleep_range in flashgchar
Date: Tue, 10 Apr 2018 21:44:41 +0800
Message-Id: <1523367881-32058-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flashgchar() is never called in atomic context.

flashgchar() is only called by flashcard().
flashcard() calls copy_from_user() and kmalloc(GFP_KERNEL), which 
indicates this function is not called in atomic context.

Despite never getting called from atomic context, flashgchar()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wireless/cisco/airo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 54201c0..45747b7 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -8106,7 +8106,7 @@ static int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
 
 		if(dwelltime && !(0x8000 & rchar)){
 			dwelltime -= 10;
-			mdelay(10);
+			usleep_range(10000, 11000);
 			continue;
 		}
 		rbyte = 0xff & rchar;
-- 
1.9.1
