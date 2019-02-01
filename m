Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8682146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6KzAO+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfBAWId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40759 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfBAWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3556161pgp.7;
        Fri, 01 Feb 2019 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWtHrAlD/PuoBaMP5Yacl9yw0RDRTuKpO9kH1XLTeNg=;
        b=X6KzAO+3EiAaIB+E+D/zBPdFOZHti5dUNmhAUtSAhPvajk89ieumQr8YIsojKRffNT
         LDFoL872dhZqMyjAPq1HqlgCgbOhUTM78s9bX1QVXpLljThCsu6WiwreqHxhVBvuctPv
         zJ63TSJskDj2Oe1h54DEjsUqPHsT7j0QOkJfnKfWRoism9EdJ4pTNgBj+rgMZ4Aly+qz
         UN9HSAcGp24cWt9EM1war4touzwM2M6qawTinbAM7OfhL84XmpOINz1jTfsl2XoM9slg
         1i2AzFIx9K6XVFarMw+1d3oQthfKlPfHqZZGnkmwGYaVDpnZPapCI9OADV3vWnpKUC/v
         S4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWtHrAlD/PuoBaMP5Yacl9yw0RDRTuKpO9kH1XLTeNg=;
        b=dVHNQQwe6FQoRjrWFeASkNvE2/5rVSRxdb1UBUUrcD0pYXb7bHL+Tdb9SGKqMEQevg
         p1/65KC4nNgW+hrivaV1klSE+aVjZm3czuDzaBxZ979/bxnWUEspxoR/5k+pHN8gBM5n
         Zhnwdig9P7ohpx6POVBK3lBKV89+wfXQlo0vmeN+xKRAHYPM+1Ih7J7Jm/QIP533BrGt
         Zu7e5k4Pnv7ld6yzMcybGVbhG2Et7cs3oredIe3StCG6qqru1K0zGBAvQL8LPhxrOWps
         SSFcGsmg30J4eojgxqPOZty2GGRpMYruzEE3k0RJWAdrTaVKzeNf/p1rk7HvVdR4nVQI
         w0mg==
X-Gm-Message-State: AJcUukeC3RlzmJ9IiafO40AKZ1XCHZ+mh3CoFr7TqTozN/qDMed2bk1S
        VnZXxgBtrhTaqRLeMJWsn5iqaflf
X-Google-Smtp-Source: ALg8bN7dZc8Ee/XVx2Rpmpd5JiP+yRwQ1p8ynfhNaejdlnVy9IfbNPYlt2BjbmcWLuFp6/Q68UOCsg==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr40722350pfg.74.1549058907164;
        Fri, 01 Feb 2019 14:08:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:26 -0800 (PST)
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
Subject: [RFC net-next 11/13] nfp: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:55 -0800
Message-Id: <20190201220657.30170-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare nfp to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
switchdev_ops::switchdev_port_attr_get operation.

We register a single blocking switchdev notifier for the entire driver
instance and we differentiate a "net" from a "repr" by comparing the
network device's netdev_ops with the ones that this driver manages.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c   | 14 +++++++++++++-
 drivers/net/ethernet/netronome/nfp/nfp_net.h    |  3 +++
 .../net/ethernet/netronome/nfp/nfp_net_common.c | 17 +++++++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_port.c   | 15 +++++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_port.h   |  5 ++++-
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 6c10e8d119e4..50c111280cd4 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -17,6 +17,7 @@
 #include <linux/vermagic.h>
 #include <linux/vmalloc.h>
 #include <net/devlink.h>
+#include <net/switchdev.h>
 
 #include "nfpcore/nfp.h"
 #include "nfpcore/nfp_cpp.h"
@@ -708,6 +709,10 @@ static void nfp_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static struct notifier_block nfp_swdev_blocking_nb = {
+	.notifier_call	= nfp_switchdev_blocking_event,
+};
+
 static struct pci_driver nfp_pci_driver = {
 	.name			= nfp_driver_name,
 	.id_table		= nfp_pci_device_ids,
@@ -725,9 +730,13 @@ static int __init nfp_main_init(void)
 
 	nfp_net_debugfs_create();
 
+	err = register_switchdev_blocking_notifier(&nfp_swdev_blocking_nb);
+	if (err)
+		goto err_destroy_debugfs;
+
 	err = pci_register_driver(&nfp_pci_driver);
 	if (err < 0)
-		goto err_destroy_debugfs;
+		goto err_unreg_notifier;
 
 	err = pci_register_driver(&nfp_netvf_pci_driver);
 	if (err)
@@ -737,6 +746,8 @@ static int __init nfp_main_init(void)
 
 err_unreg_pf:
 	pci_unregister_driver(&nfp_pci_driver);
+err_unreg_notifier:
+	unregister_switchdev_blocking_notifier(&nfp_swdev_blocking_nb);
 err_destroy_debugfs:
 	nfp_net_debugfs_destroy();
 	return err;
@@ -746,6 +757,7 @@ static void __exit nfp_main_exit(void)
 {
 	pci_unregister_driver(&nfp_netvf_pci_driver);
 	pci_unregister_driver(&nfp_pci_driver);
+	unregister_switchdev_blocking_notifier(&nfp_swdev_blocking_nb);
 	nfp_net_debugfs_destroy();
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index be37c2d6151c..57f7d6d634ea 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -915,4 +915,7 @@ static inline void nfp_net_debugfs_dir_clean(struct dentry **dir)
 }
 #endif /* CONFIG_NFP_DEBUG */
 
+int nfp_switchdev_blocking_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr);
+
 #endif /* _NFP_NET_H_ */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 7d2d4241498f..c2c5e7e3aab0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -3955,3 +3955,20 @@ void nfp_net_clean(struct nfp_net *nn)
 	unregister_netdev(nn->dp.netdev);
 	nfp_net_reconfig_wait_posted(nn);
 }
+
+int nfp_switchdev_blocking_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	if (!nfp_netdev_is_nfp_repr(dev) &&
+	    !nfp_netdev_is_nfp_net(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return nfp_port_switchdev_attr_event(event, dev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.c b/drivers/net/ethernet/netronome/nfp/nfp_port.c
index 86bc149ca231..578477242ae9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.c
@@ -59,6 +59,21 @@ const struct switchdev_ops nfp_port_switchdev_ops = {
 	.switchdev_port_attr_get	= nfp_port_attr_get,
 };
 
+int nfp_port_switchdev_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = nfp_port_attr_get(netdev, port_attr_info->attr);
+	port_attr_info->handled = true;
+
+	return notifier_from_errno(rc);
+}
+
 int nfp_port_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		      void *type_data)
 {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.h b/drivers/net/ethernet/netronome/nfp/nfp_port.h
index b2479a2a49e5..35342f88f715 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.h
@@ -10,6 +10,7 @@ struct net_device;
 struct nfp_app;
 struct nfp_pf;
 struct nfp_port;
+struct switchdev_notifier_port_attr_info;
 
 /**
  * enum nfp_port_type - type of port NFP can switch traffic to
@@ -90,7 +91,9 @@ struct nfp_port {
 };
 
 extern const struct ethtool_ops nfp_port_ethtool_ops;
-extern const struct switchdev_ops nfp_port_switchdev_ops;
+
+int nfp_port_switchdev_attr_event(unsigned long event, struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info);
 
 __printf(2, 3) u8 *nfp_pr_et(u8 *data, const char *fmt, ...);
 
-- 
2.17.1

