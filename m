Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165255AbeE1NXC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163423AbeE1Kst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Thomas Gleixner <tglx@linutronix.de>, daniel.lezcano@linaro.org,
        paul.burton@imgtec.com, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 170/496] clocksource/drivers/mips-gic-timer: Use correct shift count to extract data
Date: Mon, 28 May 2018 11:59:15 +0200
Message-Id: <20180528100327.036955288@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 5753405e27f8fe4c42c1537d3ddbd9e058e54cdc ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/mips-gic-timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -164,7 +164,7 @@ static int __init __gic_clocksource_init
 
 	/* Set clocksource mask. */
 	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
-	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
+	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
 	count_width *= 4;
 	count_width += 32;
 	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
