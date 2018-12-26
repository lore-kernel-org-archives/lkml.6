Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E64C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271C42190B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864914;
	bh=FxPu5bDpcqLY3VoyhCwSTAuRVZ/2sR+WDC1ILZl6ztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLFp3Q0T2tOeqAuxjHBP5tOwuy1l1Y14N1dzQgA/AOgExqE2arMUXajK1roJyh1ym
	 +v/FJPKjhj9W/LOmncTUkOALdsOuse6BMVRgEqPVroOT9LlQMRBQpYmjtAzF5eBA/N
	 pBJUUHxJ/2pDmiLaZiDm8ZS1WXBNNmKBq1QphI0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeLZWy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbeLZWyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B5A21741;
        Wed, 26 Dec 2018 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864893;
        bh=FxPu5bDpcqLY3VoyhCwSTAuRVZ/2sR+WDC1ILZl6ztk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7oBEzXcCL1hBiXadH2K7wBZOrlEsnTsCCt7v/gusX0vyi24IR2bxemT5wn79G4vk
         SIIqpX+697t8+LU29cfHJ4PFqGrMXVcy6ccCZQxb6trCVWNlW/3eP9BRIS/gGxS/go
         +eqGRX+374BhfcFCn7JuG+1hpJEjr8Ee0CfaYG9k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Martinsen <jasonmartinsen@msn.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 31/35] lan78xx: Resolve issue with changing MAC address
Date:   Wed, 26 Dec 2018 17:41:38 -0500
Message-Id: <20181226224142.150866-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Martinsen <jasonmartinsen@msn.com>

[ Upstream commit 15515aaaa69659c502003926a2067ee76176148a ]

Current state for the lan78xx driver does not allow for changing the
MAC address of the interface, without either removing the module (if
you compiled it that way) or rebooting the machine.  If you attempt to
change the MAC address, ifconfig will show the new address, however,
the system/interface will not respond to any traffic using that
configuration.  A few short-term options to work around this are to
unload the module and reload it with the new MAC address, change the
interface to "promisc", or reboot with the correct configuration to
change the MAC.

This patch enables the ability to change the MAC address via fairly normal means...
ifdown <interface>
modify entry in /etc/network/interfaces OR a similar method
ifup <interface>
Then test via any network communication, such as ICMP requests to gateway.

My only test platform for this patch has been a raspberry pi model 3b+.

Signed-off-by: Jason Martinsen <jasonmartinsen@msn.com>

-----

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 6b4e38105b72..e143a7fe9320 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2014,6 +2014,10 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
 	ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
 	ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 
+	/* Added to support MAC address changes */
+	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+
 	return 0;
 }
 
-- 
2.19.1

