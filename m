Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E078CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A398420881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UcIthqKW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ntMNunRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A398420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJPPLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 227E560F39; Tue, 16 Oct 2018 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539674556;
        bh=rmErbHhxeGcoDw34xCSQzAAwsUOQV1yGRknEezCy+gY=;
        h=From:To:Cc:Subject:Date:From;
        b=UcIthqKW+Fw5mF8K/KZ9LtRB9CMZ9XzOwt70IUDpqL+UDc51n7BjDjHBv7Dei773k
         1HX5ghu1GXot6EoSNZ2SdbFvq8BF6HloEjDUrcNjPeP6MdKLE9kSF71a/0NS4nsjqC
         GHYzf23We7o3n3utYEC24ffXHwsdeqlU0Odm12Zo=
Received: from mgautam-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90D42601D2;
        Tue, 16 Oct 2018 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539674555;
        bh=rmErbHhxeGcoDw34xCSQzAAwsUOQV1yGRknEezCy+gY=;
        h=From:To:Cc:Subject:Date:From;
        b=ntMNunRRJiP9Rf3eGepOzh5QGwIu7fEF+w1sqqhk5PIJq/yesosjD+WEnXehVEyAZ
         Te/id2xvZmH0CVQZGFDt7f2xz+BC1jmfl5BYkt/ULHJ8t4m2BOXbeUA0OUhTUbPPSf
         emNGTnVXg+ROEtf103B4bim6a0oSmZfWf35yVBVQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90D42601D2
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
Subject: [PATCH v2 1/2] phy: qcom-qusb2: Use HSTX_TRIM fused value as is
Date:   Tue, 16 Oct 2018 12:52:06 +0530
Message-Id: <20181016072209.1011-1-mgautam@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix HSTX_TRIM tuning logic which instead of using fused value
as HSTX_TRIM, incorrectly performs bitwise OR operation with
existing default value.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

