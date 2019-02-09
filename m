Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB04C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E3B20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJVK4lxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBIAeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44061 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:34:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so2448569plq.11;
        Fri, 08 Feb 2019 16:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJWvt+TdfuA/uy8voeT4xQktPEVBZvrAuPqf9sc140s=;
        b=vJVK4lxH055RhItDTzBGcEY1DHlc7v3DXDJXqXJT9gPkVfk2izDo5OfUFtiKlAdIB5
         u6dDWGr17KvVTEKljFxSJ7qW1Saf3w0h55czcl2X6aJHcM+OFNZSefebotHy5L0G8dN0
         jgaXaVitMdYGBd5B0PCOs8aQUovCHmBOEjlbw8w6pPp0lVFr9VfwPZ5y9cMnu0+HkAsG
         OakPj3VrZyjWVw8+BDtFqL261TY7dcUfmGKlZRr9DAbDY7Z8sZ+CrbvTFeVptLVvPa2O
         UaN1KRS7UxcdZpGcvcSxhZ6ulWy4gcD/+E5afPM8qwLpplGGvXLMCVSHuatTS9EknBDw
         9mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJWvt+TdfuA/uy8voeT4xQktPEVBZvrAuPqf9sc140s=;
        b=Z9cFxxgvA0cD9z/SnjFszxrWzmR8UJwKfHqzwuqFn0AxPRrcyduLA6wNkRtsG8ZhfI
         HeiDkOBHV8doJxhPPfm596n8ddHJGSybj0skagS68lE+bJMKd0yFwQ7Vhs25LxHTv/hw
         feaWmNg/brKTnOOun6c1a8yqjHUbIlu75KxzOfjs2IEKtaRuNe4Pr1XYpiIpEKWxsv5U
         sY/PeAztUvpiyCzzgadpRkfwXCz9iNKa2FW1jDclSCtNgtEvzHu7OJ+XCUapJ/k4XKlR
         oriipgtlIv1EURbjY2tY8W/jehGbx7LOoXkzLe7SWF+pEZE7eiKLUubCP+bNTECR3E3l
         B2WA==
X-Gm-Message-State: AHQUAuakxApzcoipt2CZrV3TWtPW23HC3w0JAlLYi6rrFJHXJim/1kwt
        6pQ37+eYD037IZQcm1RfrB8o3FUg
X-Google-Smtp-Source: AHgI3IbgVMay9vmE+wWEoJ0l8wzomXALP6TVx1+JzULywsjC4wyBX+DTD9p3YH/kRFgyrQqz4R35EQ==
X-Received: by 2002:a17:902:684:: with SMTP id 4mr25532083plh.3.1549672445415;
        Fri, 08 Feb 2019 16:34:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:34:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 13/16] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:45 -0800
Message-Id: <20190209003248.31088-14-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
ocelot_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..adab478d36f1 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1582,6 +1578,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1614,8 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

