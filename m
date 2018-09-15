Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03252ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8B620881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 07:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fydtXztW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIOMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 08:50:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38966 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 08:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mP32TR68+i+MS8dCnnMv1EiTvStTCuZNB51njvg4V0g=; b=fydtXztWghVRpXneas5lHCJm8
        bWh50Km/DFHf95jE1uu+/LrZh9UXBYTHCflfRiVsmaD9ZPLMml+VyKCt51Tm88XPomShI5DwLPy43
        aF9C68DxGMiZiChXNornVB5Cvi7VzN3axo5YgAeKGTW8hbEYhVASiiMMMiap5OZ9jK6Fo=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:60858)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g154C-0003c6-Qg; Sat, 15 Sep 2018 08:32:32 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g154A-00086o-71; Sat, 15 Sep 2018 08:32:30 +0100
Date:   Sat, 15 Sep 2018 08:32:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: sfp: Prevent NULL deference of socket_ops
Message-ID: <20180915073228.GE30658@n2100.armlinux.org.uk>
References: <20180914230132.23228-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914230132.23228-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:01:31PM -0700, Florian Fainelli wrote:
> In case we have specified a SFP and an I2C phandle in the Device Tree,
> but we somehow failed to look up the I2C adapter (e.g: the driver is not
> enabled), we will leave dangling socket_ops, and the sfp_bus will still
> have been registered. We can then observe NULL pointer dereferences
> while doing ethtool -m:
> 
> [   20.218613] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [   20.226977] pgd = (ptrval)
> [   20.229785] [00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
> [   20.236274] Internal error: Oops: 17 [#1] SMP ARM
> [   20.241122] Modules linked in:
> [   20.244278] CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
> [   20.251013] Hardware name: Broadcom Northstar Plus SoC
> [   20.256316] PC is at sfp_get_module_info+0x8/0x10
> [   20.261172] LR is at dev_ethtool+0x218c/0x2afc
> 
> Specifically guard against that.

The other alternative to this would be to only set ndev->sfp_bus when
the bus moves to registered state, which would probably be a saner
alternative than to add an additional layer of tests.  IOW:

 drivers/net/phy/sfp-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 48ca980f5c96..c4c2b5269216 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -362,6 +362,7 @@ static int sfp_register_bus(struct sfp_bus *bus)
 	}
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
+	bus->netdev->sfp_bus = bus;
 	bus->registered = true;
 	return 0;
 }
@@ -370,6 +371,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 {
 	const struct sfp_upstream_ops *ops = bus->upstream_ops;
 
+	bus->netdev->sfp_bus = NULL;
 	if (bus->registered) {
 		if (bus->started)
 			bus->socket_ops->stop(bus->sfp);
@@ -451,7 +453,6 @@ static void sfp_upstream_clear(struct sfp_bus *bus)
 {
 	bus->upstream_ops = NULL;
 	bus->upstream = NULL;
-	bus->netdev->sfp_bus = NULL;
 	bus->netdev = NULL;
 }
 
@@ -480,7 +481,6 @@ struct sfp_bus *sfp_register_upstream(struct fwnode_handle *fwnode,
 		bus->upstream_ops = ops;
 		bus->upstream = upstream;
 		bus->netdev = ndev;
-		ndev->sfp_bus = bus;
 
 		if (bus->sfp) {
 			ret = sfp_register_bus(bus);

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
