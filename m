Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39717C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207F21479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789121;
	bh=s6rW6dKWAHj69G/7IMHe0iPeIPFdUPlsBFfzU3QRtJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ww2LyRBjq3oDS6nObfKFsIOfXHMTgxBCG/3AViMQHbmvaDAWr0YVob6Rub2tfgqvb
	 K1rN2AGX1uhAD+YAc+gvTbUaAJ9FK25g5SXhVJYH5Yk20iVQcTUEu55UMFvgDFRe6d
	 HX77F7EuDHbzJcQkwpY8CAHLxBMPIutTvJRgHJ64=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0207F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbeLNMFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbeLNMFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCB721486;
        Fri, 14 Dec 2018 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789114;
        bh=s6rW6dKWAHj69G/7IMHe0iPeIPFdUPlsBFfzU3QRtJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGviU6u8URtwexOVe8u06PsN4F3RBEs5GKpXBqNO5tKqZ2MvVx6zZXzFSzbkbqTX4
         0Le3OHqjqm3pNt/dthjMaaL938u3dYGmVLPsPr7q5t5NTxI8YNivCp+dBfWprargRE
         VIFpoSk5EKp/ll8SHish1YIUHFyBXcz4bH900cWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/142] phy: qcom-qusb2: Use HSTX_TRIM fused value as is
Date:   Fri, 14 Dec 2018 12:59:12 +0100
Message-Id: <20181214115749.735610650@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



