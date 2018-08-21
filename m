Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387DAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0F2214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0F2214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeHUQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:23:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63874 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeHUQX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:23:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41vrSv5S1mz9tvSH;
        Tue, 21 Aug 2018 15:03:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IdBwutQ7B8UH; Tue, 21 Aug 2018 15:03:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41vrSv4zv4z9tvS6;
        Tue, 21 Aug 2018 15:03:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEC398B7EE;
        Tue, 21 Aug 2018 15:03:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TSHdD2BLHpQ2; Tue, 21 Aug 2018 15:03:23 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90B3D8B7DD;
        Tue, 21 Aug 2018 15:03:23 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 44C9A71322; Tue, 21 Aug 2018 13:03:23 +0000 (UTC)
Message-Id: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/nohash: fix pte_access_permitted()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
Date:   Tue, 21 Aug 2018 13:03:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
for other platforms") replaced generic pte_access_permitted() by an
arch specific one.

The generic one is defined as
(pte_present(pte) && (!(write) || pte_write(pte)))

The arch specific one is open coded checking that _PAGE_USER and
_PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
_PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.

Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
for hugetlb access check") replaced some tests performed with
pte helpers by a call to pte_access_permitted(), leading to the same
issue.

This patch rewrites powerpc/nohash pte_access_permitted()
using pte helpers.

Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 2160be2e4339..b321c82b3624 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -51,17 +51,14 @@ static inline int pte_present(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;
-- 
2.13.3

