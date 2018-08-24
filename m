Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE46C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB00721568
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00721568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHXFec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:34:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57574 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeHXFec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:34:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A6003281CA;
        Thu, 23 Aug 2018 22:02:07 -0400 (EDT)
Date:   Fri, 24 Aug 2018 12:02:06 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <9b103c232c73b223ec951994c9789326754ef7a9.1535015050.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Use correct PMU response format
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the 68k Mac port has adopted the via-pmu driver, it must decode
the PMU response accordingly otherwise the date and time will be wrong.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
I mistakenly omitted this change from my PMU patch series when I
dropped "[PATCH v3 10/12] macintosh: Use common code to access RTC".
Version 4 of that series has since been merged, which unfortunately
means that pmu_read_time() has regressed on m68k PowerBooks. This
patch is intended to prevent that regression from appearing in v4.19.
---
 arch/m68k/mac/misc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 3534aa6a4dc2..1b083c500b9a 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -98,11 +98,10 @@ static time64_t pmu_read_time(void)
 
 	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
 		return 0;
-	while (!req.complete)
-		pmu_poll();
+	pmu_wait_complete(&req);
 
-	time = (u32)((req.reply[1] << 24) | (req.reply[2] << 16) |
-		     (req.reply[3] << 8) | req.reply[4]);
+	time = (u32)((req.reply[0] << 24) | (req.reply[1] << 16) |
+		     (req.reply[2] << 8) | req.reply[3]);
 
 	return time - RTC_OFFSET;
 }
@@ -116,8 +115,7 @@ static void pmu_write_time(time64_t time)
 			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
 			(data >> 8) & 0xFF, data & 0xFF) < 0)
 		return;
-	while (!req.complete)
-		pmu_poll();
+	pmu_wait_complete(&req);
 }
 
 static __u8 pmu_read_pram(int offset)
-- 
2.16.4

