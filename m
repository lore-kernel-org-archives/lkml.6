Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32324C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005102173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfAGTyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbfAGTxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2D9218D9;
        Mon,  7 Jan 2019 19:53:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxp-0000Ms-VN; Mon, 07 Jan 2019 14:53:33 -0500
Message-Id: <20190107195333.842328119@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:53:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 11/13] x86/mm/pat: disable preemption __split_large_page() after spin_lock()
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 45c6ff4811878e5c1c2ae31303cd95cdc6ae2ab4 ]

Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
warning if __flush_tlb_all() is invoked in preemptible context. On !RT
the warning does not trigger because a spin lock is acquired which
disables preemption. On RT the spin lock does not disable preemption and
so the warning is seen.

Disable preemption to avoid the warning __flush_tlb_all().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/mm/pageattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 835620ab435f..57a04ef6fe47 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -661,12 +661,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pgprot_t ref_prot;
 
 	spin_lock(&pgd_lock);
+	/*
+	 * Keep preemption disabled after __flush_tlb_all() which expects not be
+	 * preempted during the flush of the local TLB.
+	 */
+	preempt_disable();
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
 	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte) {
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -696,6 +702,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		break;
 
 	default:
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -743,6 +750,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * going on.
 	 */
 	__flush_tlb_all();
+	preempt_enable();
 	spin_unlock(&pgd_lock);
 
 	return 0;
-- 
2.19.2


