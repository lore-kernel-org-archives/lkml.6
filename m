Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63779C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE672089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE672089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJCUrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:47:19 -0400
Received: from sauhun.de ([88.99.104.3]:53732 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:47:19 -0400
Received: from localhost (p54B337E1.dip0.t-ipconnect.de [84.179.55.225])
        by pokefinder.org (Postfix) with ESMTPSA id B29F12C790E;
        Wed,  3 Oct 2018 15:58:45 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mfd: bd9571mwv: add volatile register to make DVFS work
Date:   Wed,  3 Oct 2018 15:58:41 +0200
Message-Id: <20181003135841.4984-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dien Pham <dien.pham.ry@renesas.com>

Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
the physical register value is not updated by regmap and DVFS doesn't
work as expected. Fix it!

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[wsa: rebase, add 'Fixes', reword commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
---

Grabbed from the BSP and confirmed by the datasheet. The register is RO
and reflecting states depending on other registers.

 drivers/mfd/bd9571mwv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 503979c81dae..fab3cdc27ed6 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -59,6 +59,7 @@ static const struct regmap_access_table bd9571mwv_writable_table = {
 };
 
 static const struct regmap_range bd9571mwv_volatile_yes_ranges[] = {
+	regmap_reg_range(BD9571MWV_DVFS_MONIVDAC, BD9571MWV_DVFS_MONIVDAC),
 	regmap_reg_range(BD9571MWV_GPIO_IN, BD9571MWV_GPIO_IN),
 	regmap_reg_range(BD9571MWV_GPIO_INT, BD9571MWV_GPIO_INT),
 	regmap_reg_range(BD9571MWV_INT_INTREQ, BD9571MWV_INT_INTREQ),
-- 
2.19.0

