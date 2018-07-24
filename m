Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6660520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6660520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbeGXIM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:12:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39510 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbeGXIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:12:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8D09E275DF;
        Tue, 24 Jul 2018 03:07:25 -0400 (EDT)
Date:   Tue, 24 Jul 2018 17:07:33 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <58f371f95c10969bacff4d5bc393ff0f0c6102fb.1532415410.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Rework patch "use time64_t in RTC handling"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the issues arising from commit 324caa29cd04
("m68k: mac: use time64_t in RTC handling").

Adopt __u32 for the union in via_read_time(), consistent with changes
to via_write_time().

Use low_32_bits() in via_write_time(), consistent with changes to
pmu_write_time() and cuda_write_time().

Have via_read_time() return a time64_t, consistent with changes to
pmu_read_time and cuda_read_time().

Drop the pointless wraparound conditional in via_read_time().

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index bdc83eac6c61..19e9d8eef1f2 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -251,11 +251,11 @@ static void via_write_pram(int offset, __u8 data)
  * is basically any machine with Mac II-style ADB.
  */
 
-static long via_read_time(void)
+static time64_t via_read_time(void)
 {
 	union {
 		__u8 cdata[4];
-		long idata;
+		__u32 idata;
 	} result, last_result;
 	int count = 1;
 
@@ -275,12 +275,8 @@ static long via_read_time(void)
 		via_pram_command(0x89, &result.cdata[1]);
 		via_pram_command(0x8D, &result.cdata[0]);
 
-		if (result.idata == last_result.idata) {
-			if (result.idata < RTC_OFFSET)
-				result.idata += 0x100000000ull;
-
-			return result.idata - RTC_OFFSET;
-		}
+		if (result.idata == last_result.idata)
+			return (time64_t)result.idata - RTC_OFFSET;
 
 		if (++count > 10)
 			break;
@@ -288,8 +284,8 @@ static long via_read_time(void)
 		last_result.idata = result.idata;
 	}
 
-	pr_err("via_read_time: failed to read a stable value; got 0x%08lx then 0x%08lx\n",
-	       last_result.idata, result.idata);
+	pr_err("%s: failed to read a stable value; got 0x%08x then 0x%08x\n",
+	       __func__, last_result.idata, result.idata);
 
 	return 0;
 }
@@ -314,7 +310,7 @@ static void via_write_time(time64_t time)
 	temp = 0x55;
 	via_pram_command(0x35, &temp);
 
-	data.idata = time + RTC_OFFSET;
+	data.idata = lower_32_bits(time + RTC_OFFSET);
 	via_pram_command(0x01, &data.cdata[3]);
 	via_pram_command(0x05, &data.cdata[2]);
 	via_pram_command(0x09, &data.cdata[1]);
-- 
2.16.4

