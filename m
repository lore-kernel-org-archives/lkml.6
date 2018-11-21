Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98167C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAD02151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwOLZNhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD02151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbeKVFnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 350B9214F1;
        Wed, 21 Nov 2018 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827252;
        bh=yM9+Rdb+K2C5FjyQi3sbcerHhME+6qlPvH/FPR4kLI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwOLZNhRwgaUXfzdbwckzCKpdkmx8wDuylXmRKveCIzBkmzNWpdfPV1x+GUFFNj6h
         omiNdNQp9f05SUhfOah/12OC46oDs/FUU1L96ggZRxrBLJaEbwcBrw19P2JqMvZzrE
         pDfn9/dRK1IxsuCJlnaLaXL8V9wijGLjXGW4OBBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 31/42] net: phy: realtek: fix RTL8201F sysfs name
Date:   Wed, 21 Nov 2018 20:06:07 +0100
Message-Id: <20181121183149.325816438@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Hoffstätte <holger@applied-asynchrony.com>

[ Upstream commit 0432e833191ad4d17b7fc2364941f91dad51db1a ]

Since 4.19 the following error in sysfs has appeared when using the
r8169 NIC driver:

$cd /sys/module/realtek/drivers
$ls -l
ls: cannot access 'mdio_bus:RTL8201F 10/100Mbps Ethernet': No such file or directory
[..garbled dir entries follow..]

Apparently the forward slash in "10/100Mbps Ethernet" is interpreted
as directory separator that leads nowhere, and was introduced in commit
513588dd44b ("net: phy: realtek: add RTL8201F phy-id and functions").

Fix this by removing the offending slash in the driver name.

Other drivers in net/phy seem to have the same problem, but I cannot
test/verify them.

Fixes: 513588dd44b ("net: phy: realtek: add RTL8201F phy-id and functions")
Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -220,7 +220,7 @@ static struct phy_driver realtek_drvs[]
 		.flags          = PHY_HAS_INTERRUPT,
 	}, {
 		.phy_id		= 0x001cc816,
-		.name		= "RTL8201F 10/100Mbps Ethernet",
+		.name		= "RTL8201F Fast Ethernet",
 		.phy_id_mask	= 0x001fffff,
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_HAS_INTERRUPT,


