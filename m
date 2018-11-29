Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C642082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOyh5re3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C642082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeK3BXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbeK3BXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADAA213A2;
        Thu, 29 Nov 2018 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501063;
        bh=046qrkwSxj/ReP8zayER/SC5qpOjWYyjFzSEuibCxgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOyh5re3jhmpdbw3uAQNw/uJDZqUk7supOdn5G0JI1ZLL9D+XS/3nAH62TgSTre+1
         KtdCS7lSQ0JSbIokNYunuU2Rmp0zgO5aU5dcY2z/BkGIE6QI2kbNLabcADf6+jEiTg
         HF6oeGMcdYBMBOVNhvYQyVbqqMuOYP/ZI4BgoZ1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 27/86] net: bcmgenet: fix OF child-node lookup
Date:   Thu, 29 Nov 2018 15:11:52 +0100
Message-Id: <20181129140112.123660865@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d397dbe606120a1ea1b11b0020c3f7a3852da5ac ]

Use the new of_get_compatible_child() helper to lookup the mdio child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: David S. Miller <davem@davemloft.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 4c73feca4842..0565efad6e6e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -491,7 +491,7 @@ static int bcmgenet_mii_of_init(struct bcmgenet_priv *priv)
 	if (!compat)
 		return -ENOMEM;
 
-	priv->mdio_dn = of_find_compatible_node(dn, NULL, compat);
+	priv->mdio_dn = of_get_compatible_child(dn, compat);
 	kfree(compat);
 	if (!priv->mdio_dn) {
 		dev_err(kdev, "unable to find MDIO bus node\n");
-- 
2.17.1



