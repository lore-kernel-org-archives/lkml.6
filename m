Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D725BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8820834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m9OTzu9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE8820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLABPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeLABPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=htZ08rlxgS2BEec6pWnM6IPnKncVCK07MaVOAwK8DCU=; b=m9OTzu9sKPJUlypxtSbgEsYl59
        9EDJNEIHZxjV6qQ+asV8P6QWY1bKhE6MbRjXSOHpV84emu+gQsSOo2RvF+n+TcbpvpVVFiNWwRrFX
        /C0IbWueHTOSYltC5W2QQkjrdio61wOxgAzIHAXE02PTQ8pU6qdDHpsuky00guh1QW7RSAV72DWyS
        YiE3DLexiGK/U24ulE3mFK+ak1bdJ1y6w7qHFcov3GMDy0Ya70mWtQs+XtnkhKn6jcgYeH+IuEMAb
        1MGihzEa5odzuXjhmHCVoaGqRiFdg7yebPBzH74coZcn62DxwqDTB9VGEIP+anT7Zdn8Ji5bZRALV
        5bzIS6yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSjQv-0003Dq-21; Fri, 30 Nov 2018 14:06:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D7512029FD78; Fri, 30 Nov 2018 15:06:14 +0100 (CET)
Message-Id: <20181130140337.662216603@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 14:44:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86/mm/cpa: Better use clflushopt
References: <20181130134455.490139778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-cpa-clflush_opt.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we issue an MFENCE before and after flushing a range. This
means that if we flush a bunch of single page ranges -- like with the
cpa array, we issue a whole bunch of superfluous MFENCEs.

Reorgainze the code a little to avoid this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -251,15 +251,7 @@ static unsigned long __cpa_addr(struct c
  * Flushing functions
  */
 
-/**
- * clflush_cache_range - flush a cache range with clflush
- * @vaddr:	virtual start address
- * @size:	number of bytes to flush
- *
- * clflushopt is an unordered instruction which needs fencing with mfence or
- * sfence to avoid ordering issues.
- */
-void clflush_cache_range(void *vaddr, unsigned int size)
+static void clflush_cache_range_opt(void *vaddr, unsigned int size)
 {
 	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
 	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
@@ -268,11 +260,22 @@ void clflush_cache_range(void *vaddr, un
 	if (p >= vend)
 		return;
 
-	mb();
-
 	for (; p < vend; p += clflush_size)
 		clflushopt(p);
+}
 
+/**
+ * clflush_cache_range - flush a cache range with clflush
+ * @vaddr:	virtual start address
+ * @size:	number of bytes to flush
+ *
+ * clflushopt is an unordered instruction which needs fencing with mfence or
+ * sfence to avoid ordering issues.
+ */
+void clflush_cache_range(void *vaddr, unsigned int size)
+{
+	mb();
+	clflush_cache_range_opt(vaddr, size);
 	mb();
 }
 EXPORT_SYMBOL_GPL(clflush_cache_range);
@@ -339,6 +342,7 @@ static void cpa_flush(struct cpa_data *d
 	if (!cache)
 		return;
 
+	mb();
 	for (i = 0; i < cpa->numpages; i++) {
 		unsigned long addr = __cpa_addr(cpa, i);
 		unsigned int level;
@@ -349,8 +353,9 @@ static void cpa_flush(struct cpa_data *d
 		 * Only flush present addresses:
 		 */
 		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range((void *)addr, PAGE_SIZE);
+			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
 	}
+	mb();
 }
 
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,


