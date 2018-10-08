Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB432C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F81C21532
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipdBqqRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F81C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeJHWjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJHWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F0F21531;
        Mon,  8 Oct 2018 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012408;
        bh=khAOnNFlvqovkBdF8PQtNrS9CdHVlkFEr+hARPSlupo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipdBqqRBYKNgAXsYBw1Mko9fjiSaugoIUNeN0CE9uri285/bXYrkDbwkMbBB7709h
         0D3LICiTED5BkHNKvsZHy5QB1sI35IFU34GCF1bsdwLyyCl9+h8WbnZBT41cCc3AgG
         ki7F08noNKPTfMk3Qcuqm1QHkaulbW6MEgS2LFXs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/32] net: emac: fix fixed-link setup for the RTL8363SB switch
Date:   Mon,  8 Oct 2018 11:26:16 -0400
Message-Id: <20181008152629.70812-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit 08e39982ef64f800fd1f9b9b92968d14d5fafa82 ]

On the Netgear WNDAP620, the emac ethernet isn't receiving nor
xmitting any frames from/to the RTL8363SB (identifies itself
as a RTL8367RB).

This is caused by the emac hardware not knowing the forced link
parameters for speed, duplex, pause, etc.

This begs the question, how this was working on the original
driver code, when it was necessary to set the phy_address and
phy_map to 0xffffffff. But I guess without access to the old
PPC405/440/460 hardware, it's not possible to know.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 7feff2450ed6..d1da8f05ef85 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2671,12 +2671,17 @@ static int emac_init_phy(struct emac_instance *dev)
 		if (of_phy_is_fixed_link(np)) {
 			int res = emac_dt_mdio_probe(dev);
 
-			if (!res) {
-				res = of_phy_register_fixed_link(np);
-				if (res)
-					mdiobus_unregister(dev->mii_bus);
+			if (res)
+				return res;
+
+			res = of_phy_register_fixed_link(np);
+			dev->phy_dev = of_phy_find_device(np);
+			if (res || !dev->phy_dev) {
+				mdiobus_unregister(dev->mii_bus);
+				return res ? res : -EINVAL;
 			}
-			return res;
+			emac_adjust_link(dev->ndev);
+			put_device(&dev->phy_dev->mdio.dev);
 		}
 		return 0;
 	}
-- 
2.17.1

