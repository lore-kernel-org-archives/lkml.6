Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED1C2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWQtqjFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBAWIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40762 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBAWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3556202pgp.7;
        Fri, 01 Feb 2019 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=04O41FbtAgkXOgQua67kjcOBDU2UbpbkCof4gdxmXAg=;
        b=DWQtqjFAp/EFRXjtzJVijfxL13hxzWPXWrXn8AMdh1vyBc1ShDgTwc79WI02XMCGRL
         Rg2To9T44DeIQ9WNVidzBkLc+Sib3i9TDiAwcKVyjvxM3Eb8IgTHLV59l4m48q5PhGMi
         o1EtQQ8fBDchlWfLBpbXH7TKJ/f75H3n68X4gCVemI08pIhJy1DK8E2BSt1V86/kRtK5
         ylLDKTDRI7LkKf9vJilxyMSJTTjJ+se5vGBSLLXFpNI0bAjfeRVi3eXBBsg76PNXqbYD
         //VsG+zo4/WmBB5owVmeTkyY4jvRusdk03qoKoebhJsFMgM+Vkmume+FRdA56yCvgLaU
         HJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=04O41FbtAgkXOgQua67kjcOBDU2UbpbkCof4gdxmXAg=;
        b=piBLAmPCpuv9gzgQt+xcbHN0c/6+g48lenipFY4R3xhfbG3FxdMF126Pq6bMhS2REc
         pwpNZ2JX+eEpktmcgAXCMLviXqxvzvmjbdXUQOFrc6O+wShXbYLqtIC+zuZcZ1Ds+cO/
         SWkZ09664N935SgJU2HjqxO7WYFLA0OESrN5QO2fpiO9ApHM3WrtgsSB5AZNjYxPSalV
         3RNGi2+8Bn1C8EOF6PLCTyB2Fy3BHXDtgOQ7XR8xtILe2ORdkZsWFFK82cosXniS66Gu
         2Zlr/j4WTyg2fvwBgTW3h6fA99y5kfB4QzbGPicaQSiIgk6x2HUTxcppqOUjOmWRrj28
         DkaA==
X-Gm-Message-State: AHQUAubTyz2Zaf6bELRBQVNAFVd/U2QglbLbIe2mEXZ8BxqU9Wkn0QBS
        j8pc3oH+VD1i4NdXlxjFoEYxrWxG
X-Google-Smtp-Source: AHgI3IZx/LHZM1kP2e/f5uUHasGGpzGyT/o0sSwpNXNITurE8NKtBwUeri8CfQR0MDSFljjLyODWNg==
X-Received: by 2002:a63:5320:: with SMTP id h32mr3980916pgb.414.1549058909880;
        Fri, 01 Feb 2019 14:08:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [RFC net-next 12/13] netdevsim: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:56 -0800
Message-Id: <20190201220657.30170-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare netdevsim to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
switchdev_ops::switchdev_port_attr_get operation.

We register a single blocking switchdev notifier for the entire driver
instance.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 43 +++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8d8e2b3f263e..817d94cec90f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -168,6 +168,20 @@ static const struct switchdev_ops nsim_switchdev_ops = {
 	.switchdev_port_attr_get	= nsim_port_attr_get,
 };
 
+static int nsim_switchdev_port_attr_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = nsim_port_attr_get(dev, port_attr_info->attr);
+	port_attr_info->handled = true;
+	return notifier_from_errno(rc);
+}
+
 static int nsim_init(struct net_device *dev)
 {
 	char sdev_ddir_name[10], sdev_link_name[32];
@@ -495,6 +509,26 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_bpf		= nsim_bpf,
 };
 
+static int nsim_swdev_blocking_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	if (dev->netdev_ops != &nsim_netdev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return nsim_switchdev_port_attr_event(event, dev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nsim_swdev_blocking_nb = {
+	.notifier_call = nsim_swdev_blocking_event,
+};
+
 static void nsim_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -583,10 +617,14 @@ static int __init nsim_module_init(void)
 		goto err_debugfs_destroy;
 	}
 
-	err = bus_register(&nsim_bus);
+	err = register_switchdev_blocking_notifier(&nsim_swdev_blocking_nb);
 	if (err)
 		goto err_sdir_destroy;
 
+	err = bus_register(&nsim_bus);
+	if (err)
+		goto err_unreg_notifier;
+
 	err = nsim_devlink_init();
 	if (err)
 		goto err_unreg_bus;
@@ -601,6 +639,8 @@ static int __init nsim_module_init(void)
 	nsim_devlink_exit();
 err_unreg_bus:
 	bus_unregister(&nsim_bus);
+err_unreg_notifier:
+	unregister_switchdev_blocking_notifier(&nsim_swdev_blocking_nb);
 err_sdir_destroy:
 	debugfs_remove_recursive(nsim_sdev_ddir);
 err_debugfs_destroy:
@@ -613,6 +653,7 @@ static void __exit nsim_module_exit(void)
 	rtnl_link_unregister(&nsim_link_ops);
 	nsim_devlink_exit();
 	bus_unregister(&nsim_bus);
+	unregister_switchdev_blocking_notifier(&nsim_swdev_blocking_nb);
 	debugfs_remove_recursive(nsim_sdev_ddir);
 	debugfs_remove_recursive(nsim_ddir);
 }
-- 
2.17.1

