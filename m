Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2203218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4+NDr7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfB0BOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:14:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38156 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:14:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so4311135plb.5;
        Tue, 26 Feb 2019 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gq/qAOtWNvcuwUtUaSW2EYY4Z4jqPnX1n6JjQenVLBM=;
        b=g4+NDr7r61K9ERC3quk5u63rKL/N4u3wkUo2s/Ez3fiOkzAyRQFgZvxxyxR6NpqaRM
         /Y6aGQsAS5AC5maDmuQ1fd6ah/WZUQhSGPS6/v8AE0ROwx7YwcQYMyYE2taCRdeQl5f7
         yPnV/xVbYZVOnjV/AuDDF9+9ZJuFq0ezRBXrwsF7cejTgNxJs6KwEKDT71keOJCSCPvP
         PE4xT02oQDO7/wbE7nSBhzP5MrHMtNgc32j2a7+lAZKz1WaH04MkTz2I8ErUEpgujTmf
         XMjRAQ8Qfa+dzGKsb95rDbsBn2ZIbQRtAbsl/ffFqs0XncQzwyPVKaxZEtieb1ZjMyP4
         rh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gq/qAOtWNvcuwUtUaSW2EYY4Z4jqPnX1n6JjQenVLBM=;
        b=tpeIaGT6GvaELP1ElRzwwjMuvh11bxy9BTs+1h1H8EA7ORveB7/Ur8H+QdP+PznXTr
         TBT5BXf8iHogrGyJbPrPrMXQPrFXNLpDXyji0JB8ovUG4ddnvLe5k2r6oDbLw3OLTnRo
         RBdVoR7jVAdv1BsscepIJwKKt5vr8BKAXiQkzg6zZli7k2n+FEn8pTEQMHscff5F/G9K
         OmOTDGdSXUsjuzCJZXsitrWx7G5igqhFzwyxxJeFiPn01LM6yliOsdqLMcu+5pzdQE2i
         bf2vwGy519bZkApIK/Wyqqv0yZUydCYl331Mc9vBWP4XBRnJaOMKFxIxVXBz0sljSgq5
         7hEg==
X-Gm-Message-State: AHQUAuZT97x9BsKXfodQg+zePkTMJ76Iovb8tQXqDeg7+e9UL/W46m4l
        n4qt3TDovc30mFGmovUsO4uj5aRK
X-Google-Smtp-Source: AHgI3IaPTP+xxtelQtN0bpHnU7CwToGOhosll+76AlmZORQvCUYHxEi0wW4RNUrBH0/qxLH/NSFrEA==
X-Received: by 2002:a17:902:be15:: with SMTP id r21mr28516146pls.143.1551230089558;
        Tue, 26 Feb 2019 17:14:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:14:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 3/8] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Tue, 26 Feb 2019 17:14:22 -0800
Message-Id: <20190227011427.16487-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
dsa_slave_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7274499293c9..b089b43120e1 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1524,6 +1524,19 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+				      port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct dsa_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -1602,6 +1615,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1664,6 +1680,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

