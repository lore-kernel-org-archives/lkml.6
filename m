Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C681C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26851208B3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmYROIcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26851208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeI3CYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeI3CYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so6517850pfh.2;
        Sat, 29 Sep 2018 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFvXkTztOIIjYdRfaWKAifhvc9l1yE2CQD4pWZVMgK0=;
        b=XmYROIcMT86iOZPrHDAMyls8PEgnubW8x7RdMDmhqSfIB3BEsigASgFWoZjajKQiko
         kvd3+R62mGLUqdX/a9LK5M65JjMG8GuFCjIHe4Ka5GDhWm8qIlztw+Tnpd1O2LUBXKrP
         9bNagM89aISjoQ+MtIeu7fSzE6XSu4+vaLVLRW2xNFxnhcOVvcyFDsSn7Qd3anumo73h
         tqtKKyArKAIl1Y3ujWX9Sw8uspdzvapJYL6+RbIP08xIMu/1Dqfp4f3eTR4f2d5QqSFe
         DVTFYSTTGJMMASuh8xIH1LexKe1T+ehurSoJ1OSL0orjaYa+CPKX58fNbdjBr1BjbLsN
         lMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFvXkTztOIIjYdRfaWKAifhvc9l1yE2CQD4pWZVMgK0=;
        b=AKceqSUsHhvCu5pUnGaAs/+ubtli79VfdHwZYPSe2ASIUYBkfr7/87/6AGgmugXI00
         yt/8V4Li4hNBREXu+XqCeILTNToPccZWZFpGIOeaeHNneqoZJIqGpLzuPxPOiXWaO5zI
         Ak3ksNYVlXrO00RKVh5Bums49y1Z+IbbOyf7s3kxVqW/E7UBFuWg5Be5ySMZHuyIGJng
         MdESU5McTf0RUrG8fpUCmLba52sUivyOUr485g3j8Ft+sCj1po14PsP0V+lLU7Wb2ah9
         G8ivAgNPMkK0QKZkXQj8XTEuDkHY8fxolxCene866BpS716mIIGlxiBnSKkIX1sIbr9G
         cbRQ==
X-Gm-Message-State: ABuFfojP8Dv801Cpf31X/3r1DHnZeBk5oflRSb5mxe1vieKd0AJubMNM
        cTLtsrSYNJMyjL5pAXutgkkJp99G
X-Google-Smtp-Source: ACcGV62e8eC7NCTeq27lhfveXZ10FBKisMqSmmqJuT9THNq/GG/X45e2nuWRstf8AyEdu9ruKwP/PQ==
X-Received: by 2002:a63:f14a:: with SMTP id o10-v6mr3944100pgk.339.1538250900024;
        Sat, 29 Sep 2018 12:55:00 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:59 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 10/17] media: staging/imx: of: Remove recursive graph walk
Date:   Sat, 29 Sep 2018 12:54:13 -0700
Message-Id: <20180929195420.28579-11-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After moving to subdev notifiers, it's no longer necessary to recursively
walk the OF graph, because the subdev notifiers will discover and add
devices from the graph for us.

So the recursive of_parse_subdev() function is gone, replaced with
of_add_csi() which adds only the CSI port fwnodes to the imx-media
root notifier.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-of.c | 106 ++---------------------
 1 file changed, 8 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index acde372c6795..1c9175433ba6 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -20,74 +20,19 @@
 #include <video/imx-ipu-v3.h>
 #include "imx-media.h"
 
-static int of_get_port_count(const struct device_node *np)
+static int of_add_csi(struct imx_media_dev *imxmd, struct device_node *csi_np)
 {
-	struct device_node *ports, *child;
-	int num = 0;
-
-	/* check if this node has a ports subnode */
-	ports = of_get_child_by_name(np, "ports");
-	if (ports)
-		np = ports;
-
-	for_each_child_of_node(np, child)
-		if (of_node_cmp(child->name, "port") == 0)
-			num++;
-
-	of_node_put(ports);
-	return num;
-}
-
-/*
- * find the remote device node given local endpoint node
- */
-static bool of_get_remote(struct device_node *epnode,
-			  struct device_node **remote_node)
-{
-	struct device_node *rp, *rpp;
-	struct device_node *remote;
-	bool is_csi_port;
-
-	rp = of_graph_get_remote_port(epnode);
-	rpp = of_graph_get_remote_port_parent(epnode);
-
-	if (of_device_is_compatible(rpp, "fsl,imx6q-ipu")) {
-		/* the remote is one of the CSI ports */
-		remote = rp;
-		of_node_put(rpp);
-		is_csi_port = true;
-	} else {
-		remote = rpp;
-		of_node_put(rp);
-		is_csi_port = false;
-	}
-
-	if (!of_device_is_available(remote)) {
-		of_node_put(remote);
-		*remote_node = NULL;
-	} else {
-		*remote_node = remote;
-	}
-
-	return is_csi_port;
-}
-
-static int
-of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
-		bool is_csi_port)
-{
-	int i, num_ports, ret;
+	int ret;
 
-	if (!of_device_is_available(sd_np)) {
+	if (!of_device_is_available(csi_np)) {
 		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
-			sd_np->name);
+			csi_np->name);
 		/* unavailable is not an error */
 		return 0;
 	}
 
-	/* register this subdev with async notifier */
-	ret = imx_media_add_async_subdev(imxmd, of_fwnode_handle(sd_np),
-					 NULL);
+	/* add CSI fwnode to async notifier */
+	ret = imx_media_add_async_subdev(imxmd, of_fwnode_handle(csi_np), NULL);
 	if (ret) {
 		if (ret == -EEXIST) {
 			/* already added, everything is fine */
@@ -98,42 +43,7 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
 		return ret;
 	}
 
-	/*
-	 * the ipu-csi has one sink port. The source pads are not
-	 * represented in the device tree by port nodes, but are
-	 * described by the internal pads and links later.
-	 */
-	num_ports = is_csi_port ? 1 : of_get_port_count(sd_np);
-
-	for (i = 0; i < num_ports; i++) {
-		struct device_node *epnode = NULL, *port, *remote_np;
-
-		port = is_csi_port ? sd_np : of_graph_get_port_by_id(sd_np, i);
-		if (!port)
-			continue;
-
-		for_each_child_of_node(port, epnode) {
-			bool remote_is_csi;
-
-			remote_is_csi = of_get_remote(epnode, &remote_np);
-			if (!remote_np)
-				continue;
-
-			ret = of_parse_subdev(imxmd, remote_np, remote_is_csi);
-			of_node_put(remote_np);
-			if (ret)
-				break;
-		}
-
-		if (port != sd_np)
-			of_node_put(port);
-		if (ret) {
-			of_node_put(epnode);
-			break;
-		}
-	}
-
-	return ret;
+	return 0;
 }
 
 int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
@@ -147,7 +57,7 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
 		if (!csi_np)
 			break;
 
-		ret = of_parse_subdev(imxmd, csi_np, true);
+		ret = of_add_csi(imxmd, csi_np);
 		of_node_put(csi_np);
 		if (ret)
 			return ret;
-- 
2.17.1

