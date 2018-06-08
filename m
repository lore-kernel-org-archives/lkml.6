Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fNVdDmjpGVtnFAAAmS7hNA
	; Fri, 08 Jun 2018 02:27:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81BF86089E; Fri,  8 Jun 2018 02:27:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0127360290;
	Fri,  8 Jun 2018 02:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0127360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeFHC1F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:27:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58522 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeFHCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:24:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id ECBC42A331; Thu,  7 Jun 2018 22:24:28 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <dc2239bf4d037bf85bb1821354534793c3ba2270.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 03/12] macintosh/via-pmu: Don't clear shift register
 interrupt flag twice
Date: Thu,  7 Jun 2018 22:24:28 -0400 (EDT)
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
