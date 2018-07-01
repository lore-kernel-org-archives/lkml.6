Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E2C255C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E2C255C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeGARLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:11:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031968AbeGAQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1AE56AA6;
        Sun,  1 Jul 2018 16:40:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.17 094/220] IB/hfi1: Fix user context tail allocation for DMA_RTAIL
Date:   Sun,  1 Jul 2018 18:21:58 +0200
Message-Id: <20180701160912.340753060@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 1bc0299d976e000ececc6acd76e33b4582646cb7 upstream.

The following code fails to allocate a buffer for the
tail address that the hardware DMAs into when the user
context DMA_RTAIL is set.

if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL)) {
	rcd->rcvhdrtail_kvaddr = dma_zalloc_coherent(
		&dd->pcidev->dev, PAGE_SIZE, &dma_hdrqtail,
                gfp_flags);
	if (!rcd->rcvhdrtail_kvaddr)
		goto bail_free;
	rcd->rcvhdrqtailaddr_dma = dma_hdrqtail;
}

So the rcvhdrtail_kvaddr would then be NULL.

The mmap logic fails to check for a NULL rcvhdrtail_kvaddr.

The fix is to test for both user and kernel DMA_TAIL options
during the allocation as well as testing for a NULL
rcvhdrtail_kvaddr during the mmap processing.

Additionally, all downstream testing of the capmask for DMA_RTAIL
have been eliminated in favor of testing rcvhdrtail_kvaddr.

Cc: <stable@vger.kernel.org> # 4.9.x
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/chip.c     |    8 ++++----
 drivers/infiniband/hw/hfi1/file_ops.c |    2 +-
 drivers/infiniband/hw/hfi1/init.c     |    9 ++++-----
 3 files changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -6829,7 +6829,7 @@ static void rxe_kernel_unfreeze(struct h
 		}
 		rcvmask = HFI1_RCVCTRL_CTXT_ENB;
 		/* HFI1_RCVCTRL_TAILUPD_[ENB|DIS] needs to be set explicitly */
-		rcvmask |= HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL) ?
+		rcvmask |= rcd->rcvhdrtail_kvaddr ?
 			HFI1_RCVCTRL_TAILUPD_ENB : HFI1_RCVCTRL_TAILUPD_DIS;
 		hfi1_rcvctrl(dd, rcvmask, rcd);
 		hfi1_rcd_put(rcd);
@@ -8355,7 +8355,7 @@ static inline int check_packet_present(s
 	u32 tail;
 	int present;
 
-	if (!HFI1_CAP_IS_KSET(DMA_RTAIL))
+	if (!rcd->rcvhdrtail_kvaddr)
 		present = (rcd->seq_cnt ==
 				rhf_rcv_seq(rhf_to_cpu(get_rhf_addr(rcd))));
 	else /* is RDMA rtail */
@@ -11823,7 +11823,7 @@ void hfi1_rcvctrl(struct hfi1_devdata *d
 		/* reset the tail and hdr addresses, and sequence count */
 		write_kctxt_csr(dd, ctxt, RCV_HDR_ADDR,
 				rcd->rcvhdrq_dma);
-		if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL))
+		if (rcd->rcvhdrtail_kvaddr)
 			write_kctxt_csr(dd, ctxt, RCV_HDR_TAIL_ADDR,
 					rcd->rcvhdrqtailaddr_dma);
 		rcd->seq_cnt = 1;
@@ -11903,7 +11903,7 @@ void hfi1_rcvctrl(struct hfi1_devdata *d
 		rcvctrl |= RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
 	if (op & HFI1_RCVCTRL_INTRAVAIL_DIS)
 		rcvctrl &= ~RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
-	if (op & HFI1_RCVCTRL_TAILUPD_ENB && rcd->rcvhdrqtailaddr_dma)
+	if ((op & HFI1_RCVCTRL_TAILUPD_ENB) && rcd->rcvhdrtail_kvaddr)
 		rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
 	if (op & HFI1_RCVCTRL_TAILUPD_DIS) {
 		/* See comment on RcvCtxtCtrl.TailUpd above */
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -505,7 +505,7 @@ static int hfi1_file_mmap(struct file *f
 			ret = -EINVAL;
 			goto done;
 		}
-		if (flags & VM_WRITE) {
+		if ((flags & VM_WRITE) || !uctxt->rcvhdrtail_kvaddr) {
 			ret = -EPERM;
 			goto done;
 		}
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1844,7 +1844,6 @@ int hfi1_create_rcvhdrq(struct hfi1_devd
 	u64 reg;
 
 	if (!rcd->rcvhdrq) {
-		dma_addr_t dma_hdrqtail;
 		gfp_t gfp_flags;
 
 		/*
@@ -1869,13 +1868,13 @@ int hfi1_create_rcvhdrq(struct hfi1_devd
 			goto bail;
 		}
 
-		if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL)) {
+		if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL) ||
+		    HFI1_CAP_UGET_MASK(rcd->flags, DMA_RTAIL)) {
 			rcd->rcvhdrtail_kvaddr = dma_zalloc_coherent(
-				&dd->pcidev->dev, PAGE_SIZE, &dma_hdrqtail,
-				gfp_flags);
+				&dd->pcidev->dev, PAGE_SIZE,
+				&rcd->rcvhdrqtailaddr_dma, gfp_flags);
 			if (!rcd->rcvhdrtail_kvaddr)
 				goto bail_free;
-			rcd->rcvhdrqtailaddr_dma = dma_hdrqtail;
 		}
 
 		rcd->rcvhdrq_size = amt;


