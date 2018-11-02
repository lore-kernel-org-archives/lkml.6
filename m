Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F03DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AE72082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ywJYAxdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AE72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbeKCEA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7AC2082D;
        Fri,  2 Nov 2018 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184733;
        bh=/VlMrkuU6cyCS9dPFsooo/ILwPim1mJMrETBqZ7ZLbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywJYAxdXI8+OzOMy1ZuCMYjwiVmu+7REUTUd2s0qolMIYJgnqep7gRmBkeADCP2hc
         srbBxhla3gZrn7NuCfYyAO43NvtYSNOrogmj8xo9FSuOthcjZhjc4/ay8VGNa5BzBU
         P0GJUeyOcXWPXZV8K3DTFJ245CZxDQ73CxPQXjzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/143] lan78xx: Dont reset the interface on open
Date:   Fri,  2 Nov 2018 19:34:28 +0100
Message-Id: <20181102182904.260414847@linuxfoundation.org>
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
 drivers/net/usb/lan78xx.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2508,10 +2508,6 @@ static int lan78xx_open(struct net_devic
 	if (ret < 0)
 		goto out;
 
-	ret = lan78xx_reset(dev);
-	if (ret < 0)
-		goto done;
-
 	phy_start(net->phydev);
 
 	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");


