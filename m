Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeDJHrg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:47:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40730 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeDJHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:46:43 -0400
X-Google-Smtp-Source: AIpwx487Zv/zyXpsIJgrjve0GFTOw+Aoah7aZ/8GlnYNVSHnKXiT4HeiRPX2Vpm1vUlUDG7z3MtLMg==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 3/5] dmaengine: sprd: Move DMA request mode and interrupt type into head file
Date: Tue, 10 Apr 2018 15:46:05 +0800
Message-Id: <c31db49672ba765881dc8329f5681a891cc615ba.1523346135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

This patch will move the Spreadtrum DMA request mode and interrupt type
into one head file for user to configure. And other special SPRD DMA
configurations will be added in the following patches.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c       |   52 +-------------------------------------
 include/linux/dma/sprd-dma.h |   57 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/dma/sprd-dma.h

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 9f44d6f..5c26fde 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/sprd-dma.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -119,57 +120,6 @@
 #define SPRD_DMA_SOFTWARE_UID		0
 
 /*
- * enum sprd_dma_req_mode: define the DMA request mode
- * @SPRD_DMA_FRAG_REQ: fragment request mode
- * @SPRD_DMA_BLK_REQ: block request mode
- * @SPRD_DMA_TRANS_REQ: transaction request mode
- * @SPRD_DMA_LIST_REQ: link-list request mode
- *
- * We have 4 types request mode: fragment mode, block mode, transaction mode
- * and linklist mode. One transaction can contain several blocks, one block can
- * contain several fragments. Link-list mode means we can save several DMA
- * configuration into one reserved memory, then DMA can fetch each DMA
- * configuration automatically to start transfer.
- */
-enum sprd_dma_req_mode {
-	SPRD_DMA_FRAG_REQ,
-	SPRD_DMA_BLK_REQ,
-	SPRD_DMA_TRANS_REQ,
-	SPRD_DMA_LIST_REQ,
-};
-
-/*
- * enum sprd_dma_int_type: define the DMA interrupt type
- * @SPRD_DMA_NO_INT: do not need generate DMA interrupts.
- * @SPRD_DMA_FRAG_INT: fragment done interrupt when one fragment request
- * is done.
- * @SPRD_DMA_BLK_INT: block done interrupt when one block request is done.
- * @SPRD_DMA_BLK_FRAG_INT: block and fragment interrupt when one fragment
- * or one block request is done.
- * @SPRD_DMA_TRANS_INT: tansaction done interrupt when one transaction
- * request is done.
- * @SPRD_DMA_TRANS_FRAG_INT: transaction and fragment interrupt when one
- * transaction request or fragment request is done.
- * @SPRD_DMA_TRANS_BLK_INT: transaction and block interrupt when one
- * transaction request or block request is done.
- * @SPRD_DMA_LIST_INT: link-list done interrupt when one link-list request
- * is done.
- * @SPRD_DMA_CFGERR_INT: configure error interrupt when configuration is
- * incorrect.
- */
-enum sprd_dma_int_type {
-	SPRD_DMA_NO_INT,
-	SPRD_DMA_FRAG_INT,
-	SPRD_DMA_BLK_INT,
-	SPRD_DMA_BLK_FRAG_INT,
-	SPRD_DMA_TRANS_INT,
-	SPRD_DMA_TRANS_FRAG_INT,
-	SPRD_DMA_TRANS_BLK_INT,
-	SPRD_DMA_LIST_INT,
-	SPRD_DMA_CFGERR_INT,
-};
-
-/*
  * enum sprd_dma_step: define the DMA transfer step type
  * @SPRD_DMA_NONE_STEP: transfer do not need step
  * @SPRD_DMA_BYTE_STEP: transfer step is one byte
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
new file mode 100644
index 0000000..c545162
--- /dev/null
+++ b/include/linux/dma/sprd-dma.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _SPRD_DMA_H_
+#define _SPRD_DMA_H_
+
+/*
+ * enum sprd_dma_req_mode: define the DMA request mode
+ * @SPRD_DMA_FRAG_REQ: fragment request mode
+ * @SPRD_DMA_BLK_REQ: block request mode
+ * @SPRD_DMA_TRANS_REQ: transaction request mode
+ * @SPRD_DMA_LIST_REQ: link-list request mode
+ *
+ * We have 4 types request mode: fragment mode, block mode, transaction mode
+ * and linklist mode. One transaction can contain several blocks, one block can
+ * contain several fragments. Link-list mode means we can save several DMA
+ * configuration into one reserved memory, then DMA can fetch each DMA
+ * configuration automatically to start transfer.
+ */
+enum sprd_dma_req_mode {
+	SPRD_DMA_FRAG_REQ,
+	SPRD_DMA_BLK_REQ,
+	SPRD_DMA_TRANS_REQ,
+	SPRD_DMA_LIST_REQ,
+};
+
+/*
+ * enum sprd_dma_int_type: define the DMA interrupt type
+ * @SPRD_DMA_NO_INT: do not need generate DMA interrupts.
+ * @SPRD_DMA_FRAG_INT: fragment done interrupt when one fragment request
+ * is done.
+ * @SPRD_DMA_BLK_INT: block done interrupt when one block request is done.
+ * @SPRD_DMA_BLK_FRAG_INT: block and fragment interrupt when one fragment
+ * or one block request is done.
+ * @SPRD_DMA_TRANS_INT: tansaction done interrupt when one transaction
+ * request is done.
+ * @SPRD_DMA_TRANS_FRAG_INT: transaction and fragment interrupt when one
+ * transaction request or fragment request is done.
+ * @SPRD_DMA_TRANS_BLK_INT: transaction and block interrupt when one
+ * transaction request or block request is done.
+ * @SPRD_DMA_LIST_INT: link-list done interrupt when one link-list request
+ * is done.
+ * @SPRD_DMA_CFGERR_INT: configure error interrupt when configuration is
+ * incorrect.
+ */
+enum sprd_dma_int_type {
+	SPRD_DMA_NO_INT,
+	SPRD_DMA_FRAG_INT,
+	SPRD_DMA_BLK_INT,
+	SPRD_DMA_BLK_FRAG_INT,
+	SPRD_DMA_TRANS_INT,
+	SPRD_DMA_TRANS_FRAG_INT,
+	SPRD_DMA_TRANS_BLK_INT,
+	SPRD_DMA_LIST_INT,
+	SPRD_DMA_CFGERR_INT,
+};
+
+#endif
-- 
1.7.9.5
