Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h+PS+Daw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECCF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbeGXPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:19:47 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:46355 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388315AbeGXPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:19:46 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EA6D624E046A;
        Tue, 24 Jul 2018 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532441586; bh=oNcZm8GFAc4g5NeW9IE36g/mmrk6HvEF1vCDuijychM=;
        h=From:To:Cc:Subject:Date:From;
        b=h+PS+Daw+I3e+sb7N9+OvL2iljS2GJhPvZXO29RuZ4b8ReQ0KaqymFG37tJMTzaZX
         HkviZJl5QdUHLvoGEKk/nDL6ZrfL9sTrBW+E7QlpD8xL8EQ0qVlk7xCOl9xiJQ4tXK
         1Lp3+aoCmZasLuIiXujgs32e7PhlS7d4YYhyonzIjlLqBCAdWVmxeBiYGhXgQnvkEN
         +rT2xJE5mfE3aqO4WMyoT55Ljw68P1QPD+vq9CTXoSnnqDbSdMtWKvRUFJJtcgzXMx
         ql7ive04O5zFYy06bNHhlyS/TaKoRGE5k7SCP+XmGn2RBDEUf6iLaYd0Rc95FN8MI6
         JP+1VWmUnOzug==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 38A835CFD;
        Tue, 24 Jul 2018 07:13:05 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: fix broken noncoherent cache ops
Date:   Tue, 24 Jul 2018 17:13:02 +0300
Message-Id: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All DMA devices on ARC haven't worked with SW cache control
since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
This happens because we don't check direction argument at all in
new implementation. Fix that.

Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
NOTE:
 * This patch was stress tested on HSDK with bonie++ (usb and sdio)
   with IOC disabled. The ethernet wasn't tested because it doesn't
   work with SW cache control as for today (see STAR 9001336019)

 arch/arc/mm/dma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 8c1071840979..cefb776a99ff 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -129,14 +129,56 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
+/*
+ * Cache operations depending on function and direction argument, inspired by
+ * https://lkml.org/lkml/2018/5/18/979
+ * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
+ * dma-mapping: provide a generic dma-noncoherent implementation)"
+ *
+ *          |   map          ==  for_device     |   unmap     ==  for_cpu
+ *          |----------------------------------------------------------------
+ * TO_DEV   |   writeback        writeback      |   none          none
+ * FROM_DEV |   invalidate       invalidate     |   invalidate    invalidate
+ * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invalidate
+ *
+ * NOTE: we don't check the validity of direction argument as it is done in
+ * upper layer functions (in include/linux/dma-mapping.h)
+ */
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_wback(paddr, size);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		dma_cache_wback(paddr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		dma_cache_inv(paddr, size);
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_inv(paddr, size);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		dma_cache_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
 }
-- 
2.14.4

