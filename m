Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E5DC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB9120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAOEWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:22:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37550 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfAOEW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:29 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 6921A29E6F; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <95b208ccdb3276ad6a0a2aacc5de828550a8a024.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 12/22] m68k/mac: Use macros for RTC accesses not magic
 numbers
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is intended to improve code style and not affect code behaviour.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c | 59 ++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 78c807025436..af000a015f68 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -136,6 +136,21 @@ static void via_rtc_send(__u8 data)
 	}
 }
 
+/*
+ * These values can be found in Inside Macintosh vol. III ch. 2
+ * which has a description of the RTC chip in the original Mac.
+ */
+
+#define RTC_FLG_READ            BIT(7)
+#define RTC_FLG_WRITE_PROTECT   BIT(7)
+#define RTC_CMD_READ(r)         (RTC_FLG_READ | (r << 2))
+#define RTC_CMD_WRITE(r)        (r << 2)
+#define RTC_REG_SECONDS_0       0
+#define RTC_REG_SECONDS_1       1
+#define RTC_REG_SECONDS_2       2
+#define RTC_REG_SECONDS_3       3
+#define RTC_REG_WRITE_PROTECT   13
+
 /*
  * Execute a VIA PRAM/RTC command. For read commands
  * data should point to a one-byte buffer for the
@@ -145,13 +160,17 @@ static void via_rtc_send(__u8 data)
  * This function disables all interrupts while running.
  */
 
-static void via_pram_command(int command, __u8 *data)
+static void via_rtc_command(int command, __u8 *data)
 {
 	unsigned long flags;
 	int is_read;
 
 	local_irq_save(flags);
 
+	/* The least significant bits must be 0b01 according to Inside Mac */
+
+	command = (command & ~3) | 1;
+
 	/* Enable the RTC and make sure the strobe line is high */
 
 	via1[vBufB] = (via1[vBufB] | VIA1B_vRTCClk) & ~VIA1B_vRTCEnb;
@@ -159,10 +178,10 @@ static void via_pram_command(int command, __u8 *data)
 	if (command & 0xFF00) {		/* extended (two-byte) command */
 		via_rtc_send((command & 0xFF00) >> 8);
 		via_rtc_send(command & 0xFF);
-		is_read = command & 0x8000;
+		is_read = command & (RTC_FLG_READ << 8);
 	} else {			/* one-byte command */
 		via_rtc_send(command);
-		is_read = command & 0x80;
+		is_read = command & RTC_FLG_READ;
 	}
 	if (is_read) {
 		*data = via_rtc_recv();
@@ -201,10 +220,10 @@ static time64_t via_read_time(void)
 	} result, last_result;
 	int count = 1;
 
-	via_pram_command(0x81, &last_result.cdata[3]);
-	via_pram_command(0x85, &last_result.cdata[2]);
-	via_pram_command(0x89, &last_result.cdata[1]);
-	via_pram_command(0x8D, &last_result.cdata[0]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_0), &last_result.cdata[3]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_1), &last_result.cdata[2]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_2), &last_result.cdata[1]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_3), &last_result.cdata[0]);
 
 	/*
 	 * The NetBSD guys say to loop until you get the same reading
@@ -212,10 +231,14 @@ static time64_t via_read_time(void)
 	 */
 
 	while (1) {
-		via_pram_command(0x81, &result.cdata[3]);
-		via_pram_command(0x85, &result.cdata[2]);
-		via_pram_command(0x89, &result.cdata[1]);
-		via_pram_command(0x8D, &result.cdata[0]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_0),
+		                &result.cdata[3]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_1),
+		                &result.cdata[2]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_2),
+		                &result.cdata[1]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_3),
+		                &result.cdata[0]);
 
 		if (result.idata == last_result.idata)
 			return (time64_t)result.idata - RTC_OFFSET;
@@ -254,18 +277,18 @@ static void via_set_rtc_time(struct rtc_time *tm)
 	/* Clear the write protect bit */
 
 	temp = 0x55;
-	via_pram_command(0x35, &temp);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 
 	data.idata = lower_32_bits(time + RTC_OFFSET);
-	via_pram_command(0x01, &data.cdata[3]);
-	via_pram_command(0x05, &data.cdata[2]);
-	via_pram_command(0x09, &data.cdata[1]);
-	via_pram_command(0x0D, &data.cdata[0]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_0), &data.cdata[3]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_1), &data.cdata[2]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_2), &data.cdata[1]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_3), &data.cdata[0]);
 
 	/* Set the write protect bit */
 
-	temp = 0xD5;
-	via_pram_command(0x35, &temp);
+	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
 
 static void via_shutdown(void)
-- 
2.19.2

