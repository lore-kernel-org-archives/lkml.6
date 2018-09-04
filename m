Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE567C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC962086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIi2iC8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC962086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIDUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:55:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42241 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:55:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so1913275pgp.9;
        Tue, 04 Sep 2018 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bD1MxRLgpDynhenUMtxV06TIQ+lkhLirw3i7l5ZgMHw=;
        b=MIi2iC8rUtUwu2++W+z66BY1eJ133o1UYpdA6iqaoI4vm90meTcbI2soatFTdb17cA
         BiozRcLMq1icv0wylECe/Redty6zG/ksNWq/nki2Kqy5Rbm7NVggZGxxlEyzmuAwkTcO
         tcaATSZgieGPvkhAZ0sc+IrRdHIZB4kThJHIoEGHdGqk3rrjpGmHNAnfaCL8otYR6FQo
         xdtJWTMStxRuDh2B1X5gpcfUVJCumjCY/IDtP47mnEOzXw7qlDh11Y/C1UHP6FSfQfMh
         8WZBBCBY5gN7wPBDIsEX0G37Ni2rFMkX5/mLBkNkl7z9Wq0IMPeXP7FgyfNSY5wFjyYd
         8bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bD1MxRLgpDynhenUMtxV06TIQ+lkhLirw3i7l5ZgMHw=;
        b=pnoqHWykgYBq+lIoCrs25bX/safsrBezJICY+9idgh9bxtsDyBGKps8kwTs/mmBjIE
         D32y1wheqMnjM2x6K9jO5yBQS+Kct2xj8vy0uE2z8qCr8zBW9S0DAHsQmN+6ps/Tcuat
         PT9hRphBKPj3sZBflrgZtxOl7RW4c0fVKjtyduxdWX70FV8dDlebK6Dj55epJTWIc2B3
         gk5bi0EU2WTWAhNJQVWxzg/4J1URpb/JdkU/h9FS5VU4bHjf9gDrIpQr3ZpDa5lsn8bF
         lVLoUoWwYW73+f++iFVS/o7LH2gMmM5kRXytkP/uSiU6ePfCfXjr/dTMctnVxn7raavS
         R71Q==
X-Gm-Message-State: APzg51DVaqbGBsEA8dHFh5xZx0vpSVT2I8ayHTsoJ8I71YCR6ymDxIeR
        +jQDZiXpGmxbGnkdxCL3pP69uIdg
X-Google-Smtp-Source: ANB0VdaxyBtwwIHdQ1njkJsbrLbxTIa22o9sD76fda7hwq9+HsO/G16YVKiZ2UuVhhZB0iWwgZQ69Q==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr35684557pfi.137.1536078589091;
        Tue, 04 Sep 2018 09:29:49 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:48 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v3 14/15] soc: octeontx2: Register for CGX lmac events
Date:   Tue,  4 Sep 2018 21:58:44 +0530
Message-Id: <1536078525-31534-15-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linu Cherian <lcherian@marvell.com>

Added support in RVU AF driver to register for
CGX LMAC link status change events from firmware
and managing them. Processing part will be added
in followup patches.

- Introduced eventqueue for posting events from cgx lmac.
  Queueing mechanism will ensure that events can be posted
  and firmware can be acked immediately and hence event
  reception and processing are decoupled.
- Events gets added to the queue by notification callback.
  Notification callback is expected to be atomic, since it
  is called from interrupt context.
- Events are dequeued and processed in a worker thread.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c     |   6 +-
 drivers/soc/marvell/octeontx2/rvu.h     |   5 ++
 drivers/soc/marvell/octeontx2/rvu_cgx.c | 101 +++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index faf7d0f..282982f 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -1564,10 +1564,11 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = rvu_register_interrupts(rvu);
 	if (err)
-		goto err_mbox;
+		goto err_cgx;
 
 	return 0;
-
+err_cgx:
+	rvu_cgx_wq_destroy(rvu);
 err_mbox:
 	rvu_mbox_destroy(rvu);
 err_hwsetup:
@@ -1589,6 +1590,7 @@ static void rvu_remove(struct pci_dev *pdev)
 	struct rvu *rvu = pci_get_drvdata(pdev);
 
 	rvu_unregister_interrupts(rvu);
+	rvu_cgx_wq_destroy(rvu);
 	rvu_mbox_destroy(rvu);
 	rvu_reset_all_blocks(rvu);
 	rvu_free_hw_resources(rvu);
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 385f597..d169fa9 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -110,6 +110,10 @@ struct rvu {
 						  * every cgx lmac port
 						  */
 	void			**cgx_idmap; /* cgx id to cgx data map table */
+	struct			work_struct cgx_evh_work;
+	struct			workqueue_struct *cgx_evh_wq;
+	spinlock_t		cgx_evq_lock; /* cgx event queue lock */
+	struct list_head	cgx_evq_head; /* cgx event queue head */
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -150,4 +154,5 @@ int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero);
 
 /* CGX APIs */
 int rvu_cgx_probe(struct rvu *rvu);
+void rvu_cgx_wq_destroy(struct rvu *rvu);
 #endif /* RVU_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_cgx.c b/drivers/soc/marvell/octeontx2/rvu_cgx.c
index bf81507..2359806e 100644
--- a/drivers/soc/marvell/octeontx2/rvu_cgx.c
+++ b/drivers/soc/marvell/octeontx2/rvu_cgx.c
@@ -15,6 +15,11 @@
 #include "rvu.h"
 #include "cgx.h"
 
+struct cgx_evq_entry {
+	struct list_head evq_node;
+	struct cgx_link_event link_event;
+};
+
 static inline u8 cgxlmac_id_to_bmap(u8 cgx_id, u8 lmac_id)
 {
 	return ((cgx_id & 0xF) << 4) | (lmac_id & 0xF);
@@ -72,9 +77,95 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 	return 0;
 }
 
+/* This is called from interrupt context and is expected to be atomic */
+static int cgx_lmac_postevent(struct cgx_link_event *event, void *data)
+{
+	struct rvu *rvu = data;
+	struct cgx_evq_entry *qentry;
+
+	/* post event to the event queue */
+	qentry = kmalloc(sizeof(*qentry), GFP_ATOMIC);
+	if (!qentry)
+		return -ENOMEM;
+	qentry->link_event = *event;
+	spin_lock(&rvu->cgx_evq_lock);
+	list_add_tail(&qentry->evq_node, &rvu->cgx_evq_head);
+	spin_unlock(&rvu->cgx_evq_lock);
+
+	/* start worker to process the events */
+	queue_work(rvu->cgx_evh_wq, &rvu->cgx_evh_work);
+
+	return 0;
+}
+
+static void cgx_evhandler_task(struct work_struct *work)
+{
+	struct rvu *rvu = container_of(work, struct rvu, cgx_evh_work);
+	struct cgx_evq_entry *qentry;
+	struct cgx_link_event *event;
+	unsigned long flags;
+
+	do {
+		/* Dequeue an event */
+		spin_lock_irqsave(&rvu->cgx_evq_lock, flags);
+		qentry = list_first_entry_or_null(&rvu->cgx_evq_head,
+						  struct cgx_evq_entry,
+						  evq_node);
+		if (qentry)
+			list_del(&qentry->evq_node);
+		spin_unlock_irqrestore(&rvu->cgx_evq_lock, flags);
+		if (!qentry)
+			break; /* nothing more to process */
+
+		event = &qentry->link_event;
+
+		/* Do nothing for now */
+		kfree(qentry);
+	} while (1);
+}
+
+static void cgx_lmac_event_handler_init(struct rvu *rvu)
+{
+	struct cgx_event_cb cb;
+	int cgx, lmac, err;
+	void *cgxd;
+
+	spin_lock_init(&rvu->cgx_evq_lock);
+	INIT_LIST_HEAD(&rvu->cgx_evq_head);
+	INIT_WORK(&rvu->cgx_evh_work, cgx_evhandler_task);
+	rvu->cgx_evh_wq = alloc_workqueue("rvu_evh_wq", 0, 0);
+	if (!rvu->cgx_evh_wq) {
+		dev_err(rvu->dev, "alloc workqueue failed");
+		return;
+	}
+
+	cb.notify_link_chg = cgx_lmac_postevent; /* link change call back */
+	cb.data = rvu;
+
+	for (cgx = 0; cgx < rvu->cgx_cnt; cgx++) {
+		cgxd = rvu_cgx_pdata(cgx, rvu);
+		for (lmac = 0; lmac < cgx_get_lmac_cnt(cgxd); lmac++) {
+			err = cgx_lmac_evh_register(&cb, cgxd, lmac);
+			if (err)
+				dev_err(rvu->dev,
+					"%d:%d handler register failed\n",
+					cgx, lmac);
+		}
+	}
+}
+
+void rvu_cgx_wq_destroy(struct rvu *rvu)
+{
+	if (rvu->cgx_evh_wq) {
+		flush_workqueue(rvu->cgx_evh_wq);
+		destroy_workqueue(rvu->cgx_evh_wq);
+		rvu->cgx_evh_wq = NULL;
+	}
+}
+
 int rvu_cgx_probe(struct rvu *rvu)
 {
-	int i;
+	int i, err;
 
 	/* find available cgx ports */
 	rvu->cgx_cnt = cgx_get_cgx_cnt();
@@ -93,5 +184,11 @@ int rvu_cgx_probe(struct rvu *rvu)
 		rvu->cgx_idmap[i] = cgx_get_pdata(i);
 
 	/* Map CGX LMAC interfaces to RVU PFs */
-	return rvu_map_cgx_lmac_pf(rvu);
+	err = rvu_map_cgx_lmac_pf(rvu);
+	if (err)
+		return err;
+
+	/* Register for CGX events */
+	cgx_lmac_event_handler_init(rvu);
+	return 0;
 }
-- 
2.7.4

