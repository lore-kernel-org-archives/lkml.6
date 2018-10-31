Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5838920847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCurcFgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838920847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeKAIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbeKAIK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85E420838;
        Wed, 31 Oct 2018 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027414;
        bh=FjF0sxzkT6nEUZLq6yowJ/HrHE4IiKXSwG4ehYfem20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCurcFgBr0JrmAKBu2jXoDvp/bgQYiZd45/43KB8qZnYfeepb2O/1ai83HwMAq54m
         M1bV44EM4UzKIuqN1dDckUiL2wIst0jCB8CAi+7H7pPFobx06AhMHIk2UXPRetXl2l
         r861lXJzmZugFv/9a0IPBCPS4NTKnvPKUl/eOCH0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 28/73] net: phy: phylink: ensure the carrier is off when starting phylink
Date:   Wed, 31 Oct 2018 19:09:03 -0400
Message-Id: <20181031230948.29203-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit aeeb2e8fdefdd5d257a1446351c70cb3df540199 ]

Phylink made an assumption about the carrier state being down when
calling phylink_start(). If this assumption isn't satisfied, the
internal phylink state could misbehave and a net device could end up not
being functional.

This patch fixes this by explicitly calling netif_carrier_off() in
phylink_start().

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e4a6ed88b9cf..9b8b9242fb61 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -747,6 +747,9 @@ void phylink_start(struct phylink *pl)
 		    phylink_an_mode_str(pl->link_an_mode),
 		    phy_modes(pl->link_config.interface));
 
+	/* Always set the carrier off */
+	netif_carrier_off(pl->netdev);
+
 	/* Apply the link configuration to the MAC when starting. This allows
 	 * a fixed-link to start with the correct parameters, and also
 	 * ensures that we set the appropriate advertisment for Serdes links.
-- 
2.17.1

