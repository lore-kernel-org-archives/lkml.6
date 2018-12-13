Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23696C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3220851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeLMQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:44:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLMQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:44:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gXU6B-0003tG-5E; Thu, 13 Dec 2018 17:44:31 +0100
Date:   Thu, 13 Dec 2018 17:44:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Subject: [PATCH RT] x86/mm/pat: disable preemption __split_large_page() after
 spin_lock()
Message-ID: <20181213164430.mggilzfjgr5retz6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
warning if __flush_tlb_all() is invoked in preemptible context. On !RT
the warning does not trigger because a spin lock is acquired which
disables preemption. On RT the spin lock does not disable preemption and
so the warning is seen.

Disable preemption to avoid the warning in __flush_tlb_all().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/pageattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e2d4b25c7aa44..abbe3e93ec266 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -687,6 +687,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pgprot_t ref_prot;
 
 	spin_lock(&pgd_lock);
+	preempt_disable();
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
@@ -694,6 +695,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte) {
 		spin_unlock(&pgd_lock);
+		preempt_enable();
 		return 1;
 	}
 
@@ -727,6 +729,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 
 	default:
 		spin_unlock(&pgd_lock);
+		preempt_enable();
 		return 1;
 	}
 
@@ -764,6 +767,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * going on.
 	 */
 	__flush_tlb_all();
+	preempt_enable();
 	spin_unlock(&pgd_lock);
 
 	return 0;
-- 
2.20.0

