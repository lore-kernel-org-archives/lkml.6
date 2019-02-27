Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1EEC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA59217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKYS5XLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfB0Tpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43286 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbfB0Tpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so8485957pfh.10;
        Wed, 27 Feb 2019 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2kn9V7ShGWUd8iHWxgRcRX7WVTJEqZ9g7Azsttn428=;
        b=hKYS5XLi2T8MEWy1epSAPd2hxWSDk1jAHYGHB1nKIZ8GN/NhminwTr8wCtwedr8UGB
         RqsvBpzAKdRRg4DNWHoeYpKuwKWPP2kjoDbB4DPFAsF7LUA4E7ThOezxR9jdwjvl0Ain
         gJBwcGbEIytew2qwGE7OfJTNoSsEe3riC1dJWibJSo1OekYcgjJdpowAUhWmCDupUdBY
         IV3EWIpSihH7UYBVHnZQY8Swr5UPIA44qG/U/vpLfgRsAJ/4nh0oeUTr7BX5mBZx5T/Y
         pNHvnVHImchk+nzlCzezFPtcYDue7yJi/cVkMmOknCb6WnWoqd9Ap86zkxcZ8mmEWsNe
         v5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G2kn9V7ShGWUd8iHWxgRcRX7WVTJEqZ9g7Azsttn428=;
        b=M7EHUXhs6LDAo+4Gub+GpfEv4u7OeAnn/HOtBNLBvw2s1LofMKYPzHR8f7sisZpVur
         yhDS6gWaPEOO9dPzsZqEU86nquSYmHtQ+sbDRJ4dsCE+cV3X80+1X8zvnpVATcTZHnX3
         gHZJnHma0Yan2lPI13+xoBQEGsPNWzhRwaSC9r9nEKRbCWgDiM4qgOzXBd79BKHFJkAc
         +bh5QDMVg7hIGdEBppzWXYix2BG7dhMR37EBGzM5shr47YiosrwS/XF6u9Xn8pwSfAjU
         efXhnVPooNoInhgIzc57FBzFdrpR4HxZ0IsaOzawcjzmNGLhj+f/Fc7U7wUiczhX9m6M
         4kCw==
X-Gm-Message-State: AHQUAuYaErDm+e9fJrAGhrgQ8K1OZvFIBg5ZwbocXzd1v3XAfw4W3ShM
        eamw3j479AXQYlASlHutc6DPItsb
X-Google-Smtp-Source: AHgI3IY2cXOXPu7O3DDjXLdu+HDmeu198xHFiIsLUT+phztyVToZcyXQ54NSvNYrQVHHJV40wRgkKw==
X-Received: by 2002:a62:5c87:: with SMTP id q129mr3313431pfb.180.1551296737858;
        Wed, 27 Feb 2019 11:45:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 7/8] net: switchdev: Replace port attr set SDO with a notification
Date:   Wed, 27 Feb 2019 11:44:31 -0800
Message-Id: <20190227194432.725-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
from all clients, which were migrated to use switchdev notification in
the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_SET and calls the blocking (process)
notifier chain.

We have one odd case within net/bridge/br_switchdev.c with the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier that
requires executing from atomic context, we deal with that one
specifically.

Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c |  8 +++++-
 net/switchdev/switchdev.c | 53 ++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index af57c4a2b78a..921310d3cbae 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -67,12 +67,18 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 		.u.brport_flags = mask,
 	};
+	struct switchdev_notifier_port_attr_info info = {
+		.attr = &attr,
+	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_set(p->dev, &attr);
+	/* We run from atomic context here */
+	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
+				       &info.info, NULL);
+	err = notifier_to_errno(err);
 	if (err == -EOPNOTSUPP)
 		return 0;
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 3560c19aa7e2..d81cfcee9ad9 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,39 +174,32 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	int err = -EOPNOTSUPP;
-
-	if (ops && ops->switchdev_port_attr_set) {
-		err = ops->switchdev_port_attr_set(dev, attr, trans);
-		goto done;
-	}
-
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
-		goto done;
+	int err;
+	int rc;
 
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
+	rc = call_switchdev_blocking_notifiers(nt, dev,
+					       &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
+		return err;
 	}
 
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -225,7 +218,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -244,7 +238,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
-- 
2.17.1

