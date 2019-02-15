Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E467C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE121934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196722;
	bh=dVAiIHuw0E+PlsXSgmiKkIGI7JFclc6jl/VfrJkywmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HysIzmUFBft544DC4mnJj6VvnXWlh9iPWvrMj161tF16BALDXvPd3fpLDEwnOtki8
	 etG4DULhwJpEgt2U7N5MIyY5F6oyAdgxeYWERfruO79ND3BUFfpBnVWSzh1eNYNcSE
	 sxgLK6t7oSWmCW8Yzt2wHKfDL86xRDMuSFKmdg9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390952AbfBOCMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390882AbfBOCLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D2C621B68;
        Fri, 15 Feb 2019 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196714;
        bh=dVAiIHuw0E+PlsXSgmiKkIGI7JFclc6jl/VfrJkywmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZV+WLufPpFd0JxmS9UMvynPHj/2X/7Be9v9TgHai/T6effssrbw0rDcPltpcTX+b
         aLwVKmYuCXH75qJs1R3YiO2X2k85XB7WS3yQcs2sbt8fC0FzuGqWmnEpCKiyBdG7Bk
         jbBjET+QRASY5/t9YIYQsQKPosb396ycf1enjMTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 20/65] phy: ath79-usb: Fix the power on error path
Date:   Thu, 14 Feb 2019 21:10:36 -0500
Message-Id: <20190215021121.177674-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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

