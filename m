Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6283C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6283C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeKQIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42141 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so8303740oiw.9;
        Fri, 16 Nov 2018 14:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ahPfAPBkVVHlKR+9OuAA9mtdstlQ5mUFYmT8zTXrUI=;
        b=CelCnjHm7Z+WOvM46/5vqqrNIlNGxxVDYMAnP/BOQGSFHZT8Cm3HylP2litkp0RvtO
         EHBfF6R+dC+8+kS9K6rY5XBTqw8OyFvrnrK+SdIJuSaidzhkGafQdU4evB6vEYzDc1Rp
         XG9ODPx4VGN4ABJV2FPRwfUBLF+MC9o4z6qo7w6WRDSYgOyvKgg/HWovaom9Ud76gZEH
         d+w5+BlPzs+0yUj2/Ugwt1Q62f6sEDMZfnNsZRUOuPhWtfTgvjoH2pO7p5E5pOzJ3f7Z
         qAaMjHkzuDEbqyYHKoPpOify89S/5dULvNep1a7k0ZrvuDHu97jjov5CZu4QXufvFc7v
         L0dA==
X-Gm-Message-State: AGRZ1gJuImZamI5cF5LPi+L5sNY1/McBkeUn6eZm6b4BP+TwecMaQWpc
        UCWYMFZ3x7R7/mX4mF6Oow==
X-Google-Smtp-Source: AJdET5dpwKgxOZ47A/fBWjFQCeIL6+fnlfCqoU4kCjiKTo7H45pkjY+eg6k683995ebjqUBZLvK4DA==
X-Received: by 2002:aca:fd91:: with SMTP id b139mr2056107oii.83.1542406266239;
        Fri, 16 Nov 2018 14:11:06 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:05 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:10:57 -0600
Message-Id: <20181116221104.23024-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c |  4 ++--
 drivers/of/base.c    | 18 ++++++++++++------
 drivers/of/device.c  |  9 +++++----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 7ddbf0a1ab86..ae48e121b6e7 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -110,8 +110,8 @@ static int of_bus_pci_match(struct device_node *np)
 	 * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
 	 * "ht" is hypertransport
 	 */
-	return !strcmp(np->type, "pci") || !strcmp(np->type, "pciex") ||
-		!strcmp(np->type, "vci") || !strcmp(np->type, "ht");
+	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
+		of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..57c837140a8b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -79,6 +79,13 @@ bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 }
 EXPORT_SYMBOL(of_node_name_prefix);
 
+static bool __of_node_is_type(const struct device_node *np, const char *type)
+{
+	const char *match = __of_get_property(np, "device_type", NULL);
+
+	return np && match && type && !strcmp(match, type);
+}
+
 int of_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
@@ -482,7 +489,7 @@ static int __of_device_is_compatible(const struct device_node *device,
 
 	/* Matching type is better than matching name */
 	if (type && type[0]) {
-		if (!device->type || of_node_cmp(type, device->type))
+		if (!__of_node_is_type(device, type))
 			return 0;
 		score += 2;
 	}
@@ -775,7 +782,7 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
 	}
 	for (; next; next = next->sibling) {
 		if (!(of_node_name_eq(next, "cpu") ||
-		      (next->type && !of_node_cmp(next->type, "cpu"))))
+		      __of_node_is_type(next, "cpu")))
 			continue;
 		if (of_node_get(next))
 			break;
@@ -983,8 +990,7 @@ struct device_node *of_find_node_by_type(struct device_node *from,
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	for_each_of_allnodes_from(from, np)
-		if (np->type && (of_node_cmp(np->type, type) == 0)
-		    && of_node_get(np))
+		if (__of_node_is_type(np, type) && of_node_get(np))
 			break;
 	of_node_put(from);
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
@@ -2108,9 +2114,9 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && of_node_is_type(np, "cpu"))
 		for_each_child_of_node(np, child)
-			if (!strcmp(child->type, "cache"))
+			if (of_node_is_type(child, "cache"))
 				return child;
 
 	return NULL;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5592437bb3d1..3717f2a20d0d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -211,7 +211,7 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	/* Name & Type */
 	/* %p eats all alphanum characters, so %c must be used here */
 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
-			 dev->of_node->type);
+			 of_node_get_device_type(dev->of_node));
 	tsize = csize;
 	len -= csize;
 	if (str)
@@ -281,7 +281,7 @@ EXPORT_SYMBOL_GPL(of_device_modalias);
  */
 void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	const char *compat;
+	const char *compat, *type;
 	struct alias_prop *app;
 	struct property *p;
 	int seen = 0;
@@ -291,8 +291,9 @@ void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	add_uevent_var(env, "OF_NAME=%pOFn", dev->of_node);
 	add_uevent_var(env, "OF_FULLNAME=%pOF", dev->of_node);
-	if (dev->of_node->type && strcmp("<NULL>", dev->of_node->type) != 0)
-		add_uevent_var(env, "OF_TYPE=%s", dev->of_node->type);
+	type = of_node_get_device_type(dev->of_node);
+	if (type)
+		add_uevent_var(env, "OF_TYPE=%s", type);
 
 	/* Since the compatible field can contain pretty much anything
 	 * it's not really legal to split it out with commas. We split it
-- 
2.19.1

