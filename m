Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC6FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EFE2064E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EFE2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbeHNU0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:26:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeHNU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:26:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DE1BD20;
        Tue, 14 Aug 2018 17:38:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 102/104] x86/mm/kmmio: Make the tracer robust against L1TF
Date:   Tue, 14 Aug 2018 19:17:56 +0200
Message-Id: <20180814171521.627418245@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 1063711b57393c1999248cccb57bebfaf16739e7 upstream

The mmio tracer sets io mapping PTEs and PMDs to non present when enabled
without inverting the address bits, which makes the PTE entry vulnerable
for L1TF.

Make it use the right low level macros to actually invert the address bits
to protect against L1TF.

In principle this could be avoided because MMIO tracing is not likely to be
enabled on production machines, but the fix is straigt forward and for
consistency sake it's better to get rid of the open coded PTE manipulation.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/kmmio.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -126,24 +126,29 @@ static struct kmmio_fault_page *get_kmmi
 
 static void clear_pmd_presence(pmd_t *pmd, bool clear, pmdval_t *old)
 {
+	pmd_t new_pmd;
 	pmdval_t v = pmd_val(*pmd);
 	if (clear) {
-		*old = v & _PAGE_PRESENT;
-		v &= ~_PAGE_PRESENT;
-	} else	/* presume this has been called with clear==true previously */
-		v |= *old;
-	set_pmd(pmd, __pmd(v));
+		*old = v;
+		new_pmd = pmd_mknotpresent(*pmd);
+	} else {
+		/* Presume this has been called with clear==true previously */
+		new_pmd = __pmd(*old);
+	}
+	set_pmd(pmd, new_pmd);
 }
 
 static void clear_pte_presence(pte_t *pte, bool clear, pteval_t *old)
 {
 	pteval_t v = pte_val(*pte);
 	if (clear) {
-		*old = v & _PAGE_PRESENT;
-		v &= ~_PAGE_PRESENT;
-	} else	/* presume this has been called with clear==true previously */
-		v |= *old;
-	set_pte_atomic(pte, __pte(v));
+		*old = v;
+		/* Nothing should care about address */
+		pte_clear(&init_mm, 0, pte);
+	} else {
+		/* Presume this has been called with clear==true previously */
+		set_pte_atomic(pte, __pte(*old));
+	}
 }
 
 static int clear_page_presence(struct kmmio_fault_page *f, bool clear)


