Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421DE20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Uio94W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421DE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeKCEDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeKCEDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:20 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBF020848;
        Fri,  2 Nov 2018 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184904;
        bh=eDhdw3p8LGZu7gRHy/jC4V00E+0N8XnHgjKPzZSmkDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4Uio94W8mummsevG8CHyELI2goyoYEO1Btwrno9VXZaVilEpE4mJUxxeTlX9jy0x
         mlxdOg3iUDzEst6umvz/gk1yFy8F5zptGndXq8a2OqxvamCU6EbiNu4VNBhXcmQi6f
         88FwcfiAOq2DZm90SEvncHy1tmnb3bSo/MEL63BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 124/143] net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules
Date:   Fri,  2 Nov 2018 19:35:09 +0100
Message-Id: <20181102182907.777681537@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 30549aab146ccb1275230c3b4b4bc6b4181fd54e ]

When building stmmac, it is only possible to select CONFIG_DWMAC_GENERIC,
or any of the glue drivers, when CONFIG_STMMAC_PLATFORM is set.
The only exception is CONFIG_STMMAC_PCI.

When calling of_mdiobus_register(), it will call our ->reset()
callback, which is set to stmmac_mdio_reset().

Most of the code in stmmac_mdio_reset() is protected by a
"#if defined(CONFIG_STMMAC_PLATFORM)", which will evaluate
to false when CONFIG_STMMAC_PLATFORM=m.

Because of this, the phy reset gpio will only be pulled when
stmmac is built as built-in, but not when built as modules.

Fix this by using "#if IS_ENABLED()" instead of "#if defined()".

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -133,7 +133,7 @@ static int stmmac_mdio_write(struct mii_
  */
 int stmmac_mdio_reset(struct mii_bus *bus)
 {
-#if defined(CONFIG_STMMAC_PLATFORM)
+#if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	unsigned int mii_address = priv->hw->mii.addr;


