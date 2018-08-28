Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88707C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4219C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4219C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeH1TpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37656 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeH1TpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so3731298oic.4;
        Tue, 28 Aug 2018 08:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNm0gRPsyFlr2esmw5DnNxNac32G1LKICofHULJsyvM=;
        b=WqlBg5I295R30bVgOyoZnPWprGxhBTo1dF9ujstF257nOyQctq4Iobd9Iy2EDht9YO
         Pqh7C1/28nOoDfke3x1C00u/5xrBbRo0kKZ1uX1B8HP8FTfimnxfv+jY+hQ1YTKCjkm2
         2C2DPyE1DPbjTKKG7ZNpjMuJ6A4v5Ua9mXu+UdcP0t96Ab6X2hcCXsEeiQPHjYLtMnj4
         v/+biihs1sgrAqsYONhCyTKcr/3jY5keyYyaU4gKOLsnsi7y2pTZo0tIlqlQC1Hql6FE
         ERWNdnk58sYZxF0ystK62vqChxQM0zYWGNm94s6am9xQROQRKJNHyS8wnYX6wZnYVYTp
         Jd8A==
X-Gm-Message-State: APzg51AFBIOcId8M8h6GmGh1wyH6xc7LpOuwPTj5aSB+4Rl9VHhnpXGz
        kISGl0KZOnk5d9AUSdgn0w==
X-Google-Smtp-Source: ANB0Vdbgx3ik4rOk673NR9AVahJCfTvqgh5r+D0bctCwF2YRU5nd2adeLZlq1bSzx/H5lvmrtYg3Lg==
X-Received: by 2002:aca:3ec5:: with SMTP id l188-v6mr1554263oia.181.1535471578723;
        Tue, 28 Aug 2018 08:52:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o68-v6sm2902294oik.56.2018.08.28.08.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:52:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 3/4] of: Convert to using %pOFn instead of device_node.name
Date:   Tue, 28 Aug 2018 10:52:53 -0500
Message-Id: <20180828155254.10709-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828155254.10709-1-robh@kernel.org>
References: <20180828155254.10709-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c   |  4 ++--
 drivers/of/of_mdio.c  | 12 ++++++------
 drivers/of/of_numa.c  |  4 ++--
 drivers/of/overlay.c  |  4 ++--
 drivers/of/platform.c |  8 ++++----
 drivers/of/unittest.c | 12 ++++++------
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5957cd4fa262..daa075d87317 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -219,7 +219,7 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 		return -ENODEV;
 
 	/* Name & Type */
-	csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
+	csize = snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
 			 dev->of_node->type);
 	tsize = csize;
 	len -= csize;
@@ -298,7 +298,7 @@ void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if ((!dev) || (!dev->of_node))
 		return;
 
-	add_uevent_var(env, "OF_NAME=%s", dev->of_node->name);
+	add_uevent_var(env, "OF_NAME=%pOFn", dev->of_node);
 	add_uevent_var(env, "OF_FULLNAME=%pOF", dev->of_node);
 	if (dev->of_node->type && strcmp("<NULL>", dev->of_node->type) != 0)
 		add_uevent_var(env, "OF_TYPE=%s", dev->of_node->type);
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index e92391d6d1bd..5ad1342f5682 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -97,8 +97,8 @@ static int of_mdiobus_register_phy(struct mii_bus *mdio,
 		return rc;
 	}
 
-	dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
-		child->name, addr);
+	dev_dbg(&mdio->dev, "registered phy %pOFn at address %i\n",
+		child, addr);
 	return 0;
 }
 
@@ -127,8 +127,8 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 		return rc;
 	}
 
-	dev_dbg(&mdio->dev, "registered mdio device %s at address %i\n",
-		child->name, addr);
+	dev_dbg(&mdio->dev, "registered mdio device %pOFn at address %i\n",
+		child, addr);
 	return 0;
 }
 
@@ -263,8 +263,8 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				continue;
 
 			/* be noisy to encourage people to set reg property */
-			dev_info(&mdio->dev, "scan phy %s at address %i\n",
-				 child->name, addr);
+			dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
+				 child, addr);
 
 			if (of_mdiobus_child_is_phy(child)) {
 				rc = of_mdiobus_register_phy(mdio, child, addr);
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 27d9b4bba535..67d3386195bf 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -163,8 +163,8 @@ int of_node_to_nid(struct device_node *device)
 		np = of_get_next_parent(np);
 	}
 	if (np && r)
-		pr_warn("Invalid \"numa-node-id\" property in node %s\n",
-			np->name);
+		pr_warn("Invalid \"numa-node-id\" property in node %pOFn\n",
+			np);
 	of_node_put(np);
 
 	/*
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..42b1f73ac5f6 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -425,8 +425,8 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
 	for_each_child_of_node(overlay_node, child) {
 		ret = add_changeset_node(ovcs, target_node, child);
 		if (ret) {
-			pr_debug("Failed to apply node @%pOF/%s, err=%d\n",
-				 target_node, child->name, ret);
+			pr_debug("Failed to apply node @%pOF/%pOFn, err=%d\n",
+				 target_node, child, ret);
 			of_node_put(child);
 			return ret;
 		}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7ba90c290a42..868905f2d638 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -91,8 +91,8 @@ static void of_device_make_bus_id(struct device *dev)
 		 */
 		reg = of_get_property(node, "reg", NULL);
 		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
-			dev_set_name(dev, dev_name(dev) ? "%llx.%s:%s" : "%llx.%s",
-				     (unsigned long long)addr, node->name,
+			dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
+				     (unsigned long long)addr, node,
 				     dev_name(dev));
 			return;
 		}
@@ -142,8 +142,8 @@ struct platform_device *of_device_alloc(struct device_node *np,
 			WARN_ON(rc);
 		}
 		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
-			pr_debug("not all legacy IRQ resources mapped for %s\n",
-				 np->name);
+			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
+				 np);
 	}
 
 	dev->dev.of_node = of_node_get(np);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9def7be9c111..d9d012198ca5 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -212,8 +212,8 @@ static int __init of_unittest_check_node_linkage(struct device_node *np)
 
 	for_each_child_of_node(np, child) {
 		if (child->parent != np) {
-			pr_err("Child node %s links to wrong parent %s\n",
-				 child->name, np->name);
+			pr_err("Child node %pOFn links to wrong parent %pOFn\n",
+				 child, np);
 			rc = -EINVAL;
 			goto put_child;
 		}
@@ -1040,16 +1040,16 @@ static void __init of_unittest_platform_populate(void)
 	for_each_child_of_node(np, child) {
 		for_each_child_of_node(child, grandchild)
 			unittest(of_find_device_by_node(grandchild),
-				 "Could not create device for node '%s'\n",
-				 grandchild->name);
+				 "Could not create device for node '%pOFn'\n",
+				 grandchild);
 	}
 
 	of_platform_depopulate(&test_bus->dev);
 	for_each_child_of_node(np, child) {
 		for_each_child_of_node(child, grandchild)
 			unittest(!of_find_device_by_node(grandchild),
-				 "device didn't get destroyed '%s'\n",
-				 grandchild->name);
+				 "device didn't get destroyed '%pOFn'\n",
+				 grandchild);
 	}
 
 	platform_device_unregister(test_bus);
-- 
2.17.1

