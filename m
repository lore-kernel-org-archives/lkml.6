Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9401C20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8MoydQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9401C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeLEQTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:19:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40923 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeLEQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:19:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so10234892pfo.7;
        Wed, 05 Dec 2018 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1dQ2p+wlJHnvgVjYXtksddQgKWwiQhuGWFNxVx0hU0=;
        b=O8MoydQ8bu5yH3IGdjAhrJyjGmnDk/357P9kJMcDbZB/pREEkjik3QvxOS8nQFBdp6
         njry5vdtEJq3luMkbmN8YM4KP5G7fXxVhohi5FEqlzd6nN9WC9DJPB4z+OH+Lft/vsr1
         KNO9dsxnyMeGS+sgrPs0yM5TIkp5XdmG5isGjVa9HTW44ijWM8+mJ0bkaM/BAeHdJPem
         npE9whVqclztUjli3S11SJMxAOn4z75gj938CCwqEE4NqIJ2wL86QbATX+lseZoywmK0
         0pPgFpCCnkJCWaTUvB9Xz5kWql5Vxo9bd2HLdTQuF158+OMIJORYvRcRHix0MK3ZPLba
         RPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1dQ2p+wlJHnvgVjYXtksddQgKWwiQhuGWFNxVx0hU0=;
        b=LvXga/d48HHUuUT+pe3t9EsofhEB6dpcAXwU2OyeATbQYuqzSHOc8UrU5nb63DIlwY
         6SX9yTDkUEGYIlGVPfGYFeHQ/XgFqaKkEkHGbC+hkP7dZWJXDfdnMJVioqaCw9jzZ9It
         TBbVVZkJzuOQRh3aehpWbSyLYHsKMFlwil5PdodLXBpsdfeGhThlxtLfaMPXTd4QEb02
         s9xMYK+rH2chI59Gm5xTsiKs7jFgptHoKXLzCi4Yyi8Q3x8jHLopEv2ICnuY+c/QyB2o
         MXU/MV1zR9bH5kw5ZuPajvJUmd6iA33ZEe5zXj41y9iHqjQ3oe+dMiGT2GgXaxZq4PqQ
         bsoQ==
X-Gm-Message-State: AA+aEWZXDluGLYcSPXkFjLW44RewzW/zpbyBswgqzM0rd1QCeBDR+AKY
        I3Xg1yZfndJ1kwhBwK45ldA=
X-Google-Smtp-Source: AFSGD/W0w2+Trnd5e1MgQZoMYzuj/aaMuoTd9y9BpPGEx6ZBSGqeQ8rAGc/1WXiAwBXVkBr2EFQxnA==
X-Received: by 2002:a62:190e:: with SMTP id 14mr24887086pfz.70.1544026756215;
        Wed, 05 Dec 2018 08:19:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v190sm30041298pfv.26.2018.12.05.08.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:19:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/4] dmaengine: pxa: remove DBGFS_FUNC_DECL()
Date:   Wed,  5 Dec 2018 11:18:59 -0500
Message-Id: <20181205161900.16434-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
such a macro, so remove DBGFS_FUNC_DECL.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 825725057e00..e78fe98b5cf1 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -189,7 +189,7 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param);
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
 
-static int dbg_show_requester_chan(struct seq_file *s, void *p)
+static int requester_chan_show(struct seq_file *s, void *p)
 {
 	struct pxad_phy *phy = s->private;
 	int i;
@@ -220,7 +220,7 @@ static int is_phys_valid(unsigned long addr)
 #define PXA_DCSR_STR(flag) (dcsr & PXA_DCSR_##flag ? #flag" " : "")
 #define PXA_DCMD_STR(flag) (dcmd & PXA_DCMD_##flag ? #flag" " : "")
 
-static int dbg_show_descriptors(struct seq_file *s, void *p)
+static int descriptors_show(struct seq_file *s, void *p)
 {
 	struct pxad_phy *phy = s->private;
 	int i, max_show = 20, burst, width;
@@ -263,7 +263,7 @@ static int dbg_show_descriptors(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int dbg_show_chan_state(struct seq_file *s, void *p)
+static int chan_state_show(struct seq_file *s, void *p)
 {
 	struct pxad_phy *phy = s->private;
 	u32 dcsr, dcmd;
@@ -306,7 +306,7 @@ static int dbg_show_chan_state(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int dbg_show_state(struct seq_file *s, void *p)
+static int state_show(struct seq_file *s, void *p)
 {
 	struct pxad_device *pdev = s->private;
 
@@ -317,22 +317,10 @@ static int dbg_show_state(struct seq_file *s, void *p)
 	return 0;
 }
 
-#define DBGFS_FUNC_DECL(name) \
-static int dbg_open_##name(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, dbg_show_##name, inode->i_private); \
-} \
-static const struct file_operations dbg_fops_##name = { \
-	.open		= dbg_open_##name, \
-	.llseek		= seq_lseek, \
-	.read		= seq_read, \
-	.release	= single_release, \
-}
-
-DBGFS_FUNC_DECL(state);
-DBGFS_FUNC_DECL(chan_state);
-DBGFS_FUNC_DECL(descriptors);
-DBGFS_FUNC_DECL(requester_chan);
+DEFINE_SHOW_ATTRIBUTE(state);
+DEFINE_SHOW_ATTRIBUTE(chan_state);
+DEFINE_SHOW_ATTRIBUTE(descriptors);
+DEFINE_SHOW_ATTRIBUTE(requester_chan);
 
 static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
 					     int ch, struct dentry *chandir)
@@ -348,13 +336,13 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
 
 	if (chan)
 		chan_state = debugfs_create_file("state", 0400, chan, dt,
-						 &dbg_fops_chan_state);
+						 &chan_state_fops);
 	if (chan_state)
 		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
-						 &dbg_fops_descriptors);
+						 &descriptors_fops);
 	if (chan_descr)
 		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
-						&dbg_fops_requester_chan);
+						&requester_chan_fops);
 	if (!chan_reqs)
 		goto err_state;
 
@@ -375,7 +363,7 @@ static void pxad_init_debugfs(struct pxad_device *pdev)
 		goto err_root;
 
 	pdev->dbgfs_state = debugfs_create_file("state", 0400, pdev->dbgfs_root,
-						pdev, &dbg_fops_state);
+						pdev, &state_fops);
 	if (!pdev->dbgfs_state)
 		goto err_state;
 
-- 
2.17.0

