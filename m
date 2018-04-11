Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDKCrZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:47:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46404 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeDKCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:47:23 -0400
X-Google-Smtp-Source: AIpwx4+kVNUdEgJiTk50jjqjDHy+D+coogy7iZjTzNrhElMBT5xuZTA3sWkYUR2+5OCF7yqDftd8BA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: pierre@ossman.eu, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] mmc: wbsd: Replace mdelay with usleep_range in wbsd_pnp_resume
Date: Wed, 11 Apr 2018 10:47:13 +0800
Message-Id: <1523414833-2714-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd_pnp_resume() is never called in atomic context.
This function is only set as ".resume" in struct pnp_driver.

Despite never getting called from atomic context, wbsd_pnp_resume()
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
index 546aaf8..83e13cf 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1890,7 +1890,7 @@ static int wbsd_pnp_resume(struct pnp_dev *pnp_dev)
 	/*
 	 * Allow device to initialise itself properly.
 	 */
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	wbsd_init_device(host);
 	return 0;
-- 
1.9.1
