Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24582146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS6E6qvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBAWIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36546 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfBAWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so3888373pfc.3;
        Fri, 01 Feb 2019 14:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+T17e/diI+UiXLEq42atmBhalipvIFURLEZX7VprqE=;
        b=RS6E6qvrnOpEaP08PWRhkUXtx+fZBzOSLxkmBGNKRl7wGLlaPAeI7jwk4JH6me8HkO
         uA9FGSq9Zyu7N5TV1LNn7qhGHU6Zzvi5bPnBbPvo6TIQuUickHUUUwzQys8I+zfWYMW7
         w+/pF10mK3aBEmT4kbDscd6YkY0K6Z+qrTshpkOFjS/TJSvMQJiCSQNEO0ed6iKFynWo
         rF4dy9fz9krQqM7D11nb018IKg6XxfBjpW6c2zlsYHWmFUJJ+eDio0hZ0SiudVDs/Vf7
         PHW+YnGRcxnPncKG5E2I6jNTpas8FaQAFtgRIcYZLioNCbLgYDPuwbAFpUKEJIrfyqxr
         wMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+T17e/diI+UiXLEq42atmBhalipvIFURLEZX7VprqE=;
        b=Kf2TKk15ucCEiGgB0HGKRQNQc2FZkkLeMnV/4YXvWrE4K6qzkmgjuR9T3nwzVVxRGy
         P/8qztEtFlTAlECGeHInv6jl7EHn4dPoVNKcZ2ggXpedwFPzhux2sbk7/URo8wUyYLcd
         ouC7MB3HFajy2Ah0QZ8nNT7PG0xe0doO5leXjc549voWh1b7xbWVR2iOhRw9r0TLGhbT
         9ZY6+t1eTr/72EeJ8ZKS9tGAoZyAtK6AT2OqIBgDqKPSEdUzwFCGKaXKUfQCZaZjcy/V
         PuSNBoit6y89/D3Pg4mvGUwBQRYY1uReaftFqJ9mvvvCn1UX7Vt6HktNPvI/kMSRLb88
         bn4w==
X-Gm-Message-State: AJcUukebkDZGSLM862jOwoJKuSBJ23c6Ed0o3Epsi9Wkr2SWVBLnMt4x
        MIOwiJbNbLczGfYwFqbxfXNdYP66
X-Google-Smtp-Source: ALg8bN5LNNL0Dhaq4dEfmya15TWqj0PF4bPO1oBAszIt2yI6kn1qUWF+udsnIcTYsLYRFo/ujk2q0w==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr41500977pfd.56.1549058897139;
        Fri, 01 Feb 2019 14:08:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:16 -0800 (PST)
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
Subject: [RFC net-next 07/13] bnxt: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:51 -0800
Message-Id: <20190201220657.30170-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare bnxt to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
switchdev_ops::switchdev_port_attr_get operation.

We register a single blocking switchdev notifier for the entire driver
instance and we differentiate a PF from a VF by comparing the network
device's netdev_ops with the ones that this driver manages.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 58 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h |  8 +++
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6a512871176b..c3178ca4a004 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10045,6 +10045,45 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_get_phys_port_name = bnxt_get_phys_port_name
 };
 
+static int bnxt_swdev_port_attr_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	if (bnxt_dev_is_vf_rep(dev))
+		rc = bnxt_vf_rep_port_attr_get(dev, port_attr_info->attr);
+	else
+		rc = bnxt_port_attr_get(netdev_priv(dev), port_attr_info->attr);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(rc);
+}
+
+static int bnxt_switchdev_blocking_event(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	if (dev->netdev_ops != &bnxt_netdev_ops &&
+	    !bnxt_dev_is_vf_rep(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return bnxt_swdev_port_attr_event(event, dev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block bnxt_swdev_blocking_nb = {
+	.notifier_call = bnxt_switchdev_blocking_event,
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -10817,8 +10856,24 @@ static struct pci_driver bnxt_pci_driver = {
 
 static int __init bnxt_init(void)
 {
+	int rc;
+
 	bnxt_debug_init();
-	return pci_register_driver(&bnxt_pci_driver);
+	rc = register_switchdev_blocking_notifier(&bnxt_swdev_blocking_nb);
+	if (rc)
+		goto err_debug;
+
+	rc = pci_register_driver(&bnxt_pci_driver);
+	if (rc)
+		goto err_unreg_notifier;
+
+	return rc;
+
+err_unreg_notifier:
+	unregister_switchdev_notifier(&bnxt_swdev_blocking_nb);
+err_debug:
+	bnxt_debug_exit();
+	return rc;
 }
 
 static void __exit bnxt_exit(void)
@@ -10826,6 +10881,7 @@ static void __exit bnxt_exit(void)
 	pci_unregister_driver(&bnxt_pci_driver);
 	if (bnxt_pf_wq)
 		destroy_workqueue(bnxt_pf_wq);
+	unregister_switchdev_notifier(&bnxt_swdev_blocking_nb);
 	bnxt_debug_exit();
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 9a25c05aa571..a06f93b49dd5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -237,8 +237,8 @@ static void bnxt_vf_rep_get_drvinfo(struct net_device *dev,
 	strlcpy(info->version, DRV_MODULE_VERSION, sizeof(info->version));
 }
 
-static int bnxt_vf_rep_port_attr_get(struct net_device *dev,
-				     struct switchdev_attr *attr)
+int bnxt_vf_rep_port_attr_get(struct net_device *dev,
+			      struct switchdev_attr *attr)
 {
 	struct bnxt_vf_rep *vf_rep = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h
index d7287651422f..ba24ac222182 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h
@@ -32,6 +32,8 @@ bool bnxt_dev_is_vf_rep(struct net_device *dev);
 int bnxt_dl_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int bnxt_dl_eswitch_mode_set(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
+int bnxt_vf_rep_port_attr_get(struct net_device *dev,
+			      struct switchdev_attr *attr);
 
 #else
 
@@ -61,5 +63,11 @@ static inline bool bnxt_dev_is_vf_rep(struct net_device *dev)
 {
 	return false;
 }
+
+static inline int bnxt_vf_rep_port_attr_get(struct net_device *dev,
+					    struct switchdev_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BNXT_SRIOV */
 #endif /* BNXT_VFR_H */
-- 
2.17.1

