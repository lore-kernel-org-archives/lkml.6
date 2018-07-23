Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B509ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6F220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6F220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeGWNba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:31:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbeGWNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:31:30 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 144F4BDB;
        Mon, 23 Jul 2018 12:30:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Couzens <lynxis@fe80.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 40/44] net: usb: asix: replace mii_nway_restart in resume path
Date:   Mon, 23 Jul 2018 14:25:16 +0200
Message-Id: <20180723122439.349944840@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
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

From: Alexander Couzens <lynxis@fe80.eu>

[ Upstream commit 5c968f48021a9b3faa61ac2543cfab32461c0e05 ]

mii_nway_restart is not pm aware which results in a rtnl deadlock.
Implement mii_nway_restart manual by setting BMCR_ANRESTART if
BMCR_ANENABLE is set.

To reproduce:
* plug an asix based usb network interface
* wait until the device enters PM (~5 sec)
* `ip link set eth1 up` will never return

Fixes: d9fe64e51114 ("net: asix: Add in_pm parameter")
Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/asix_devices.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -642,10 +642,12 @@ static void ax88772_restore_phy(struct u
 				     priv->presvd_phy_advertise);
 
 		/* Restore BMCR */
+		if (priv->presvd_phy_bmcr & BMCR_ANENABLE)
+			priv->presvd_phy_bmcr |= BMCR_ANRESTART;
+
 		asix_mdio_write_nopm(dev->net, dev->mii.phy_id, MII_BMCR,
 				     priv->presvd_phy_bmcr);
 
-		mii_nway_restart(&dev->mii);
 		priv->presvd_phy_advertise = 0;
 		priv->presvd_phy_bmcr = 0;
 	}


