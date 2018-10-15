Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C9C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3E20895
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh5+o4A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3E20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJOIJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43487 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJOIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:09:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so8384198plb.10;
        Sun, 14 Oct 2018 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lcuTd93Zs0lVeU8vKhWhv5GEua+bMb9Vyzo19XuwRmc=;
        b=Bh5+o4A0M2N6QlVmdomIjWhFrf4xvr1abWLG9NqdVLB+bcy3AGcqSRkPGCzn3wYY8s
         YtrjktZUaz3bFyJ5EdvmqqSTA/TOp5SXaQgEs+SYh432/4j9sAzcMDoeQxgMmmy6e7vG
         hJivODcbGojVwlm/x3puKgANs5bB0KO7x38C8+NlPRvJjUdKCNssiEL67egRZJ7rN0l4
         JCCMqHpGmaiDkKA+/L4GVpLbDQ8y2pmK/ScEiWklxud0Mt8dqEwb2+zXF9WC+Ne9CQe0
         gdN7+8B07io3RvzaWnpkK0p5iYXxmhXtHLZ1UQX/6p+V/jNl+hUThrSR0Fiikasmxpl3
         bABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lcuTd93Zs0lVeU8vKhWhv5GEua+bMb9Vyzo19XuwRmc=;
        b=dSvDql5zlUInRsaKmLcR2+KRzZz9sPLMo1gnViUEInGFS4hQSIWl4b81Mj4Oiv8jQF
         FCwZ+2PPVSDgW+fJ9vcVHSQOL9vpn0oq9fa85PNFmFfaQ6/jf73mDHXf01+cG/8ICwzu
         3xio9dD0JHQPSFRmh0aIyGxmYAZGrmn9SWEgVlO34HfsVdwhe+de4A7cZO0Bs5FKO9pQ
         mNRJWW6WxU9F0yH4KnQpXs2x1sr82pxxAdcXp0W9aRDWbcZNN046zGHZNO4S0raMuM6R
         GAYYUYeLOyJ7OS8AG+T+UW6CAKetlUXTloxpaSg1ca/J5PLo13DbZ3+meE4cx5eAw8Ck
         jpLg==
X-Gm-Message-State: ABuFfoh82QiJ6hXKGOpUQUL56Bi2z9+hXLSmQ9WE2bk1bKRloBhJkkT+
        QwA5cVbrFjMACDBbZ3pKsn4=
X-Google-Smtp-Source: ACcGV63xgSMZmmfakM1xgmwWpxXa2OCrH10UuSWo8uVM11CtijeadZtv2y99CZR1xD+Gk91tNXiRLw==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr15031222pln.27.1539563178699;
        Sun, 14 Oct 2018 17:26:18 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:18 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 15/18] of: overlay: set node fields from properties when add new overlay node
Date:   Sun, 14 Oct 2018 17:24:27 -0700
Message-Id: <1539563070-12969-16-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Overlay nodes added by add_changeset_node() do not have the node
fields name, phandle, and type set.

The node passed to __of_attach_node() when the add node changeset
entry is processed does not contain any properties.  The node's
properties are located in add property changeset entries that will
be processed after the add node changeset is applied.

Set the node's fields in the node contained in the add node
changeset entry and do not set them to incorrect values in
add_changeset_node().

A visible symptom that is fixed by this patch is the names of nodes
added by overlays that have an entry in /sys/bus/platform/drivers/*/
will contain the unit-address but the node-name will be <NULL>,  for
example, "fc4ab000.<NULL>".  After applying the patch the name, in
this example, for node restart@fc4ab000 is "fc4ab000.restart".

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c | 27 ++++++++++++++++++---------
 drivers/of/overlay.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 5f7c99b9de0d..5b740114dbdc 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -205,15 +205,24 @@ static void __of_attach_node(struct device_node *np)
 	const __be32 *phandle;
 	int sz;
 
-	np->name = __of_get_property(np, "name", NULL) ? : "<NULL>";
-	np->type = __of_get_property(np, "device_type", NULL) ? : "<NULL>";
-
-	phandle = __of_get_property(np, "phandle", &sz);
-	if (!phandle)
-		phandle = __of_get_property(np, "linux,phandle", &sz);
-	if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
-		phandle = __of_get_property(np, "ibm,phandle", &sz);
-	np->phandle = (phandle && (sz >= 4)) ? be32_to_cpup(phandle) : 0;
+	if (!of_node_check_flag(np, OF_OVERLAY)) {
+		np->name = __of_get_property(np, "name", NULL);
+		np->type = __of_get_property(np, "device_type", NULL);
+		if (!np->name)
+			np->name = "<NULL>";
+		if (!np->type)
+			np->type = "<NULL>";
+
+		phandle = __of_get_property(np, "phandle", &sz);
+		if (!phandle)
+			phandle = __of_get_property(np, "linux,phandle", &sz);
+		if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
+			phandle = __of_get_property(np, "ibm,phandle", &sz);
+		if (phandle && (sz >= 4))
+			np->phandle = be32_to_cpup(phandle);
+		else
+			np->phandle = 0;
+	}
 
 	np->child = NULL;
 	np->sibling = np->parent->child;
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 908bcc62019b..f5c3330567b6 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -307,10 +307,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	int ret = 0;
 	bool check_for_non_overlay_node = false;
 
-	if (!of_prop_cmp(overlay_prop->name, "name") ||
-	    !of_prop_cmp(overlay_prop->name, "phandle") ||
-	    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
-		return 0;
+	if (target->in_livetree)
+		if (!of_prop_cmp(overlay_prop->name, "name") ||
+		    !of_prop_cmp(overlay_prop->name, "phandle") ||
+		    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
+			return 0;
 
 	if (target->in_livetree)
 		prop = of_find_property(target->np, overlay_prop->name, NULL);
@@ -331,6 +332,10 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!prop) {
 
 		check_for_non_overlay_node = true;
+		if (!target->in_livetree) {
+			new_prop->next = target->np->deadprops;
+			target->np->deadprops = new_prop;
+		}
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
 
@@ -406,9 +411,10 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		struct target *target, struct device_node *node)
 {
 	const char *node_kbasename;
+	const __be32 *phandle;
 	struct device_node *tchild;
 	struct target target_child;
-	int ret = 0;
+	int ret = 0, size;
 
 	node_kbasename = kbasename(node->full_name);
 
@@ -422,6 +428,19 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			return -ENOMEM;
 
 		tchild->parent = target->np;
+		tchild->name = __of_get_property(node, "name", NULL);
+		tchild->type = __of_get_property(node, "device_type", NULL);
+
+		if (!tchild->name)
+			tchild->name = "<NULL>";
+		if (!tchild->type)
+			tchild->type = "<NULL>";
+
+		/* ignore obsolete "linux,phandle" */
+		phandle = __of_get_property(node, "phandle", &size);
+		if (phandle && (size == 4))
+			tchild->phandle = be32_to_cpup(phandle);
+
 		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
-- 
Frank Rowand <frank.rowand@sony.com>

