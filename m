Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C1420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039562;
	bh=ItZjhtQGDU/kdfCvaJZBbmAcHs286RF6nBBmFx+Fb9Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f6PFr2fwq/uaPe83Xo8Wvc9irrS8rdSj8d4AOkP6mBpiPRNY8xnZM3K3i6SZI6NtN
	 xnfUbmSn9uFeu54qh/Y0kDV3/VJg9GaDOaMr2Kfz8BytfwjBcHrXuzrp4hFGP9sT3L
	 e/oFkmrz0jKpZmZFRuYjWSsw2INmnofKe3vkS/wg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C1420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeLETvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40315 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbeLETvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so19788007oth.7;
        Wed, 05 Dec 2018 11:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+fSGn4OllWf4hAbOO3XQLLQL9DSPKaKdUubSPAsM7g=;
        b=c4rmy2X0uvWE1JC2nFi3hLfyG+vXw6Id8xI/y7X4giSmlXPelpO/IBKB0C+d/o+lRM
         jykcAY7tiL4joxkrZFSufNxl7D5Ox7Kx43I2/+QEYuAj7gkBGgxBGHTkh7Pm2aAWQaKm
         /5CqdjRadwyePjpEUvEG7GVJdF0KJ7yVuShgJj14TdlCbDAknYDf49OZolt7lBcybtPQ
         s5d33mCduiNZyayg5eggDXIak8gttNA0Nx1C7HK0RgM4eybcy6esjasXRfj29WJXM0H8
         jSGFEfa7xgHi9mSzgMP3uHeOE7a8XxRwO/F0Wh4YGMgOYXjDEYDKnhYiBhMKmo5ate1L
         KfOQ==
X-Gm-Message-State: AA+aEWb5mFYDI+EZxIIV87yjK58Ta5OmUzQKL2ec/MqdPXoY1vWbaJGL
        47ic+YppxB60nZFTBKFIgCZY3Z8=
X-Google-Smtp-Source: AFSGD/WL88zYejmq+v6vyM+oncOvEeTWh9wHe8KjzEaX2N0i3ogfqPz66ZzO/IaAdswV8JauUxYGxw==
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr15245617otj.268.1544039470271;
        Wed, 05 Dec 2018 11:51:10 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:09 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH] of: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:33 -0600
Message-Id: <20181205195050.4759-17-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c  |  2 +-
 drivers/of/base.c     |  7 +++----
 drivers/of/property.c | 10 +++++-----
 drivers/of/resolver.c |  4 ++--
 drivers/of/unittest.c |  4 ++--
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index ae48e121b6e7..2270373b30ab 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -371,7 +371,7 @@ EXPORT_SYMBOL(of_pci_range_to_resource);
 
 static int of_bus_isa_match(struct device_node *np)
 {
-	return !strcmp(np->name, "isa");
+	return of_node_name_eq(np, "isa");
 }
 
 static void of_bus_isa_count_cells(struct device_node *child,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 57c837140a8b..998d032fcef9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -496,7 +496,7 @@ static int __of_device_is_compatible(const struct device_node *device,
 
 	/* Matching name is a bit better than not */
 	if (name && name[0]) {
-		if (!device->name || of_node_cmp(name, device->name))
+		if (!of_node_name_eq(device, name))
 			return 0;
 		score++;
 	}
@@ -835,7 +835,7 @@ struct device_node *of_get_child_by_name(const struct device_node *node,
 	struct device_node *child;
 
 	for_each_child_of_node(node, child)
-		if (child->name && (of_node_cmp(child->name, name) == 0))
+		if (of_node_name_eq(child, name))
 			break;
 	return child;
 }
@@ -961,8 +961,7 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	for_each_of_allnodes_from(from, np)
-		if (np->name && (of_node_cmp(np->name, name) == 0)
-		    && of_node_get(np))
+		if (of_node_name_eq(np, name) && of_node_get(np))
 			break;
 	of_node_put(from);
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
diff --git a/drivers/of/property.c b/drivers/of/property.c
index f46828e3b082..08430031bd28 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -571,7 +571,7 @@ struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
 	for_each_child_of_node(parent, port) {
 		u32 port_id = 0;
 
-		if (of_node_cmp(port->name, "port") != 0)
+		if (!of_node_name_eq(port, "port"))
 			continue;
 		of_property_read_u32(port, "reg", &port_id);
 		if (id == port_id)
@@ -646,7 +646,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 			port = of_get_next_child(parent, port);
 			if (!port)
 				return NULL;
-		} while (of_node_cmp(port->name, "port"));
+		} while (!of_node_name_eq(port, "port"));
 	}
 }
 EXPORT_SYMBOL(of_graph_get_next_endpoint);
@@ -715,7 +715,7 @@ struct device_node *of_graph_get_port_parent(struct device_node *node)
 	/* Walk 3 levels up only if there is 'ports' node. */
 	for (depth = 3; depth && node; depth--) {
 		node = of_get_next_parent(node);
-		if (depth == 2 && of_node_cmp(node->name, "ports"))
+		if (depth == 2 && !of_node_name_eq(node, "ports"))
 			break;
 	}
 	return node;
@@ -893,7 +893,7 @@ of_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 	struct device_node *child;
 
 	for_each_available_child_of_node(node, child)
-		if (!of_node_cmp(child->name, childname))
+		if (of_node_name_eq(child, childname))
 			return of_fwnode_handle(child);
 
 	return NULL;
@@ -955,7 +955,7 @@ of_fwnode_graph_get_port_parent(struct fwnode_handle *fwnode)
 		return NULL;
 
 	/* Is this the "ports" node? If not, it's the port parent. */
-	if (of_node_cmp(np->name, "ports"))
+	if (!of_node_name_eq(np, "ports"))
 		return of_fwnode_handle(np);
 
 	return of_fwnode_handle(of_get_next_parent(np));
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 7edfac6f1914..c1b67dd7cd6e 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -281,7 +281,7 @@ int of_resolve_phandles(struct device_node *overlay)
 	adjust_overlay_phandles(overlay, phandle_delta);
 
 	for_each_child_of_node(overlay, local_fixups)
-		if (!of_node_cmp(local_fixups->name, "__local_fixups__"))
+		if (of_node_name_eq(local_fixups, "__local_fixups__"))
 			break;
 
 	err = adjust_local_phandle_references(local_fixups, overlay, phandle_delta);
@@ -291,7 +291,7 @@ int of_resolve_phandles(struct device_node *overlay)
 	overlay_fixups = NULL;
 
 	for_each_child_of_node(overlay, child) {
-		if (!of_node_cmp(child->name, "__fixups__"))
+		if (of_node_name_eq(child, "__fixups__"))
 			overlay_fixups = child;
 	}
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 49ae2aa744d6..39cf2ec1856f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2339,7 +2339,7 @@ static __init void of_unittest_overlay_high_level(void)
 	 */
 	pprev = &overlay_base_root->child;
 	for (np = overlay_base_root->child; np; np = np->sibling) {
-		if (!of_node_cmp(np->name, "__local_fixups__")) {
+		if (of_node_name_eq(np, "__local_fixups__")) {
 			*pprev = np->sibling;
 			break;
 		}
@@ -2352,7 +2352,7 @@ static __init void of_unittest_overlay_high_level(void)
 		/* will have to graft properties from node into live tree */
 		pprev = &overlay_base_root->child;
 		for (np = overlay_base_root->child; np; np = np->sibling) {
-			if (!of_node_cmp(np->name, "__symbols__")) {
+			if (of_node_name_eq(np, "__symbols__")) {
 				overlay_base_symbols = np;
 				*pprev = np->sibling;
 				break;
-- 
2.19.1

