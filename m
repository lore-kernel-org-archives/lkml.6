Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E96C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDEB20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xBBdGp0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDEB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJYWoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05E220869;
        Thu, 25 Oct 2018 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476702;
        bh=/eFXsTEA2fxE0zFLjCH0fQoAEkEPbIMyq2sWv2ZakH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBBdGp0t4BAOeHtx0nW07e4VWyLeAH/ncg8xwsh2aGI3ZWL/WgigKVinqJVRzK2xz
         TpjT85RtSuxLcvvsyzl2VgdBffjaJHlry7VsU7fc3lLdq/a+oiuNIxlKxmCmhFAOtX
         44qyyn67sN9eW2T3azmfjjL6NqlvqbXhXoMjyKvU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 34/46] lan78xx: Don't reset the interface on open
Date:   Thu, 25 Oct 2018 10:10:41 -0400
Message-Id: <20181025141053.213330-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

[ Upstream commit 47b998653fea4ef69e3e89574956386f262bccca ]

Commit 92571a1aae40 ("lan78xx: Connect phy early") moves the PHY
initialisation into lan78xx_probe, but lan78xx_open subsequently calls
lan78xx_reset. As well as forcing a second round of link negotiation,
this reset frequently prevents the phy interrupt from being generated
(even though the link is up), rendering the interface unusable.

Fix this issue by removing the lan78xx_reset call from lan78xx_open.

Fixes: 92571a1aae40 ("lan78xx: Connect phy early")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 9e3f632e22f1..a090112880fd 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2517,10 +2517,6 @@ static int lan78xx_open(struct net_device *net)
 	if (ret < 0)
 		goto out;
 
-	ret = lan78xx_reset(dev);
-	if (ret < 0)
-		goto done;
-
 	phy_start(net->phydev);
 
 	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
-- 
2.17.1

