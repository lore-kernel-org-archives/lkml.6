Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E5EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5532084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJjpGPua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5532084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeLEJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbeLEJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:46 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1031E2084C;
        Wed,  5 Dec 2018 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002725;
        bh=mQVq7lO1QFu16OvFTmXI8DVN1f4nscl45HCf9jVNAxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJjpGPuaSoTR/iRi1Zrk7WDsLNnP4pVK77whtCUvEOSwXToC0rNBaXz24HZXDing6
         +CMT/dWiqz69DzYxLJSMFVIhCejgKgC7xbtgePgqBP0b6caRuz9bTFhD3TXwqi4KM1
         22y7EJGCUwhcomQef2HqjPgJQExg5y+d2o4y28t8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 049/123] phy: qcom-qusb2: Use HSTX_TRIM fused value as is
Date:   Wed,  5 Dec 2018 04:34:41 -0500
Message-Id: <20181205093555.5386-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Gautam <mgautam@codeaurora.org>

[ Upstream commit 6e34d358b24ffc40764eb3681164c79091765429 ]

Fix HSTX_TRIM tuning logic which instead of using fused value
as HSTX_TRIM, incorrectly performs bitwise OR operation with
existing default value.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index e70e425f26f5..9d6c88064158 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -402,10 +402,10 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 
 	/*
 	 * Read efuse register having TUNE2/1 parameter's high nibble.
-	 * If efuse register shows value as 0x0, or if we fail to find
-	 * a valid efuse register settings, then use default value
-	 * as 0xB for high nibble that we have already set while
-	 * configuring phy.
+	 * If efuse register shows value as 0x0 (indicating value is not
+	 * fused), or if we fail to find a valid efuse register setting,
+	 * then use default value for high nibble that we have already
+	 * set while configuring the phy.
 	 */
 	val = nvmem_cell_read(qphy->cell, NULL);
 	if (IS_ERR(val) || !val[0]) {
@@ -415,12 +415,13 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 
 	/* Fused TUNE1/2 value is the higher nibble only */
 	if (cfg->update_tune1_with_efuse)
-		qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
-			      val[0] << 0x4);
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
+				 val[0] << HSTX_TRIM_SHIFT,
+				 HSTX_TRIM_MASK);
 	else
-		qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
-			      val[0] << 0x4);
-
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
+				 val[0] << HSTX_TRIM_SHIFT,
+				 HSTX_TRIM_MASK);
 }
 
 static int qusb2_phy_set_mode(struct phy *phy, enum phy_mode mode)
-- 
2.17.1

