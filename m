Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D864C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325BD222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbfBMJHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:07:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727954AbfBMJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:07:07 -0500
X-UUID: 7bcd46a362e948fb83ece4cec05995db-20190213
X-UUID: 7bcd46a362e948fb83ece4cec05995db-20190213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2061458422; Wed, 13 Feb 2019 17:06:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 17:06:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 17:06:56 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date:   Wed, 13 Feb 2019 17:06:52 +0800
Message-ID: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 68645DB28F340A99640835A4B7B41D19430DCE141EC0F639AD3442A3CDA9D7072000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
Therefore, any commands sent to the card should use HS400 timing.
reduce clock frequency to 50Mhz but without host timming change
may cause CMD6 response CRC error. because host still running at
hs400 mode, and it's hard to find a suitable setting for all eMMC
cards when clock frequency reduced to 50Mhz but card & host still
in hs400 mode.
this patch refers to mmc_select_hs400(), make the reduce clock frequency
after card timing change.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
---
 drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 09c688f..00adc2d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
-	if (err)
-		goto out_err;
+	/*
+	 * as we are on the way to do re-tune, so if the CMD6 got response CRC
+	 * error, do not treat it as error.
+	 */
+	if (err) {
+		if (err == -EILSEQ) {
+			/*
+			 * card will busy after sending out response and host
+			 * driver may not wait busy de-assert when get
+			 * response CRC error. so just wait enough time to
+			 * ensure card leave busy state.
+			 */
+			mmc_delay(card->ext_csd.generic_cmd6_time);
+			pr_debug("%s: %s switch to HS got CRC error\n",
+				 mmc_hostname(host), __func__);
+		} else {
+			goto out_err;
+		}
+	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-- 
1.8.1.1.dirty

