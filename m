Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4891C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9nG6HiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKTXMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:12:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bDC1jsxvFOd8I5xXFBDzemAk6occ6ogzcepkNcGkf7U=; b=r9nG6HiWuCsZQBRPL3NoAUKNO
        nwNXdYVo9SsmR7+Gf7fqwvCtJUA1SXaPrYbZR6irKlSxajJPwW5Rh/ODmQ1ZJ6xBn9lNAt+OzDHPE
        xYqf7fEzv9ssoqqx6JcHG8cAzImyekK7ubZ9bU26hukv2ZbScTCmqfqKR+R7Z84vgskp0fa/Z1Mod
        BRT48rGfLvQun+zMkoVLRnO48LGyfSIHCrmBA6+z4yEjOx3qcqg7m5A5TjQI7s0DWWqjKzv38kvgo
        sXXPZsWIPuSv+33ekrIdirTKVAxNHz+kVCrmt50nCUuvX3UaShkmKTl4i5eGVsVXHuyPlRfSS8jsV
        W2hwkQA2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP5MP-0003Qm-V4; Tue, 20 Nov 2018 12:42:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51D6F2029F87F; Tue, 20 Nov 2018 13:42:32 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:42:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 00/10] x86/alternative: text_poke() fixes
Message-ID: <20181120124232.GK2131@hirez.programming.kicks-ass.net>
References: <20181113130730.44844-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113130730.44844-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 05:07:20AM -0800, Nadav Amit wrote:
> v4->v5:
> - Fix Xen breakage [Damian Tometzki]
> - BUG_ON() when poking_mm initialization fails [PeterZ]
> - Better comments on "x86/mm: temporary mm struct"
> - Cleaner removal of the custom poker

I'll re-iterate my position: it is impossible for the text not to match,
and if it somehow does not match, something went sideways in an
unrecoverably fashion.

text_poke() must not fail, ever. If it does, our text is inconsistent
and we must abort/panic/bug.

The only way I will accept anything else is if someone can come up with
a sensible scenario of text_poke() failing and recovering from it.
AFAICT there is no possible way to gracefully recover.

Consider a jump label with multiple patch sites; we patch the first,
then fail. In order to restore to a sane state, we must undo the
patching of the first, but undoing text_poke() fails again. Then
what?

Allowing text_poke() to fail only creates an unfixable mess. Esp. since
there is no sane scenario under which is can fail.

---


--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -695,7 +695,7 @@ void __init_or_module text_poke_early(vo
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static int __text_poke(void *addr, const void *opcode, size_t len)
+static void __text_poke(void *addr, const void *opcode, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	temporary_mm_state_t prev;
@@ -731,13 +731,10 @@ static int __text_poke(void *addr, const
 	 * The lock is not really needed, but this allows to avoid open-coding.
 	 */
 	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
-
 	/*
-	 * If we failed to allocate a PTE, fail. This should *never* happen,
-	 * since we preallocate the PTE.
+	 * This must not fail; preallocated in poking_init().
 	 */
-	if (WARN_ON_ONCE(!ptep))
-		goto out;
+	VM_BUG_ON(!ptep)
 
 	pte = mk_pte(pages[0], PAGE_KERNEL);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
@@ -795,12 +792,14 @@ static int __text_poke(void *addr, const
 	unuse_temporary_mm(prev);
 
 	pte_unmap_unlock(ptep, ptl);
-out:
-	if (memcmp(addr, opcode, len))
-		r = -EFAULT;
+
+	/*
+	 * If the text doesn't match what we just wrote; something is
+	 * fundamentally screwy, there's nothing we can really do about that.
+	 */
+	BUG_ON(memcmp(addr, opcode, len));
 
 	local_irq_restore(flags);
-	return r;
 }
 
 /**
@@ -814,21 +813,10 @@ static int __text_poke(void *addr, const
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
  */
-int text_poke(void *addr, const void *opcode, size_t len)
+void text_poke(void *addr, const void *opcode, size_t len)
 {
-	int r;
-
 	lockdep_assert_held(&text_mutex);
-
-	r = __text_poke(addr, opcode, len);
-
-	/*
-	 * TODO: change the callers to consider the return value and remove this
-	 *       historical assertion.
-	 */
-	BUG_ON(r);
-
-	return r;
+	__text_poke(addr, opcode, len);
 }
 
 /**
@@ -847,7 +835,7 @@ int text_poke(void *addr, const void *op
  */
 int text_poke_kgdb(void *addr, const void *opcode, size_t len)
 {
-	return __text_poke(addr, opcode, len);
+	__text_poke(addr, opcode, len);
 }
 
 static void do_sync_core(void *info)
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -767,10 +767,8 @@ int kgdb_arch_set_breakpoint(struct kgdb
 	 */
 	if (mutex_is_locked(&text_mutex))
 		return -EBUSY;
-	err = text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
+	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
 			     BREAK_INSTR_SIZE);
-	if (err)
-		return err;
 	bpt->type = BP_POKE_BREAKPOINT;
 
 	return err;
@@ -788,11 +786,8 @@ int kgdb_arch_remove_breakpoint(struct k
 	 */
 	if (mutex_is_locked(&text_mutex))
 		goto knl_write;
-	err = text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
-			     BREAK_INSTR_SIZE);
-	if (err)
-		goto knl_write;
-	return err;
+	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr, BREAK_INSTR_SIZE);
+	return 0;
 
 knl_write:
 	return probe_kernel_write((char *)bpt->bpt_addr,
