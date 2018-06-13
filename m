Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9A20C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A080208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A080208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935142AbeFMKiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:38:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47888 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935132AbeFMKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:38:02 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 86AD522C16; Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <6337cdd06d5ea5828c4917ccbfd0125bb8a52cb9.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 02/12] macintosh/via-pmu: Add missing mmio accessors
Date:   Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing in_8() accessors to init_pmu() and pmu_sr_intr().

This fixes several sparse warnings:
drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expression

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index fd3c5640d586..74065ea410bd 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -532,8 +532,9 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
 
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* Negate TREQ. Set TACK to input and TREQ to output. */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
 
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =  100000;
@@ -1455,8 +1456,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite = 0;
 
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
-- 
2.16.4

