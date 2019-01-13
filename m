Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5120873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfAMJZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:25:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60664
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfAMJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:24:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291725800"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 10:24:46 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/imx: imx-ldb: add missing of_node_puts
Date:   Sun, 13 Jan 2019 09:47:42 +0100
Message-Id: <1547369264-24831-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node iterators perform an of_node_get on each
iteration, so a jump out of the loop requires an of_node_put.

Move the initialization channel->child = child; down to just
before the call to imx_ldb_register so that intervening failures
don't need to clear it.  Add a label at the end of the function to
do all the of_node_puts.

The semantic patch that finds part of this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
*  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
This changes the semantics, with respect to the availability of the child
field, and has not been tested.

 drivers/gpu/drm/imx/imx-ldb.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 2c5bbe3..e31e263 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -643,8 +643,10 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		int bus_format;
 
 		ret = of_property_read_u32(child, "reg", &i);
-		if (ret || i < 0 || i > 1)
-			return -EINVAL;
+		if (ret || i < 0 || i > 1) {
+			ret = -EINVAL;
+			goto free_child;
+		}
 
 		if (!of_device_is_available(child))
 			continue;
@@ -657,7 +659,6 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		channel = &imx_ldb->channel[i];
 		channel->ldb = imx_ldb;
 		channel->chno = i;
-		channel->child = child;
 
 		/*
 		 * The output port is port@4 with an external 4-port mux or
@@ -667,13 +668,13 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 						  imx_ldb->lvds_mux ? 4 : 2, 0,
 						  &channel->panel, &channel->bridge);
 		if (ret && ret != -ENODEV)
-			return ret;
+			goto free_child;
 
 		/* panel ddc only if there is no bridge */
 		if (!channel->bridge) {
 			ret = imx_ldb_panel_ddc(dev, channel, child);
 			if (ret)
-				return ret;
+				goto free_child;
 		}
 
 		bus_format = of_get_bus_format(dev, child);
@@ -689,18 +690,26 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		if (bus_format < 0) {
 			dev_err(dev, "could not determine data mapping: %d\n",
 				bus_format);
-			return bus_format;
+			ret = bus_format;
+			goto free_child;
 		}
 		channel->bus_format = bus_format;
+		channel->child = child;
 
 		ret = imx_ldb_register(drm, channel);
-		if (ret)
-			return ret;
+		if (ret) {
+			channel->child = NULL;
+			goto free_child;
+		}
 	}
 
 	dev_set_drvdata(dev, imx_ldb);
 
 	return 0;
+
+free_child:
+	of_node_put(child);
+	return ret;
 }
 
 static void imx_ldb_unbind(struct device *dev, struct device *master,

