Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033478AbeBOOog (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:44:36 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:40282 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033256AbeBOOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:44:35 -0500
Date: Thu, 15 Feb 2018 15:34:55 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sil2review@lists.osadl.org
Subject: [PATCH] gpu: ipu-v3: pre: fix device node leak in
 ipu_pre_lookup_by_phandle
Message-ID: <20180215143454.xfgpdximc4yrcd4x@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning, call of_node_put() for the device node returned by
of_parse_phandle().

Fixes: d2a34232580a ("gpu: ipu-v3: add driver for Prefetch Resolve Engine")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
 drivers/gpu/ipu-v3/ipu-pre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
index f1cec3d70498..0f70e8847540 100644
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -129,11 +129,14 @@ ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
 		if (pre_node == pre->dev->of_node) {
 			mutex_unlock(&ipu_pre_list_mutex);
 			device_link_add(dev, pre->dev, DL_FLAG_AUTOREMOVE);
+			of_node_put(pre_node);
 			return pre;
 		}
 	}
 	mutex_unlock(&ipu_pre_list_mutex);
 
+	of_node_put(pre_node);
+
 	return NULL;
 }
 
-- 
2.11.0
