Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C71DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C1218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2FA62Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfB0BPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:15:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47051 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbfB0BPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:15:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id c17so3938517plz.13;
        Tue, 26 Feb 2019 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LyKdp20X8t4ovPHYE9CH/9hVrvQZYs4Dq33a5OBgkXM=;
        b=o2FA62BnB5vfqvE9uANqgGYsKnlq/OF2lifybXrCMuoNW4XtsgVRmOp+u9HsI0YXqO
         WMT7aAWUx2e5r7r9g6LDBn4ygH2remUJVlK9eE+HWJlOymjuN++uXBS/t/RUlFRMCp1p
         FwTXy2vwhRh3A128FH5egRyeWi/Uh/Dir+CnPlx2aRSdzk1rQAVPCLsM9zfd1i7eH69H
         Xvkk4iDSOFcncdFqRBWFOfFriAUyYJBMp3lVhy0q2jrwWzYkcI3wA5tBcFz0xGlY2jrl
         MTfu/Z2XEWScwpZC+CBxRLnNSCO4r7O0KrvibSPuAOS1RtZlyzUaehdgjQl8tFELCD/V
         1PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LyKdp20X8t4ovPHYE9CH/9hVrvQZYs4Dq33a5OBgkXM=;
        b=iJGKZ424Lysnklo+ehK2+3vdzqTovEjxorsM0ynXJ7cq4VvNTMb5/1l/3u/9zKP0/C
         a9sLhhweKtoB5QG0CwjYdsngaac7Yo/8dmT+rQo3iC33Qo5vu8A+HNUnfyF1R7bE2P3n
         Cwbh2rfrcJoqbngWzL9HNUyb9aLL6jbIDSQ/+6Yi+ngfKqkizWpuGhqQ42KU1Zft9N5b
         j6Pz9QohZJlqk/sEIqZRr882LzM3tbdQDfVjpZlDbViMCIqAbs8THoK3AZZiFlcbQSgH
         RKHMYxYqgpgg8foaX6EzOhv173ViKqDdZMl6BGBLt7FfpUQiGzXkL3fp1REpueTqA55G
         P+Og==
X-Gm-Message-State: AHQUAua+corOpL5el+M2lAvLvVDzrMhtAmHKEcVPzYggmEuVaCN95jpe
        cSPtooO8U4KfWsztVzxxeWUGkED3
X-Google-Smtp-Source: AHgI3Ia1UB9v+IarCmUenvjzs4XQcr6Kdhty1PcT62013YayVt6sQUDLxZuDXN8IuROiNbEzD8UVSg==
X-Received: by 2002:a17:902:b590:: with SMTP id a16mr29441716pls.22.1551230102490;
        Tue, 26 Feb 2019 17:15:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:15:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 6/8] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Tue, 26 Feb 2019 17:14:25 -0800
Message-Id: <20190227011427.16487-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 018399ee8731..b0d2d9bf2532 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -929,6 +929,19 @@ static const struct switchdev_ops ethsw_port_switchdev_ops = {
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
+static int
+ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1047,6 +1060,12 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1115,6 +1134,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

