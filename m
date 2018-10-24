Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B6C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E07D2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E07D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hale.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJXWqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:46:48 -0400
Received: from gw.hale.at ([89.26.116.210]:44686 "EHLO gw.hale.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXWqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:46:48 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 18:46:46 EDT
X-HALE-Mailborder-Watermark: 1540995031.09042@bwZdRO9TuQceypuyP6SWjw
X-HALE-Mailborder-From: michael.thalmeier@hale.at
X-HALE-Mailborder-SpamCheck: not spam,
        SpamAssassin (nicht zwischen gespeichert, Wertung=-2.899,
        benoetigt 3, autolearn=not spam, ALL_TRUSTED -1.00, BAYES_00 -1.90,
        SURBL_BLOCKED 0.00)
X-HALE-Mailborder-IP-Protocol: IPv4
X-HALE-Mailborder: Found to be clean
X-HALE-Mailborder-ID: 997492C0EC7.A6767
X-HALE-Mailborder-Information: Please contact your admin for more information
Received: from mail.hale (mail.hale [192.168.100.5])
        by gw.hale.at (Postfix) with ESMTP id 997492C0EC7;
        Wed, 24 Oct 2018 16:10:30 +0200 (CEST)
Received: from mail.hale (localhost.localdomain [127.0.0.1])
        by mail.hale (Postfix) with ESMTP id 93D8366115E;
        Wed, 24 Oct 2018 16:10:30 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.hale (Postfix) with ESMTP id 8653C660A1C;
        Wed, 24 Oct 2018 16:10:30 +0200 (CEST)
Received: from mail.hale ([127.0.0.1])
        by localhost (mail.hale [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qf5mvJApmbfk; Wed, 24 Oct 2018 16:10:30 +0200 (CEST)
Received: from entw49.HALE (entw49.hale [192.168.100.117])
        by mail.hale (Postfix) with ESMTP id 6A4506607B7;
        Wed, 24 Oct 2018 16:10:30 +0200 (CEST)
From:   Michael Thalmeier <michael.thalmeier@hale.at>
To:     Roman Peniaev <r.peniaev@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        michael@thalmeier.at
Subject: [PATCH] Revert "mmc: mxs: fix card detection in case of 'broken-cd' flag set"
Date:   Wed, 24 Oct 2018 16:10:08 +0200
Message-Id: <20181024141008.30312-1-michael.thalmeier@hale.at>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f726f495f2d ("mmc: mxs: fix card detection in case of 'broken-cd' flag set").

Since mxs_mmc_probe always sets MMC_CAP_NEEDS_POLL unconditionally, card
detect is not working properly any more since commit 6f726f495f2d.
Instead of querying the card detect status mxs_mmc_get_cd now always
returns 1 which causes probing commands being sent to the mmc card.

The expected behaviour of commit 6f726f495f2d should be reachable by setting
broken_cd instead.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/mmc/host/mxs-mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70..cfdae61 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -86,8 +86,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	if (ret >= 0)
 		return ret;
 
-	present = mmc->caps & MMC_CAP_NEEDS_POLL ||
-		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+	present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 			BM_SSP_STATUS_CARD_DETECT);
 
 	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
-- 
2.9.2

