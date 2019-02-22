Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9224120651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY1gqsuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfBWAA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37903 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so1817663pgl.5;
        Fri, 22 Feb 2019 16:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=coNXLpDgHf1oTanf9T6uDRbWXQQYcKuOOfGnCffIngI=;
        b=MY1gqsuFFgiFbDQlAd2uBKMQM5D8pARLr5E4gIRoPuND0ClbMeUbTvBz5Dyg4E6GgG
         cem40N7cHYVEm+XUYOobP2DqxJwVU1lmbtW//6C0sYmw6PyXW3Thj5krWeArqH5XtJgP
         Ps0KQf4Iokm5u1MlIujs2ULwFlIkhJPBcdrK+wRYW0GXOmt9QfFa71c5VS5LMqiUO511
         8fEl+NF5Pvv/XyU/qCIw+r/GDNZlNdknkfm3vqxtATTeyK1lZsY2wWVc5w2XMbxQqRbC
         EcvvjfAYs9rI19o/vvYTqohgmQxqAGep3bCp1StP67dL5sse+7ZObHBI0KKjcXcu+AZL
         jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=coNXLpDgHf1oTanf9T6uDRbWXQQYcKuOOfGnCffIngI=;
        b=kKmKT0hkY4FNNukTrg0WrGDsH1MGy9dRDR9cc4pZbA2yOdYpVtPhrfr1cm6a4druoC
         LE+7kolTb7vy/sJKtwylQLlhN+B0Ud71JdCTN23t7UMuiQeOPEwK6qOt7EmZ2sHNEnGY
         WoY2InqgKllEWJfzAeND7CPRRXsnlolmjFoKs9KdvkpJvWbdyZihEMerS/1Qkgx1uTKn
         jbIz11vwNP8ZkyBVsu99X4XmN2EX3uSaPTEtdrP4559y9KdEJE7XoBf1stlrzOijEY82
         tNAoDQW7kc1j1Mepo1d5YVgxOupktU7lBScL7RiHGNQy8hgR/3FKtqTGxedT9j1BdMh5
         CUlA==
X-Gm-Message-State: AHQUAuZ6tp8wikpmGcqKaOmkgIo9hGrFDWLdk4harhi9dlNRXoKAtne7
        0zKWgzpO25F0XVWQX6Yna906htKh
X-Google-Smtp-Source: AHgI3IZz0cjrZc7lHPih8k5yBfqanvcrcJKlnbaJoc93v7wF0zL62pjrJdWMOslAQeZiBetrZdWp5Q==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr6333282pgt.217.1550880054100;
        Fri, 22 Feb 2019 16:00:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:53 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO with a notification
Date:   Fri, 22 Feb 2019 15:59:25 -0800
Message-Id: <20190222235927.10295-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
from all clients, which were migrated to use switchdev notification in
the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
(atomic) notifier chain accordingly.

Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/switchdev/switchdev.c | 96 +++++++++++----------------------------
 1 file changed, 26 insertions(+), 70 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 94400f5b8e07..a1f16836ef89 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-/**
- *	switchdev_port_attr_get - Get port attribute
- *
- *	@dev: port device
- *	@attr: attribute to get
- */
-int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	struct switchdev_attr first = {
-		.id = SWITCHDEV_ATTR_ID_UNDEFINED
-	};
-	int err = -EOPNOTSUPP;
+	int err;
+	int rc;
 
-	if (ops && ops->switchdev_port_attr_get)
-		return ops->switchdev_port_attr_get(dev, attr);
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
+	if (attr & SWITCHDEV_F_DEFER)
+		rc = call_switchdev_blocking_notifiers(nt, dev,
+						       &attr_info.info, NULL);
+	else
+		rc = call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
 		return err;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to get attr on
-	 * each port.  Return -ENODATA if attr values don't
-	 * compare across ports.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = switchdev_port_attr_get(lower_dev, attr);
-		if (err)
-			break;
-		if (first.id == SWITCHDEV_ATTR_ID_UNDEFINED)
-			first = *attr;
-		else if (memcmp(&first, attr, sizeof(*attr)))
-			return -ENODATA;
 	}
 
-	return err;
-}
-EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
-
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
-{
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
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
-	}
-
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -267,7 +221,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -286,7 +241,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
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

