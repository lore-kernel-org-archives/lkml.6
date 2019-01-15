Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC2E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1nPeEzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbfAOWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:43:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46226 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbfAOWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:43:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so1845334pgp.13;
        Tue, 15 Jan 2019 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZOnjqvNYpF0b3NTZ9L7L8hAtbEIUG8+2lvDJ4PJi+ZA=;
        b=t1nPeEzs16fXHuhrT13p83AB0PlIz2zHTem8fGQbrKNNXcU52WMXJ6Plyv0UJCSVmQ
         g7ykB/ma94bBE19uguRa1acoDZyNhlb7iJnrjgJonsvW1IHubDbSvNlTfCuHp87VIjq8
         jiUufxwLn2VllBJ0mQj/v1TMEk5cVuHB2u480Zv35oTY37cdFDcdMHiYAl3I6IwlbSgZ
         bk7W5V228xLDLEsZfz7f9KxmKrf617U4uzJiBOejb4XwzOmpaXbWP4Z0WwbX7G6KlUGI
         rswHDe4h57W9hCiFPvtGjSalNJugiuESHahUxIgWo7Zq7pvMf0QOn9Klh5JSIGkkapgG
         lN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZOnjqvNYpF0b3NTZ9L7L8hAtbEIUG8+2lvDJ4PJi+ZA=;
        b=qjwbZt20r5c4/w0g0bQRPM4KQPau+aiqBocTP8cLSbyEypiSUDe9rsl8A03QZOaP/6
         p5B0WiI7ghlsUYECjyR7a6qJ4wpORiNOCc0LaWyIvBP2UMih8iclCkyihYIQelXyEWzz
         l66N15rQ+n6ahpmwuV+/FBASJdIj3OXjkHl4uFctQbl5td34Pkjx9mE429ERCTZV/k2d
         0BPVWZMCjOWe4PnvIlt+fcv80q8LQkhs3xK4FWWKImEVDtM5J+W+S+0GNHBjmlq3d3QP
         rl512T98n6hDVlo5bgkyz5guIoulPnwXzI6EHYL76t+cCNP6Ou+9Y5Y5YC9lposxGuzv
         Z7iQ==
X-Gm-Message-State: AJcUukcIkedhWo1QcPcXc3zys+9gBAa48YE6i2YgNn1qkvzCaD+ccj3w
        /AAOogb+P3nzCpRrVdo/grA/2Gq9
X-Google-Smtp-Source: ALg8bN7ka+dMCDujW8q1HJiYcezbQ0JWu3oX5oL7wcBj3Ha7HajcHAOruTokb1QenQ36EgmP+zhlEg==
X-Received: by 2002:a65:4049:: with SMTP id h9mr5820945pgp.304.1547592213133;
        Tue, 15 Jan 2019 14:43:33 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i184sm5206628pfc.41.2019.01.15.14.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 14:43:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: Add ndo_get_phys_port_name() for CPU port
Date:   Tue, 15 Jan 2019 14:43:04 -0800
Message-Id: <20190115224304.17500-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not currently way to infer the port number through sysfs that
is being used as the CPU port number. Overlay a ndo_get_phys_port_name()
operation onto the DSA master network device in order to retrieve that
information.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/dsa.h |  5 +++++
 net/dsa/master.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index b3eefe8e18fd..2f1daf29131a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -208,6 +208,11 @@ struct dsa_port {
 	 * Original copy of the master netdev ethtool_ops
 	 */
 	const struct ethtool_ops *orig_ethtool_ops;
+
+	/*
+	 * Original copy of the master netdev net_device_ops
+	 */
+	const struct net_device_ops *orig_ndo_ops;
 };
 
 struct dsa_switch {
diff --git a/net/dsa/master.c b/net/dsa/master.c
index 71bb15f491c8..79e97d2f2d9b 100644
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -126,6 +126,17 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
 	}
 }
 
+static int dsa_master_get_phys_port_name(struct net_device *dev,
+					 char *name, size_t len)
+{
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+
+	if (snprintf(name, len, "p%d", cpu_dp->index) >= len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int dsa_master_ethtool_setup(struct net_device *dev)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
@@ -158,6 +169,38 @@ static void dsa_master_ethtool_teardown(struct net_device *dev)
 	cpu_dp->orig_ethtool_ops = NULL;
 }
 
+static int dsa_master_ndo_setup(struct net_device *dev)
+{
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_switch *ds = cpu_dp->ds;
+	struct net_device_ops *ops;
+
+	if (dev->netdev_ops->ndo_get_phys_port_name)
+		return 0;
+
+	ops = devm_kzalloc(ds->dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	cpu_dp->orig_ndo_ops = dev->netdev_ops;
+	if (cpu_dp->orig_ndo_ops)
+		memcpy(ops, cpu_dp->orig_ndo_ops, sizeof(*ops));
+
+	ops->ndo_get_phys_port_name = dsa_master_get_phys_port_name;
+
+	dev->netdev_ops  = ops;
+
+	return 0;
+}
+
+static void dsa_master_ndo_teardown(struct net_device *dev)
+{
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+
+	dev->netdev_ops = cpu_dp->orig_ndo_ops;
+	cpu_dp->orig_ndo_ops = NULL;
+}
+
 static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
 			    char *buf)
 {
@@ -223,16 +266,27 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 	if (ret)
 		return ret;
 
+	ret = dsa_master_ndo_setup(dev);
+	if (ret)
+		goto out_err_ethtool_teardown;
+
 	ret = sysfs_create_group(&dev->dev.kobj, &dsa_group);
 	if (ret)
-		dsa_master_ethtool_teardown(dev);
+		goto out_err_ndo_teardown;
+
+	return ret;
 
+out_err_ndo_teardown:
+	dsa_master_ndo_teardown(dev);
+out_err_ethtool_teardown:
+	dsa_master_ethtool_teardown(dev);
 	return ret;
 }
 
 void dsa_master_teardown(struct net_device *dev)
 {
 	sysfs_remove_group(&dev->dev.kobj, &dsa_group);
+	dsa_master_ndo_teardown(dev);
 	dsa_master_ethtool_teardown(dev);
 	dsa_master_reset_mtu(dev);
 
-- 
2.17.1

