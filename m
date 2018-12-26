Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32124C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C6C214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864494;
	bh=i//FoLVYFFr3qEM7CG0uan4cmDpCYe4/AzwOBGH/i4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJOS7M+ML+YV/ZzNTCl+WexAFLlsCkzpMj2VL9w9KEt7kOrBUFdMyY9UcyXEtikla
	 55BcVrlJJyS55j93IiV6jHxABdbrzO+1X0+JF+4EqCRZHmQV4ABoDhRbpqYNrPAmA/
	 VBmoeUPHEnt/PGDltQEUzvV9YaLzTY6FrD9VmKc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeLZWiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbeLZWiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0B6218E2;
        Wed, 26 Dec 2018 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863887;
        bh=i//FoLVYFFr3qEM7CG0uan4cmDpCYe4/AzwOBGH/i4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7AklEgHoWebBjnrCODAlrYgrGlg0/pB48dp32f0gkl6uGRx3CLcLAuvRWOsk195f
         XNfMMW3C3C6bHBpmNAuiZgY0kKqqd8iKFn/35gL25vDClo5CSNr8l6X5G+/4GgcyWq
         LGKIgzNbIxb8O/wQHLISH/IDBdup9BbsUcOMDDtE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 76/97] lan743x: Expand phy search for LAN7431
Date:   Wed, 26 Dec 2018 17:35:36 -0500
Message-Id: <20181226223557.149329-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit 0db7d253e9f0ff1a41c602429bea93df221be6ed ]

The LAN7431 uses an external phy, and it can be found anywhere in
the phy address space. This patch uses phy address 1 for LAN7430
only. And searches all addresses otherwise.

Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index aaedf1072460..ff196a66eaaa 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2722,8 +2722,9 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	snprintf(adapter->mdiobus->id, MII_BUS_ID_SIZE,
 		 "pci-%s", pci_name(adapter->pdev));
 
-	/* set to internal PHY id */
-	adapter->mdiobus->phy_mask = ~(u32)BIT(1);
+	if ((adapter->csr.id_rev & ID_REV_ID_MASK_) == ID_REV_ID_LAN7430_)
+		/* LAN7430 uses internal phy at address 1 */
+		adapter->mdiobus->phy_mask = ~(u32)BIT(1);
 
 	/* register mdiobus */
 	ret = mdiobus_register(adapter->mdiobus);
-- 
2.19.1

