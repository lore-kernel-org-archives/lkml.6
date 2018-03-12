Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeCLDid (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:38:33 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32906 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933216AbeCLDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:38:29 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5977dbd89e07c780224405e3b3c8adb999c5171d.1520825708.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1520825708.git.fthain@telegraphics.com.au>
References: <cover.1520825708.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/3] m68k/mac: Enable RTC for 100-series PowerBooks
Date: Sun, 11 Mar 2018 23:38:28 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Apple's Developer Notes, all of the early PowerBook models
have their RTC connected to VIA1. Use the VIA clock ops as appropriate.
This was tested on a PowerBook 170.

Don't use the VIA ops when not appropriate. Calling unimplemented clock
or PRAM getter or setter ops can now result in an error instead of
failing silently.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c | 70 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 1cae14e140d3..e0a5e2dfeb46 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -83,12 +83,7 @@ static void cuda_write_pram(int offset, __u8 data)
 	while (!req.complete)
 		cuda_poll();
 }
-#else
-#define cuda_read_time() 0
-#define cuda_write_time(n)
-#define cuda_read_pram NULL
-#define cuda_write_pram NULL
-#endif
+#endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU68K
 static long pmu_read_time(void)
@@ -141,12 +136,7 @@ static void pmu_write_pram(int offset, __u8 data)
 	while (!req.complete)
 		pmu_poll();
 }
-#else
-#define pmu_read_time() 0
-#define pmu_write_time(n)
-#define pmu_read_pram NULL
-#define pmu_write_pram NULL
-#endif
+#endif /* CONFIG_ADB_PMU68K */
 
 /*
  * VIA PRAM/RTC access routines
@@ -426,19 +416,25 @@ void mac_pram_read(int offset, __u8 *buffer, int len)
 	int i;
 
 	switch (macintosh_config->adb_type) {
+	case MAC_ADB_IOP:
+	case MAC_ADB_II:
 	case MAC_ADB_PB1:
-	case MAC_ADB_PB2:
-		func = pmu_read_pram;
+		func = via_read_pram;
 		break;
+#ifdef CONFIG_ADB_CUDA
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
 		func = cuda_read_pram;
 		break;
+#endif
+#ifdef CONFIG_ADB_PMU68K
+	case MAC_ADB_PB2:
+		func = pmu_read_pram;
+		break;
+#endif
 	default:
-		func = via_read_pram;
-	}
-	if (!func)
 		return;
+	}
 	for (i = 0 ; i < len ; i++) {
 		buffer[i] = (*func)(offset++);
 	}
@@ -450,19 +446,25 @@ void mac_pram_write(int offset, __u8 *buffer, int len)
 	int i;
 
 	switch (macintosh_config->adb_type) {
+	case MAC_ADB_IOP:
+	case MAC_ADB_II:
 	case MAC_ADB_PB1:
-	case MAC_ADB_PB2:
-		func = pmu_write_pram;
+		func = via_write_pram;
 		break;
+#ifdef CONFIG_ADB_CUDA
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
 		func = cuda_write_pram;
 		break;
+#endif
+#ifdef CONFIG_ADB_PMU68K
+	case MAC_ADB_PB2:
+		func = pmu_write_pram;
+		break;
+#endif
 	default:
-		func = via_write_pram;
-	}
-	if (!func)
 		return;
+	}
 	for (i = 0 ; i < len ; i++) {
 		(*func)(offset++, buffer[i]);
 	}
@@ -663,18 +665,22 @@ int mac_hwclk(int op, struct rtc_time *t)
 
 	if (!op) { /* read */
 		switch (macintosh_config->adb_type) {
-		case MAC_ADB_II:
 		case MAC_ADB_IOP:
-			now = via_read_time();
-			break;
+		case MAC_ADB_II:
 		case MAC_ADB_PB1:
-		case MAC_ADB_PB2:
-			now = pmu_read_time();
+			now = via_read_time();
 			break;
+#ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
 			now = cuda_read_time();
 			break;
+#endif
+#ifdef CONFIG_ADB_PMU68K
+		case MAC_ADB_PB2:
+			now = pmu_read_time();
+			break;
+#endif
 		default:
 			now = 0;
 		}
@@ -695,18 +701,24 @@ int mac_hwclk(int op, struct rtc_time *t)
 			     t->tm_hour, t->tm_min, t->tm_sec);
 
 		switch (macintosh_config->adb_type) {
-		case MAC_ADB_II:
 		case MAC_ADB_IOP:
+		case MAC_ADB_II:
+		case MAC_ADB_PB1:
 			via_write_time(now);
 			break;
+#ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
 			cuda_write_time(now);
 			break;
-		case MAC_ADB_PB1:
+#endif
+#ifdef CONFIG_ADB_PMU68K
 		case MAC_ADB_PB2:
 			pmu_write_time(now);
 			break;
+#endif
+		default:
+			return -ENODEV;
 		}
 	}
 	return 0;
-- 
2.16.1
