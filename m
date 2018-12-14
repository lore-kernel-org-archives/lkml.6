Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E82145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789057;
	bh=ksuse7HFfmNaurGItV3/+FtAPAUjp3T987tMu0ugo4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WM2Oq4zKPd4EYLFsvHb5ZP9nX4Duei46JDng2260wsXtia+Mad3Sezkb0x39BAYul
	 gqJg4yjqT8iFC/O0GqIaMp6HpAjb7VcX+77dp6hoAcPxVIQEEY/dbXZcgs2wuF3pPb
	 US09Ul6jRE8lcvMZI3Damnd4NNi+M+vKc/3Zgyy0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5E82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbeLNMEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbeLNMEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3B92147D;
        Fri, 14 Dec 2018 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789052;
        bh=ksuse7HFfmNaurGItV3/+FtAPAUjp3T987tMu0ugo4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjY+5Rd/w7b9TewCm30PwQzg5NoI5LlYSJcrG/VRLZaBcGTsk82QDevfUNf2isyAu
         RKdSbsN/x22ywy7ITXgfKf4/Rlul1Z66P0Ko7SgZ9G+WN/eo/eHUFy+++g5wdo3qiL
         41I2LqPdKihFYACAqB9rTxrgK1AcaUMpkQEXN8j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/142] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845
Date:   Fri, 14 Dec 2018 12:59:13 +0100
Message-Id: <20181214115749.775097168@linuxfoundation.org>
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
2.19.1



