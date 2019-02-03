Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68929C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415BC218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBCNzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:55:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54480 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEK-0004R6-En; Sun, 03 Feb 2019 13:54:40 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9t-0007R0-V7; Sun, 03 Feb 2019 14:50:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Andreas Dannenberg" <dannenberg@ti.com>,
        "Sjoerd Simons" <sjoerd.simons@collabora.co.uk>,
        "Faiz Abbas" <faiz_abbas@ti.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.984497851@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 289/305] mmc: core: Use a minimum 1600ms timeout when
 enabling CACHE ctrl
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit e3ae3401aa19432ee4943eb0bbc2ec704d07d793 upstream.

Some eMMCs from Micron have been reported to need ~800 ms timeout, while
enabling the CACHE ctrl after running sudden power failure tests. The
needed timeout is greater than what the card specifies as its generic CMD6
timeout, through the EXT_CSD register, hence the problem.

Normally we would introduce a card quirk to extend the timeout for these
specific Micron cards. However, due to the rather complicated debug process
needed to find out the error, let's simply use a minimum timeout of 1600ms,
the double of what has been reported, for all cards when enabling CACHE
ctrl.

Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reported-by: Andreas Dannenberg <dannenberg@ti.com>
Reported-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -24,6 +24,8 @@
 #include "mmc_ops.h"
 #include "sd_ops.h"
 
+#define MIN_CACHE_EN_TIMEOUT_MS 1600
+
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
 	0,		0,		0,		0
@@ -1426,13 +1428,18 @@ static int mmc_init_card(struct mmc_host
 	}
 
 	/*
-	 * If cache size is higher than 0, this indicates
-	 * the existence of cache and it can be turned on.
+	 * If cache size is higher than 0, this indicates the existence of cache
+	 * and it can be turned on. Note that some eMMCs from Micron has been
+	 * reported to need ~800 ms timeout, while enabling the cache after
+	 * sudden power failure tests. Let's extend the timeout to a minimum of
+	 * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
 	 */
 	if (card->ext_csd.cache_size > 0) {
+		unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
+
+		timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1,
-				card->ext_csd.generic_cmd6_time);
+				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
 		if (err && err != -EBADMSG)
 			goto free_card;
 

