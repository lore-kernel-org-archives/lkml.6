Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953EB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAOEW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:22:57 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37566 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbfAOEW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:29 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 77C5729E7E; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <7fecc680c01b3d47eaf7eca741ae01636aa53a8d.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 13/22] m68k/mac: Fix PRAM accessors
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMU-based m68k Macs pre-date PowerMac-style NVRAM. Use the appropriate
PMU commands. Also implement the missing XPRAM accessors for VIA-based
Macs.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v7:
 - Revised PMU response decoding due to via-pmu68k driver replacement.
---
 arch/m68k/mac/misc.c     | 43 ++++++++++++++++++++++++++++++----------
 include/uapi/linux/pmu.h |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index af000a015f68..d016ca2e0d10 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -66,23 +66,22 @@ static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
 
-	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+	if (pmu_request(&req, NULL, 3, PMU_READ_XPRAM,
+	                offset & 0xFF, 1) < 0)
 		return 0;
-	while (!req.complete)
-		pmu_poll();
-	return req.reply[3];
+	pmu_wait_complete(&req);
+
+	return req.reply[0];
 }
 
 static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 
-	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+	if (pmu_request(&req, NULL, 4, PMU_WRITE_XPRAM,
+	                offset & 0xFF, 1, data) < 0)
 		return;
-	while (!req.complete)
-		pmu_poll();
+	pmu_wait_complete(&req);
 }
 #endif /* CONFIG_ADB_PMU */
 
@@ -151,6 +150,16 @@ static void via_rtc_send(__u8 data)
 #define RTC_REG_SECONDS_3       3
 #define RTC_REG_WRITE_PROTECT   13
 
+/*
+ * Inside Mac has no information about two-byte RTC commands but
+ * the MAME/MESS source code has the essentials.
+ */
+
+#define RTC_REG_XPRAM           14
+#define RTC_CMD_XPRAM_READ      (RTC_CMD_READ(RTC_REG_XPRAM) << 8)
+#define RTC_CMD_XPRAM_WRITE     (RTC_CMD_WRITE(RTC_REG_XPRAM) << 8)
+#define RTC_CMD_XPRAM_ARG(a)    (((a & 0xE0) << 3) | ((a & 0x1F) << 2))
+
 /*
  * Execute a VIA PRAM/RTC command. For read commands
  * data should point to a one-byte buffer for the
@@ -198,11 +207,25 @@ static void via_rtc_command(int command, __u8 *data)
 
 static unsigned char via_pram_read_byte(int offset)
 {
-	return 0;
+	unsigned char temp;
+
+	via_rtc_command(RTC_CMD_XPRAM_READ | RTC_CMD_XPRAM_ARG(offset), &temp);
+
+	return temp;
 }
 
 static void via_pram_write_byte(unsigned char data, int offset)
 {
+	unsigned char temp;
+
+	temp = 0x55;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
+
+	temp = data;
+	via_rtc_command(RTC_CMD_XPRAM_WRITE | RTC_CMD_XPRAM_ARG(offset), &temp);
+
+	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
 
 /*
diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index 97256f90e6df..f2fc1bd80017 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -19,7 +19,9 @@
 #define PMU_POWER_CTRL		0x11	/* control power of some devices */
 #define PMU_ADB_CMD		0x20	/* send ADB packet */
 #define PMU_ADB_POLL_OFF	0x21	/* disable ADB auto-poll */
+#define PMU_WRITE_XPRAM		0x32	/* write eXtended Parameter RAM */
 #define PMU_WRITE_NVRAM		0x33	/* write non-volatile RAM */
+#define PMU_READ_XPRAM		0x3a	/* read eXtended Parameter RAM */
 #define PMU_READ_NVRAM		0x3b	/* read non-volatile RAM */
 #define PMU_SET_RTC		0x30	/* set real-time clock */
 #define PMU_READ_RTC		0x38	/* read real-time clock */
-- 
2.19.2

