Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17D92C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB76C208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB76C208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935268AbeFMKiF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:38:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47898 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:38:02 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id AB3AE27768; Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <dc2239bf4d037bf85bb1821354534793c3ba2270.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 03/12] macintosh/via-pmu: Don't clear shift register
 interrupt flag twice
Date:   Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
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
index 74065ea410bd..4c1bae5380c2 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1458,7 +1458,6 @@ pmu_sr_intr(void)
 
 	if (in_8(&via[B]) & TREQ) {
 		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
-		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
 	/* The ack may not yet be low when we get the interrupt */
-- 
2.16.4

