Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE948C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00B220865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00B220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeILEql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:5845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbeILEqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208235"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/9] HID: intel_ish-hid: Enhance API to get ring buffer sizes
Date:   Tue, 11 Sep 2018 16:44:19 -0700
Message-Id: <20180911234421.10691-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added two APIs:

- ishtp_cl_get_tx_free_buffer_size:
This returns total size available for a client to queue TX data.

- ishtp_cl_get_tx_free_rings:
This returns total number of TX rings available for a client.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../hid/intel-ish-hid/ishtp/client-buffers.c  |  4 ++++
 drivers/hid/intel-ish-hid/ishtp/client.c      | 24 +++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.h      |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index 12d61305e83d..248651c35497 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -69,6 +69,8 @@ int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl)
 	int	j;
 	unsigned long	flags;
 
+	cl->tx_ring_free_size = 0;
+
 	/* Allocate pool to free Tx bufs */
 	for (j = 0; j < cl->tx_ring_size; ++j) {
 		struct ishtp_cl_tx_ring	*tx_buf;
@@ -85,6 +87,7 @@ int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl)
 
 		spin_lock_irqsave(&cl->tx_free_list_spinlock, flags);
 		list_add_tail(&tx_buf->list, &cl->tx_free_list.list);
+		++cl->tx_ring_free_size;
 		spin_unlock_irqrestore(&cl->tx_free_list_spinlock, flags);
 	}
 	return	0;
@@ -144,6 +147,7 @@ void ishtp_cl_free_tx_ring(struct ishtp_cl *cl)
 		tx_buf = list_entry(cl->tx_free_list.list.next,
 				    struct ishtp_cl_tx_ring, list);
 		list_del(&tx_buf->list);
+		--cl->tx_ring_free_size;
 		kfree(tx_buf->send_buf.data);
 		kfree(tx_buf);
 	}
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 007443ef5fca..faeccdb1475b 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -22,6 +22,25 @@
 #include "hbm.h"
 #include "client.h"
 
+int ishtp_cl_get_tx_free_buffer_size(struct ishtp_cl *cl)
+{
+	unsigned long tx_free_flags;
+	int size;
+
+	spin_lock_irqsave(&cl->tx_free_list_spinlock, tx_free_flags);
+	size = cl->tx_ring_free_size * cl->device->fw_client->props.max_msg_length;
+	spin_unlock_irqrestore(&cl->tx_free_list_spinlock, tx_free_flags);
+
+	return size;
+}
+EXPORT_SYMBOL(ishtp_cl_get_tx_free_buffer_size);
+
+int ishtp_cl_get_tx_free_rings(struct ishtp_cl *cl)
+{
+	return cl->tx_ring_free_size;
+}
+EXPORT_SYMBOL(ishtp_cl_get_tx_free_rings);
+
 /**
  * ishtp_read_list_flush() - Flush read queue
  * @cl: ishtp client instance
@@ -90,6 +109,7 @@ static void ishtp_cl_init(struct ishtp_cl *cl, struct ishtp_device *dev)
 
 	cl->rx_ring_size = CL_DEF_RX_RING_SIZE;
 	cl->tx_ring_size = CL_DEF_TX_RING_SIZE;
+	cl->tx_ring_free_size = cl->tx_ring_size;
 
 	/* dma */
 	cl->last_tx_path = CL_TX_PATH_IPC;
@@ -577,6 +597,8 @@ int ishtp_cl_send(struct ishtp_cl *cl, uint8_t *buf, size_t length)
 	 * max ISHTP message size per client
 	 */
 	list_del_init(&cl_msg->list);
+	--cl->tx_ring_free_size;
+
 	spin_unlock_irqrestore(&cl->tx_free_list_spinlock, tx_free_flags);
 	memcpy(cl_msg->send_buf.data, buf, length);
 	cl_msg->send_buf.size = length;
@@ -685,6 +707,7 @@ static void ipc_tx_callback(void *prm)
 		ishtp_write_message(dev, &ishtp_hdr, pmsg);
 		spin_lock_irqsave(&cl->tx_free_list_spinlock, tx_free_flags);
 		list_add_tail(&cl_msg->list, &cl->tx_free_list.list);
+		++cl->tx_ring_free_size;
 		spin_unlock_irqrestore(&cl->tx_free_list_spinlock,
 			tx_free_flags);
 	} else {
@@ -778,6 +801,7 @@ static void ishtp_cl_send_msg_dma(struct ishtp_device *dev,
 	ishtp_write_message(dev, &hdr, (unsigned char *)&dma_xfer);
 	spin_lock_irqsave(&cl->tx_free_list_spinlock, tx_free_flags);
 	list_add_tail(&cl_msg->list, &cl->tx_free_list.list);
+	++cl->tx_ring_free_size;
 	spin_unlock_irqrestore(&cl->tx_free_list_spinlock, tx_free_flags);
 	++cl->send_msg_cnt_dma;
 }
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index a82ee4d82cdb..042f4c4853b1 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -84,6 +84,7 @@ struct ishtp_cl {
 	/* Client Tx buffers list */
 	unsigned int	tx_ring_size;
 	struct ishtp_cl_tx_ring	tx_list, tx_free_list;
+	int		tx_ring_free_size;
 	spinlock_t	tx_list_spinlock;
 	spinlock_t	tx_free_list_spinlock;
 	size_t	tx_offs;	/* Offset in buffer at head of 'tx_list' */
@@ -137,6 +138,8 @@ int ishtp_cl_alloc_rx_ring(struct ishtp_cl *cl);
 int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl);
 void ishtp_cl_free_rx_ring(struct ishtp_cl *cl);
 void ishtp_cl_free_tx_ring(struct ishtp_cl *cl);
+int ishtp_cl_get_tx_free_buffer_size(struct ishtp_cl *cl);
+int ishtp_cl_get_tx_free_rings(struct ishtp_cl *cl);
 
 /* DMA I/F functions */
 void recv_ishtp_cl_msg_dma(struct ishtp_device *dev, void *msg,
-- 
2.17.1

