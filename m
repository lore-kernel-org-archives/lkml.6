Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E61ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDBC2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDBC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeIXSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:41:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbeIXSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:41:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06A001098;
        Mon, 24 Sep 2018 12:39:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.18 144/235] of: add helper to lookup compatible child node
Date:   Mon, 24 Sep 2018 13:52:10 +0200
Message-Id: <20180924113119.969672702@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 36156f9241cb0f9e37d998052873ca7501ad4b36 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/base.c  |   25 +++++++++++++++++++++++++
 include/linux/of.h |    8 ++++++++
 2 files changed, 33 insertions(+)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -723,6 +723,31 @@ struct device_node *of_get_next_availabl
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
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
+/**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
  *	@name:	child name to look for.
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -290,6 +290,8 @@ extern struct device_node *of_get_next_c
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
 
+extern struct device_node *of_get_compatible_child(const struct device_node *parent,
+					const char *compatible);
 extern struct device_node *of_get_child_by_name(const struct device_node *node,
 					const char *name);
 
@@ -632,6 +634,12 @@ static inline bool of_have_populated_dt(
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


