Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CCFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4FE24738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FE24738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeGDGyt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:54:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGDGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:54:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fabgS-0000S3-Nz; Wed, 04 Jul 2018 06:54:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: bcm_sf2: remove redundant variable off
Date:   Wed,  4 Jul 2018 07:54:36 +0100
Message-Id: <20180704065436.13719-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable 'off' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'off' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/dsa/bcm_sf2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 02e8982519ce..ac96ff40d37e 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -220,7 +220,7 @@ static void bcm_sf2_port_disable(struct dsa_switch *ds, int port,
 				 struct phy_device *phy)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
-	u32 off, reg;
+	u32 reg;
 
 	if (priv->wol_ports_mask & (1 << port))
 		return;
@@ -231,11 +231,6 @@ static void bcm_sf2_port_disable(struct dsa_switch *ds, int port,
 	if (priv->int_phy_mask & 1 << port && priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, false);
 
-	if (dsa_is_cpu_port(ds, port))
-		off = CORE_IMP_CTL;
-	else
-		off = CORE_G_PCTL_PORT(port);
-
 	b53_disable_port(ds, port, phy);
 
 	/* Power down the port memory */
-- 
2.17.1

