Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C97C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B224625B1C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B224625B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeGBIX3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:23:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48740 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeGBIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 72A9A293A0; Mon,  2 Jul 2018 04:21:18 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <36cec2adcb532b5171ab4318b46a8d27d4195c07.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 03/11] macintosh/via-pmu: Don't clear shift register
 interrupt flag twice
Date:   Mon,  2 Jul 2018 04:21:18 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shift register interrupt flag gets cleared in via_pmu_interrupt()
and once again in pmu_sr_intr(). Fix this theoretical race condition.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index ba41220f618e..c313ddfdb17a 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1421,7 +1421,6 @@ pmu_sr_intr(void)
 
 	if (in_8(&via[B]) & TREQ) {
 		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
-		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
 	/* The ack may not yet be low when we get the interrupt */
-- 
2.16.4

