Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FD6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CBB208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CBB208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeGIHDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:03:19 -0400
Received: from asrmicro.com ([210.13.118.86]:19683 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeGIHDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:03:17 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 03:03:17 EDT
Received: from localhost (10.1.170.159) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 9 Jul 2018 14:47:30
 +0800
From:   Hongjie Fang <hongjiefang@asrmicro.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <shawn.lin@rock-chips.com>, <linus.walleij@linaro.org>,
        <bst@pengutronix.de>, <wsa+renesas@sang-engineering.com>,
        <chanho.min@lge.com>, <kyle.roeschley@ni.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
Date:   Mon, 9 Jul 2018 14:47:23 +0800
Message-ID: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.159]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_select_hs400es() calls mmc_select_bus_width() which will try to
set 4bit transfer mode if fail to set 8bit mode. The problem is that
the bus width should not be set to 4bit in HS400es mode.

Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..94c3cc5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
-	err = mmc_select_bus_width(card);
-	if (err < 0)
+	/* Switch card to 8 bit mode */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BUS_WIDTH,
+			 EXT_CSD_BUS_WIDTH_8,
+			 card->ext_csd.generic_cmd6_time);
+	if (err) {
+		pr_err("%s: switch to 8 bit mode for hs400es failed, err:%d\n",
+			mmc_hostname(host), err);
+		goto out_err;
+	}
+
+	mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
+
+	if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+		err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
+	else
+		err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
+	if (err) {
+		pr_err("%s: test 8 bit mode for hs400es failed, err:%d\n",
+			mmc_hostname(host), err);
 		goto out_err;
+	}
 
 	/* Switch card to HS mode */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-- 
1.9.1

