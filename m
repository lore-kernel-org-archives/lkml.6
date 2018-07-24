Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F061C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gsv+Zhe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeGXVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:52:10 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:42829 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:52:10 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D901B10C0AE2;
        Tue, 24 Jul 2018 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532465036; bh=7KtHUX781IYQZM2CrowAlbGeQrDmnIAgPQRyo3fZmbg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Gsv+Zhe4R324X7q7gOetg6j01X3/2VrBK5XsRY/Tt4YnnVC6RpIzbszsgqFOWeKFi
         htRfSlUKqi91onMn3wpF/INuyee5RR80d24pf1MXuuajTBKkdEB047vXVC9K0rMDiY
         VT0gZPxsiYMxUJbEpCoav+1PnRPRDsxrMMnZamI1g8w5PT1xuSJdbbHFnVr64RmO2y
         pFOLHKVkMqK5DqatrrFsUB/4dXo1hV9DIwAnoVEIfuHyl5uzHJ73pXAmHTIY6XQFXY
         4ljWyJz/Cv2JBX/nB0Y80lRdJYLPNuVrMveskwe0RhixFskrYNJ0Ay4MPHrPEYvMek
         wJYGIa51dsVVA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C3A403A67;
        Tue, 24 Jul 2018 13:43:56 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 24 Jul 2018 13:43:56 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 25 Jul 2018 02:13:53 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 25 Jul 2018 02:13:52 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>
CC:     <hch@lst.de>, <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: dma [non IOC]: fix arc_dma_sync_single_for_(device|cpu)
Date:   Tue, 24 Jul 2018 13:43:45 -0700
Message-ID: <1532465025-15600-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B08382A@us01wembx1.internal.synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA23075012B08382A@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

ARC backend for dma_sync_single_for_(device|cpu) was broken as it was
not honoring the @dir argument and simply forcing it based on the call:
 - arc_dma_sync_single_for_device(dir) assumed DMA_TO_DEVICE (cache wback)
 - arc_dma_sync_single_for_cpu(dir) assumed DMA_FROM_DEVICE (cache inv)

This is not true given the DMA API programming model and has been
discussed here [1] in some detail.

Interestingly while the deficiency has been there forever, it only started
showing up after 4.17 dma common ops rework, commit a8eb92d02dd7
("arc: fix arc_dma_{map,unmap}_page") which wired up these calls under the
more commonly used dma_map_page API triggering the issue.

[1]: https://lkml.org/lkml/2018/5/18/979
Fixes: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: reworked changelog]

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
This needs to be added to stable 4.17 but Cc with "4.17+" was causing git-send-email issues.
---
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
2.7.4

