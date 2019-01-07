Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91E2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfAGTpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:45:03 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:13708 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfAGTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:45:02 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a9a9:5e6d:35c6:d37d])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 0F6625FFA0;
        Mon,  7 Jan 2019 20:44:55 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/2] phy: ath79-usb: Fix the power on error path
Date:   Mon,  7 Jan 2019 20:44:53 +0100
Message-Id: <20190107194454.16500-1-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the power on function the error path doesn't return the suspend
override to its proper state. It should should deassert this reset
line to enable the suspend override.

Signed-off-by: Alban Bedel <albeu@free.fr>
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

