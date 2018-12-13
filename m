Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5009C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B8520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675430;
	bh=saA2gMFnkAL9Ocve+PFq2jgmMWxYge9eHkVsG+OqLvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrNWWuCQ9RuxKpg+gqNAr/MV7tmzMjKX9/gznPyEl7B3Em1OxcVr4GScKYJdBZPNv
	 wDSMcxlwClsbF39Pqtjpq52jdC/ihSY+FGjdW498ZwttMyHzDggtIbhaFaF4S3+k5e
	 xAz9UuLe2UE2hwTRxXN8KiMIae2QHNJBXkTEHqKc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B8520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeLMEa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbeLMEaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4552920879;
        Thu, 13 Dec 2018 04:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675424;
        bh=saA2gMFnkAL9Ocve+PFq2jgmMWxYge9eHkVsG+OqLvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlB5yqmczWBOHGgmjnKtKk08AO0Yhi+MCe7Ft46k+fg/DxCxHVb1g6lNg95aMt7My
         DkblwL0YDZ5tU6vcxbP+9dv3UfTDUA53dzKH9+tOb/7nXL3yQ+0U+9dVdlUeKpDLdY
         SR+dCw1Or3IEJdjvZywW/9LiS7WIZfKYeahKEXR8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 56/73] net: mvpp2: fix detection of 10G SFP modules
Date:   Wed, 12 Dec 2018 23:28:21 -0500
Message-Id: <20181213042838.75160-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 01b3fd5ac97caffb8e5d5bd85086da33db3b361f ]

The mvpp2_phylink_validate() relies on the interface field of
phylink_link_state to determine valid link modes. However, when called
from phylink_sfp_module_insert() this field in not initialized. The
default switch case then excludes 10G link modes. This allows 10G SFP
modules that are detected correctly to be configured at max rate of
2.5G.

Catch the uninitialized PHY mode case, and allow 10G rates.

Fixes: d97c9f4ab000b ("net: mvpp2: 1000baseX support")
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index a74002b43b51..1b3b64fea038 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4271,6 +4271,7 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_10GKR:
+	case PHY_INTERFACE_MODE_NA:
 		phylink_set(mask, 10000baseCR_Full);
 		phylink_set(mask, 10000baseSR_Full);
 		phylink_set(mask, 10000baseLR_Full);
-- 
2.19.1

