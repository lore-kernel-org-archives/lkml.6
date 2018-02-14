Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966518AbeBNBwI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:52:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:56121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966458AbeBNBv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498964"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 9/9] hyper_dmabuf: threaded interrupt in Xen-backend
Date: Tue, 13 Feb 2018 17:50:08 -0800
Message-Id: <20180214015008.9513-10-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use threaded interrupt intead of regular one because most part of ISR
is time-critical and possibly sleeps

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 .../hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
index 30bc4b6304ac..65af5ddfb2d7 100644
--- a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
@@ -332,11 +332,14 @@ int xen_be_init_tx_rbuf(int domid)
 	}
 
 	/* setting up interrupt */
-	ret = bind_evtchn_to_irqhandler(alloc_unbound.port,
-					front_ring_isr, 0,
-					NULL, (void *) ring_info);
+	ring_info->irq = bind_evtchn_to_irq(alloc_unbound.port);
 
-	if (ret < 0) {
+	ret = request_threaded_irq(ring_info->irq,
+				   NULL,
+				   front_ring_isr,
+				   IRQF_ONESHOT, NULL, ring_info);
+
+	if (ret != 0) {
 		dev_err(hy_drv_priv->dev,
 			"Failed to setup event channel\n");
 		close.port = alloc_unbound.port;
@@ -348,7 +351,6 @@ int xen_be_init_tx_rbuf(int domid)
 	}
 
 	ring_info->rdomain = domid;
-	ring_info->irq = ret;
 	ring_info->port = alloc_unbound.port;
 
 	mutex_init(&ring_info->lock);
@@ -535,9 +537,10 @@ int xen_be_init_rx_rbuf(int domid)
 	if (!xen_comm_find_tx_ring(domid))
 		ret = xen_be_init_tx_rbuf(domid);
 
-	ret = request_irq(ring_info->irq,
-			  back_ring_isr, 0,
-			  NULL, (void *)ring_info);
+	ret = request_threaded_irq(ring_info->irq,
+				   NULL,
+				   back_ring_isr, IRQF_ONESHOT,
+				   NULL, (void *)ring_info);
 
 	return ret;
 
-- 
2.16.1
