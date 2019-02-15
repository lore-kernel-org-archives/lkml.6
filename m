Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E162421A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfBOF7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:59:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47875 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732516AbfBOF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:59:49 -0500
X-UUID: e51d0c45e26d4af5b7d6f9a7aaee8b38-20190215
X-UUID: e51d0c45e26d4af5b7d6f9a7aaee8b38-20190215
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1533631543; Fri, 15 Feb 2019 13:59:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 13:59:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 13:59:42 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 2/2] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date:   Fri, 15 Feb 2019 13:59:35 +0800
Message-ID: <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
before send CMD6 to switch card's timing to HS mode, it reduce clock
frequency to 50Mhz firstly, the original intention of reduce clock
is to make "more stable" when doing HS switch. however,reduce clock
frequency to 50Mhz but without host timming change may cause CMD6
response CRC error. because host is still running at hs400 mode,
and it's hard to find a suitable setting for all eMMC cards when
clock frequency reduced to 50Mhz but card & host still in hs400 mode.

so that We consider that CMD6 response CRC error is not a fatal error,
if host gets CMD6 response CRC error, it means that card has already
received this command.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
---
 drivers/mmc/core/mmc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 09c688f..03d1c17 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1248,8 +1248,25 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
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
 
-- 
1.8.1.1.dirty

