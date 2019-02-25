Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131293;
	bh=ESUUDWVpMyGgrP6fTjAJuP2uCH9xRXSCpRR6cOICpTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K9rCBXTwIsJdB63lzFTdGxt+Tciqnu5aqA1gwRD/WqvfqmBeQmqxv0NYXPrxGC+E7
	 bvXJcRPfgcGKdvIrDLMXX2ZFPUdfFZlearKTnXQ1yLyauyRSDabjXfXLFr/MkVAyB7
	 7Gj50MlMzxcLoIr3eDqtyTn8OMo1yLpu7SylSQAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfBYV1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbfBYV06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD092084D;
        Mon, 25 Feb 2019 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130017;
        bh=ESUUDWVpMyGgrP6fTjAJuP2uCH9xRXSCpRR6cOICpTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9NqmnEzTtrww5IUyzVlZ9XMXURc4fXEobVSJo4pVUvECB+kNQ/KMwvN7UXESJK4C
         RNkZFVJXk6WUJbeuUt2K6tCfRC+xGUzL9pFNFoe+eoeogOdyU5ibwz/olKkciDkmSE
         HvXEh4S08ne7AR/nDGsrAzVn4V67NqpdEs8aI3a8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 105/152] net: sfp: do not probe SFP module before were attached
Date:   Mon, 25 Feb 2019 22:11:37 +0100
Message-Id: <20190225195050.152825050@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit b5bfc21af5cb3d53f9cee0ef82eaa43762a90f81 ]

When we probe a SFP module, we expect to be able to call the upstream
device's module_insert() function so that the upstream link can be
configured.  However, when the upstream device is delayed, we currently
may end up probing the module before the upstream device is available,
and lose the module_insert() call.

Avoid this by holding off probing the module until the SFP bus is
properly connected to both the SFP socket driver and the upstream
driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    2 ++
 drivers/net/phy/sfp.c     |   30 +++++++++++++++++++++---------
 drivers/net/phy/sfp.h     |    2 ++
 3 files changed, 25 insertions(+), 9 deletions(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -347,6 +347,7 @@ static int sfp_register_bus(struct sfp_b
 				return ret;
 		}
 	}
+	bus->socket_ops->attach(bus->sfp);
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
 	bus->netdev->sfp_bus = bus;
@@ -362,6 +363,7 @@ static void sfp_unregister_bus(struct sf
 	if (bus->registered) {
 		if (bus->started)
 			bus->socket_ops->stop(bus->sfp);
+		bus->socket_ops->detach(bus->sfp);
 		if (bus->phydev && ops && ops->disconnect_phy)
 			ops->disconnect_phy(bus->upstream);
 	}
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -184,6 +184,7 @@ struct sfp {
 
 	struct gpio_desc *gpio[GPIO_MAX];
 
+	bool attached;
 	unsigned int state;
 	struct delayed_work poll;
 	struct delayed_work timeout;
@@ -1475,7 +1476,7 @@ static void sfp_sm_event(struct sfp *sfp
 	 */
 	switch (sfp->sm_mod_state) {
 	default:
-		if (event == SFP_E_INSERT) {
+		if (event == SFP_E_INSERT && sfp->attached) {
 			sfp_module_tx_disable(sfp);
 			sfp_sm_ins_next(sfp, SFP_MOD_PROBE, T_PROBE_INIT);
 		}
@@ -1607,6 +1608,19 @@ static void sfp_sm_event(struct sfp *sfp
 	mutex_unlock(&sfp->sm_mutex);
 }
 
+static void sfp_attach(struct sfp *sfp)
+{
+	sfp->attached = true;
+	if (sfp->state & SFP_F_PRESENT)
+		sfp_sm_event(sfp, SFP_E_INSERT);
+}
+
+static void sfp_detach(struct sfp *sfp)
+{
+	sfp->attached = false;
+	sfp_sm_event(sfp, SFP_E_REMOVE);
+}
+
 static void sfp_start(struct sfp *sfp)
 {
 	sfp_sm_event(sfp, SFP_E_DEV_UP);
@@ -1667,6 +1681,8 @@ static int sfp_module_eeprom(struct sfp
 }
 
 static const struct sfp_socket_ops sfp_module_ops = {
+	.attach = sfp_attach,
+	.detach = sfp_detach,
 	.start = sfp_start,
 	.stop = sfp_stop,
 	.module_info = sfp_module_info,
@@ -1834,10 +1850,6 @@ static int sfp_probe(struct platform_dev
 	dev_info(sfp->dev, "Host maximum power %u.%uW\n",
 		 sfp->max_power_mW / 1000, (sfp->max_power_mW / 100) % 10);
 
-	sfp->sfp_bus = sfp_register_socket(sfp->dev, sfp, &sfp_module_ops);
-	if (!sfp->sfp_bus)
-		return -ENOMEM;
-
 	/* Get the initial state, and always signal TX disable,
 	 * since the network interface will not be up.
 	 */
@@ -1848,10 +1860,6 @@ static int sfp_probe(struct platform_dev
 		sfp->state |= SFP_F_RATE_SELECT;
 	sfp_set_state(sfp, sfp->state);
 	sfp_module_tx_disable(sfp);
-	rtnl_lock();
-	if (sfp->state & SFP_F_PRESENT)
-		sfp_sm_event(sfp, SFP_E_INSERT);
-	rtnl_unlock();
 
 	for (i = 0; i < GPIO_MAX; i++) {
 		if (gpio_flags[i] != GPIOD_IN || !sfp->gpio[i])
@@ -1884,6 +1892,10 @@ static int sfp_probe(struct platform_dev
 		dev_warn(sfp->dev,
 			 "No tx_disable pin: SFP modules will always be emitting.\n");
 
+	sfp->sfp_bus = sfp_register_socket(sfp->dev, sfp, &sfp_module_ops);
+	if (!sfp->sfp_bus)
+		return -ENOMEM;
+
 	return 0;
 }
 
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -7,6 +7,8 @@
 struct sfp;
 
 struct sfp_socket_ops {
+	void (*attach)(struct sfp *sfp);
+	void (*detach)(struct sfp *sfp);
 	void (*start)(struct sfp *sfp);
 	void (*stop)(struct sfp *sfp);
 	int (*module_info)(struct sfp *sfp, struct ethtool_modinfo *modinfo);


