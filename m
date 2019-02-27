Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C56C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8EC218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adl0hWXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfB0BPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:15:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40459 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbfB0BPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:15:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so7106413plb.7;
        Tue, 26 Feb 2019 17:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CGC5288aeDnGMAvwttKUw53qJk7EfFD9Gkif20wQhNs=;
        b=Adl0hWXGRaegsDZvEEe6hj1WEIeKWdS4AuhXO9aGYC8/BypwCai4NE7oji23SNRKmy
         X8Go5eqxpOAJvg/iaLgFUQYNtT17dRsVqbhD3QsLzNZOGbFa+YeiqVsTbIittT5nnSja
         e4X0AqdE6QLXN8MfzxCxOh3PP3GOdpb28bROmy7R0lUO4wSRwlAxUx1SKRYQ9xEOCen/
         ttk0clPZscen3dddNvJLmqFX5+HV/gbtZ9W1S14M8VhvsS9dqM+YspFklHomg6xJL+IX
         W7YL2zZgMO9lI+gpPT/iRDzfIgQ2YQ1ia/wY9ftGLszQ5qyNrciJtW8RAUH/ZzmNPuzk
         Lq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CGC5288aeDnGMAvwttKUw53qJk7EfFD9Gkif20wQhNs=;
        b=GQZYyRLjqcNzvG7NSGCVRL5zf96u7GQxLto27LIiYxIrxVb+7uOVoNIrm35IRSrXwA
         /z+TkxAZXM1b4w3z3HsWAwiJOf4Q4EMnlRnemCEzfW1CGR6tkav0hXAcQ8k+HbEqQO9t
         9lTch0qEqo5sxjUzu7eonkeMWT0QG6kAVgWa60K/LaMmJAgsVvAfiUV3YDntjHIMMSmA
         L2zFb6eaWyxGlSLATWRNFz8d0SXlEjwcLpF8CMqlE8TWP7/P4xoQHSjXldkN44gDUquM
         juuxlVGIciwbnkX83SBeBIhMT8EmmH01Poq8KDAB3OWgltLHDqvviCQ/QTmQxYlsAsrX
         vc/w==
X-Gm-Message-State: AHQUAubWM3WbRrtwpUlhen3RL2I2oesMYGd8B57CLq9QQNdbsZgj5ckw
        JZSszX9GfBiQAvYzqgs9ySbntutt
X-Google-Smtp-Source: AHgI3IYlZW7CI7MVXzQQSGhJIhJRKjfx2Xqn+L8U78Wu9GT6g6wlKuXCpTwqCC2YcOsojkG/Ywe1Rg==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr28780826plz.148.1551230106884;
        Tue, 26 Feb 2019 17:15:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:15:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 7/8] net: switchdev: Replace port attr set SDO with a notification
Date:   Tue, 26 Feb 2019 17:14:26 -0800
Message-Id: <20190227011427.16487-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
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
 net/bridge/br_switchdev.c |  7 +++++-
 net/switchdev/switchdev.c | 53 ++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index af57c4a2b78a..b7988d49d708 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -67,12 +67,17 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
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

