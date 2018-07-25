Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37753ECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E448420685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dY0yO9yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E448420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeGYKvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:51:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeGYKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fgDyiypyOdGUz51hRQvMvm3VaztqnkDgLYPlLCHln4M=; b=dY0yO9yLTk4lk9eauxcD6Xn+r
        PlsBOlW3aGH+/vOAjEBQ/WsNpyVULGde58XMNPeSaDxYo3KsMj2IwOGqShU2vSCIT466mloSZK7Q1
        e0/o/NQaltFfkOes7SURZY8ABPwfcNdIsyvB75nzQoIpzguZZfPFe5aXYiyKXEJBoJowV35mNVgRz
        WKBt8WTDqz3uYtajoVo/q6WL8Go5KAhu9t4ZuX3emhfxlspmc83zBUZw+I8jIbs7CIStdikZkt9kj
        2UCGS5nxRFqcKqDg79P/rMJIPZJBDpqwdZuNwYgIoJsSLtD+KqnQNIl7F8vQDvRYGLXGmMoub1NSD
        f0pLjKZcA==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGHs-0007Sk-B3; Wed, 25 Jul 2018 09:40:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sh: introduce a sh_cacheop_vaddr helper
Date:   Wed, 25 Jul 2018 11:40:40 +0200
Message-Id: <20180725094043.32443-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725094043.32443-1-hch@lst.de>
References: <20180725094043.32443-1-hch@lst.de>
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

