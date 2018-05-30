Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeE3L3u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41993 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeE3L3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:29:41 -0400
X-Google-Smtp-Source: ADUXVKJRHoQ2/QMRDDw3Qap3CUP+Khv5tDXQOYbfu/4rqSECsBHNYOLraKfPbvQllPJzusXfm0lD0g==
From: Baolin Wang <baolin.wang@linaro.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] mm: dmapool: Check the dma pool name
Date: Wed, 30 May 2018 19:28:43 +0800
Message-Id: <59623b15001e5a20ac32b1a393db88722be2e718.1527679621.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be crash if we pass one NULL name when creating one dma pool,
so we should check the passing name when copy it to dma pool.

Moreover this patch replaces kmalloc_node() with kzalloc_node() to make
sure the name array of dma pool is initialized in case the passing name
is NULL.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 mm/dmapool.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4d90a64..349f13d 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -155,11 +155,12 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if ((boundary < size) || (boundary & (boundary - 1)))
 		return NULL;
 
-	retval = kmalloc_node(sizeof(*retval), GFP_KERNEL, dev_to_node(dev));
+	retval = kzalloc_node(sizeof(*retval), GFP_KERNEL, dev_to_node(dev));
 	if (!retval)
 		return retval;
 
-	strlcpy(retval->name, name, sizeof(retval->name));
+	if (name)
+		strlcpy(retval->name, name, sizeof(retval->name));
 
 	retval->dev = dev;
 
-- 
1.7.9.5
