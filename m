Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E6208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1E6208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbeHWM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:55 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC440CA0;
        Thu, 23 Aug 2018 09:01:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 246/324] sfp: fix module initialisation with netdev already up
Date:   Thu, 23 Aug 2018 09:55:12 +0200
Message-Id: <20180823075008.384354832@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 576cd32082351620a4e76b8babc4d5ae9b4bbb98 ]

It was been observed that with a particular order of initialisation,
the netdev can be up, but the SFP module still has its TX_DISABLE
signal asserted.  This occurs when the network device brought up before
the SFP kernel module has been inserted by userspace.

This occurs because sfp-bus layer does not hear about the change in
network device state, and so assumes that it is still down.  Set
netdev->sfp when the upstream is registered to work around this problem.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -349,7 +349,6 @@ static int sfp_register_bus(struct sfp_b
 	}
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
-	bus->netdev->sfp_bus = bus;
 	bus->registered = true;
 	return 0;
 }
@@ -364,7 +363,6 @@ static void sfp_unregister_bus(struct sf
 		if (bus->phydev && ops && ops->disconnect_phy)
 			ops->disconnect_phy(bus->upstream);
 	}
-	bus->netdev->sfp_bus = NULL;
 	bus->registered = false;
 }
 
@@ -440,6 +438,7 @@ static void sfp_upstream_clear(struct sf
 {
 	bus->upstream_ops = NULL;
 	bus->upstream = NULL;
+	bus->netdev->sfp_bus = NULL;
 	bus->netdev = NULL;
 }
 
@@ -468,6 +467,7 @@ struct sfp_bus *sfp_register_upstream(st
 		bus->upstream_ops = ops;
 		bus->upstream = upstream;
 		bus->netdev = ndev;
+		ndev->sfp_bus = bus;
 
 		if (bus->sfp) {
 			ret = sfp_register_bus(bus);


