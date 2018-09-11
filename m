Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2EFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E64D20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64D20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeILEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeILEqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208223"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 3/9] hid: intel-ish-hid: ishtp: add helper functions for client buffer operation
Date:   Tue, 11 Sep 2018 16:44:15 -0700
Message-Id: <20180911234421.10691-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Add helper ishtp_cl_tx_empty() and ishtp_cl_rx_get_rb() to hide internal
details from callers, who needs this functionality.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../hid/intel-ish-hid/ishtp/client-buffers.c  | 45 +++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.h      |  2 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index b9b917d2d50d..12d61305e83d 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -255,3 +255,48 @@ int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb)
 	return	rets;
 }
 EXPORT_SYMBOL(ishtp_cl_io_rb_recycle);
+
+/**
+ * ishtp_cl_tx_empty() -test whether client device tx buffer is empty
+ * @cl: Pointer to client device instance
+ *
+ * Look client device tx buffer list, and check whether this list is empty
+ *
+ * Return: true if client tx buffer list is empty else false
+ */
+bool ishtp_cl_tx_empty(struct ishtp_cl *cl)
+{
+	int tx_list_empty;
+	unsigned long tx_flags;
+
+	spin_lock_irqsave(&cl->tx_list_spinlock, tx_flags);
+	tx_list_empty = list_empty(&cl->tx_list.list);
+	spin_unlock_irqrestore(&cl->tx_list_spinlock, tx_flags);
+
+	return !!tx_list_empty;
+}
+EXPORT_SYMBOL(ishtp_cl_tx_empty);
+
+/**
+ * ishtp_cl_rx_get_rb() -Get a rb from client device rx buffer list
+ * @cl: Pointer to client device instance
+ *
+ * Check client device in-processing buffer list and get a rb from it.
+ *
+ * Return: rb pointer if buffer list isn't empty else NULL
+ */
+struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl)
+{
+	unsigned long rx_flags;
+	struct ishtp_cl_rb *rb;
+
+	spin_lock_irqsave(&cl->in_process_spinlock, rx_flags);
+	rb = list_first_entry_or_null(&cl->in_process_list.list,
+				struct ishtp_cl_rb, list);
+	if (rb)
+		list_del_init(&rb->list);
+	spin_unlock_irqrestore(&cl->in_process_spinlock, rx_flags);
+
+	return rb;
+}
+EXPORT_SYMBOL(ishtp_cl_rx_get_rb);
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index 79eade547f5d..a82ee4d82cdb 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -178,5 +178,7 @@ int ishtp_cl_flush_queues(struct ishtp_cl *cl);
 
 /* exported functions from ISHTP client buffer management scope */
 int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb);
+bool ishtp_cl_tx_empty(struct ishtp_cl *cl);
+struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl);
 
 #endif /* _ISHTP_CLIENT_H_ */
-- 
2.17.1

