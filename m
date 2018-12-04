Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fcIQEIoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D3A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeLDPRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:17:12 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44246 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:17:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 68EC39BB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 15:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oJcDkrdZLS73 for <linux-kernel@vger.kernel.org>;
        Tue,  4 Dec 2018 09:17:10 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 39B829C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 09:17:10 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id n25so14699964iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N31xBexgIJW5+eH2O9sr6YlKAbFEkhI3s+d2ZJoJz+g=;
        b=fcIQEIoJJb6yJLnvpD4+ZgMWsoQVVlr4dA0MZyGxVQneHOJuAT0mTdlQIksI/Nw03y
         1KvS/14IsM2Zvw3HBsHyDfWv8s7vKDPRnc/HuZfIGT5XIb3+LDXZasP3mn4cJ95cu99S
         U3MOY3WkhN1aoTpEhGXOMXVlwBKqx6BEohdLqF/Phr7LdUEWPHQY6LK8O7Ub2XFtOUkF
         mM54Qv+EvTrEDWHyudFVg+o9CnT36ngcadMRNEOdYGVOmbnUAnnG2r0BvpR7m917KHu9
         Mzl/PBMgVxerxnIxFwdtxYT5zxi8kgkWaMM79S3nSUxiYfhQEGh3smmZkr5Qp133VJiX
         dmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N31xBexgIJW5+eH2O9sr6YlKAbFEkhI3s+d2ZJoJz+g=;
        b=GyNtOXyCXUm7VdAWn6LyKrpxZZtEgx+oUC/wHcmr8NdrvFAzzIhCQbpZszf3/l/8t3
         1lJrdNw16M8r52xrnkJxtOvKjIItShAaZKWCdExtysCqHZp+20OtUouYLVXLn20LZeLi
         MQwnxL9tOajf6MfSYbUe5Afwfc1hm4qH/OTUFFrsvmoQXh3DSLO3o25UYMvWsq8DTfj9
         kj0DJUkMc/E83SFenr9D733YER+ZO7LHvVV7gTzkVJzuO9XTp62ENanpEOJePVfYXHAt
         DE5uRKM9LdMxoMLFYZc1cvKj1N9CTaOf5/xeoQgBNMpo04Egzvg+k3GYWO68oTHS4ceV
         dL1Q==
X-Gm-Message-State: AA+aEWb3CnrCbYSdr2gJfMd5ufoun0SylVCf2UyI47BhzvqxQn6uJPJm
        QzP04AjbtjJNtSk2PZp4KLwp9x1/LPIJxzczGJnpZH7tbZBZTGn+mTvFcIUiLcadNcNMuWWrPR0
        695qD/AvHPNkyATjzIJm9PMWzzrF4
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr11247835ita.140.1543936629827;
        Tue, 04 Dec 2018 07:17:09 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UBZdyglOFFzeHCojcDmVLzEt7ltcotRlSEcuBV0Lx0Kwxy2MdqSm7Dsy6zF9a5qpu4DhNUmg==
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr11247824ita.140.1543936629597;
        Tue, 04 Dec 2018 07:17:09 -0800 (PST)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id c25sm6767680ioa.86.2018.12.04.07.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 07:17:08 -0800 (PST)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] misc: mic: fix a DMA pool free failure
Date:   Tue,  4 Dec 2018 09:16:41 -0600
Message-Id: <1543936604-6194-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _scif_prog_signal(), a DMA pool is allocated if the MIC Coprocessor is
not X100, i.e., the boolean variable 'x100' is false. This DMA pool will be
freed eventually through the callback function scif_prog_signal_cb() with
the parameter of 'status', which actually points to the start of DMA pool.
Specifically, in scif_prog_signal_cb(), the 'ep' field and the
'src_dma_addr' field of 'status' are used to free the DMA pool by invoking
dma_pool_free(). Given that 'status' points to the start address of the DMA
pool, both 'status->ep' and 'status->src_dma_addr' are in the DMA pool. And
so, the device has the permission to access them. Even worse, a malicious
device can modify them. As a result, dma_pool_free() will not succeed.

To avoid the above issue, this patch introduces a new data structure, i.e.,
scif_cb_arg, to store the arguments required by the call back function. A
variable 'cb_arg' is allocated in _scif_prog_signal() to pass the
arguments. 'cb_arg' will be freed after dma_pool_free() in
scif_prog_signal_cb().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/misc/mic/scif/scif_fence.c | 22 +++++++++++++++++-----
 drivers/misc/mic/scif/scif_rma.h   | 13 +++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
index 7bb929f..2e7ce6a 100644
--- a/drivers/misc/mic/scif/scif_fence.c
+++ b/drivers/misc/mic/scif/scif_fence.c
@@ -195,10 +195,11 @@ static inline void *scif_get_local_va(off_t off, struct scif_window *window)
 
 static void scif_prog_signal_cb(void *arg)
 {
-	struct scif_status *status = arg;
+	struct scif_cb_arg *cb_arg = arg;
 
-	dma_pool_free(status->ep->remote_dev->signal_pool, status,
-		      status->src_dma_addr);
+	dma_pool_free(cb_arg->ep->remote_dev->signal_pool, cb_arg->status,
+		      cb_arg->src_dma_addr);
+	kfree(cb_arg);
 }
 
 static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
@@ -209,6 +210,7 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 	bool x100 = !is_dma_copy_aligned(chan->device, 1, 1, 1);
 	struct dma_async_tx_descriptor *tx;
 	struct scif_status *status = NULL;
+	struct scif_cb_arg *cb_arg = NULL;
 	dma_addr_t src;
 	dma_cookie_t cookie;
 	int err;
@@ -257,8 +259,16 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 		goto dma_fail;
 	}
 	if (!x100) {
+		cb_arg = kmalloc(sizeof(*cb_arg), GFP_KERNEL);
+		if (!cb_arg) {
+			err = -ENOMEM;
+			goto dma_fail;
+		}
+		cb_arg->src_dma_addr = src;
+		cb_arg->status = status;
+		cb_arg->ep = ep;
 		tx->callback = scif_prog_signal_cb;
-		tx->callback_param = status;
+		tx->callback_param = cb_arg;
 	}
 	cookie = tx->tx_submit(tx);
 	if (dma_submit_error(cookie)) {
@@ -270,9 +280,11 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 	dma_async_issue_pending(chan);
 	return 0;
 dma_fail:
-	if (!x100)
+	if (!x100) {
 		dma_pool_free(ep->remote_dev->signal_pool, status,
 			      src - offsetof(struct scif_status, val));
+		kfree(cb_arg);
+	}
 alloc_fail:
 	return err;
 }
diff --git a/drivers/misc/mic/scif/scif_rma.h b/drivers/misc/mic/scif/scif_rma.h
index fa67222..84af303 100644
--- a/drivers/misc/mic/scif/scif_rma.h
+++ b/drivers/misc/mic/scif/scif_rma.h
@@ -206,6 +206,19 @@ struct scif_status {
 };
 
 /*
+ * struct scif_cb_arg - Stores the argument of the callback func
+ *
+ * @src_dma_addr: Source buffer DMA address
+ * @status: DMA status
+ * @ep: SCIF endpoint
+ */
+struct scif_cb_arg {
+	dma_addr_t src_dma_addr;
+	struct scif_status *status;
+	struct scif_endpt *ep;
+};
+
+/*
  * struct scif_window - Registration Window for Self and Remote
  *
  * @nr_pages: Number of pages which is defined as a s64 instead of an int
-- 
2.7.4

