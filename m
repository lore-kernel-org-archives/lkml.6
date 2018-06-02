Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeFBD15 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:27:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37974 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFBD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:27:52 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
        <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 02/11] macintosh/via-pmu: Add missing mmio accessors
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
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
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index aea147bd8754..9c94f99e80da 100644
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
2.16.1
