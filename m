Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4130A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeIRTVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:21:10 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57159 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729656AbeIRTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09498876|-1;CH=green;FP=7487995090241864675|1|1|1|0|-1|-1|-1;HT=e01e01454;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CsTi4vb_1537278498;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CsTi4vb_1537278498)
          by smtp.aliyun-inc.com(10.147.42.198);
          Tue, 18 Sep 2018 21:48:18 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
Date:   Tue, 18 Sep 2018 21:48:13 +0800
Message-Id: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ref: https://lkml.org/lkml/2018/5/18/1068

        map             for_cpu         for_device      unmap
TO_DEV  writeback       none            writeback       none
TO_CPU  invalidate      invalidate*     invalidate      invalidate*
BIDIR   writeback       invalidate      writeback       invalidate

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/mm/dma-mapping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 16c2087..30a2041 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -217,7 +217,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		BUG();
+		dma_wbinv_range(vaddr + offset, vaddr + offset + size);
+		break;
 	default:
 		BUG();
 	}
@@ -240,7 +241,7 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		BUG();
+		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
 		dma_wbinv_range(vaddr + offset, vaddr + offset + size);
-- 
2.7.4

