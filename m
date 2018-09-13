Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A821CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CACD20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CACD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeIMS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:58:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbeIMS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:58:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2BA74D1A;
        Thu, 13 Sep 2018 13:48:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.14 103/115] x86/xen: dont write ptes directly in 32-bit PV guests
Date:   Thu, 13 Sep 2018 15:32:03 +0200
Message-Id: <20180913131829.701763608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
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

From: Juergen Gross <jgross@suse.com>

commit f7c90c2aa4004808dff777ba6ae2c7294dd06851 upstream.

In some cases 32-bit PAE PV guests still write PTEs directly instead of
using hypercalls. This is especially bad when clearing a PTE as this is
done via 32-bit writes which will produce intermediate L1TF attackable
PTEs.

Change the code to use hypercalls instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/mmu_pv.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -425,14 +425,13 @@ static void xen_set_pud(pud_t *ptr, pud_
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
@@ -1543,7 +1542,7 @@ static void __init xen_set_pte_init(pte_
 		pte = __pte_ma(((pte_val_ma(*ptep) & _PAGE_RW) | ~_PAGE_RW) &
 			       pte_val_ma(pte));
 #endif
-	native_set_pte(ptep, pte);
+	__xen_set_pte(ptep, pte);
 }
 
 /* Early in boot, while setting up the initial pagetable, assume


