Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeCTIdo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:33:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34072 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeCTIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:33:40 -0400
X-Google-Smtp-Source: AG47ELuH91Rp3dSjghlu/z5XBfUXd5pJAV/647sNQI+GZe14inqwc+a48QZOzHUeeNjLrc5ng61e+Q==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] clk: cs2000: set pm_ops in hibernate-compatible way
Date: Tue, 20 Mar 2018 11:33:23 +0300
Message-Id: <20180320083323.23289-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SET_LATE_SYSTEM_SLEEP_PM_OPS() macro instead of direct assignment to
.resume_early field.

This fixes initialization of CS2000 in restore from hibernation in case
of kernel used to load image did not initialize CS2000 while kernel
being restored had CS2000 initialized.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/clk/clk-cs2000-cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index e8ea81c30f0c..c58019750b7e 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -549,7 +549,7 @@ static int cs2000_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops cs2000_pm_ops = {
-	.resume_early	= cs2000_resume,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, cs2000_resume)
 };
 
 static struct i2c_driver cs2000_driver = {
-- 
2.11.0
