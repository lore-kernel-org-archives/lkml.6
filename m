Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548EB2172E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548EB2172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeI1HN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:13:26 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52931 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbeI1HN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08872253|-1;CH=blue;FP=7344213741358826467|1|1|12|0|-1|-1|-1;HT=e02c03307;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwkaOHk_1538095931;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkaOHk_1538095931)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 28 Sep 2018 08:52:11 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Date:   Fri, 28 Sep 2018 08:51:17 +0800
Message-Id: <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
broken for some combinations that end up in a BUG() instead of performing
the necessary flushes.

The implementation of arch should follow the following rules:
         map             for_cpu         for_device      unmap
 TO_DEV  writeback       none            writeback       none
 TO_CPU  invalidate      invalidate*     invalidate      invalidate*
 BIDIR   writeback       invalidate      writeback       invalidate

Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
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

