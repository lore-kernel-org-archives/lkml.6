Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AFA21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVlbH4dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfBKTKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42422 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfBKTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so5721539plp.9;
        Mon, 11 Feb 2019 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHKxFom+TS/uF5v75rmvzWOuknaksPpVihcsZQowL1A=;
        b=MVlbH4dzntI3IR9RVcIK2FK8xRxzeOeNb27b9kw5jLskOwT1wRIwWxZRbtILQhYpJW
         ANUTedMB3lzTaedxha+8Yeh/5jB8x5sRGrS15zyaUzv/2vXgLajWhJw2CG/5hOCv33jv
         DfPe4aBGANyQubzxw2DNkITnX/a9ezGDmDRFfG9JAj21wkM8zI7vS6XvPlGbwMKLOaL2
         dsvLtiZSUaFmPVT3gzZllCliRN6ptrgNR1M+MQMXHjnkHAInZLuj9FRNBB8DL5RQ39Zj
         w8RSbGA15xJoCRXcfBaTJ2ogmtA/m9d9Ad0m8LN635J5Pb2ekspQec6ORBQJRUaQWhiu
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gHKxFom+TS/uF5v75rmvzWOuknaksPpVihcsZQowL1A=;
        b=pLo5q2dNn5uMmHtxbaaPNgKSYnyKmE64rlvgQf7RVFCdIw8wR4H8lKUiHO6oP3e7j6
         k3eUjdobcWa7LlkzA/isw2ybTWoG3bknO0O5AmUETkhgN3hl9kaMRSsqYsEJY0jsuJt8
         54dUQA4yXCerHnAdrL9bbKxqdAkRkzh8UB8wInQ0wwt4NiesY/wdv/PXrjom0aQFCGDs
         mc3/NZIAZuR/jzhANsLQwXzr0a4XGyKNdDw036O0ir7pIL51ZvaT6/UEWIO6Dp97M2gs
         pu24fINQ2qJDeaeDHxpX4zt6C/MD1Cy0MXzHsvzUIgpf9jxFrk3GHYnWTRwpy0a/eG6v
         8CXA==
X-Gm-Message-State: AHQUAuYUI/6+LmljJxVKm1LMj9GtLxCZXOF49bLckRcq33NTqfg23oUG
        oDmNBQRH5yG4RPjUJ/AaZcrjSHBd
X-Google-Smtp-Source: AHgI3IZRxgnj4A54FpZk15/tXm5N61F4aLsHNizx+1Qy8u7RNKrQFRbeshBD9KwPBrYwgKHgc8Jb7Q==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr38282056plh.99.1549912248637;
        Mon, 11 Feb 2019 11:10:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 5/9] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Mon, 11 Feb 2019 11:09:57 -0800
Message-Id: <20190211191001.8623-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
ocelot_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..2708809713ed 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
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
@@ -1600,6 +1618,9 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

