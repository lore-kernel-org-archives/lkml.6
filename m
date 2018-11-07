Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD96C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA72086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA72086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeKHIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42787 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeKHIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id n46so12110023otb.9;
        Wed, 07 Nov 2018 14:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzI8JHdrx3gMSYYSAWjUWfYDzwDDbM1CO6mI41xpJGw=;
        b=iNipIryrABO8B97uPY646/9dkP9qT17nPVLD+4TydaCyQsSd/z4LLrkbkdScSjgRSi
         0Nn/yXHWur6hib+mS0Xa6DF+j6Hhufhwd9TuXPBhCwOokH6fS4bEdkq6aKQNuiggSf+u
         YxBbOCRkszo6682MRnI2b9zVYwLG2NykVYCr4zrR1H16ByoToVMSvGiHRmy9rAIGVXS5
         gORle8Sy0y0Sf7zRu4L3mQHv/j9Kj4OxFFlTCuVor3IhyaMh7q77pojIjdwEVCVJah+E
         SUrCTqJeAj+j0UMY7YkqwJknLABCqgiKhW6NCQ5JsL9f9QP+MQl8HzcLepBQ+7YrbQ8s
         tIdw==
X-Gm-Message-State: AGRZ1gIyCQlwplo2k1lKLzThdQZUm9yJIfT/UYBnnmhyzntjIyvDo+vz
        X37GIzcq+ize1aUyVQzw5A==
X-Google-Smtp-Source: AJdET5fZHsaUeQSpvFRVSRdZPPQfzIV3F1OmIVw8hx/2zH1KuDMPGt/e5K8wG8dMrjuwmFPA0ZvgRQ==
X-Received: by 2002:a9d:2987:: with SMTP id n7mr1316096otb.339.1541629915084;
        Wed, 07 Nov 2018 14:31:55 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:31:54 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
Date:   Wed,  7 Nov 2018 16:31:45 -0600
Message-Id: <20181107223151.14991-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are no more users of path_component_name outside of
the PDT code and users of device_node.full_name are converted to use
"%pOF" printf specifier, we can align Sparc with other arches and store
just the base node name and unit address in full_name. This makes
path_component_name redundant, so it can be removed.

As full_name is used by printf specifiers, set it as early as possible.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/pdt.c   | 26 +++-----------------------
 include/linux/of.h |  1 -
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 013e65de074a..40321b6b82e2 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
 
 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
-	int len, ourlen, plen;
-	char *n;
-
-	dp->path_component_name = build_path_component(dp);
-
-	plen = strlen(dp->parent->full_name);
-	ourlen = strlen(dp->path_component_name);
-	len = ourlen + plen + 2;
-
-	n = prom_early_alloc(len);
-	strcpy(n, dp->parent->full_name);
-	if (!of_node_is_root(dp->parent)) {
-		strcpy(n + plen, "/");
-		plen++;
-	}
-	strcpy(n + plen, dp->path_component_name);
-
-	return n;
+	return build_path_component(dp);
 }
 
 #else /* CONFIG_SPARC */
@@ -181,6 +164,8 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 
 	dp->properties = of_pdt_build_prop_list(node);
 
+	dp->full_name = of_pdt_build_full_name(dp);
+
 	irq_trans_init(dp);
 
 	return dp;
@@ -204,8 +189,6 @@ static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
 			ret = dp;
 		prev_sibling = dp;
 
-		dp->full_name = of_pdt_build_full_name(dp);
-
 		dp->child = of_pdt_build_tree(dp, of_pdt_prom_ops->getchild(node));
 
 		if (of_pdt_build_more)
@@ -228,9 +211,6 @@ void __init of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops)
 	of_pdt_prom_ops = ops;
 
 	of_root = of_pdt_create_node(root_node, NULL);
-#if defined(CONFIG_SPARC)
-	of_root->path_component_name = "";
-#endif
 	of_root->full_name = "/";
 
 	of_root->child = of_pdt_build_tree(of_root,
diff --git a/include/linux/of.h b/include/linux/of.h
index a5aee3c438ad..0fe5bef81a7e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -66,7 +66,6 @@ struct device_node {
 	unsigned long _flags;
 	void	*data;
 #if defined(CONFIG_SPARC)
-	const char *path_component_name;
 	unsigned int unique_id;
 	struct of_irq_controller *irq_trans;
 #endif
-- 
2.19.1

