Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeB1J4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:56:15 -0500
Received: from nbd.name ([46.4.11.11]:41686 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeB1J4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:56:14 -0500
From: Felix Fietkau <nbd@nbd.name>
To: linux-kernel@vger.kernel.org
Cc: daniel.lezcano@linaro.org, paul.burton@imgtec.com, tglx@linutronix.de
Subject: [PATCH v2] clocksource: mips-gic-timer: fix clocksource counter width
Date: Wed, 28 Feb 2018 10:56:10 +0100
Message-Id: <20180228095610.50341-1-nbd@nbd.name>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is trying to extract the GIC_CONFIG_COUNTBITS field from
read_gic_config(), so it needs to shift count_width right by the index
of the least significant bit (__ffs) instead of the most significant bit
(__fls) of the field mask.

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
