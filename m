Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F2521534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F2521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeHTI3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 04:29:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeHTI3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 04:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19D25AD48;
        Mon, 20 Aug 2018 05:15:02 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/2] x86/xen: don't write ptes directly in 32-bit PV guests
Date:   Mon, 20 Aug 2018 07:14:55 +0200
Message-Id: <20180820051456.20779-2-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180820051456.20779-1-jgross@suse.com>
References: <20180820051456.20779-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases 32-bit PAE PV guests still write PTEs directly instead of
using hypercalls. This is especially bad when clearing a PTE as this is
done via 32-bit writes which will produce intermediate L1TF attackable
PTEs.

Change the code to use hypercalls instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/mmu_pv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 9e7012858420..9396b4d17064 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -434,14 +434,13 @@ static void xen_set_pud(pud_t *ptr, pud_t val)
 static void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	trace_xen_mmu_set_pte_atomic(ptep, pte);
-	set_64bit((u64 *)ptep, native_pte_val(pte));
+	__xen_set_pte(ptep, pte);
 }
 
 static void xen_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	trace_xen_mmu_pte_clear(mm, addr, ptep);
-	if (!xen_batched_set_pte(ptep, native_make_pte(0)))
-		native_pte_clear(mm, addr, ptep);
+	__xen_set_pte(ptep, native_make_pte(0));
 }
 
 static void xen_pmd_clear(pmd_t *pmdp)
@@ -1569,7 +1568,7 @@ static void __init xen_set_pte_init(pte_t *ptep, pte_t pte)
 		pte = __pte_ma(((pte_val_ma(*ptep) & _PAGE_RW) | ~_PAGE_RW) &
 			       pte_val_ma(pte));
 #endif
-	native_set_pte(ptep, pte);
+	__xen_set_pte(ptep, pte);
 }
 
 /* Early in boot, while setting up the initial pagetable, assume
-- 
2.13.7

