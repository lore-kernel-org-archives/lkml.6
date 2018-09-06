Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D72075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2U3jVha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9D72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIFOvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:51:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeIFOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yxmbl56tv7HLNfXgOE/BZI19JdBTawzvk1NPURmcTeY=; b=c2U3jVhaYHNNmNQOgwPDYW8tW
        j0TAzSt4R5+v5R330p8JI6xH/sZG4t//KgCTf4+uCN78+AHM2m0asf9p+oV2Uvh4ZOtZ/u4oqogau
        pBSD/RaC04/YO2M2hHkkiraMKzoyrjLcQxh0VBC9KBCGCIAkQQ54R9HXEEXMgpJpJYQ6iTisFFBzk
        jKl54rWa87G0XNne6HYJQmjJhH00Q+6BO9WljseLykWRm9nNoqCDCsPjrRSvZSTOqeKVood8QtwY0
        Nr+xE1UVLUrGuBIYxP3Scixvieh+NeBTTTjx2vyfoF6FW3Dp7Nu5qMFCelMfo6H1c94z0JrWMxQLa
        YhfD27ggQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxrL9-0001V9-0H; Thu, 06 Sep 2018 10:16:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8202D20210309; Thu,  6 Sep 2018 12:16:41 +0200 (CEST)
Date:   Thu, 6 Sep 2018 12:16:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906101641.GG24142@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906081300.GF24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:13:00AM +0200, Peter Zijlstra wrote:
> No, you got it the first time. There are in fact more fixmap abusers;
> see drivers/acpi/apei/ghes.c.  Also, as long as set_fixmap() allows
> overwriting a _PAGE_PRESENT pte and has that dodgy
> __flush_tlb_one_kernel() in it, the broken remains (and can return).
> 
> So we need to fix fixmap, to either disallow overwriting a _PAGE_PRESENT
> pte, or to issue a full TLB invalidate.
> 
> Either fix will terminally break GHES, but that's OK, they've known
> about this issue since 2015 and haven't cared, so I can't be bothered
> about them.

In fact, the below seems to cure all woes..

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b9d5e7c9ef43..00f1c9e4f0a3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -709,22 +709,25 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 		pages[1] = virt_to_page(addr + PAGE_SIZE);
 	}
 	BUG_ON(!pages[0]);
-	local_irq_save(flags);
+
 	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
 	if (pages[1])
 		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
+
+	local_irq_save(flags);
 	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
 	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
-	clear_fixmap(FIX_TEXT_POKE0);
-	if (pages[1])
-		clear_fixmap(FIX_TEXT_POKE1);
-	local_flush_tlb();
 	sync_core();
 	/* Could also do a CLFLUSH here to speed up CPU recovery; but
 	   that causes hangs on some VIA CPUs. */
 	for (i = 0; i < len; i++)
 		BUG_ON(((char *)addr)[i] != ((char *)opcode)[i]);
 	local_irq_restore(flags);
+
+	clear_fixmap(FIX_TEXT_POKE0);
+	if (pages[1])
+		clear_fixmap(FIX_TEXT_POKE1);
+
 	return addr;
 }
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..fd6af66bc400 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -260,14 +260,28 @@ static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 {
 	pmd_t *pmd = fill_pmd(pud, vaddr);
 	pte_t *pte = fill_pte(pmd, vaddr);
+	pte_t old_pte = *pte;
 
 	set_pte(pte, new_pte);
 
 	/*
-	 * It's enough to flush this one mapping.
-	 * (PGE mappings get flushed as well)
+	 * If it was present and changes, we need to invalidate TLBs.
 	 */
-	__flush_tlb_one_kernel(vaddr);
+	if (!(pte_present(old_pte) && !pte_same(old_pte, new_pte)))
+		return;
+
+	if (WARN(irqs_disabled(), "broken set_fixmap(%d, %lx), was: %lx",
+				(int)__virt_to_fix(vaddr),
+				pte_val(new_pte), pte_val(old_pte))) {
+		/*
+		 * It is _NOT_ enough to flush just the local mapping;
+		 * it might mostly work, but there is no guarantee a remote
+		 * CPU didn't load this entry into its TLB.
+		 */
+		__flush_tlb_one_kernel(vaddr);
+	} else {
+		flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
+	}
 }
 
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 52ae5438edeb..e3c415bdbfbf 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -19,6 +19,7 @@ config ACPI_APEI
 
 config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
+	depends on BROKEN if X86
 	depends on ACPI_APEI
 	select ACPI_HED
 	select IRQ_WORK
