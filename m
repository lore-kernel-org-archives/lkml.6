Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C72C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE220651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMPT3zqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBWAAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35237 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id p19so1791947plo.2;
        Fri, 22 Feb 2019 16:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xdJhj6/KPsXtmI8sxeS4sEhQiluHyols6G0sMJAn/vE=;
        b=cMPT3zqBnUoHOQ7FgutZLL9dZQBj3bMUOzF5MTZ3dOCPHbt6GZIht1q3reXAe3YSxU
         fFcMqnWQplBHwaWJpOBGJcT9A1cT9ZV+pmgsSn9yI72BTTjzwXxmo3YBT1TnnJYj4fN9
         38LSncJiwf6UkuR7xixClQBTXkk0taOBZ+I1rf9Cc7EBpjRU9/vRBRsnFVVP+jNJoyrp
         jRxd1UadfTMIZzHSJ9Na0+Wkmo0CJVmr9wI1iRpZDJq1RxD65/1j/Luk0Ts3hhp8w7RP
         YQ/AfhGziKyGGLXLVKPtcGX9vW0UTQ25+Dt37D0sl1WaDkenPOAWMfms9Ip7Q/3ZYc0w
         Aoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xdJhj6/KPsXtmI8sxeS4sEhQiluHyols6G0sMJAn/vE=;
        b=COfGqP/XfHcV9pn8ZOqekd4A6GODmotSI6z1orDpyzaRhGYyINfCecyLAb2y5nTMiK
         9G7Alv0FWDUTBNwJ2PuXlhA8paq507mWw1mUpXuB69w7Q6RqkDciTDt18Doci+7b2U1A
         V294DGrHcG/LJDjyBDVueUyYZJHy00gJjq3XpRgtyDarVdjve71hy9hRJCx2QPpU0GTv
         QqC/w/kXif3gTqLjDDAb8ABFzqM2gmpCER0UIuHm3MDL0DyNTiGDgguSHv2QNPyOyDqB
         g8HVJmJ5TD3mhgnv7egl+Pifo8dI7SeP3acbfqhAxwsYNayw4rid+xOjH1hTsU6qQkZT
         dfyg==
X-Gm-Message-State: AHQUAuYdjctHduu8xAYOnnF53DYpSfBmCMBLSXn1g2n8uK+KaH6pOmI2
        YEUQ7YNPsgymYjrTuOsAeA3LEQ2H
X-Google-Smtp-Source: AHgI3IZ7hGFcEgTnHIDiGffe+0k9r7lTx91HUWccChg9ec07hQ4hX6wGRseM0BofBN1UGRsbDBvYBA==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr6734890plo.67.1550880045331;
        Fri, 22 Feb 2019 16:00:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 5/8] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:23 -0800
Message-Id: <20190222235927.10295-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use notifiers to perform those tasks.

Ocelot does not currently have an atomic notifier registered for
switchdev events, so we need to register one in order to deal with
atomic context SWITCHDEV_PORT_ATTR_SET events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c       | 27 ++++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h       |  1 +
 drivers/net/ethernet/mscc/ocelot_board.c |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..83a678b11757 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,28 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int ocelot_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	return NOTIFY_DONE;
+}
+
+struct notifier_block ocelot_switchdev_nb __read_mostly = {
+	.notifier_call = ocelot_switchdev_event,
+};
+EXPORT_SYMBOL(ocelot_switchdev_nb);
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1622,11 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 086775f7b52f..ba3b3380b4d0 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -499,6 +499,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 		      struct phy_device *phy);
 
 extern struct notifier_block ocelot_netdevice_nb;
+extern struct notifier_block ocelot_switchdev_nb;
 extern struct notifier_block ocelot_switchdev_blocking_nb;
 
 #endif
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index ca3ea2fbfcd0..2c1121d86edf 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -329,6 +329,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	}
 
 	register_netdevice_notifier(&ocelot_netdevice_nb);
+	register_switchdev_notifier(&ocelot_switchdev_nb);
 	register_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 
 	dev_info(&pdev->dev, "Ocelot switch probed\n");
@@ -345,6 +346,7 @@ static int mscc_ocelot_remove(struct platform_device *pdev)
 
 	ocelot_deinit(ocelot);
 	unregister_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
+	unregister_switchdev_notifier(&ocelot_switchdev_nb);
 	unregister_netdevice_notifier(&ocelot_netdevice_nb);
 
 	return 0;
-- 
2.17.1

