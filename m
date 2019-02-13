Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F878C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E01222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJwpSI/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404625AbfBMRrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:47:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404576AbfBMRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=scDNPfor2+o2sRXISwjXU4Ei4L2S2/i4alFAOpD2+h8=; b=IJwpSI/XRhEAwk7ZzJEGRkrw9d
        jGjt38pnhTVOHXpxC14ac+cB89UHoVWK5xl6vc120cHNKmjpAJe+WlWjQ4411nbOc6irZz0FSwmem
        4K7YXZvxLlhchihXJusyTq2KxOmh3Zire4J5JN9xn6Re3evnof3iJ9ozTK2DfNuGitsjCl4FEapYi
        jYEMJuAD4CvXUs/CjaxTOmI88L14bw049dP5+0t9rYM7cS+FnwGI9GlykHqqfk23Lorutp4E7xxym
        w0T8xV3/mfnDmG6FHmInh3GObANIk6lnQCvDs8uFmsghKNjU++Q/j5wo9Z4/gT6TVNzUcZIWiJK34
        fGtsADkA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtycL-0006ux-DF; Wed, 13 Feb 2019 17:46:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] initramfs: poison freed initrd memory
Date:   Wed, 13 Feb 2019 18:46:21 +0100
Message-Id: <20190213174621.29297-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various architectures including x86 poison the freed initrd memory.
Do the same in the generic free_initrd_mem implementation and switch
a few more architectures that are identical to the generic code over
to it now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/init.c     | 8 --------
 arch/s390/mm/init.c     | 8 --------
 arch/sparc/mm/init_32.c | 8 --------
 arch/sparc/mm/init_64.c | 8 --------
 init/initramfs.c        | 3 ++-
 5 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index b521d8e2d359..a9a977d75838 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -492,14 +492,6 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void (*free_init_pages_eva)(void *begin, void *end) = NULL;
 
 void __ref free_initmem(void)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3e82f66d5c61..25e3113091ea 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -154,14 +154,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 unsigned long memory_block_size_bytes(void)
 {
 	/*
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952bfc5f..f0dbc0bde70f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -299,14 +299,6 @@ void free_initmem (void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index b4221d3727d0..4179f0e11fd5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2602,14 +2602,6 @@ void free_initmem(void)
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 pgprot_t PAGE_KERNEL __read_mostly;
 EXPORT_SYMBOL(PAGE_KERNEL);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index f3aaa58ac63d..4a42ff3a2bd1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -529,7 +529,8 @@ extern unsigned long __initramfs_size;
 
 void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
+			"initrd");
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
2.20.1

