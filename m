Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8408BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552A421B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8yCDwGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfBKTLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:11:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfBKTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so15229pfe.1;
        Mon, 11 Feb 2019 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QPgFt5j6UGQb+YmlyjgIvSlCGoFlyBm2NR9++YJ/iss=;
        b=t8yCDwGfisKuIVMD1tXN+vqj45cMlPM2XmC78pl355j/537+oBFV3mapZqnNmlg+k0
         NoQUOCWfKGYPJch0bYxXfo+Hz5T3OVDjUs2iddTX7edc76wz/hicWpluIMn6uawBRSak
         EQuAcpqirdfhYdYb5oNPA/UGHWlEtp0DJbdMuI7v2K7uQTMWoB+Sm68latHf5turkcFg
         lc8i5Bkaa53IUazdHwY0vsMTqr7bnj8xGVtnwfC9OTtL50ilvBaudJ+Xg8gTKarKtGT1
         eota6GzH3QYlXbdcpLi1M3zZSKNX0Cy/s6jJG7HWiTgQMnJ2/IcOaV8SjvnTUu0zE2tY
         WdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QPgFt5j6UGQb+YmlyjgIvSlCGoFlyBm2NR9++YJ/iss=;
        b=Hm3hVUasBDawC8Et+HGCyRpDEQN0gE2pgDmOmAffef1Vt5IJapKxZvGlHLikvxQDkD
         rNeVMhVuaiE+TFCk1U3KTB9E4cnNEmBPJjcm9ECTWYT55YU63JG7RXO0ul+5DdWueKrO
         8irZJ84Wnt4k8zNBZ5qETNUrGTQ9DQ6jKTG+FtoaRbELb4uqrUGa9AC+ftzcuH1aIvGI
         2cgmOSKQbx3jEaOxJuEbUuwr+RSx6I1I5g46EH9SzjJ4ryGSWTIBN1xGwma4kqj/UPc2
         JdhjYtMGzf8sB7arFqtPqefoackst8S5trlX2eUmSgxIHXwY5NYBwgcZ/kKJXLXBPyAP
         cz5A==
X-Gm-Message-State: AHQUAualiViVChEvR+bICYj8l1NltrwQG+a6wKZ6qpzvzkLQxgPMz6lP
        +FPHx4+pUS7FB6nF0QUBqFMpkfGF
X-Google-Smtp-Source: AHgI3IbzF9ES1nHxpxd9zZbML0Iess69DcezcjTNdVCNN8jZ4EAmJAJMimDCm+WnfBvme3z75hjLHQ==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr39117095pfc.135.1549912258113;
        Mon, 11 Feb 2019 11:10:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 7/9] net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Mon, 11 Feb 2019 11:09:59 -0800
Message-Id: <20190211191001.8623-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
dsa_slave_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..66c6c353f4f7 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1558,6 +1558,27 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+					      port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = dsa_slave_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1570,6 +1591,9 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

