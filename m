Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E48C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ACE21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGG2yXff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ACE21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeK3BXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01F4208E7;
        Thu, 29 Nov 2018 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501058;
        bh=5pNSrrpD0fBeKfM5KBcwWR7JFH++1tiFo+49xtQb7+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGG2yXffFUqG+39GOIjy5/ZeUWqpHbFjJH6IQUUIGMXZATnqjog5xo3rGQ2DeyZ+w
         MPxjvuvWTqxdWO0JlWvbZQQWPKMegc9eOog+2+5AkomndC9wfNtan3EYExMiDjPqX+
         taRYUOHTBtGLM9/zlGiyRMEJ5lGu9y+u7lc8ujAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 25/86] of: add helper to lookup compatible child node
Date:   Thu, 29 Nov 2018 15:11:50 +0100
Message-Id: <20181129140111.907831844@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 36156f9241cb0f9e37d998052873ca7501ad4b36 ]

Add of_get_compatible_child() helper that can be used to lookup
compatible child nodes.

Several drivers currently use of_find_compatible_node() to lookup child
nodes while failing to notice that the of_find_ functions search the
entire tree depth-first (from a given start node) and therefore can
match unrelated nodes. The fact that these functions also drop a
reference to the node they start searching from (e.g. the parent node)
is typically also overlooked, something which can lead to use-after-free
bugs.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c  | 25 +++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 31341290cd91..c6e019208d17 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -712,6 +712,31 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_next_available_child);
 
+/**
+ * of_get_compatible_child - Find compatible child node
+ * @parent:	parent node
+ * @compatible:	compatible string
+ *
+ * Lookup child node whose compatible property contains the given compatible
+ * string.
+ *
+ * Returns a node pointer with refcount incremented, use of_node_put() on it
+ * when done; or NULL if not found.
+ */
+struct device_node *of_get_compatible_child(const struct device_node *parent,
+				const char *compatible)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(parent, child) {
+		if (of_device_is_compatible(child, compatible))
+			break;
+	}
+
+	return child;
+}
+EXPORT_SYMBOL(of_get_compatible_child);
+
 /**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
diff --git a/include/linux/of.h b/include/linux/of.h
index dd10626a615f..d9371c9cd88a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -265,6 +265,8 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
 
+extern struct device_node *of_get_compatible_child(const struct device_node *parent,
+					const char *compatible);
 extern struct device_node *of_get_child_by_name(const struct device_node *node,
 					const char *name);
 
@@ -462,6 +464,12 @@ static inline bool of_have_populated_dt(void)
 	return false;
 }
 
+static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
+					const char *compatible)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_child_by_name(
 					const struct device_node *node,
 					const char *name)
-- 
2.17.1



