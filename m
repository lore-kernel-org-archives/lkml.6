Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeBZNBT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:01:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeBZNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:01:15 -0500
Date: Mon, 26 Feb 2018 05:01:02 -0800
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-f287eb9013ccf199cbfa4eabd80c36fedfc15a73@git.kernel.org>
Cc: mingo@kernel.org, colin.king@canonical.com, daniel.lezcano@linaro.org,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        colin.king@canonical.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180226113614.3092-1-colin.king@canonical.com>
References: <20180226113614.3092-1-colin.king@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/fsl_ftm_timer: Fix error
 return checking
Git-Commit-ID: f287eb9013ccf199cbfa4eabd80c36fedfc15a73
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f287eb9013ccf199cbfa4eabd80c36fedfc15a73
Gitweb:     https://git.kernel.org/tip/f287eb9013ccf199cbfa4eabd80c36fedfc15a73
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Mon, 26 Feb 2018 11:36:14 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 26 Feb 2018 13:56:05 +0100

clocksource/drivers/fsl_ftm_timer: Fix error return checking

The error checks on freq for a negative error return always fails because
freq is unsigned and can never be negative. Fix this by making freq a
signed long.

Detected with Coccinelle:
drivers/clocksource/fsl_ftm_timer.c:287:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0
drivers/clocksource/fsl_ftm_timer.c:291:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0

Fixes: 2529c3a33079 ("clocksource: Add Freescale FlexTimer Module (FTM) timer support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20180226113614.3092-1-colin.king@canonical.com

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
