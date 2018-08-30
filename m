Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9EF20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9EF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeH3Wzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:55:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35694 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Wzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:55:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so17336554oic.2;
        Thu, 30 Aug 2018 11:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bU8Ge6+nlZXLJgwhVZ43Qgco2niBTNtZy9BzLIh7PwY=;
        b=IIgUtZOgXBcxrj56mJJCGn71Ia4HOCN6lFQr52HD+z0dakTqMb8TEYApT8LoJynSd7
         Hm6I5Z7PhMievqlhiD8HDhASokMeRUR2H0wMBXLROiHcyDWzphO4fVBurXKFZGrKkmgC
         e/m0uyHs1Zo0X6EXXfLPG6gbtrLK7uaP8D49v8cXDEs3+vFtPnmUJKMzuE6UcNQT91Qb
         GjRMcKt0YY/LbZLMEaD3p9dEQIMsQIDVqhFdQvRCBVxha5wnES45OwH+kPlFBVQK1UNB
         yvlNQqXlaopSGNeDWHklfo2JFdGtjMbUAGQ+ak9EPGqEi2BLxekBWjG9hj5TR1chH4+9
         qxvA==
X-Gm-Message-State: APzg51DjbpSLmo/xSJUH5RQs9yiPdU+IH9jjqf/eXQrEhdd80aPWDrhM
        K6vBZ95J4t9H8VTg+ed2g7Z0ZIQ=
X-Google-Smtp-Source: ANB0VdZgyeoN/1SVVy9M7i1ZDIbFyrJtRwdMUBwQ9olqualLHHtWTQvO+aoEjG7uDY4w8lg7yWuN2Q==
X-Received: by 2002:aca:d7c1:: with SMTP id o184-v6mr3916517oig.347.1535655138096;
        Thu, 30 Aug 2018 11:52:18 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm11763317oiy.2.2018.08.30.11.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:52:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: add node name compare helper functions
Date:   Thu, 30 Aug 2018 13:52:16 -0500
Message-Id: <20180830185216.20054-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove device_node.name pointer, add helper functions
for node name comparisons which are a common pattern throughout the kernel.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..185bfe077d0a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -54,6 +54,28 @@ DEFINE_MUTEX(of_mutex);
  */
 DEFINE_RAW_SPINLOCK(devtree_lock);
 
+bool of_node_name_eq(const struct device_node *np, const char *name)
+{
+	const char *node_name;
+	size_t len;
+
+	if (!np)
+		return false;
+
+	node_name = kbasename(np->full_name);
+	len = strchrnul(node_name, '@') - node_name;
+
+	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
+}
+
+bool of_node_name_prefix(const struct device_node *np, const char *prefix)
+{
+	if (!np)
+		return false;
+
+	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
+}
+
 int of_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..a40f63a36afa 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -256,6 +256,9 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
+extern bool of_node_name_eq(const struct device_node *np, const char *name);
+extern bool of_node_name_prefix(const struct device_node *np, const char *prefix);
+
 static inline const char *of_node_full_name(const struct device_node *np)
 {
 	return np ? np->full_name : "<no-node>";
@@ -561,6 +564,16 @@ static inline struct device_node *to_of_node(const struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline bool of_node_name_eq(const struct device_node *np, const char *name)
+{
+	return false;
+}
+
+static inline bool of_node_name_prefix(const struct device_node *np, const char *prefix)
+{
+	return false;
+}
+
 static inline const char* of_node_full_name(const struct device_node *np)
 {
 	return "<no-node>";
-- 
2.17.1

