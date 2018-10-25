Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6B920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xW2zWlf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6B920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJYWou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbeJYWor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29DB020848;
        Thu, 25 Oct 2018 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476712;
        bh=ikPRD1fkHakiAN3lZIv6ebEw/fOaiZc24mzkwyDfWHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xW2zWlf2YWReTU1ClnUGkufpTcL6X3ptF8D3iMy+2MecZ7GhcM1RyR+Cf3ndc8PTW
         44vf02xnStvbncJwiK6dKnIDwS8LYBxK3UIO2r43xcIx3AvvSSdk2sLusxrYQuRyG7
         GDb7p2tjWJBVKaPKAtPUdIXLFLmYNG+PFLkZUPXw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 41/46] net: phy: phylink: Don't release NULL GPIO
Date:   Thu, 25 Oct 2018 10:10:48 -0400
Message-Id: <20181025141053.213330-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 3bcd47726c3b744fd08781795cca905cc59a1382 ]

If CONFIG_GPIOLIB is disabled, gpiod_put() becomes a stub that produces a
warning, this helped identify that we could be attempting to release a NULL
pl->link_gpio GPIO descriptor, so guard against that.

Fixes: daab3349ad1a ("net: phy: phylink: Release link GPIO")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e4a6ed88b9cf..79f28b9186c6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -561,7 +561,7 @@ void phylink_destroy(struct phylink *pl)
 {
 	if (pl->sfp_bus)
 		sfp_unregister_upstream(pl->sfp_bus);
-	if (!IS_ERR(pl->link_gpio))
+	if (!IS_ERR_OR_NULL(pl->link_gpio))
 		gpiod_put(pl->link_gpio);
 
 	cancel_work_sync(&pl->resolve);
-- 
2.17.1

