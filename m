Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E69C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761DE21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761DE21728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbeHNUQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:16:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733240AbeHNUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:16:12 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2F6E40B;
        Tue, 14 Aug 2018 17:28:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 76/79] x86/mm/pat: Make set_memory_np() L1TF safe
Date:   Tue, 14 Aug 2018 19:17:35 +0200
Message-Id: <20180814171341.054441030@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

set_memory_np() is used to mark kernel mappings not present, but it has
it's own open coded mechanism which does not have the L1TF protection of
inverting the address bits.

Replace the open coded PTE manipulation with the L1TF protecting low level
PTE routines.

Passes the CPA self test.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pageattr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1014,8 +1014,8 @@ static long populate_pmd(struct cpa_data
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, __pmd(cpa->pfn << PAGE_SHIFT | _PAGE_PSE |
-				   massage_pgprot(pmd_pgprot)));
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;
 		cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
@@ -1087,8 +1087,8 @@ static int populate_pud(struct cpa_data
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
 	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
-		set_pud(pud, __pud(cpa->pfn << PAGE_SHIFT | _PAGE_PSE |
-				   massage_pgprot(pud_pgprot)));
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+				   canon_pgprot(pud_pgprot))));
 
 		start	  += PUD_SIZE;
 		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;


