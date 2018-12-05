Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D016C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E033C20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMA5SUcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E033C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeLEJix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbeLEJiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:50 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3D42084C;
        Wed,  5 Dec 2018 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002729;
        bh=u+tN+tN6Ir9FcpEep76QACMEVvWYlIQmpPvX3Rz3EDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMA5SUcF6hKvQrsokTxdtWtkeXVTFvH8AiMJe1egLagBkq/npaulVQLL+t44tfj6m
         HhW+h0v/aRbgQimSxLrGASmrZk+KrvaBwEspue3MEYTdr7ZsGUxdal3Ma0BVXtsI1W
         MdY5GUciPk2gAsituLLeEE5+OgTUbWjgmcQlgOkY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 050/123] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845
Date:   Wed,  5 Dec 2018 04:34:42 -0500
Message-Id: <20181205093555.5386-50-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Gautam <mgautam@codeaurora.org>

[ Upstream commit c88520db18ba0b9a41326c3b8680e7c09eb4c381 ]

Tune1 register on sdm845 is used to update HSTX_TRIM with fused
setting. Enable same by specifying update_tune1_with_efuse flag
for sdm845, otherwise driver ends up programming tune2 register.

Fixes: ef17f6e212ca ("phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845")
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

