Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673E020656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298253;
	bh=2UtlnOQDlFF1Ai690xwU7hWJVfCxP+x+wsHYUfBZLWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhgswSmlU3MpFTMS3j3Zw3s7IgMvPA9CT7CIXljn6s9Zh4caEE2jGZj+wTjFVdV9y
	 QHrhgR/0CuTiNOpXCNB5vjvDgJRVRDvb+VTGUAGGdur0tjLMaHDkJq+nn24rBbBIsb
	 ejzBzmZPTYluuyunhF3rddXn2zj6JnUN35+Cyibk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeLTJaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731085AbeLTJaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979CE20989;
        Thu, 20 Dec 2018 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298246;
        bh=2UtlnOQDlFF1Ai690xwU7hWJVfCxP+x+wsHYUfBZLWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TKS3h/8+/pjtc31kRD5ZWqwcOhadGC9ggQ5okOwgsGo3LupZ8F4BaL10NoR6NfaxX
         pZ/vx71UrW8463YjHtHf7ea9t2EaNyD/n2CelkOA/YfG6asec6mxbnBlpccXtmkgY5
         eDHelJDQJNbU9Dp3JBGiigsBL607ZOUKyh8a5CNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/67] net: mvpp2: fix detection of 10G SFP modules
Date:   Thu, 20 Dec 2018 10:19:04 +0100
Message-Id: <20181220085905.610142629@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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



