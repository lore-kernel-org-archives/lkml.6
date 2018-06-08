Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hIf7GfzoGVsEEwAAmS7hNA
	; Fri, 08 Jun 2018 02:25:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E6317601B4; Fri,  8 Jun 2018 02:25:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DCA5160290;
	Fri,  8 Jun 2018 02:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCA5160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeFHCZU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:25:20 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58590 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeFHCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:24:30 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 722A02A339; Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <2efc384fa288f94376c65e00770e05bbbde07cf8.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 10/12] macintosh: Use common code to access RTC
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the 68k Mac port has adopted the via-pmu driver, it must access
the PMU RTC using the appropriate command format. The same code can now
be used for both m68k and powerpc.

Replace the RTC code that's duplicated in arch/powerpc and arch/m68k
with common RTC accessors for Cuda and PMU devices.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
Cc: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c                   | 64 ++---------------------------
 arch/powerpc/platforms/powermac/time.c | 74 +---------------------------------
 drivers/macintosh/via-cuda.c           | 34 ++++++++++++++++
 drivers/macintosh/via-pmu.c            | 32 +++++++++++++++
 include/linux/cuda.h                   |  3 ++
 include/linux/pmu.h                    |  3 ++
 6 files changed, 78 insertions(+), 132 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 28090a44fa09..397f9f942a9f 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -33,34 +33,6 @@
 static void (*rom_reset)(void);
 
 #ifdef CONFIG_ADB_CUDA
-static long cuda_read_time(void)
-{
-	struct adb_request req;
-	long time;
-
-	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
-		return 0;
-	while (!req.complete)
-		cuda_poll();
-
-	time = (req.reply[3] << 24) | (req.reply[4] << 16) |
-	       (req.reply[5] << 8) | req.reply[6];
-	return time - RTC_OFFSET;
-}
-
-static void cuda_write_time(long data)
-{
-	struct adb_request req;
-
-	data += RTC_OFFSET;
-	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			 (data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			 (data >> 8) & 0xFF, data & 0xFF) < 0)
-		return;
-	while (!req.complete)
-		cuda_poll();
-}
-
 static __u8 cuda_read_pram(int offset)
 {
 	struct adb_request req;
@@ -86,34 +58,6 @@ static void cuda_write_pram(int offset, __u8 data)
 #endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU
-static long pmu_read_time(void)
-{
-	struct adb_request req;
-	long time;
-
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return 0;
-	while (!req.complete)
-		pmu_poll();
-
-	time = (req.reply[1] << 24) | (req.reply[2] << 16) |
-	       (req.reply[3] << 8) | req.reply[4];
-	return time - RTC_OFFSET;
-}
-
-static void pmu_write_time(long data)
-{
-	struct adb_request req;
-
-	data += RTC_OFFSET;
-	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
-			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-}
-
 static __u8 pmu_read_pram(int offset)
 {
 	struct adb_request req;
@@ -635,12 +579,12 @@ int mac_hwclk(int op, struct rtc_time *t)
 #ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
-			now = cuda_read_time();
+			now = cuda_get_time();
 			break;
 #endif
 #ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
-			now = pmu_read_time();
+			now = pmu_get_time();
 			break;
 #endif
 		default:
@@ -671,12 +615,12 @@ int mac_hwclk(int op, struct rtc_time *t)
 #ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
-			cuda_write_time(now);
+			cuda_set_time(now);
 			break;
 #endif
 #ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
-			pmu_write_time(now);
+			pmu_set_time(now);
 			break;
 #endif
 		default:
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..e9c1f3dafe2f 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,9 +42,6 @@
 #define DBG(x...)
 #endif
 
-/* Apparently the RTC stores seconds since 1 Jan 1904 */
-#define RTC_OFFSET	2082844800
-
 /*
  * Calibrate the decrementer frequency with the VIA timer 1.
  */
@@ -103,43 +100,8 @@ static unsigned long from_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_CUDA
-static unsigned long cuda_get_time(void)
-{
-	struct adb_request req;
-	unsigned int now;
-
-	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
-		return 0;
-	while (!req.complete)
-		cuda_poll();
-	if (req.reply_len != 7)
-		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
-		       req.reply_len);
-	now = (req.reply[3] << 24) + (req.reply[4] << 16)
-		+ (req.reply[5] << 8) + req.reply[6];
-	return ((unsigned long)now) - RTC_OFFSET;
-}
-
 #define cuda_get_rtc_time(tm)	to_rtc_time(cuda_get_time(), (tm))
-
-static int cuda_set_rtc_time(struct rtc_time *tm)
-{
-	unsigned int nowtime;
-	struct adb_request req;
-
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
-	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
-			 nowtime) < 0)
-		return -ENXIO;
-	while (!req.complete)
-		cuda_poll();
-	if ((req.reply_len != 3) && (req.reply_len != 7))
-		printk(KERN_ERR "cuda_set_rtc_time: got %d byte reply\n",
-		       req.reply_len);
-	return 0;
-}
-
+#define cuda_set_rtc_time(tm)	cuda_set_time(from_rtc_time(tm))
 #else
 #define cuda_get_time()		0
 #define cuda_get_rtc_time(tm)
@@ -147,40 +109,8 @@ static int cuda_set_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_PMU
-static unsigned long pmu_get_time(void)
-{
-	struct adb_request req;
-	unsigned int now;
-
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return 0;
-	pmu_wait_complete(&req);
-	if (req.reply_len != 4)
-		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
-		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
-	return ((unsigned long)now) - RTC_OFFSET;
-}
-
 #define pmu_get_rtc_time(tm)	to_rtc_time(pmu_get_time(), (tm))
-
-static int pmu_set_rtc_time(struct rtc_time *tm)
-{
-	unsigned int nowtime;
-	struct adb_request req;
-
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
-	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
-			nowtime >> 16, nowtime >> 8, nowtime) < 0)
-		return -ENXIO;
-	pmu_wait_complete(&req);
-	if (req.reply_len != 0)
-		printk(KERN_ERR "pmu_set_rtc_time: %d byte reply from PMU\n",
-		       req.reply_len);
-	return 0;
-}
-
+#define pmu_set_rtc_time(tm)	pmu_set_time(from_rtc_time(tm))
 #else
 #define pmu_get_time()		0
 #define pmu_get_rtc_time(tm)
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 019556136e77..8e7fb2115f10 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -771,3 +771,37 @@ cuda_input(unsigned char *buf, int nb)
 	               buf, nb, false);
     }
 }
+
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+unsigned long cuda_get_time(void)
+{
+	struct adb_request req;
+	unsigned long now;
+
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
+		return 0;
+	while (!req.complete)
+		cuda_poll();
+	if (req.reply_len != 7)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (req.reply[3] << 24) + (req.reply[4] << 16) +
+	      (req.reply[5] << 8) + req.reply[6];
+	return now - RTC_OFFSET;
+}
+
+int cuda_set_time(unsigned long now)
+{
+	struct adb_request req;
+
+	now += RTC_OFFSET;
+	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+			now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	while (!req.complete)
+		cuda_poll();
+	if ((req.reply_len != 3) && (req.reply_len != 7))
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 22cb7d94e3ce..38d7dd0bdb28 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1820,6 +1820,38 @@ pmu_shutdown(void)
 		;
 }
 
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+unsigned long pmu_get_time(void)
+{
+	struct adb_request req;
+	unsigned long now;
+
+	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
+		return 0;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 4)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (req.reply[0] << 24) + (req.reply[1] << 16) +
+	      (req.reply[2] << 8) + req.reply[3];
+	return now - RTC_OFFSET;
+}
+
+int pmu_set_time(unsigned long now)
+{
+	struct adb_request req;
+
+	now += RTC_OFFSET;
+	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
+			now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 0)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
+
 int
 pmu_present(void)
 {
diff --git a/include/linux/cuda.h b/include/linux/cuda.h
index 056867f09a01..a68669f746e1 100644
--- a/include/linux/cuda.h
+++ b/include/linux/cuda.h
@@ -16,4 +16,7 @@ extern int cuda_request(struct adb_request *req,
 			void (*done)(struct adb_request *), int nbytes, ...);
 extern void cuda_poll(void);
 
+extern unsigned long cuda_get_time(void);
+extern int cuda_set_time(unsigned long now);
+
 #endif /* _LINUX_CUDA_H */
diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 9ac8fc60ad49..feefd0bff9cf 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -34,6 +34,9 @@ static inline void pmu_resume(void)
 {}
 #endif
 
+extern unsigned long pmu_get_time(void);
+extern int pmu_set_time(unsigned long now);
+
 extern void pmu_enable_irled(int on);
 
 extern void pmu_restart(void);
-- 
2.16.4
