Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033464AbeBOOof (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:44:35 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:40284 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033153AbeBOOoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:44:34 -0500
Date: Thu, 15 Feb 2018 15:35:30 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sil2review@lists.osadl.org
Subject: [PATCH] gpu: ipu-v3: prg: fix device node leak in
 ipu_prg_lookup_by_phandle
Message-ID: <20180215143530.e3qxat3rxcudqcsl@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning, call of_node_put() for the device node returned by
of_parse_phandle().

Fixes: ea9c260514c1 ("gpu: ipu-v3: add driver for Prefetch Resolve Gasket")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 067365c733c6..97b99500153d 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -102,11 +102,14 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 			mutex_unlock(&ipu_prg_list_mutex);
 			device_link_add(dev, prg->dev, DL_FLAG_AUTOREMOVE);
 			prg->id = ipu_id;
+			of_node_put(prg_node);
 			return prg;
 		}
 	}
 	mutex_unlock(&ipu_prg_list_mutex);
 
+	of_node_put(prg_node);
+
 	return NULL;
 }
 
-- 
2.11.0
