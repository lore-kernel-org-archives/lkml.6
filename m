Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD39C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC602075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+NR29/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC602075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeIFNR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:17:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeIFNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I2m1nJpxwolK6Ba/t22GmwAF/t69Hse/lOxUqR6MY4o=; b=j+NR29/ux8yOkc6iH/+tknb/W
        f+BW7V0QOoy8oXCSPm6DimqxSHFuFRgC8YpdOtcuHsD3drlkQdMZu94K+9ctY9EDVcW7XV7L6b8SN
        EHqY5AqoPeb/ctjZr8ntO95pTBR7Z2KsGkHKmTIS/yFjNZ9gkAQfJC0RNIMwiuw7uAESpfFQvmN2V
        QFwq9BftK46rTHWarkVpLi1pKQ0yPmY3l8sOBIdduHiHz7doBtFO55L7yg3jklsNyCwa648obMC2Y
        pkoJWO4tCRFsyEvzx/cFS4eMC3Pb9pOBe0pxRtHsRlcwKfgh0IG5yl002V/qSYLqKRS20JPfbCgMo
        frVkP61SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxpsR-0002rE-Cv; Thu, 06 Sep 2018 08:42:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F184A202547F9; Thu,  6 Sep 2018 10:42:56 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:42:56 +0200
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
Message-ID: <20180906084256.GE24142@hirez.programming.kicks-ass.net>
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

Worse, when I boot with the below patch in, I get hits on text_poke (we
knew about this), but I also get hits from:

  release_ds_buffer()

Because PEBS/BTS hardware write through the page-tables (I know right),
their buffers need to be in the PTI user map, and we do that by mapping
the pages in the CAE, and that uses fixmap.

---
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..20dcd6fa690e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -259,9 +259,16 @@ static pte_t *fill_pte(pmd_t *pmd, unsigned long vaddr)
 static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 {
 	pmd_t *pmd = fill_pmd(pud, vaddr);
-	pte_t *pte = fill_pte(pmd, vaddr);
+	pte_t *ptep = fill_pte(pmd, vaddr);
 
-	set_pte(pte, new_pte);
+	pte_t pte = *ptep;
+
+	set_pte(ptep, new_pte);
+
+	WARN((pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) != pte_val(new_pte)),
+		"set_fixmap(%d, %lx), was: %lx",
+		(int)__virt_to_fix(vaddr),
+		pte_val(new_pte), pte_val(pte));
 
 	/*
 	 * It's enough to flush this one mapping.
