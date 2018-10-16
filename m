Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3164C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E620881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TgZ1wY8W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TgZ1wY8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430E620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJPPLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5DEB60A34; Tue, 16 Oct 2018 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539674560;
        bh=qUx72voxU4tZTyKO/SenLyoz0HDLI6MekyS5fU6sb/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgZ1wY8WKtroq1dVleheEn84Go+X1Q58vHx0atV5adU1iUi70tqDftXMUNqEWj7sc
         i9i2F20WaSU/UpwSXErYLrjtrDHXpCakhAVz7+PDngFoYxAMCQYw87yRNSPXOnBVGS
         NCGAvd3CniCu/wHyqxfHSGQTVPQhph2s+BPlHzjk=
Received: from mgautam-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D92E612F8;
        Tue, 16 Oct 2018 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539674560;
        bh=qUx72voxU4tZTyKO/SenLyoz0HDLI6MekyS5fU6sb/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgZ1wY8WKtroq1dVleheEn84Go+X1Q58vHx0atV5adU1iUi70tqDftXMUNqEWj7sc
         i9i2F20WaSU/UpwSXErYLrjtrDHXpCakhAVz7+PDngFoYxAMCQYw87yRNSPXOnBVGS
         NCGAvd3CniCu/wHyqxfHSGQTVPQhph2s+BPlHzjk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D92E612F8
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
Subject: [PATCH v2 2/2] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845
Date:   Tue, 16 Oct 2018 12:52:07 +0530
Message-Id: <20181016072209.1011-2-mgautam@codeaurora.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181016072209.1011-1-mgautam@codeaurora.org>
References: <20181016072209.1011-1-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune1 register on sdm845 is used to update HSTX_TRIM with fused
setting. Enable same by specifying update_tune1_with_efuse flag
for sdm845, otherwise driver ends up programming tune2 register.

Fixes: ef17f6e212ca ("phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845")
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 9d6c88064158..69c92843eb3b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -231,6 +231,7 @@ static const struct qusb2_phy_cfg sdm845_phy_cfg = {
 	.mask_core_ready = CORE_READY_STATUS,
 	.has_pll_override = true,
 	.autoresume_en	  = BIT(0),
+	.update_tune1_with_efuse = true,
 };
 
 static const char * const qusb2_phy_vreg_names[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

