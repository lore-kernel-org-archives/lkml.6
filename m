Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58B2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53982243B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhPduF/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53982243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbeKLIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390163AbeKLIWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2723A21780;
        Sun, 11 Nov 2018 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975525;
        bh=NGnSLJ8RbFtDbfZlKfoRY1cq9X92ZKJbVMuuCFGd3y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhPduF/MoXzdlEQE6mvyvBlQvi6QllzHBd4NbM85rQ0IZ6aPeoHTEGCdbKVb22OLL
         +z/cDC7SqBRqG+jaSbpmU6WpWEMtwQm8nZ7dOCWYRIuXZqVMZEgNFRZG8hbA0IkCq9
         izapsFPkyT9IiCmlOxxJ0O+DJFCiMnkl0hZUw8rc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4.14 022/222] x86/mm/pat: Disable preemption around __flush_tlb_all()
Date:   Sun, 11 Nov 2018 14:21:59 -0800
Message-Id: <20181111221650.152810263@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit f77084d96355f5fba8e2c1fb3a51a393b1570de7 upstream.

The WARN_ON_ONCE(__read_cr3() != build_cr3()) in switch_mm_irqs_off()
triggers every once in a while during a snapshotted system upgrade.

The warning triggers since commit decab0888e6e ("x86/mm: Remove
preempt_disable/enable() from __native_flush_tlb()"). The callchain is:

  get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()

with CONFIG_DEBUG_PAGEALLOC enabled.

Disable preemption during CR3 reset / __flush_tlb_all() and add a comment
why preemption has to be disabled so it won't be removed accidentaly.

Add another preemptible() check in __flush_tlb_all() to catch callers with
enabled preemption when PGE is enabled, because PGE enabled does not
trigger the warning in __native_flush_tlb(). Suggested by Andy Lutomirski.

Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181017103432.zgv46nlu3hc7k4rq@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/tlbflush.h |    6 ++++++
 arch/x86/mm/pageattr.c          |    6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -466,6 +466,12 @@ static inline void __native_flush_tlb_on
  */
 static inline void __flush_tlb_all(void)
 {
+	/*
+	 * This is to catch users with enabled preemption and the PGE feature
+	 * and don't trigger the warning in __native_flush_tlb().
+	 */
+	VM_WARN_ON_ONCE(preemptible());
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2037,9 +2037,13 @@ void __kernel_map_pages(struct page *pag
 
 	/*
 	 * We should perform an IPI and flush all tlbs,
-	 * but that can deadlock->flush only current cpu:
+	 * but that can deadlock->flush only current cpu.
+	 * Preemption needs to be disabled around __flush_tlb_all() due to
+	 * CR3 reload in __native_flush_tlb().
 	 */
+	preempt_disable();
 	__flush_tlb_all();
+	preempt_enable();
 
 	arch_flush_lazy_mmu_mode();
 }


