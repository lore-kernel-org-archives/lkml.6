Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF13208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF13208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeGaEdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:33:41 -0400
Received: from asrmicro.com ([210.13.118.86]:62250 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaEdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:33:40 -0400
Received: from localhost (10.1.170.159) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 31 Jul 2018 10:55:12
 +0800
From:   Hongjie Fang <hongjiefang@asrmicro.com>
To:     <ulf.hansson@linaro.org>
CC:     <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <linus.walleij@linaro.org>, <horms+renesas@verge.net.au>,
        <wsa+renesas@sang-engineering.com>, <bst@pengutronix.de>,
        <chanho.min@lge.com>, <kyle.roeschley@ni.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH V5] mmc: core: improve reasonableness of bus width setting for HS400es
Date:   Tue, 31 Jul 2018 10:55:09 +0800
Message-ID: <1533005709-10909-1-git-send-email-hongjiefang@asrmicro.com>
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

mmc_select_hs400es() calls mmc_select_bus_width() which will continue
to set 4bit transfer mode if fail to set 8bit mode. The bus width
should not be set to 4bit in HS400es.

When fail to set 8bit mode, need return error directly for HS400es.

Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/mmc/core/mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..82af1e0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1338,8 +1338,12 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 
 	err = mmc_select_bus_width(card);
-	if (err < 0)
+	if (err != MMC_BUS_WIDTH_8) {
+		pr_err("%s: switch to 8bit bus width failed, err:%d\n",
+			mmc_hostname(host), err);
+		err = err < 0 ? err : -ENOTSUPP;
 		goto out_err;
+	}
 
 	/* Switch card to HS mode */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-- 
1.9.1

