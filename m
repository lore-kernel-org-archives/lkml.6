Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F87C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DD42087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeI3ESZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51631 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H3-A7; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yV-I9; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andi Kleen" <ak@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.643444669@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 120/131] x86/mm/pat: Make set_memory_np() L1TF safe
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

commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream.

set_memory_np() is used to mark kernel mappings not present, but it has
it's own open coded mechanism which does not have the L1TF protection of
inverting the address bits.

Replace the open coded PTE manipulation with the L1TF protecting low level
PTE routines.

Passes the CPA self test.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16:
 - cpa->pfn is actually a physical address here and needs to be shifted to
   produce a PFN
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -952,7 +952,8 @@ static int populate_pmd(struct cpa_data
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, __pmd(cpa->pfn | _PAGE_PSE | massage_pgprot(pgprot)));
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
+					canon_pgprot(pgprot))));
 
 		start	  += PMD_SIZE;
 		cpa->pfn  += PMD_SIZE;
@@ -1022,7 +1023,8 @@ static int populate_pud(struct cpa_data
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
 	while (end - start >= PUD_SIZE) {
-		set_pud(pud, __pud(cpa->pfn | _PAGE_PSE | massage_pgprot(pgprot)));
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn >> PAGE_SHIFT,
+				   canon_pgprot(pgprot))));
 
 		start	  += PUD_SIZE;
 		cpa->pfn  += PUD_SIZE;

