Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE02086E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DE02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGKDDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:03:31 -0400
Received: from asrmicro.com ([210.13.118.86]:64291 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbeGKDDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:03:31 -0400
Received: from localhost (10.1.170.159) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 11 Jul 2018 11:00:52
 +0800
From:   Hongjie Fang <hongjiefang@asrmicro.com>
To:     <ulf.hansson@linaro.org>
CC:     <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <linus.walleij@linaro.org>, <wsa+renesas@sang-engineering.com>,
        <bst@pengutronix.de>, <jinqian@google.com>, <chanho.min@lge.com>,
        <kyle.roeschley@ni.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH V2] mmc: core: improve reasonableness of bus width setting for HS400es
Date:   Wed, 11 Jul 2018 11:00:49 +0800
Message-ID: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
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
 drivers/mmc/core/mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..4bd6c09 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1021,8 +1021,11 @@ static int mmc_select_bus_width(struct mmc_card *card)
 				 EXT_CSD_BUS_WIDTH,
 				 ext_csd_bits[idx],
 				 card->ext_csd.generic_cmd6_time);
-		if (err)
+		if (err) {
+			if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+				return err;
 			continue;
+		}
 
 		bus_width = bus_widths[idx];
 		mmc_set_bus_width(host, bus_width);
-- 
1.9.1

