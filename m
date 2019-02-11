Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE90C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4521B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfBKPyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:54:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:45575 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfBKPyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:54:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 07:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="142467517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2019 07:54:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C55F5F5; Mon, 11 Feb 2019 17:54:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v1] dma-mapping: Move debug configuration options to kernel/dma
Date:   Mon, 11 Feb 2019 17:54:09 +0200
Message-Id: <20190211155409.41465-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to the commit cf65a0f6f6ff

  ("dma-mapping: move all DMA mapping code to kernel/dma")

which moved source code of DMA API to kernel/dma folder. Since there is
no file left in the lib that require DMA API debugging options move the
latter to kernel/dma as well.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/dma/Kconfig       |  2 ++
 kernel/dma/Kconfig.debug | 36 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        | 36 ------------------------------------
 3 files changed, 38 insertions(+), 36 deletions(-)
 create mode 100644 kernel/dma/Kconfig.debug

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index ca88b867e7fe..cba73df57982 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -53,3 +53,5 @@ config DMA_REMAP
 config DMA_DIRECT_REMAP
 	bool
 	select DMA_REMAP
+
+source "kernel/dma/Kconfig.debug"
diff --git a/kernel/dma/Kconfig.debug b/kernel/dma/Kconfig.debug
new file mode 100644
index 000000000000..2015976cf4ca
--- /dev/null
+++ b/kernel/dma/Kconfig.debug
@@ -0,0 +1,36 @@
+config DMA_API_DEBUG
+	bool "Enable debugging of DMA-API usage"
+	select NEED_DMA_MAP_STATE
+	help
+	  Enable this option to debug the use of the DMA API by device drivers.
+	  With this option you will be able to detect common bugs in device
+	  drivers like double-freeing of DMA mappings or freeing mappings that
+	  were never allocated.
+
+	  This also attempts to catch cases where a page owned by DMA is
+	  accessed by the cpu in a way that could cause data corruption.  For
+	  example, this enables cow_user_page() to check that the source page is
+	  not undergoing DMA.
+
+	  This option causes a performance degradation.  Use only if you want to
+	  debug device drivers and dma interactions.
+
+	  If unsure, say N.
+
+config DMA_API_DEBUG_SG
+	bool "Debug DMA scatter-gather usage"
+	default y
+	depends on DMA_API_DEBUG
+	help
+	  Perform extra checking that callers of dma_map_sg() have respected the
+	  appropriate segment length/boundary limits for the given device when
+	  preparing DMA scatterlists.
+
+	  This is particularly likely to have been overlooked in cases where the
+	  dma_map_sg() API is used for general bulk mapping of pages rather than
+	  preparing literal scatter-gather descriptors, where there is a risk of
+	  unexpected behaviour from DMA API implementations if the scatterlist
+	  is technically out-of-spec.
+
+	  If unsure, say N.
+
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..ef5d7c08e5b9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1655,42 +1655,6 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
-config DMA_API_DEBUG
-	bool "Enable debugging of DMA-API usage"
-	select NEED_DMA_MAP_STATE
-	help
-	  Enable this option to debug the use of the DMA API by device drivers.
-	  With this option you will be able to detect common bugs in device
-	  drivers like double-freeing of DMA mappings or freeing mappings that
-	  were never allocated.
-
-	  This also attempts to catch cases where a page owned by DMA is
-	  accessed by the cpu in a way that could cause data corruption.  For
-	  example, this enables cow_user_page() to check that the source page is
-	  not undergoing DMA.
-
-	  This option causes a performance degradation.  Use only if you want to
-	  debug device drivers and dma interactions.
-
-	  If unsure, say N.
-
-config DMA_API_DEBUG_SG
-	bool "Debug DMA scatter-gather usage"
-	default y
-	depends on DMA_API_DEBUG
-	help
-	  Perform extra checking that callers of dma_map_sg() have respected the
-	  appropriate segment length/boundary limits for the given device when
-	  preparing DMA scatterlists.
-
-	  This is particularly likely to have been overlooked in cases where the
-	  dma_map_sg() API is used for general bulk mapping of pages rather than
-	  preparing literal scatter-gather descriptors, where there is a risk of
-	  unexpected behaviour from DMA API implementations if the scatterlist
-	  is technically out-of-spec.
-
-	  If unsure, say N.
-
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
-- 
2.20.1

