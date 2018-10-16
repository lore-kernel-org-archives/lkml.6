Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9337420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3llPpK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9337420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeJQBFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6187D20866;
        Tue, 16 Oct 2018 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710039;
        bh=oyzVHra+OcCSA7yj3/rWQ02MgjbIAxdI/TSnDpRoaCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3llPpK+5yIFk6PSeWFGjZjpnlp1reu4zpMehbX6UwUuBM7Laq5DvonEx043YIW2E
         xcmlkr5Mcnosdb4WlMR2lDyOBs8cOcMjSU2FlDnZhlqPmvuuaI62kQ8xzP7u02xyKz
         K/DV62f7GUGksuXBb2Mma2n0opJByxFFG5yOh0OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 046/135] sfp: fix oops with ethtool -m
Date:   Tue, 16 Oct 2018 19:04:36 +0200
Message-Id: <20181016170517.917484649@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 126d6848ef13958e1cb959e96c21d19bc498ade9 ]

If a network interface is created prior to the SFP socket being
available, ethtool can request module information.  This unfortunately
leads to an oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = (ptrval)
[00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
Hardware name: Broadcom Northstar Plus SoC
PC is at sfp_get_module_info+0x8/0x10
LR is at dev_ethtool+0x218c/0x2afc

Fix this by not filling in the network device's SFP bus pointer until
SFP is fully bound, thereby avoiding the core calling into the SFP bus
code.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -349,6 +349,7 @@ static int sfp_register_bus(struct sfp_b
 	}
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
+	bus->netdev->sfp_bus = bus;
 	bus->registered = true;
 	return 0;
 }
@@ -357,6 +358,7 @@ static void sfp_unregister_bus(struct sf
 {
 	const struct sfp_upstream_ops *ops = bus->upstream_ops;
 
+	bus->netdev->sfp_bus = NULL;
 	if (bus->registered) {
 		if (bus->started)
 			bus->socket_ops->stop(bus->sfp);
@@ -438,7 +440,6 @@ static void sfp_upstream_clear(struct sf
 {
 	bus->upstream_ops = NULL;
 	bus->upstream = NULL;
-	bus->netdev->sfp_bus = NULL;
 	bus->netdev = NULL;
 }
 
@@ -467,7 +468,6 @@ struct sfp_bus *sfp_register_upstream(st
 		bus->upstream_ops = ops;
 		bus->upstream = upstream;
 		bus->netdev = ndev;
-		ndev->sfp_bus = bus;
 
 		if (bus->sfp) {
 			ret = sfp_register_bus(bus);


