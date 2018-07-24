Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19731204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WunWYiq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19731204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeGXNI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:08:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbeGXNI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fgDyiypyOdGUz51hRQvMvm3VaztqnkDgLYPlLCHln4M=; b=WunWYiq00Jrq9VhsoQjPVQKCq
        gTyXSEaBFZWrhYvomwrr9RKyMcCxzfb7Ae2j9eMQjh2m6io9h7r4wHaQ3oSLWpTrd1BqEg3Bms/sr
        drKAV2NKbn/AVo/XYnyCbA74TNAKhAUx6BqQ26KE2csrlTTVCaP6fbxaYArjV63haNqxcewX771HD
        VhFuXfxjK17LOYtc3O8ZSzzxAhez54Ugnn5GCsw+6Wk6WSXqNsymk4le93IPzRHlgFDmUtprFa1SV
        dXxPULh2ZMafxGaIkXO2WU59v3R8Z2zOYceutfHiE6Dnf95LvzQmkTFUoj6gCDaLGNHRsfIKWTVvn
        Rwe1DPo3Q==;
Received: from 089144194224.atnat0003.highway.a1.net ([89.144.194.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhw0q-0001Vz-8o; Tue, 24 Jul 2018 12:01:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sh: introduce a sh_cacheop_vaddr helper
Date:   Tue, 24 Jul 2018 14:01:44 +0200
Message-Id: <20180724120147.15096-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724120147.15096-1-hch@lst.de>
References: <20180724120147.15096-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And use it in the maple bus code to avoid a dma API dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/cacheflush.h | 7 +++++++
 arch/sh/mm/consistent.c          | 6 +-----
 drivers/sh/maple/maple.c         | 7 ++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index d103ab5a4e4b..b932e42ef028 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -101,5 +101,12 @@ void kunmap_coherent(void *kvaddr);
 
 void cpu_cache_init(void);
 
+static inline void *sh_cacheop_vaddr(void *vaddr)
+{
+	if (__in_29bit_mode())
+		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
+	return vaddr;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHEFLUSH_H */
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index e9d422bd42a5..1622ae6b9dbd 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -74,10 +74,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 void sh_sync_dma_for_device(void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-	void *addr;
-
-	addr = __in_29bit_mode() ?
-	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
+	void *addr = sh_cacheop_vaddr(vaddr);
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
@@ -93,7 +90,6 @@ void sh_sync_dma_for_device(void *vaddr, size_t size,
 		BUG();
 	}
 }
-EXPORT_SYMBOL(sh_sync_dma_for_device);
 
 static int __init memchunk_setup(char *str)
 {
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 2e45988d1259..e5d7fb81ad66 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -300,8 +300,8 @@ static void maple_send(void)
 	mutex_unlock(&maple_wlist_lock);
 	if (maple_packets > 0) {
 		for (i = 0; i < (1 << MAPLE_DMA_PAGES); i++)
-			sh_sync_dma_for_device(maple_sendbuf + i * PAGE_SIZE,
-				       PAGE_SIZE, DMA_BIDIRECTIONAL);
+			__flush_purge_region(maple_sendbuf + i * PAGE_SIZE,
+					PAGE_SIZE);
 	}
 
 finish:
@@ -642,7 +642,8 @@ static void maple_dma_handler(struct work_struct *work)
 		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
 			mdev = mq->dev;
 			recvbuf = mq->recvbuf->buf;
-			sh_sync_dma_for_device(recvbuf, 0x400, DMA_FROM_DEVICE);
+			__flush_invalidate_region(sh_cacheop_vaddr(recvbuf),
+					0x400);
 			code = recvbuf[0];
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
-- 
2.18.0

