Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeDKCrJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:47:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36900 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeDKCrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:47:07 -0400
X-Google-Smtp-Source: AIpwx49XMa9nEyZKNA+uy5zArJmWz6GtpWfj+DgwF2fts6i3hpFcDhfggeH4+md+F76oigIuC9oSog==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: pierre@ossman.eu, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] mmc: wbsd: Replace mdelay with usleep_range in wbsd_platform_resume
Date: Wed, 11 Apr 2018 10:47:01 +0800
Message-Id: <1523414821-2670-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd_platform_resume() is never called in atomic context.
This function is only set as ".resume" in struct platform_driver.

Despite never getting called from atomic context, wbsd_platform_resume()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/host/wbsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 546aaf8..17d36c1 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1846,7 +1846,7 @@ static int wbsd_platform_resume(struct platform_device *dev)
 	/*
 	 * Allow device to initialise itself properly.
 	 */
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	wbsd_init_device(host);
 	return 0;
-- 
1.9.1
