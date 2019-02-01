Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E864D2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJFqFjju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfBAWI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44091 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfBAWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so610348plq.11;
        Fri, 01 Feb 2019 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVEHNsHDA6/vqXNVWaoWZR+03PraIBRPRrx8fH+NeCo=;
        b=mJFqFjjuzY+1JIDU4W1Y7VyHLJHhHNL+L1/NMxmkxrctXpmVv6h3dS78wORdiHDPwx
         2AKPJlKirGulu+apviWMEvMETGli+1mg6XW3XL44DBIRDdcA4ocRlC/TKMHy5sLbNYUy
         gc1cMW3Jy0AQwi8Si3eBx8tSm+d6irOjrjd2lbpoVgH+wSqC79GAEHX4fVsLjCEepnun
         ZYEc9faiolGUwJM1I+AWcHLx09wRELEY8SfCXXw02sBwsWVWdfNHJwOaYN7NUZiK/RDI
         hQ/BV2aeOdoCKw3fvqAkh/o6/BEUHU9MnLMOQLiWS7zKnG6ZuAtiIgJe7tz3/RqgyloL
         E5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVEHNsHDA6/vqXNVWaoWZR+03PraIBRPRrx8fH+NeCo=;
        b=P1iWoD+2+iujRpOr9OdVtDmOnoGQlx8s8PT0Ab9g0QFfh1UFzbL4JHn0t33yaAT9l3
         W3oGvLgnVsUYRrLI8C8Hu+WxJdVIY46du0gbWdNPyGtkVX0XYkAJerMI4YO2nMF0O56M
         vw1+i1/Ten2VcToCfgtrB50QeaQzocSZXiH30vzgkiUpBWSn4xVc0FqO+H0rlHF96P4B
         myA92ThqR4S6msfos37MK4xZCVqdnETsdyGWQiGzU0+y5yI9ffboQnzlKIpKqnL4UYtG
         l3vrQS4oe5Kiy6oygd4CSS8OZT9FhnCeO1u1WIvrW5Qfw9ZhjjUh25O+PEYuZR25Svfd
         /zvg==
X-Gm-Message-State: AJcUukex5xaX9shq0UAnD90GkMZXeaRJQuHIxtnlw57XlzR3VKwgIsVx
        6cJOWqsvbgnQgqci5oCj6opeMKTZ
X-Google-Smtp-Source: ALg8bN7czyIItSX6mC+lYi9u4WKeOO+wZqlrtggBXdhwSnQuaF8wHMVnd+3G9mdgxGKqqVGxx5ewFw==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr42017462plk.291.1549058902123;
        Fri, 01 Feb 2019 14:08:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:21 -0800 (PST)
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
Subject: [RFC net-next 09/13] mlxsw: switchx2: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:53 -0800
Message-Id: <20190201220657.30170-10-f.fainelli@gmail.com>
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
instance and check that thet network device maps to the one that
switchx2 manages.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
index 2d4f213e154d..82fb8f1bb6e9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
@@ -923,6 +923,36 @@ static const struct switchdev_ops mlxsw_sx_port_switchdev_ops = {
 	.switchdev_port_attr_get	= mlxsw_sx_port_attr_get,
 };
 
+static int mlxsw_sx_port_attr_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = mlxsw_sx_port_attr_get(dev, port_attr_info->attr);
+	port_attr_info->handled = true;
+	return notifier_from_errno(rc);
+}
+
+static int mlxsw_sx_swdev_blocking_event(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	if (dev->netdev_ops != &mlxsw_sx_port_netdev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return mlxsw_sx_port_attr_event(event, dev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int mlxsw_sx_hw_id_get(struct mlxsw_sx *mlxsw_sx)
 {
 	char spad_pl[MLXSW_REG_SPAD_LEN] = {0};
@@ -1638,6 +1668,10 @@ static void mlxsw_sx_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sx_ports_remove(mlxsw_sx);
 }
 
+static struct notifier_block mlxsw_sx_swdev_nb = {
+	.notifier_call	= mlxsw_sx_swdev_blocking_event,
+};
+
 static const struct mlxsw_config_profile mlxsw_sx_config_profile = {
 	.used_max_vepa_channels		= 1,
 	.max_vepa_channels		= 0,
@@ -1698,10 +1732,14 @@ static int __init mlxsw_sx_module_init(void)
 {
 	int err;
 
-	err = mlxsw_core_driver_register(&mlxsw_sx_driver);
+	err = register_switchdev_blocking_notifier(&mlxsw_sx_swdev_nb);
 	if (err)
 		return err;
 
+	err = mlxsw_core_driver_register(&mlxsw_sx_driver);
+	if (err)
+		goto err_unregister_notifier;
+
 	err = mlxsw_pci_driver_register(&mlxsw_sx_pci_driver);
 	if (err)
 		goto err_pci_driver_register;
@@ -1710,6 +1748,8 @@ static int __init mlxsw_sx_module_init(void)
 
 err_pci_driver_register:
 	mlxsw_core_driver_unregister(&mlxsw_sx_driver);
+err_unregister_notifier:
+	unregister_switchdev_blocking_notifier(&mlxsw_sx_swdev_nb);
 	return err;
 }
 
@@ -1717,6 +1757,7 @@ static void __exit mlxsw_sx_module_exit(void)
 {
 	mlxsw_pci_driver_unregister(&mlxsw_sx_pci_driver);
 	mlxsw_core_driver_unregister(&mlxsw_sx_driver);
+	unregister_switchdev_blocking_notifier(&mlxsw_sx_swdev_nb);
 }
 
 module_init(mlxsw_sx_module_init);
-- 
2.17.1

