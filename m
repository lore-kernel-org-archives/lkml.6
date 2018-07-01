Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4444EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0269A255E8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0269A255E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753804AbeGARNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:13:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031895AbeGAQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22F2CAA6;
        Sun,  1 Jul 2018 16:40:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.17 085/220] IB/{hfi1, qib}: Add handling of kernel restart
Date:   Sun,  1 Jul 2018 18:21:49 +0200
Message-Id: <20180701160911.981173482@linuxfoundation.org>
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

From: Alex Estrin <alex.estrin@intel.com>

commit 8d3e71136a080d007620472f50c7b3e63ba0f5cf upstream.

A warm restart will fail to unload the driver, leaving link state
potentially flapping up to the point the BIOS resets the adapter.
Correct the issue by hooking the shutdown pci method,
which will bring port down.

Cc: <stable@vger.kernel.org> # 4.9.x
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/hfi.h     |    1 +
 drivers/infiniband/hw/hfi1/init.c    |   13 +++++++++++++
 drivers/infiniband/hw/qib/qib.h      |    1 +
 drivers/infiniband/hw/qib/qib_init.c |   13 +++++++++++++
 4 files changed, 28 insertions(+)

--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1856,6 +1856,7 @@ struct cc_state *get_cc_state_protected(
 #define HFI1_HAS_SDMA_TIMEOUT  0x8
 #define HFI1_HAS_SEND_DMA      0x10   /* Supports Send DMA */
 #define HFI1_FORCED_FREEZE     0x80   /* driver forced freeze mode */
+#define HFI1_SHUTDOWN          0x100  /* device is shutting down */
 
 /* IB dword length mask in PBC (lower 11 bits); same for all chips */
 #define HFI1_PBC_LENGTH_MASK                     ((1 << 11) - 1)
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1058,6 +1058,10 @@ static void shutdown_device(struct hfi1_
 	unsigned pidx;
 	int i;
 
+	if (dd->flags & HFI1_SHUTDOWN)
+		return;
+	dd->flags |= HFI1_SHUTDOWN;
+
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 
@@ -1391,6 +1395,7 @@ void hfi1_disable_after_error(struct hfi
 
 static void remove_one(struct pci_dev *);
 static int init_one(struct pci_dev *, const struct pci_device_id *);
+static void shutdown_one(struct pci_dev *);
 
 #define DRIVER_LOAD_MSG "Intel " DRIVER_NAME " loaded: "
 #define PFX DRIVER_NAME ": "
@@ -1407,6 +1412,7 @@ static struct pci_driver hfi1_pci_driver
 	.name = DRIVER_NAME,
 	.probe = init_one,
 	.remove = remove_one,
+	.shutdown = shutdown_one,
 	.id_table = hfi1_pci_tbl,
 	.err_handler = &hfi1_pci_err_handler,
 };
@@ -1816,6 +1822,13 @@ static void remove_one(struct pci_dev *p
 	postinit_cleanup(dd);
 }
 
+static void shutdown_one(struct pci_dev *pdev)
+{
+	struct hfi1_devdata *dd = pci_get_drvdata(pdev);
+
+	shutdown_device(dd);
+}
+
 /**
  * hfi1_create_rcvhdrq - create a receive header queue
  * @dd: the hfi1_ib device
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1228,6 +1228,7 @@ static inline struct qib_ibport *to_ipor
 #define QIB_BADINTR           0x8000 /* severe interrupt problems */
 #define QIB_DCA_ENABLED       0x10000 /* Direct Cache Access enabled */
 #define QIB_HAS_QSFP          0x20000 /* device (card instance) has QSFP */
+#define QIB_SHUTDOWN          0x40000 /* device is shutting down */
 
 /*
  * values for ppd->lflags (_ib_port_ related flags)
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -841,6 +841,10 @@ static void qib_shutdown_device(struct q
 	struct qib_pportdata *ppd;
 	unsigned pidx;
 
+	if (dd->flags & QIB_SHUTDOWN)
+		return;
+	dd->flags |= QIB_SHUTDOWN;
+
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 
@@ -1182,6 +1186,7 @@ void qib_disable_after_error(struct qib_
 
 static void qib_remove_one(struct pci_dev *);
 static int qib_init_one(struct pci_dev *, const struct pci_device_id *);
+static void qib_shutdown_one(struct pci_dev *);
 
 #define DRIVER_LOAD_MSG "Intel " QIB_DRV_NAME " loaded: "
 #define PFX QIB_DRV_NAME ": "
@@ -1199,6 +1204,7 @@ static struct pci_driver qib_driver = {
 	.name = QIB_DRV_NAME,
 	.probe = qib_init_one,
 	.remove = qib_remove_one,
+	.shutdown = qib_shutdown_one,
 	.id_table = qib_pci_tbl,
 	.err_handler = &qib_pci_err_handler,
 };
@@ -1549,6 +1555,13 @@ static void qib_remove_one(struct pci_de
 	qib_postinit_cleanup(dd);
 }
 
+static void qib_shutdown_one(struct pci_dev *pdev)
+{
+	struct qib_devdata *dd = pci_get_drvdata(pdev);
+
+	qib_shutdown_device(dd);
+}
+
 /**
  * qib_create_rcvhdrq - create a receive header queue
  * @dd: the qlogic_ib device


