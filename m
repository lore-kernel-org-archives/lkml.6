Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6755C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E82175E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744E82175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbeGBIWa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:22:30 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48856 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933647AbeGBIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:24 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 760D7293A8; Mon,  2 Jul 2018 04:21:19 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <3aaf05c25cc54ee3335bae315ffe181d5c751e55.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 10/11] macintosh/via-pmu: Clean up interrupt statistics
Date:   Mon,  2 Jul 2018 04:21:19 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace an open-coded ffs() with the function call.
Simplify an if-else cascade using a switch statement.
Correct a typo and an indentation issue.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index a68e7a6f00cc..3da5d40309d4 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1355,7 +1355,8 @@ pmu_resume(void)
 static void
 pmu_handle_data(unsigned char *data, int len)
 {
-	unsigned char ints, pirq;
+	unsigned char ints;
+	int idx;
 	int i = 0;
 
 	asleep = 0;
@@ -1377,25 +1378,24 @@ pmu_handle_data(unsigned char *data, int len)
 		ints &= ~(PMU_INT_ADB_AUTO | PMU_INT_AUTO_SRQ_POLL);
 
 next:
-
 	if (ints == 0) {
 		if (i > pmu_irq_stats[10])
 			pmu_irq_stats[10] = i;
 		return;
 	}
-
-	for (pirq = 0; pirq < 8; pirq++)
-		if (ints & (1 << pirq))
-			break;
-	pmu_irq_stats[pirq]++;
 	i++;
-	ints &= ~(1 << pirq);
+
+	idx = ffs(ints) - 1;
+	ints &= ~BIT(idx);
+
+	pmu_irq_stats[idx]++;
 
 	/* Note: for some reason, we get an interrupt with len=1,
 	 * data[0]==0 after each normal ADB interrupt, at least
 	 * on the Pismo. Still investigating...  --BenH
 	 */
-	if ((1 << pirq) & PMU_INT_ADB) {
+	switch (BIT(idx)) {
+	case PMU_INT_ADB:
 		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
 			struct adb_request *req = req_awaiting_reply;
 			if (!req) {
@@ -1433,25 +1433,28 @@ pmu_handle_data(unsigned char *data, int len)
 				adb_input(data+1, len-1, 1);
 #endif /* CONFIG_ADB */		
 		}
-	}
+		break;
+
 	/* Sound/brightness button pressed */
-	else if ((1 << pirq) & PMU_INT_SNDBRT) {
+	case PMU_INT_SNDBRT:
 #ifdef CONFIG_PMAC_BACKLIGHT
 		if (len == 3)
 			pmac_backlight_set_legacy_brightness_pmu(data[1] >> 4);
 #endif
-	}
+		break;
+
 	/* Tick interrupt */
-	else if ((1 << pirq) & PMU_INT_TICK) {
-		/* Environement or tick interrupt, query batteries */
+	case PMU_INT_TICK:
+		/* Environment or tick interrupt, query batteries */
 		if (pmu_battery_count) {
 			if ((--query_batt_timer) == 0) {
 				query_battery_state();
 				query_batt_timer = BATTERY_POLLING_COUNT;
 			}
 		}
-        }
-	else if ((1 << pirq) & PMU_INT_ENVIRONMENT) {
+		break;
+
+	case PMU_INT_ENVIRONMENT:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
@@ -1461,7 +1464,9 @@ pmu_handle_data(unsigned char *data, int len)
 			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
 			via_pmu_event(PMU_EVT_LID, data[1]&1);
 		}
-	} else {
+		break;
+
+	default:
 	       pmu_pass_intr(data, len);
 	}
 	goto next;
-- 
2.16.4

