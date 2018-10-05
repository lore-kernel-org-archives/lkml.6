Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E44C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2064120652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcoV2oPx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eQ+bbKdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2064120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeJEQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:07:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeJEQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:07:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14C7D6053D; Fri,  5 Oct 2018 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538730593;
        bh=VQvn80dPoPyn5RedQsq8wJ5JsAH8VFwlSxpU8cHLJmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YcoV2oPxNaJVZ31C5KaW+Cqp7HAlSYDNe54zmPU4iCETyvnkmOIXpsMEUGSQjjFNX
         U6XEi9LjeYdH93h2Y8VXXQ6Lr3d2U6qeRy1k52hkoonEYJtnKbiJLv5Gl6X+U59QSW
         zwI11JRWoCr8guZfixBVGAh9/iLV79God9xNfKWI=
Received: from mgautam-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D790607BD;
        Fri,  5 Oct 2018 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538730592;
        bh=VQvn80dPoPyn5RedQsq8wJ5JsAH8VFwlSxpU8cHLJmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eQ+bbKdj9xMBebSaQizWJ5VJ1oan5Yd4MinKfrirRWnnjwdXZwuqf2cXodNCEwdJ2
         GrWkVDjzrDivv2Q++4huv11RmIRYiUB/WozldGnFBn5kF4/2K1DIzYhDtNPZQ91kiD
         211iaHALFa6NK6vXlulWjg04uiTNJSOPKhY9Gwro=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D790607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From:   Manu Gautam <mgautam@codeaurora.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v1] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845
Date:   Fri,  5 Oct 2018 14:39:19 +0530
Message-Id: <20181005090920.26108-1-mgautam@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune1 register on sdm845 is used to update HSTX_TRIM with fused
setting. Enable same by specifying update_tune1_with_efuse flag
for sdm845, otherwise driver ends up programming tune2 register.
While at it, also fix HSTX_TRIM tuning logic which instead of
using fused value as HSTX_TRIM, incorrectly performs bitwise OR
operation with existing default value.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index e70e425f26f5..defeb0b7cfa0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -231,6 +231,7 @@ static const struct qusb2_phy_cfg sdm845_phy_cfg = {
 	.mask_core_ready = CORE_READY_STATUS,
 	.has_pll_override = true,
 	.autoresume_en	  = BIT(0),
+	.update_tune1_with_efuse = true,
 };
 
 static const char * const qusb2_phy_vreg_names[] = {
@@ -415,12 +416,13 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

