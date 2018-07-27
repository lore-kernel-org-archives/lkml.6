Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47BCC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D766208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D766208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeG0PWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:22:00 -0400
Received: from bran.ispras.ru ([83.149.199.196]:20113 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730714AbeG0PWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:22:00 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 8E441203B2;
        Fri, 27 Jul 2018 16:59:54 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] regulator: tps65217: Fix NULL pointer dereference on probe
Date:   Fri, 27 Jul 2018 16:59:29 +0300
Message-Id: <20180727135929.13406-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no check that tps->strobes is allocated successfully in
tps65217_regulator_probe().
The patch adds corresponding check.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/regulator/tps65217-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index fc12badf3805..d84fab616abf 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -232,6 +232,8 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	tps->strobes = devm_kcalloc(&pdev->dev,
 				    TPS65217_NUM_REGULATOR, sizeof(u8),
 				    GFP_KERNEL);
+	if (!tps->strobes)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, tps);
 
-- 
2.18.0

