Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4FFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CD721722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f8O9wUvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CD721722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeI0UNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:13:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0UNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oPc8CVsTAhdBUmo/apAA7tmkwWNXZSsMfbh/Wjz5WvU=; b=f8O9wUvTlkLBSxdSIUUvmgVf/
        hw9SteJrGkhehRIfAcAMAu3G3zyYj6mWhb/x/PEcN4B6WqqbfFxZLGC4Z0npjtXF033q3EilNv30B
        k9hnO7tZQYhHOHhg6XAEZV07k8drjEFK8T4vRzixEmlK6KTSqbzFKmIzjZi/+YnPCt5erRhp7mGa0
        BMIk7QcNLShA6zQJMdFPbAL5qkxbiRt2l/Gg4Bdlmv5LFqxjOeEIAy9eohqYEL3s+J611qXVITLqA
        qgcVz+mB/SPXD2WBmNi8hqhK/pNKxfal+ceTAXNdb0dH8/tTG90ZMpPWt+NH4L+HZ5qxJNWPYBzPN
        z5N94gMcQ==;
Received: from [4.28.11.154] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5WkU-0006qC-IK; Thu, 27 Sep 2018 13:54:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] unicore32: remove swiotlb support
Date:   Thu, 27 Sep 2018 06:54:34 -0700
Message-Id: <20180927135434.6866-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unicore32 is a bog standard 32-bit port without larger physical address
space, highmem or any other obvious addressing limitation.  There should
be no need to bounce buffer using swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Guan, can you double check my assumptions?  I really can't find a
reason why unicore32 would need swiotlb.

 arch/unicore32/Kconfig                   |  2 +-
 arch/unicore32/include/asm/Kbuild        |  1 +
 arch/unicore32/include/asm/dma-mapping.h | 22 ----------------------
 arch/unicore32/mm/init.c                 |  3 ---
 4 files changed, 2 insertions(+), 26 deletions(-)
 delete mode 100644 arch/unicore32/include/asm/dma-mapping.h

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 60eae744d8fd..3a3b40f79558 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -4,6 +4,7 @@ config UNICORE32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select DMA_DIRECT_OPS
 	select HAVE_MEMBLOCK
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
@@ -20,7 +21,6 @@ config UNICORE32
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
-	select SWIOTLB
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index bfc7abe77905..1372553dc0a9 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
deleted file mode 100644
index 790bc2ef4af2..000000000000
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * linux/arch/unicore32/include/asm/dma-mapping.h
- *
- * Code specific to PKUnity SoC and UniCore ISA
- *
- * Copyright (C) 2001-2010 GUAN Xue-tao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __UNICORE_DMA_MAPPING_H__
-#define __UNICORE_DMA_MAPPING_H__
-
-#include <linux/swiotlb.h>
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &swiotlb_dma_ops;
-}
-
-#endif
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index f4950fbfe574..5f72a8d1d953 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -234,9 +234,6 @@ void __init bootmem_init(void)
 
 	uc32_bootmem_init(min, max_low);
 
-#ifdef CONFIG_SWIOTLB
-	swiotlb_init(1);
-#endif
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
-- 
2.19.0

