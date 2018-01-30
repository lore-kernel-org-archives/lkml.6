Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeA3QTO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:19:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52375 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3QTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:19:13 -0500
From: Colin King <colin.king@canonical.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/fsl_ftm_timer: fix unsigned < 0 comparison check
Date: Tue, 30 Jan 2018 16:19:11 +0000
Message-Id: <20180130161911.1613-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return from the call __ftm_clk_init can be negative if there
is an error, and this is being checked, however, the check is
always false because freq is unsigned.  Fix this by removing the
unsigned type qualifier, making freq just a long.

Detected using Coccinelle:
drivers/clocksource/fsl_ftm_timer.c:287:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0
drivers/clocksource/fsl_ftm_timer.c:291:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0

Fixes: 2529c3a33079 ("clocksource: Add Freescale FlexTimer Module (FTM) timer support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clocksource/fsl_ftm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index 3ee7e6fea621..846d18daf893 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -281,7 +281,7 @@ static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
 
 static unsigned long __init ftm_clk_init(struct device_node *np)
 {
-	unsigned long freq;
+	long freq;
 
 	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
 	if (freq <= 0)
-- 
2.15.1
