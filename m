Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65431C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317BD218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwS5j/uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfB0BO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:14:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42220 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:14:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so7063327pgl.9;
        Tue, 26 Feb 2019 17:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQg9HVQIYqiPsBwNT6JyGAohQPDs6z9iGbY5s51mdrw=;
        b=ZwS5j/uZEMcNgCdr8yv+ssv1acxc44jSUPbaB6Q91l1WV9isJ9z5InSfE3H+wLUA41
         j5s3vsO4dpBviOR+nqGoDneWW5nrrZDXjv/psPVGfeM9V3pLLeAPzEb+gs7Pzga/+ZUj
         8xKNsKElta/VzPA1L2wp45Gp+LdElW7aRYeK6S1jJbd2XWyJRzlA22aSroU4w1y+NfLp
         xa6keB/3cr1cTxnRCUSKxPEIuYbMiyez+c8ynjXdqbJyzoRXdCkf4DU+aJbiaEnm9owq
         iHUxyigI1HfVBLZeYd5kQrMjZRhbA44YoUme2C1J/74rpCAknfeEBTDrnr4DbAfQL+qg
         drCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQg9HVQIYqiPsBwNT6JyGAohQPDs6z9iGbY5s51mdrw=;
        b=CmVpJ8KJj3/9JS95qWcRjGvgHKlCNw0Y8JzjBN5A/4xrkFE6Vz7hTPXtSQivKpWB/V
         CjSPdyZd+XscunCzKZTlpKi9M2vUMPZ1bH/Sk/+G+rqyVe8joR4O+fDeJc3vAEw9h3nX
         MQ5x/oqpoRpW9q/cRdt0CuP5n1rr7ehhgTWmeH7yTtEqlTtSPNMsC5YnJTf9076sOIxD
         onrKaFQjeHfZc9CU0xTG6xy6uzfSk2z+IivXV7bmgpAohj3f7bcXoBWCTiClzN8XC+WR
         FGU4hY+9wVCk15X1ltJCfHd4+jd+qQLvs/ZC67l5ui/7pNJ3KRiXPKVEfa9q9T0DpgaE
         QXUQ==
X-Gm-Message-State: AHQUAuaxxFgWQ4q2/P+duvaSZBWrSJv+oyj7jZhg79i5yOyhucDVBZ23
        mt7syppWbI5lehmOGr0yJSsiaEoF
X-Google-Smtp-Source: AHgI3IaOd7eTIbji2/UWDVBBUsqLRBifmVWcaEHBRowtzNmW774GFVWU9pQ9F6tlR2KxRoZxMHsnkQ==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr29315661pfa.130.1551230093913;
        Tue, 26 Feb 2019 17:14:53 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:14:53 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 4/8] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Tue, 26 Feb 2019 17:14:23 -0800
Message-Id: <20190227011427.16487-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
to handle stacking of devices.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 766f5b5f1cf5..c1aedfea3a31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *br_dev;
 	int err;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (!br_dev)
@@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

