Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519120836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3pnzV8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8519120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeH1Stl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeH1Stk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N7Vh+kzAINa93+ASlwx4IbhXwzGgaGba3pGlvT4L2Pg=; b=c3pnzV8C4rOFDmfWYfYw/Ky8t
        l7oqI8HLtpXIfpdL563lpWUIsZ0yQHq0UVuSQP2FyKaYGf6BHhUkXPc0K+OfUAb34zOiPcN5pBZ22
        /oJ6w70YyMn86pQ/YtRPJzlIZuKCtmfBkscQv8V6dUZwy4kyD7OkAYzGO4oaPkAwSVDU0NOGVDsIN
        pZcKyrn+8gzVPwhgXhQ7c95qYDecemHCK2M6AOjR/HBLBVfx1FBfUGmfVwJ+Hv8MvNA+cE3UkCJWw
        49gaszjah0NENyPvwxyKuabRsH9ffUn/XLSVAd1HRdhqSooebI8I1oBZhayoj4z421TLixzSyPxGr
        lDF4JCTVQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR2-0003AD-8E; Tue, 28 Aug 2018 14:57:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] cramfs: Convert to use vmf_insert_mixed
Date:   Tue, 28 Aug 2018 07:57:19 -0700
Message-Id: <20180828145728.11873-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cramfs is the only remaining user of vm_insert_mixed; convert it.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/cramfs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index f408994fc632..b72449c19cd1 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -417,10 +417,15 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		int i;
 		vma->vm_flags |= VM_MIXEDMAP;
-		for (i = 0; i < pages && !ret; i++) {
+		for (i = 0; i < pages; i++) {
+			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
 			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
-			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			if (vmf & VM_FAULT_ERROR) {
+				pages = i;
+				break;
+			}
 		}
 	}
 
-- 
2.18.0

