Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5cICFpXhGls6MgAAmS7hNA
	; Fri, 08 Jun 2018 20:05:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D63BC607E7; Fri,  8 Jun 2018 20:05:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qecjKTq+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2D35F605A5;
	Fri,  8 Jun 2018 20:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D35F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeFHUFx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbeFHUFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:49 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E62206B7;
        Fri,  8 Jun 2018 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488348;
        bh=/0ejmb1hAmQ8wNGZZ2TxfrPYtww9BPFKJEywadvr3AA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qecjKTq+gx4EH3p29V0Rw/3iEooJt63I/uY45YhEs3oAw7C5vpz7Y6OD3YwuSrUXr
         2pL/n9Ih6ZcD7R57eXPBFCLnMYlNQDEE/MCRBmF1KY2EpMoUoCLfcLSfAV0Ci6RMMj
         rsIcq+OiaZCdl6zPaOZzFsRdC2BH79xIWqHhaLwI=
Subject: [PATCH v1 10/13] PCI/AER: Move private AER things to aerdrv.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:47 -0500
Message-ID: <152848834746.11888.3692087095799839481.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Most of the things in aerdrv.h are only used in aerdrv.c, so move them
there.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |   64 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv.h |   79 -----------------------------------------
 2 files changed, 63 insertions(+), 80 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.h

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 51b66307e68c..3fc23fc95f98 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -27,8 +27,70 @@
 #include <acpi/apei.h>
 #include <ras/ras_event.h>
 
-#include "aerdrv.h"
 #include "../../pci.h"
+#include "../portdrv.h"
+
+#define AER_ERROR_SOURCES_MAX		100
+#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+
+struct aer_err_info {
+	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	int error_dev_num;
+
+	unsigned int id:16;
+
+	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
+	unsigned int __pad1:5;
+	unsigned int multi_error_valid:1;
+
+	unsigned int first_error:5;
+	unsigned int __pad2:2;
+	unsigned int tlp_header_valid:1;
+
+	unsigned int status;		/* COR/UNCOR Error Status */
+	unsigned int mask;		/* COR/UNCOR Error Mask */
+	struct aer_header_log_regs tlp;	/* TLP Header */
+};
+
+struct aer_err_source {
+	unsigned int status;
+	unsigned int id;
+};
+
+struct aer_rpc {
+	struct pci_dev *rpd;		/* Root Port device */
+	struct work_struct dpc_handler;
+	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
+	struct aer_err_info e_info;
+	unsigned short prod_idx;	/* Error Producer Index */
+	unsigned short cons_idx;	/* Error Consumer Index */
+	int isr;
+	spinlock_t e_lock;		/*
+					 * Lock access to Error Status/ID Regs
+					 * and error producer/consumer index
+					 */
+	struct mutex rpc_mutex;		/*
+					 * only one thread could do
+					 * recovery on the same
+					 * root port hierarchy
+					 */
+};
+
+#define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
+					PCI_ERR_UNC_ECRC|		\
+					PCI_ERR_UNC_UNSUP|		\
+					PCI_ERR_UNC_COMP_ABORT|		\
+					PCI_ERR_UNC_UNX_COMP|		\
+					PCI_ERR_UNC_MALF_TLP)
+
+#define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
+					PCI_EXP_RTCTL_SENFEE|	\
+					PCI_EXP_RTCTL_SEFEE)
+#define ROOT_PORT_INTR_ON_MESG_MASK	(PCI_ERR_ROOT_CMD_COR_EN|	\
+					PCI_ERR_ROOT_CMD_NONFATAL_EN|	\
+					PCI_ERR_ROOT_CMD_FATAL_EN)
+#define ERR_COR_ID(d)			(d & 0xffff)
+#define ERR_UNCOR_ID(d)			(d >> 16)
 
 static int pcie_aer_disable;
 
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
deleted file mode 100644
index 9867950635df..000000000000
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2006 Intel Corp.
- *	Tom Long Nguyen (tom.l.nguyen@intel.com)
- *	Zhang Yanmin (yanmin.zhang@intel.com)
- */
-
-#ifndef _AERDRV_H_
-#define _AERDRV_H_
-
-#include <linux/workqueue.h>
-#include <linux/aer.h>
-#include <linux/interrupt.h>
-
-#include "../portdrv.h"
-
-#define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
-					PCI_EXP_RTCTL_SENFEE|	\
-					PCI_EXP_RTCTL_SEFEE)
-#define ROOT_PORT_INTR_ON_MESG_MASK	(PCI_ERR_ROOT_CMD_COR_EN|	\
-					PCI_ERR_ROOT_CMD_NONFATAL_EN|	\
-					PCI_ERR_ROOT_CMD_FATAL_EN)
-#define ERR_COR_ID(d)			(d & 0xffff)
-#define ERR_UNCOR_ID(d)			(d >> 16)
-
-#define AER_ERROR_SOURCES_MAX		100
-
-#define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
-					PCI_ERR_UNC_ECRC|		\
-					PCI_ERR_UNC_UNSUP|		\
-					PCI_ERR_UNC_COMP_ABORT|		\
-					PCI_ERR_UNC_UNX_COMP|		\
-					PCI_ERR_UNC_MALF_TLP)
-
-#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
-struct aer_err_info {
-	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
-	int error_dev_num;
-
-	unsigned int id:16;
-
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
-	unsigned int multi_error_valid:1;
-
-	unsigned int first_error:5;
-	unsigned int __pad2:2;
-	unsigned int tlp_header_valid:1;
-
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct aer_header_log_regs tlp;	/* TLP Header */
-};
-
-struct aer_err_source {
-	unsigned int status;
-	unsigned int id;
-};
-
-struct aer_rpc {
-	struct pci_dev *rpd;		/* Root Port device */
-	struct work_struct dpc_handler;
-	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
-	struct aer_err_info e_info;
-	unsigned short prod_idx;	/* Error Producer Index */
-	unsigned short cons_idx;	/* Error Consumer Index */
-	int isr;
-	spinlock_t e_lock;		/*
-					 * Lock access to Error Status/ID Regs
-					 * and error producer/consumer index
-					 */
-	struct mutex rpc_mutex;		/*
-					 * only one thread could do
-					 * recovery on the same
-					 * root port hierarchy
-					 */
-};
-
-#endif /* _AERDRV_H_ */
