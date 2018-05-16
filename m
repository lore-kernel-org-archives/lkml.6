Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeEPJSY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:18:24 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:55908 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEPJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:18:05 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: 8390: ne: Fix accidentally removed RBTX4927 support
Date: Wed, 16 May 2018 11:18:01 +0200
Message-Id: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration settings for RBTX4927 were accidentally removed,
leading to a silently broken network interface.

Re-add the missing settings to fix this.

Fixes: 8eb97ff5a4ec941d ("net: 8390: remove m32r specific bits")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Bisected between v4.9-rc2 (doh) and v4.17-rc5.

Note to myself: I should do more boot testing on RBTX4927.
Fortunately I caught it before it ends up in a point release ;-)
---
 drivers/net/ethernet/8390/ne.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index ac99d089ac7266c3..1c97e39b478e9f89 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -164,7 +164,9 @@ bad_clone_list[] __initdata = {
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-#if defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
+#if defined(CONFIG_MACH_TX49XX)
+#  define DCR_VAL 0x48		/* 8-bit mode */
+#elif defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
 #  define DCR_VAL (MACH_IS_ATARI ? 0x48 : 0x49)
 #else
 #  define DCR_VAL 0x49
-- 
2.7.4
