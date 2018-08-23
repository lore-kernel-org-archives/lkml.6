Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B730C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E355208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E355208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeHWM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:52 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC6D5CA5;
        Thu, 23 Aug 2018 09:01:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 245/324] sfp: ensure we clean up properly on bus registration failure
Date:   Thu, 23 Aug 2018 09:55:11 +0200
Message-Id: <20180823075008.336423824@linuxfoundation.org>
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

[ Upstream commit f20a4c46b984331a509528fa2b84125c617ef98b ]

We fail to correctly clean up after a bus registration failure, which
can lead to an incorrect assumption about the registration state of
the upstream or sfp cage.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -436,6 +436,13 @@ void sfp_upstream_stop(struct sfp_bus *b
 }
 EXPORT_SYMBOL_GPL(sfp_upstream_stop);
 
+static void sfp_upstream_clear(struct sfp_bus *bus)
+{
+	bus->upstream_ops = NULL;
+	bus->upstream = NULL;
+	bus->netdev = NULL;
+}
+
 /**
  * sfp_register_upstream() - Register the neighbouring device
  * @fwnode: firmware node for the SFP bus
@@ -462,8 +469,11 @@ struct sfp_bus *sfp_register_upstream(st
 		bus->upstream = upstream;
 		bus->netdev = ndev;
 
-		if (bus->sfp)
+		if (bus->sfp) {
 			ret = sfp_register_bus(bus);
+			if (ret)
+				sfp_upstream_clear(bus);
+		}
 		rtnl_unlock();
 	}
 
@@ -488,8 +498,7 @@ void sfp_unregister_upstream(struct sfp_
 	rtnl_lock();
 	if (bus->sfp)
 		sfp_unregister_bus(bus);
-	bus->upstream = NULL;
-	bus->netdev = NULL;
+	sfp_upstream_clear(bus);
 	rtnl_unlock();
 
 	sfp_bus_put(bus);
@@ -561,6 +570,13 @@ void sfp_module_remove(struct sfp_bus *b
 }
 EXPORT_SYMBOL_GPL(sfp_module_remove);
 
+static void sfp_socket_clear(struct sfp_bus *bus)
+{
+	bus->sfp_dev = NULL;
+	bus->sfp = NULL;
+	bus->socket_ops = NULL;
+}
+
 struct sfp_bus *sfp_register_socket(struct device *dev, struct sfp *sfp,
 				    const struct sfp_socket_ops *ops)
 {
@@ -573,8 +589,11 @@ struct sfp_bus *sfp_register_socket(stru
 		bus->sfp = sfp;
 		bus->socket_ops = ops;
 
-		if (bus->netdev)
+		if (bus->netdev) {
 			ret = sfp_register_bus(bus);
+			if (ret)
+				sfp_socket_clear(bus);
+		}
 		rtnl_unlock();
 	}
 
@@ -592,9 +611,7 @@ void sfp_unregister_socket(struct sfp_bu
 	rtnl_lock();
 	if (bus->netdev)
 		sfp_unregister_bus(bus);
-	bus->sfp_dev = NULL;
-	bus->sfp = NULL;
-	bus->socket_ops = NULL;
+	sfp_socket_clear(bus);
 	rtnl_unlock();
 
 	sfp_bus_put(bus);


