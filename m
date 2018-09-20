Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D76C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7E121522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E121522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeITLV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:21:28 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34451 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09605671|-1;CH=green;FP=7487995090233476067|1|1|1|0|-1|-1|-1;HT=e01l07447;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CtH6Egw_1537421978;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtH6Egw_1537421978)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 20 Sep 2018 13:39:38 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 1/6] csky/dma: bugfix dma_sync_for_cpu/device
Date:   Thu, 20 Sep 2018 13:39:27 +0800
Message-Id: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537417413.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
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

