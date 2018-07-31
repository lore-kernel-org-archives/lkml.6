Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CF3208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CF3208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeGaIQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbeGaIQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154197"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:28 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 05/12] mei: define dma ring buffer sizes for PCH12 HW and newer
Date:   Tue, 31 Jul 2018 09:35:37 +0300
Message-Id: <20180731063544.25540-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Define dma ring buffer sizes for PCH12 (CLN HW and newer)

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 13 +++++++++++++
 drivers/misc/mei/hw-me.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 0e3c31595dda..0759c3a668de 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/sizes.h>
 
 #include "mei_dev.h"
 #include "hbm.h"
@@ -1389,6 +1390,11 @@ static bool mei_me_fw_type_sps(struct pci_dev *pdev)
 	.fw_status.status[4] = PCI_CFG_HFS_5,   \
 	.fw_status.status[5] = PCI_CFG_HFS_6
 
+#define MEI_CFG_DMA_128 \
+	.dma_size[DMA_DSCR_HOST] = SZ_128K, \
+	.dma_size[DMA_DSCR_DEVICE] = SZ_128K, \
+	.dma_size[DMA_DSCR_CTRL] = PAGE_SIZE
+
 /* ICH Legacy devices */
 static const struct mei_cfg mei_me_ich_cfg = {
 	MEI_CFG_ICH_HFS,
@@ -1421,6 +1427,12 @@ static const struct mei_cfg mei_me_pch8_sps_cfg = {
 	MEI_CFG_FW_SPS,
 };
 
+/* Cannon Lake and newer devices */
+static const struct mei_cfg mei_me_pch12_cfg = {
+	MEI_CFG_PCH8_HFS,
+	MEI_CFG_DMA_128,
+};
+
 /*
  * mei_cfg_list - A list of platform platform specific configurations.
  * Note: has to be synchronized with  enum mei_cfg_idx.
@@ -1433,6 +1445,7 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH_CPT_PBG_CFG] = &mei_me_pch_cpt_pbg_cfg,
 	[MEI_ME_PCH8_CFG] = &mei_me_pch8_cfg,
 	[MEI_ME_PCH8_SPS_CFG] = &mei_me_pch8_sps_cfg,
+	[MEI_ME_PCH12_CFG] = &mei_me_pch12_cfg,
 };
 
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 0c6fe71d1212..bbcc5fc106cd 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -31,10 +31,12 @@
  *
  * @fw_status: FW status
  * @quirk_probe: device exclusion quirk
+ * @dma_size: device DMA buffers size
  */
 struct mei_cfg {
 	const struct mei_fw_status fw_status;
 	bool (*quirk_probe)(struct pci_dev *pdev);
+	size_t dma_size[DMA_DSCR_NUM];
 };
 
 
@@ -80,6 +82,7 @@ struct mei_me_hw {
  * @MEI_ME_PCH8_SPS_CFG:   Platform Controller Hub Gen8 and newer
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
+ * @MEI_ME_PCH12_CFG:      Platform Controller Hub Gen12 and newer
  * @MEI_ME_NUM_CFG:        Upper Sentinel.
  */
 enum mei_cfg_idx {
@@ -90,6 +93,7 @@ enum mei_cfg_idx {
 	MEI_ME_PCH_CPT_PBG_CFG,
 	MEI_ME_PCH8_CFG,
 	MEI_ME_PCH8_SPS_CFG,
+	MEI_ME_PCH12_CFG,
 	MEI_ME_NUM_CFG,
 };
 
-- 
2.14.4

