Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE46C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703720880
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFn2KoN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7703720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeJ3WVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJ3WVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF7C20838;
        Tue, 30 Oct 2018 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906065;
        bh=UKXrqkXSbb/zTa6ZI1klKizMpIEh13OfQDgO3SiT+ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFn2KoN8oUuBmQCmenvoP/C76+6CTwRcmNB5HAErEun/xvc7Uh9npQWOXtnLuFSzN
         pZubDsySleK6qT6IVox4UCdKnWl3snJafEldCAdw3Vto7Nv/KIrx4nclOVGAwso01+
         qZ5n5v+wnlQt78EXQYjxxBLJjBNGL+RxpFqbL0c4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 16/33] net: bcmgenet: Poll internal PHY for GENETv5
Date:   Tue, 30 Oct 2018 09:26:40 -0400
Message-Id: <20181030132657.217970-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 64bd9c8135751b561f27edaaffe93d07093f81af ]

On GENETv5, there is a hardware issue which prevents the GENET hardware
from generating a link UP interrupt when the link is operating at
10Mbits/sec. Since we do not have any way to configure the link
detection logic, fallback to polling in that case.

Fixes: 421380856d9c ("net: bcmgenet: add support for the GENETv5 hardware")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 4241ae928d4a..34af5f1569c8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -321,9 +321,12 @@ int bcmgenet_mii_probe(struct net_device *dev)
 	phydev->advertising = phydev->supported;
 
 	/* The internal PHY has its link interrupts routed to the
-	 * Ethernet MAC ISRs
+	 * Ethernet MAC ISRs. On GENETv5 there is a hardware issue
+	 * that prevents the signaling of link UP interrupts when
+	 * the link operates at 10Mbps, so fallback to polling for
+	 * those versions of GENET.
 	 */
-	if (priv->internal_phy)
+	if (priv->internal_phy && !GENET_IS_V5(priv))
 		dev->phydev->irq = PHY_IGNORE_INTERRUPT;
 
 	return 0;
-- 
2.17.1

