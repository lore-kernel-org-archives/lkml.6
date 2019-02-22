Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1BF206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/xvMrPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfBWAAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45945 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so1777664pfm.12;
        Fri, 22 Feb 2019 16:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=T/xvMrPInTZVV/RHVi8N8KxnUG7NjDH+YfgFoDOKRiGaKyS/4sT4EDJImoiES+CsQd
         5ivaOfbp1nDZag60HJZUpPbSPI+NGjgZhXkj431ib8u6/yeS4UiVZB/DNZAO8rrOPWOr
         8fCj9pOt3YNDes3iWBUuKDbD4EhGsbXB/sBiJlpYQN9SQv3hH+REW9SyMWzMTlQS/r7F
         SH+4tEFbZAOSTDXEOI+dKro11nvDv0nhwWSJaA+1v397Z9MzFxxmWPxpQZqHOXSiGBAq
         QACCYECyiD6kLFc9Lv6W25DCoKH4E7dZ9kyVvxMpRF/IxEl7JtqtKuc4NDsk1KuzYRo/
         qxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=OTQrvBJrV9pRIDvtRVUWSPksf0cUSRxS0xVNtrxKwannWIJnsWtFgCoE5/oV4jAGc+
         mO6i+s98lpNGTvaenatxMRcZBHK9ypJCiPKpYPt46UXXxACKc92Mg0qpc3WTm4JVXEBC
         LAeqJeiaBfPtKPv1rXGFF1uOzGFsZXb3mHnsbliISpsYuqGIeZ8D0qGyBI5fDxVVTazn
         nvsOVhcGC/Qn0rXI0VMVDFbaIubilmXxCcp+56Co1O0QBjZII7TeHJ/Pm8Rbawl/XeIb
         /2xg/eitD/jSQ53MNCEltysp3cyeJ1jXb3fkJdDv37JYgf22Z716S3wJ4HM9CCurXDtL
         bSDg==
X-Gm-Message-State: AHQUAuYYSFKBc3hXb3nrvRMa8+dUFV84CluR07/NDCggztW8BBGMTQ4H
        mL067DrxEuHL4j4HghOZaalpxVe6
X-Google-Smtp-Source: AHgI3IYxJNpflXt0sYbsxRfDz/3HD7rJmAKK4bl4QJDNMLz9JJtf+dPl+5dkHwbNvhWqI6isAnPKEw==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr6528326pfk.186.1550880032077;
        Fri, 22 Feb 2019 16:00:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 2/8] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:20 -0800
Message-Id: <20190222235927.10295-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
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

