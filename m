Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeB1M7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:59:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeB1M7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:59:07 -0500
Date: Wed, 28 Feb 2018 04:58:56 -0800
From: tip-bot for Felix Fietkau <tipbot@zytor.com>
Message-ID: <tip-5753405e27f8fe4c42c1537d3ddbd9e058e54cdc@git.kernel.org>
Cc: tglx@linutronix.de, nbd@nbd.name, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, nbd@nbd.name, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180228095610.50341-1-nbd@nbd.name>
References: <20180228095610.50341-1-nbd@nbd.name>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/mips-gic-timer: Use correct
 shift count to extract data
Git-Commit-ID: 5753405e27f8fe4c42c1537d3ddbd9e058e54cdc
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

Commit-ID:  5753405e27f8fe4c42c1537d3ddbd9e058e54cdc
Gitweb:     https://git.kernel.org/tip/5753405e27f8fe4c42c1537d3ddbd9e058e54cdc
Author:     Felix Fietkau <nbd@nbd.name>
AuthorDate: Wed, 28 Feb 2018 10:56:10 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 13:55:14 +0100

clocksource/drivers/mips-gic-timer: Use correct shift count to extract data

__gic_clocksource_init() extracts the GIC_CONFIG_COUNTBITS field from
read_gic_config() by right shifting the register value. The shift count is
determined by the most significant bit (__fls) of the bitmask which is
wrong as it shifts out the complete bitfield.

Use the least significant bit (__ffs) instead to shift the bitfield down to
bit 0.

Fixes: e07127a077c7 ("clocksource: mips-gic-timer: Use new GIC accessor functions")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: daniel.lezcano@linaro.org
Cc: paul.burton@imgtec.com
Link: https://lkml.kernel.org/r/20180228095610.50341-1-nbd@nbd.name

---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 65e18c86d9b9..986b6796b631 100644
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
