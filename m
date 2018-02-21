Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBUMr5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:47:57 -0500
Received: from nbd.name ([46.4.11.11]:38166 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeBUMrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:47:55 -0500
From: Felix Fietkau <nbd@nbd.name>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, paul.burton@imgtec.com
Subject: [PATCH] clocksource: mips-gic-timer: fix clocksource counter width
Date: Wed, 21 Feb 2018 13:47:49 +0100
Message-Id: <20180221124749.39471-1-nbd@nbd.name>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code needs to use ffs instead of fls on the mask to determine the
shift for reading the GIC_CONFIG_COUNTBITS field.

Fixes: e07127a077c7 ("clocksource: mips-gic-timer: Use new GIC accessor functions")
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index a04808a21d4e..bf0eee78c6ef 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -166,7 +166,7 @@ static int __init __gic_clocksource_init(void)
 
 	/* Set clocksource mask. */
 	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
-	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
+	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
 	count_width *= 4;
 	count_width += 32;
 	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
-- 
2.14.2
