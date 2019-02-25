Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE12173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129497;
	bh=XhLnNTBb5qmumP5EpzxQpfUGZ1jX2syAjN7+zFO0D5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUcZCX0P3S4NWAPTBr9Y3tLUpGtBsHJ4hqOUj9bTk+R/nm4P9NmDP2OrhEg62nJ8g
	 IeGK1g2xmdctwu0B3aF4zS96+JBHx+P5kJl6ED9o4b+QsGo0pt8ufZo7G9apuQdHqb
	 h8zXigz5UI+eaXVI8WdBs+svaT7MVsPYyLwKLUvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfBYVSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbfBYVSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD142173C;
        Mon, 25 Feb 2019 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129492;
        bh=XhLnNTBb5qmumP5EpzxQpfUGZ1jX2syAjN7+zFO0D5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jj34bapCJf1iw+FyvHw1S4hJrrK4oB6uzniefHjH2KHztOotQGR5ssnttYVCJJ7it
         oC3BXytrMdzoEzChNiZP3DCXZLhajzWSDx1e+IAcHMyWLZ0/8mEPbSYo1sLe23RhIj
         GJBJJngizbboiVKzQcDCSxJZCZJYwmyf1jet0gh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 49/71] net: sfp: do not probe SFP module before were attached
Date:   Mon, 25 Feb 2019 22:11:51 +0100
Message-Id: <20190225195038.330164020@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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
@@ -276,6 +276,7 @@ static int sfp_register_bus(struct sfp_b
 				return ret;
 		}
 	}
+	bus->socket_ops->attach(bus->sfp);
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
 	bus->registered = true;
@@ -289,6 +290,7 @@ static void sfp_unregister_bus(struct sf
 	if (bus->registered) {
 		if (bus->started)
 			bus->socket_ops->stop(bus->sfp);
+		bus->socket_ops->detach(bus->sfp);
 		if (bus->phydev && ops && ops->disconnect_phy)
 			ops->disconnect_phy(bus->upstream);
 	}
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -114,6 +114,7 @@ struct sfp {
 
 	struct gpio_desc *gpio[GPIO_MAX];
 
+	bool attached;
 	unsigned int state;
 	struct delayed_work poll;
 	struct delayed_work timeout;
@@ -500,7 +501,7 @@ static void sfp_sm_event(struct sfp *sfp
 	 */
 	switch (sfp->sm_mod_state) {
 	default:
-		if (event == SFP_E_INSERT) {
+		if (event == SFP_E_INSERT && sfp->attached) {
 			sfp_module_tx_disable(sfp);
 			sfp_sm_ins_next(sfp, SFP_MOD_PROBE, T_PROBE_INIT);
 		}
@@ -628,6 +629,19 @@ static void sfp_sm_event(struct sfp *sfp
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
@@ -687,6 +701,8 @@ static int sfp_module_eeprom(struct sfp
 }
 
 static const struct sfp_socket_ops sfp_module_ops = {
+	.attach = sfp_attach,
+	.detach = sfp_detach,
 	.start = sfp_start,
 	.stop = sfp_stop,
 	.module_info = sfp_module_info,
@@ -829,10 +845,6 @@ static int sfp_probe(struct platform_dev
 		sfp->set_state = sfp_gpio_set_state;
 	}
 
-	sfp->sfp_bus = sfp_register_socket(sfp->dev, sfp, &sfp_module_ops);
-	if (!sfp->sfp_bus)
-		return -ENOMEM;
-
 	/* Get the initial state, and always signal TX disable,
 	 * since the network interface will not be up.
 	 */
@@ -843,10 +855,6 @@ static int sfp_probe(struct platform_dev
 		sfp->state |= SFP_F_RATE_SELECT;
 	sfp_set_state(sfp, sfp->state);
 	sfp_module_tx_disable(sfp);
-	rtnl_lock();
-	if (sfp->state & SFP_F_PRESENT)
-		sfp_sm_event(sfp, SFP_E_INSERT);
-	rtnl_unlock();
 
 	for (i = 0; i < GPIO_MAX; i++) {
 		if (gpio_flags[i] != GPIOD_IN || !sfp->gpio[i])
@@ -879,6 +887,10 @@ static int sfp_remove(struct platform_de
 
 	sfp_unregister_socket(sfp->sfp_bus);
 
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


