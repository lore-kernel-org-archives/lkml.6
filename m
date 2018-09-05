Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D630C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF5F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF5F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeIFAJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45470 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIFAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so15893887oie.12;
        Wed, 05 Sep 2018 12:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SZQ1f+JXN7jSVhs4sms8EAGGvJZEZgAKSw8PvyGN5W8=;
        b=S6n5f0fulcnaRJ6975CfoYP+masr/9rUjdyFlcSQG14GYTrk1OIU7oylc4nkdvxKi2
         61KFfNUtJ40kq+GNZV821xlyc7J5Sr+Uw6ltChiKKiXr4wQXnap3AAFKc+QvZYJcxfmb
         peRp4RK6zWK8dBI4pCRdwbF1yuG5Cl5Sb0jyLcN42MJGAi0PU38DJbYnlCNcffGk5GYf
         MjlwbRmCsSueBfupPsWJfW6uznAuBRtQYeyouVhumnbpYvjESXsNJePGaFTGOHlhXe5V
         X/13abzj/eVB42YkVzCE+kFaNOh5OcKwQcsXosG0JknRUd8vrZKpI3HAgMmykOyyMLQc
         Q4Gg==
X-Gm-Message-State: APzg51AwhTxnVV6b0WmLlktDHphoxAqNBIvl0N2SNGq6Ua4xuF+lK2g8
        +yUOZDPWBm60CMPZDrBXU5XX5bQ=
X-Google-Smtp-Source: ANB0Vda9dZUGOQUFyDOPjN6NR0r50cE/F+gk2ROma+tKzx4budcKkyF5OVRnCIdi5DvlsjksgyGDxQ==
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr33048339oie.152.1536176261939;
        Wed, 05 Sep 2018 12:37:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
Date:   Wed,  5 Sep 2018 14:37:18 -0500
Message-Id: <20180905193738.19325-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterating thru cpu nodes is a common pattern. Create a common iterator
which can find child nodes either by node name or device_type == cpu.
Using the former will allow for eventually dropping device_type
properties which are deprecated for FDT.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 11 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a055cd1ef96d..4807db0a35b3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -741,6 +741,45 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_next_available_child);

+/**
+ *	of_get_next_cpu_node - Iterate on cpu nodes
+ *	@prev:	previous child of the /cpus node, or NULL to get first
+ *
+ *	Returns a cpu node pointer with refcount incremented, use of_node_put()
+ *	on it when done. Returns NULL when prev is the last child. Decrements
+ *	the refcount of prev.
+ */
+struct device_node *of_get_next_cpu_node(struct device_node *prev)
+{
+	struct device_node *next = NULL;
+	unsigned long flags;
+	struct device_node *node;
+
+	if (!prev)
+		node = of_find_node_by_path("/cpus");
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	if (prev)
+		next = prev->sibling;
+	else if (node) {
+		next = node->child;
+		of_node_put(node);
+	}
+	for (; next; next = next->sibling) {
+		if (!(of_node_name_eq(next, "cpu") ||
+		      (next->type && !of_node_cmp(next->type, "cpu"))))
+			continue;
+		if (!__of_device_is_available(next))
+			continue;
+		if (of_node_get(next))
+			break;
+	}
+	of_node_put(prev);
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	return next;
+}
+EXPORT_SYMBOL(of_get_next_cpu_node);
+
 /**
  * of_get_compatible_child - Find compatible child node
  * @parent:	parent node
diff --git a/include/linux/of.h b/include/linux/of.h
index 99b0ebf49632..1aca0dbd35df 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -353,6 +353,8 @@ extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
+extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
+
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)

@@ -754,6 +756,11 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }

+static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
@@ -1217,6 +1224,10 @@ static inline int of_property_read_s32(const struct device_node *np,
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))

+#define for_each_of_cpu_node(cpu) \
+	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
+	     cpu = of_get_next_cpu_node(cpu))
+
 #define for_each_node_with_property(dn, prop_name) \
 	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
 	     dn = of_find_node_with_property(dn, prop_name))
--
2.17.1
