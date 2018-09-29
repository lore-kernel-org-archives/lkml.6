Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79519C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495082087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495082087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeI3ES2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000HA-D0; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yH-EJ; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.291927771@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 117/131] x86/speculation/l1tf: Exempt zeroed PTEs
 from inversion
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit f19f5c49bbc3ffcc9126cc245fc1b24cc29f4a37 upstream.

It turns out that we should *not* invert all not-present mappings,
because the all zeroes case is obviously special.

clear_page() does not undergo the XOR logic to invert the address bits,
i.e. PTE, PMD and PUD entries that have not been individually written
will have val=0 and so will trigger __pte_needs_invert(). As a result,
{pte,pmd,pud}_pfn() will return the wrong PFN value, i.e. all ones
(adjusted by the max PFN mask) instead of zero. A zeroed entry is ok
because the page at physical address 0 is reserved early in boot
specifically to mitigate L1TF, so explicitly exempt them from the
inversion when reading the PFN.

Manifested as an unexpected mprotect(..., PROT_NONE) failure when called
on a VMA that has VM_PFNMAP and was mmap'd to as something other than
PROT_NONE but never used. mprotect() sends the PROT_NONE request down
prot_none_walk(), which walks the PTEs to check the PFNs.
prot_none_pte_entry() gets the bogus PFN from pte_pfn() and returns
-EACCES because it thinks mprotect() is trying to adjust a high MMIO
address.

[ This is a very modified version of Sean's original patch, but all
  credit goes to Sean for doing this and also pointing out that
  sometimes the __pte_needs_invert() function only gets the protection
  bits, not the full eventual pte.  But zero remains special even in
  just protection bits, so that's ok.   - Linus ]

Fixes: f22cc87f6c1f ("x86/speculation/l1tf: Invert all not present mappings")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable-invert.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -4,9 +4,18 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * A clear pte value is special, and doesn't get inverted.
+ *
+ * Note that even users that only pass a pgprot_t (rather
+ * than a full pte) won't trigger the special zero case,
+ * because even PAGE_NONE has _PAGE_PROTNONE | _PAGE_ACCESSED
+ * set. So the all zero case really is limited to just the
+ * cleared page table entry case.
+ */
 static inline bool __pte_needs_invert(u64 val)
 {
-	return !(val & _PAGE_PRESENT);
+	return val && !(val & _PAGE_PRESENT);
 }
 
 /* Get a mask to xor with the page table entry to get the correct pfn. */

