Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1121C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843C421848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217112;
	bh=ouJCU3hSvGBw9Shyu9jPfg3sukLdeFX9X3wN0VcI4Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KhOQ0XOhyrHozG6lGaVynhTUAppcI80on7Wa0RB9s9pTOvnwAn7KBWI9O2V/0PCzP
	 bvhTuWEqI+PsRmWVQPe7KeKe6V2dxc55ovNhJPt+1MJR+dwReNz7vtIKpO+UYlbXSA
	 lxmcIrKlAWdJgoxEvrLji8KvphtOiPKzEUwZksUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfAKObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389258AbfAKObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E670B2063F;
        Fri, 11 Jan 2019 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217109;
        bh=ouJCU3hSvGBw9Shyu9jPfg3sukLdeFX9X3wN0VcI4Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1x1aAtewCd93FDOV5X4JTfqJmp/iT2fbUKCqkoBnG7/b8V1PnsIcy5PbsCG3+bGJ
         ksHMuTFBzYIjE8g9yNPIaD3ERyrFWxhkDJk6KrxDJyKTM5NasmLF+veRTNZu24FqZu
         fLoludNxcg86rD0zBzZA5zrqwczRPoFYe1cOoqvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Martinsen <jasonmartinsen@msn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 045/105] lan78xx: Resolve issue with changing MAC address
Date:   Fri, 11 Jan 2019 15:14:16 +0100
Message-Id: <20190111131106.894847028@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e069b310d6a6..b62c41114e34 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2212,6 +2212,10 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
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



