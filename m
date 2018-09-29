Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B1FC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C792087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C792087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeI3ES2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51629 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H2-Co; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yb-JK; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Andi Kleen" <ak@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.543646646@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 121/131] x86/mm/kmmio: Make the tracer robust against
 L1TF
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 1063711b57393c1999248cccb57bebfaf16739e7 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/mm/kmmio.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -114,24 +114,29 @@ static struct kmmio_fault_page *get_kmmi
 
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

