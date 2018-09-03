Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BB620779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BB620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeICV0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:26:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbeICV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:26:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D22C6CFE;
        Mon,  3 Sep 2018 17:05:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/107] arc: fix type warnings in arc/mm/cache.c
Date:   Mon,  3 Sep 2018 18:56:04 +0200
Message-Id: <20180903165639.217764168@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ec837d620c750c0d4996a907c8c4f7febe1bbeee ]

Fix type warnings in arch/arc/mm/cache.c.

../arch/arc/mm/cache.c: In function 'flush_anon_page':
../arch/arc/mm/cache.c:1062:55: warning: passing argument 2 of '__flush_dcache_page' makes integer from pointer without a cast [-Wint-conversion]
  __flush_dcache_page((phys_addr_t)page_address(page), page_address(page));
                                                       ^~~~~~~~~~~~~~~~~~
../arch/arc/mm/cache.c:1013:59: note: expected 'long unsigned int' but argument is of type 'void *'
 void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)
                                             ~~~~~~~~~~~~~~^~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/mm/cache.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -840,7 +840,7 @@ void flush_cache_mm(struct mm_struct *mm
 void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,
 		      unsigned long pfn)
 {
-	unsigned int paddr = pfn << PAGE_SHIFT;
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
 
 	u_vaddr &= PAGE_MASK;
 
@@ -860,8 +860,9 @@ void flush_anon_page(struct vm_area_stru
 		     unsigned long u_vaddr)
 {
 	/* TBD: do we really need to clear the kernel mapping */
-	__flush_dcache_page(page_address(page), u_vaddr);
-	__flush_dcache_page(page_address(page), page_address(page));
+	__flush_dcache_page((phys_addr_t)page_address(page), u_vaddr);
+	__flush_dcache_page((phys_addr_t)page_address(page),
+			    (phys_addr_t)page_address(page));
 
 }
 


