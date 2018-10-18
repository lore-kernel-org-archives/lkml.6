Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B63C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAA6205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IHmY6eoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAA6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJSDss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:48:48 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:35252 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:48:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8FC20CBA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 19:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rt87VIgiFr1N for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 14:46:15 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 677C16AB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:46:15 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v13-v6so1250135itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eWq6i5izlkExKKurJkE2h7K71oR/GDH3ailOhPlZbr4=;
        b=IHmY6eocRFd5QqWLJznlhA2VM0NVUbQocoytcKyy0rC9wMBX+IrMhp41ughtL/Gdir
         0YPIweOTQotruBXQWfVeOa4Z6/hPINER3wTLIC1EfJ9PH9F9lacfBMhI5ZTV3H4rKs9D
         SQmKqYwH4sH7XhBe/D/Dgg+dyAZtQgVZ2uRS+m3DAo8uY0n8ygPtgVCB4Dw68On2khkh
         vqJ2H1Cm8ili2BppVhTFS5vI+UOUtaMzt6C00Jw7+JG0guuHqVgSWxBcfvcIWCfS6Hzd
         tTPGULBpg4M1dFoI/jkSQdbjQafOg7M7h6y37zHRIO2XhUPb2+NiDySJHdjU9iU8RfUR
         L8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eWq6i5izlkExKKurJkE2h7K71oR/GDH3ailOhPlZbr4=;
        b=Hw3UxPBM2h2PHNk94NhhNH5+2P2DnyicUMMRVYwT5NzRbRAre5dgdkb8XS/irsk0K0
         58kITy9aZr7wOg+n+jtDWPoKEGRuD4Bblrbd903EKDMXOvUKi81EaTLvk7C0VpHSJ6Se
         XcnvbCfhC/QQjB9kvxQqpGhepYExjVoPt+MTeg/BWkVk7dD6+jhdi4wt+UQshY3Z33Tm
         8a4VXY8WX28kj1ybOxNRvi2LMD0+lBueiDefuxMI2MgptSHb9rYkSYSSA4vYHs8+gQJT
         dNHCqn3ipwHobmItgKKVN9XJTTMtKuK8+tP582xeiwFiHlc04ch3OIe21Vozw7o8Og5j
         8oaA==
X-Gm-Message-State: ABuFfohwAp7uyNzmaF69IE35Sh7PB+PF1lLKOapx1nOIJ8AOC4Ke1u/1
        onvBj2P9jb9FQdd95RbOSxnVQSFop/gkvsBUbNElMNRBsK80gmEv3PDx1vqc2hrevZoZRxroZYA
        AeJgHiegEnTEsmu12vaha8E1quNzM
X-Received: by 2002:a24:d4c4:: with SMTP id x187-v6mr1186469itg.98.1539891974967;
        Thu, 18 Oct 2018 12:46:14 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62TPYWlbYWb4VylebyVrYntK68fU/NTGghoMQOvD0bYkg9EACvl94cPGRUk2bdd81QnCJmKrQ==
X-Received: by 2002:a24:d4c4:: with SMTP id x187-v6mr1186454itg.98.1539891974723;
        Thu, 18 Oct 2018 12:46:14 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id j19-v6sm452204itb.25.2018.10.18.12.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 12:46:13 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] misc: mic: fix a DMA pool free failure
Date:   Thu, 18 Oct 2018 14:46:03 -0500
Message-Id: <1539891966-8017-1-git-send-email-wang6495@umn.edu>
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
 drivers/misc/mic/scif/scif_fence.c | 17 +++++++++++++----
 drivers/misc/mic/scif/scif_rma.h   | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
index cac3bcc..30f7d9b 100644
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
@@ -257,8 +259,15 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 		goto dma_fail;
 	}
 	if (!x100) {
+		err = -ENOMEM;
+		cb_arg = kmalloc(sizeof(*cb_arg), GFP_KERNEL);
+		if (!cb_arg)
+			goto dma_fail;
+		cb_arg->src_dma_addr = src;
+		cb_arg->status = status;
+		cb_arg->ep = ep;
 		tx->callback = scif_prog_signal_cb;
-		tx->callback_param = status;
+		tx->callback_param = cb_arg;
 	}
 	cookie = tx->tx_submit(tx);
 	if (dma_submit_error(cookie)) {
diff --git a/drivers/misc/mic/scif/scif_rma.h b/drivers/misc/mic/scif/scif_rma.h
index fa67222..e3b80e1 100644
--- a/drivers/misc/mic/scif/scif_rma.h
+++ b/drivers/misc/mic/scif/scif_rma.h
@@ -206,6 +206,20 @@ struct scif_status {
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
+
+/*
  * struct scif_window - Registration Window for Self and Remote
  *
  * @nr_pages: Number of pages which is defined as a s64 instead of an int
-- 
2.7.4

