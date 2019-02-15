Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1956E21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198455;
	bh=dVAiIHuw0E+PlsXSgmiKkIGI7JFclc6jl/VfrJkywmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i81aBomm134ZTsnhypXbcfGdx+VAK0RO0YTQtEQV0UGchlUkvXcwvOTWnwbnNQyHh
	 EZwf3v1k0n/JsBdaJ950lbMRVG+FXno2enFbXIpaMO6qvdW+qG2z+VfpnSvCJs5MdQ
	 CdpVMeuRimc3HeSbqW3mWwwLTfDZ9W5tDcLrD1uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbfBOCJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388760AbfBOCJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C3521B68;
        Fri, 15 Feb 2019 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196583;
        bh=dVAiIHuw0E+PlsXSgmiKkIGI7JFclc6jl/VfrJkywmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlg+P08RglOW6PuIG5B+CYOD3AB/lwjdxVMpsh3Do4aAke68DQWz+J9ntJBaHJ31Z
         LdCrMn+xKhsoeD6MzF5BEb3V8TXe9AjuGfwu6HvLAU5nzMvwO30uHeSBmL4BLO2Svk
         bVhV4lSL9HJAoVvSXHe14Cy6kUghAEI6RoNSUPdg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 27/77] phy: ath79-usb: Fix the power on error path
Date:   Thu, 14 Feb 2019 21:08:05 -0500
Message-Id: <20190215020855.176727-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

[ Upstream commit 009808154c69c48d5b41fc8cf5ad5ab5704efd8f ]

In the power on function the error path doesn't return the suspend
override to its proper state. It should should deassert this reset
line to enable the suspend override.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-ath79-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-ath79-usb.c b/drivers/phy/qualcomm/phy-ath79-usb.c
index 6fd6e07ab345..f7d64f3910b4 100644
--- a/drivers/phy/qualcomm/phy-ath79-usb.c
+++ b/drivers/phy/qualcomm/phy-ath79-usb.c
@@ -31,7 +31,7 @@ static int ath79_usb_phy_power_on(struct phy *phy)
 
 	err = reset_control_deassert(priv->reset);
 	if (err && priv->no_suspend_override)
-		reset_control_assert(priv->no_suspend_override);
+		reset_control_deassert(priv->no_suspend_override);
 
 	return err;
 }
-- 
2.19.1

