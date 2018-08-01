Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404939AbeHATFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:05:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404045AbeHATFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:01 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D057CD1;
        Wed,  1 Aug 2018 17:18:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 131/246] net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value
Date:   Wed,  1 Aug 2018 18:50:41 +0200
Message-Id: <20180801165018.003185736@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit c6213eb1aee308e67377fd1890d84f7284caf531 ]

This fixes klockworks warnings: Pointer 'dev' returned from call to
function 'bus_find_device' at line 179 may be NULL and will be dereferenced
at line 181.

    cpsw-phy-sel.c:179: 'dev' is assigned the return value from function 'bus_find_device'.
    bus.c:342: 'bus_find_device' explicitly returns a NULL value.
    cpsw-phy-sel.c:181: 'dev' is dereferenced by passing argument 1 to function 'dev_get_drvdata'.
    device.h:1024: 'dev' is passed to function 'dev_get_drvdata'.
    device.h:1026: 'dev' is explicitly dereferenced.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[nsekhar@ti.com: add an error message, fix return path]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -177,12 +177,18 @@ void cpsw_phy_sel(struct device *dev, ph
 	}
 
 	dev = bus_find_device(&platform_bus_type, NULL, node, match);
-	of_node_put(node);
+	if (!dev) {
+		dev_err(dev, "unable to find platform device for %pOF\n", node);
+		goto out;
+	}
+
 	priv = dev_get_drvdata(dev);
 
 	priv->cpsw_phy_sel(priv, phy_mode, slave);
 
 	put_device(dev);
+out:
+	of_node_put(node);
 }
 EXPORT_SYMBOL_GPL(cpsw_phy_sel);
 


