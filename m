Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D829A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzqOOSGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGXNIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:08:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbeGXNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2FHW8tlV9m6Ju/msvKWhKqlWN3IbIeXGAjZfRycPqw0=; b=ZzqOOSGFCM7qi82MA8pqEl1lO
        RlAHdMXuUrqAZSMGNxIr5bD1Wfzm/uZRHra6NonycVe9p7APhHxEdRi1Ung7x7IGLRcIbwr7XNleE
        8w5CQ8cG7XvKCeyNzS+/EuUPXVKjj8fH6LWC+Kia+KICcO/TK5dk8/O+jtEWqmUxmmubt+8FUPRXJ
        foIqLYSsUy5rnTeXGCczBaHNSy1RWbL0wsbBDrJaypG+W8hMsu7IwV4zJB90FR0eFhzv1Mlk0h8+s
        Ud/nE47zXvNXocZSh2CeJ0o4wg/6u3l01cp2XEG9GYSwGIegpJSVQlaIv/frC5iV49gT3UcrTyNRh
        P8MrSts4A==;
Received: from 089144194224.atnat0003.highway.a1.net ([89.144.194.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhw0t-0001XQ-GD; Tue, 24 Jul 2018 12:01:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sh: use dma_direct_ops for the CONFIG_DMA_COHERENT case
Date:   Tue, 24 Jul 2018 14:01:45 +0200
Message-Id: <20180724120147.15096-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724120147.15096-1-hch@lst.de>
References: <20180724120147.15096-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a slight change in behavior as we avoid the detour through the
virtual mapping for the coherent allocator, but if this CPU really is
coherent that should be the right thing to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig                   | 1 +
 arch/sh/include/asm/dma-mapping.h | 4 ++++
 arch/sh/kernel/Makefile           | 4 ++--
 arch/sh/kernel/dma-nommu.c        | 4 ----
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index dd4f3d3e644f..c9993a0cdc7e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -159,6 +159,7 @@ config SWAP_IO_SPACE
 	bool
 
 config DMA_COHERENT
+	select DMA_DIRECT_OPS
 	bool
 
 config DMA_NONCOHERENT
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 149e71f95be7..1ebc6a4eb1c5 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -6,7 +6,11 @@ extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_DMA_NONCOHERENT
 	return &nommu_dma_ops;
+#else
+	return &dma_direct_ops;
+#endif
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index dc80041f7363..cb5f1bfb52de 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -12,7 +12,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 		\
+obj-y	:= debugtraps.o dumpstack.o 		\
 	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
 	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 79a9edafa5b0..d8689b1cb743 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -51,7 +51,6 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
 static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
 			      size_t size, enum dma_data_direction dir)
 {
@@ -67,16 +66,13 @@ static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nelems, i)
 		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 }
-#endif
 
 const struct dma_map_ops nommu_dma_ops = {
 	.alloc			= dma_generic_alloc_coherent,
 	.free			= dma_generic_free_coherent,
 	.map_page		= nommu_map_page,
 	.map_sg			= nommu_map_sg,
-#ifdef CONFIG_DMA_NONCOHERENT
 	.sync_single_for_device	= nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
-#endif
 };
 EXPORT_SYMBOL(nommu_dma_ops);
-- 
2.18.0

