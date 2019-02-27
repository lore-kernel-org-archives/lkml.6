Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E5217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j021yYei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfB0TqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:46:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43266 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfB0Tp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id m10so8485646plt.10;
        Wed, 27 Feb 2019 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=j021yYeipzReB/VJeFej4t7hA3KZ2emfPOD04doaq64ceTFd72OyfNErGSy5xy80Y/
         VZbgcEnB8si8F+3PBCgTgzi1jAl20SaFd8OJIoSK8DdiGp47qjxRkVIk96WSHINOGM+W
         1RdDb4Sp3RYuf/WitgTgK0ny4lwpFh5SnnTNITwxjtm4k73gJ+qZ4Atwq9dRBIQnrghI
         qf26YiVum6Q4Q2YpJ7HRPVY5lVMdaCLb5GTTabcW1NtArLv2AYHTLinQuRkj8y8mnSXA
         UWCWbailpAQdLU0bRmDFoc8/KJGnoD9IQK1l9nJzwRf2/9sgUq5XZtbkxo1SFRT+wO8V
         BUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=taCpR/kt4GDT9jcld+4B4Gp9UQ3KTAPb0wm1lsYN1UfyYS7xirOp/kII9UQQ9atLEk
         qkGCIzIHnKLe5RcmWMRmmHOhKaK/5v2FN+EN0qZF5IX7Wv+swAu6PIldafVjKFHvppjD
         8RTBPu4F2/H9/arHCf8sd4tTUeSqF9ob39dzBFFFnOHzgY6CmQQPGNpDUIYZjdTmRzxz
         eaLuoFEvmWWqEnlKVbdJ+Rhl/4gpMeUHixI8Ys3CdEUTdF2DLbeLflBO8qIojpYonjf4
         MQwJqDEhc9QJX+PaKtcHeSUv7BElHE6sIlgO1ZcRUdTwGIiSuBOHEcOum6OONB24egwK
         AKeQ==
X-Gm-Message-State: AHQUAuammmhulryAAC5d7lmNyOz7H6/2c5lYI3+caxm7C2rUnqS5kfJl
        t0j6oKwsgZVBKUpcDCxeLepvnsGs
X-Google-Smtp-Source: AHgI3Iau7np9NdxU/LUJT+ZJ7pPLkMbk8zTBDW0HrkiOkefMfq37ATX60llteY0UndHxgGKCMmfUdA==
X-Received: by 2002:a17:902:7604:: with SMTP id k4mr3925379pll.232.1551296727808;
        Wed, 27 Feb 2019 11:45:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 2/8] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Wed, 27 Feb 2019 11:44:26 -0800
Message-Id: <20190227194432.725-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
rocker_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 309a6bf9130c..fc772cf079cc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2710,6 +2710,19 @@ static bool rocker_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &rocker_port_netdev_ops;
 }
 
+static int
+rocker_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = rocker_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct rocker_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -2779,6 +2792,9 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 	if (!rocker_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
+
 	rocker_port = netdev_priv(dev);
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (WARN_ON(!switchdev_work))
@@ -2841,6 +2857,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

