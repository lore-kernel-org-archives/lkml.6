Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0026DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F35214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F35214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIQRh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:37:57 -0400
Received: from shell.v3.sk ([90.176.6.54]:47304 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbeIQRh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:37:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A8E08AEEAD;
        Mon, 17 Sep 2018 14:10:52 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Za2rIdfMEKrC; Mon, 17 Sep 2018 14:10:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D136AAF016;
        Mon, 17 Sep 2018 14:10:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qLN2yEueWE6t; Mon, 17 Sep 2018 14:10:49 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 34464AEEAD;
        Mon, 17 Sep 2018 14:10:49 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Gracefully handle power supplies with disabled PM
Date:   Mon, 17 Sep 2018 14:10:41 +0200
Message-Id: <20180917121041.21084-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows use of SPI when power management is disables, such as on
early boot;

See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
with disabled runtime PM")

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..6546564e41d0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1212,7 +1212,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 	if (!was_busy && ctlr->auto_runtime_pm) {
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EACCES) {
 			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
-- 
2.17.1

