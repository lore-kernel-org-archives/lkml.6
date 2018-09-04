Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82405C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DD22086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGRzLpCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DD22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeIDUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:55:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:55:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1918940pgv.8;
        Tue, 04 Sep 2018 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=280EP+QgaX/l+BzeVZuKBc4Hv62//0y2K3uoqdg3hqA=;
        b=lGRzLpCMULpDkzIlCOKgM20bG7jzEH0DYPLGhnU3pWzXLvbiYdTeMp5ASIqWeQP7ci
         lnudN0jh4uvspH5bzRcZH3/q8JgKuRMkAMkGdyGdtkGuOQUT3QhG1il0v+2ePJekzSld
         tvoUsp+DukeM+CGtii9vffn7LQvrep9lR2uKaGGIoDBrPhGu/hnCVSxLSJJmqT74fEML
         ISVbgl+zx45QaPxA1/u4RqLNb+UxmOVuNPgWsQd889bz792DuGQ2WGiCCR5qOxwhlIhA
         6FbLAtoJ2KQDm4l4Q1wo7wqmIIZOYuDng5tj6CCa/Zn1uWEdlJHuWwbFKIq05xaoEGQU
         eeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=280EP+QgaX/l+BzeVZuKBc4Hv62//0y2K3uoqdg3hqA=;
        b=AMLPzGP0US0xru8ZbJxR+3m0526acNcZznwkqIk187LSzDES8osZ2a0VTuXDJyCd5B
         mQIm2+gDu1R3R/YN3S5RHsRtRmq2MMUkgfEqOp6jh6OTYmqIqGwUKzcZ8/izA/9Lenw7
         VGkC00FFmOTuhcmvBuhfxj2pQbARwH0UJA/Q7E8/5x1IB+EBVHWqI6GzQAq6h8TmKSMe
         443O/AQi5hftdChZcJJzXCwmY+/A5qYlFg/XnXt6bxfrHLHUNkAITDfIDc6RrTTkwn+p
         Sld81GLR2wv7z2KsXRRRy37idwP24mrdYk7sdTZRsemImkuGEAaODWhkPjjzR26usiMt
         yGtw==
X-Gm-Message-State: APzg51DGqphGYLjnaRHAG99tp0A+QJBC7sDYal43KmdxYORKam9T/2Qu
        OrkRFDN2Z0hTeTXoiKJdeFJ4iBtE
X-Google-Smtp-Source: ANB0Vda2YfT8gX3dW3jmRQwdZCw7Nf1E9nbaQ7Fkdh1J0aOdjQXU/jpZq1zDN95PJ88A5D0/UeDsVA==
X-Received: by 2002:a62:8186:: with SMTP id t128-v6mr35237488pfd.192.1536078553760;
        Tue, 04 Sep 2018 09:29:13 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:12 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v3 05/15] soc: octeontx2: Add mailbox IRQ and msg handlers
Date:   Tue,  4 Sep 2018 21:58:35 +0530
Message-Id: <1536078525-31534-6-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds support for mailbox interrupt and message
handling. Mapped mailbox region and registered a workqueue
for message handling. Enabled mailbox IRQ of RVU PFs
and registered a interrupt handler. When IRQ is triggered
work is added to the mbox workqueue for msgs to get processed.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/octeontx2/mbox.h       |  14 +-
 drivers/soc/marvell/octeontx2/rvu.c        | 254 +++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu.h        |  22 +++
 drivers/soc/marvell/octeontx2/rvu_struct.h |  22 +++
 4 files changed, 309 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/mbox.h b/drivers/soc/marvell/octeontx2/mbox.h
index 8e205fd..fc593f0 100644
--- a/drivers/soc/marvell/octeontx2/mbox.h
+++ b/drivers/soc/marvell/octeontx2/mbox.h
@@ -33,6 +33,8 @@
 # error "incorrect mailbox area sizes"
 #endif
 
+#define INTR_MASK(pfvfs) ((pfvfs < 64) ? (BIT_ULL(pfvfs) - 1) : (~0ull))
+
 #define MBOX_RSP_TIMEOUT	1000 /* in ms, Time to wait for mbox response */
 
 #define MBOX_MSG_ALIGN		16  /* Align mbox msg start to 16bytes */
@@ -90,8 +92,9 @@ struct mbox_msghdr {
 
 void otx2_mbox_reset(struct otx2_mbox *mbox, int devid);
 void otx2_mbox_destroy(struct otx2_mbox *mbox);
-int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
-		   void *reg_base, int direction, int ndevs);
+int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
+		   struct pci_dev *pdev, void __force *reg_base,
+		   int direction, int ndevs);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
@@ -115,7 +118,7 @@ static inline struct mbox_msghdr *otx2_mbox_alloc_msg(struct otx2_mbox *mbox,
 #define MBOX_MSG_MAX				0xFFFF
 
 #define MBOX_MESSAGES							\
-M(READY,		0x001, msg_req, msg_rsp)
+M(READY,		0x001, msg_req, ready_msg_rsp)
 
 enum {
 #define M(_name, _id, _1, _2) MBOX_MSG_ ## _name = _id,
@@ -139,4 +142,9 @@ struct msg_rsp {
 	struct mbox_msghdr hdr;
 };
 
+struct ready_msg_rsp {
+	struct mbox_msghdr hdr;
+	u16    sclk_feq;	/* SCLK frequency */
+};
+
 #endif /* MBOX_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index fa5f40b..e795c2f 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -258,6 +258,245 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	return 0;
 }
 
+static int rvu_process_mbox_msg(struct rvu *rvu, int devid,
+				struct mbox_msghdr *req)
+{
+	/* Check if valid, if not reply with a invalid msg */
+	if (req->sig != OTX2_MBOX_REQ_SIG)
+		goto bad_message;
+
+	if (req->id == MBOX_MSG_READY)
+		return 0;
+
+bad_message:
+	otx2_reply_invalid_msg(&rvu->mbox, devid, req->pcifunc,
+			       req->id);
+	return -ENODEV;
+}
+
+static void rvu_mbox_handler(struct work_struct *work)
+{
+	struct rvu_work *mwork = container_of(work, struct rvu_work, work);
+	struct rvu *rvu = mwork->rvu;
+	struct otx2_mbox_dev *mdev;
+	struct mbox_hdr *req_hdr;
+	struct mbox_msghdr *msg;
+	struct otx2_mbox *mbox;
+	int offset, id, err;
+	u16 pf;
+
+	mbox = &rvu->mbox;
+	pf = mwork - rvu->mbox_wrk;
+	mdev = &mbox->dev[pf];
+
+	/* Process received mbox messages */
+	req_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	if (req_hdr->num_msgs == 0)
+		return;
+
+	offset = mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
+
+	for (id = 0; id < req_hdr->num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
+
+		/* Set which PF sent this message based on mbox IRQ */
+		msg->pcifunc &= ~(RVU_PFVF_PF_MASK << RVU_PFVF_PF_SHIFT);
+		msg->pcifunc |= (pf << RVU_PFVF_PF_SHIFT);
+		err = rvu_process_mbox_msg(rvu, pf, msg);
+		if (!err) {
+			offset = mbox->rx_start + msg->next_msgoff;
+			continue;
+		}
+
+		if (msg->pcifunc & RVU_PFVF_FUNC_MASK)
+			dev_warn(rvu->dev, "Error %d when processing message %s (0x%x) from PF%d:VF%d\n",
+				 err, otx2_mbox_id2name(msg->id), msg->id, pf,
+				 (msg->pcifunc & RVU_PFVF_FUNC_MASK) - 1);
+		else
+			dev_warn(rvu->dev, "Error %d when processing message %s (0x%x) from PF%d\n",
+				 err, otx2_mbox_id2name(msg->id), msg->id, pf);
+	}
+
+	/* Send mbox responses to PF */
+	otx2_mbox_msg_send(mbox, pf);
+}
+
+static int rvu_mbox_init(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	struct rvu_work *mwork;
+	void __iomem *hwbase = NULL;
+	u64 bar4_addr;
+	int err, pf;
+
+	rvu->mbox_wq = alloc_workqueue("rvu_afpf_mailbox",
+				       WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				       hw->total_pfs);
+	if (!rvu->mbox_wq)
+		return -ENOMEM;
+
+	rvu->mbox_wrk = devm_kcalloc(rvu->dev, hw->total_pfs,
+				     sizeof(struct rvu_work), GFP_KERNEL);
+	if (!rvu->mbox_wrk) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Map mbox region shared with PFs */
+	bar4_addr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PF_BAR4_ADDR);
+	/* Mailbox is a reserved memory (in RAM) region shared between
+	 * RVU devices, shouldn't be mapped as device memory to allow
+	 * unaligned accesses.
+	 */
+	hwbase = ioremap_wc(bar4_addr, MBOX_SIZE * hw->total_pfs);
+	if (!hwbase) {
+		dev_err(rvu->dev, "Unable to map mailbox region\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	err = otx2_mbox_init(&rvu->mbox, hwbase, rvu->pdev, rvu->afreg_base,
+			     MBOX_DIR_AFPF, hw->total_pfs);
+	if (err)
+		goto exit;
+
+	for (pf = 0; pf < hw->total_pfs; pf++) {
+		mwork = &rvu->mbox_wrk[pf];
+		mwork->rvu = rvu;
+		INIT_WORK(&mwork->work, rvu_mbox_handler);
+	}
+
+	return 0;
+exit:
+	if (hwbase)
+		iounmap((void __iomem *)hwbase);
+	destroy_workqueue(rvu->mbox_wq);
+	return err;
+}
+
+static void rvu_mbox_destroy(struct rvu *rvu)
+{
+	if (rvu->mbox_wq) {
+		flush_workqueue(rvu->mbox_wq);
+		destroy_workqueue(rvu->mbox_wq);
+		rvu->mbox_wq = NULL;
+	}
+
+	if (rvu->mbox.hwbase)
+		iounmap((void __iomem *)rvu->mbox.hwbase);
+
+	otx2_mbox_destroy(&rvu->mbox);
+}
+
+static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	u64 intr;
+	u8  pf;
+
+	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
+	/* Clear interrupts */
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT, intr);
+
+	/* Sync with mbox memory region */
+	smp_wmb();
+
+	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
+		if (intr & (1ULL << pf)) {
+			mbox = &rvu->mbox;
+			mdev = &mbox->dev[pf];
+			hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+			if (hdr->num_msgs)
+				queue_work(rvu->mbox_wq,
+					   &rvu->mbox_wrk[pf].work);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void rvu_enable_mbox_intr(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+
+	/* Clear spurious irqs, if any */
+	rvu_write64(rvu, BLKADDR_RVUM,
+		    RVU_AF_PFAF_MBOX_INT, INTR_MASK(hw->total_pfs));
+
+	/* Enable mailbox interrupt for all PFs except PF0 i.e AF itself */
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1S,
+		    INTR_MASK(hw->total_pfs) & ~1ULL);
+}
+
+static void rvu_unregister_interrupts(struct rvu *rvu)
+{
+	int irq;
+
+	/* Disable the Mbox interrupt */
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1C,
+		    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
+
+	for (irq = 0; irq < rvu->num_vec; irq++) {
+		if (rvu->irq_allocated[irq])
+			free_irq(pci_irq_vector(rvu->pdev, irq), rvu);
+	}
+
+	pci_free_irq_vectors(rvu->pdev);
+	rvu->num_vec = 0;
+}
+
+static int rvu_register_interrupts(struct rvu *rvu)
+{
+	int ret;
+
+	rvu->num_vec = pci_msix_vec_count(rvu->pdev);
+
+	rvu->irq_name = devm_kmalloc_array(rvu->dev, rvu->num_vec,
+					   NAME_SIZE, GFP_KERNEL);
+	if (!rvu->irq_name)
+		return -ENOMEM;
+
+	rvu->irq_allocated = devm_kcalloc(rvu->dev, rvu->num_vec,
+					  sizeof(bool), GFP_KERNEL);
+	if (!rvu->irq_allocated)
+		return -ENOMEM;
+
+	/* Enable MSI-X */
+	ret = pci_alloc_irq_vectors(rvu->pdev, rvu->num_vec,
+				    rvu->num_vec, PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(rvu->dev,
+			"RVUAF: Request for %d msix vectors failed, ret %d\n",
+			rvu->num_vec, ret);
+		return ret;
+	}
+
+	/* Register mailbox interrupt handler */
+	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
+	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
+			  rvu_mbox_intr_handler, 0,
+			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
+	if (ret) {
+		dev_err(rvu->dev,
+			"RVUAF: IRQ registration failed for mbox irq\n");
+		goto fail;
+	}
+
+	rvu->irq_allocated[RVU_AF_INT_VEC_MBOX] = true;
+
+	/* Enable mailbox interrupts from all PFs */
+	rvu_enable_mbox_intr(rvu);
+
+	return 0;
+
+fail:
+	pci_free_irq_vectors(rvu->pdev);
+	return ret;
+}
+
 static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -320,8 +559,21 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_release_regions;
 
+	err = rvu_mbox_init(rvu);
+	if (err)
+		goto err_hwsetup;
+
+	err = rvu_register_interrupts(rvu);
+	if (err)
+		goto err_mbox;
+
 	return 0;
 
+err_mbox:
+	rvu_mbox_destroy(rvu);
+err_hwsetup:
+	rvu_reset_all_blocks(rvu);
+	rvu_free_hw_resources(rvu);
 err_release_regions:
 	pci_release_regions(pdev);
 err_disable_device:
@@ -337,6 +589,8 @@ static void rvu_remove(struct pci_dev *pdev)
 {
 	struct rvu *rvu = pci_get_drvdata(pdev);
 
+	rvu_unregister_interrupts(rvu);
+	rvu_mbox_destroy(rvu);
 	rvu_reset_all_blocks(rvu);
 	rvu_free_hw_resources(rvu);
 
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 592b820..2fb9407 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -12,6 +12,7 @@
 #define RVU_H
 
 #include "rvu_struct.h"
+#include "mbox.h"
 
 /* PCI device IDs */
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
@@ -23,6 +24,17 @@
 
 #define NAME_SIZE				32
 
+/* PF_FUNC */
+#define RVU_PFVF_PF_SHIFT	10
+#define RVU_PFVF_PF_MASK	0x3F
+#define RVU_PFVF_FUNC_SHIFT	0
+#define RVU_PFVF_FUNC_MASK	0x3FF
+
+struct rvu_work {
+	struct	work_struct work;
+	struct	rvu *rvu;
+};
+
 struct rsrc_bmap {
 	unsigned long *bmap;	/* Pointer to resource bitmap */
 	u16  max;		/* Max resource id or count */
@@ -57,6 +69,16 @@ struct rvu {
 	struct pci_dev		*pdev;
 	struct device		*dev;
 	struct rvu_hwinfo       *hw;
+
+	/* Mbox */
+	struct otx2_mbox	mbox;
+	struct rvu_work		*mbox_wrk;
+	struct workqueue_struct *mbox_wq;
+
+	/* MSI-X */
+	u16			num_vec;
+	char			*irq_name;
+	bool			*irq_allocated;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
diff --git a/drivers/soc/marvell/octeontx2/rvu_struct.h b/drivers/soc/marvell/octeontx2/rvu_struct.h
index 4122559..1dc1518 100644
--- a/drivers/soc/marvell/octeontx2/rvu_struct.h
+++ b/drivers/soc/marvell/octeontx2/rvu_struct.h
@@ -33,4 +33,26 @@ enum rvu_block_addr_e {
 	BLK_COUNT	= 0xfULL,
 };
 
+/* RVU Admin function Interrupt Vector Enumeration */
+enum rvu_af_int_vec_e {
+	RVU_AF_INT_VEC_POISON = 0x0,
+	RVU_AF_INT_VEC_PFFLR  = 0x1,
+	RVU_AF_INT_VEC_PFME   = 0x2,
+	RVU_AF_INT_VEC_GEN    = 0x3,
+	RVU_AF_INT_VEC_MBOX   = 0x4,
+};
+
+/**
+ * RVU PF Interrupt Vector Enumeration
+ */
+enum rvu_pf_int_vec_e {
+	RVU_PF_INT_VEC_VFFLR0     = 0x0,
+	RVU_PF_INT_VEC_VFFLR1     = 0x1,
+	RVU_PF_INT_VEC_VFME0      = 0x2,
+	RVU_PF_INT_VEC_VFME1      = 0x3,
+	RVU_PF_INT_VEC_VFPF_MBOX0 = 0x4,
+	RVU_PF_INT_VEC_VFPF_MBOX1 = 0x5,
+	RVU_PF_INT_VEC_AFPF_MBOX  = 0x6,
+};
+
 #endif /* RVU_STRUCT_H */
-- 
2.7.4

