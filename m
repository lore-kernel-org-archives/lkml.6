Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF38BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31822084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZB8VX8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31822084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJYXHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbeJYWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C281B20834;
        Thu, 25 Oct 2018 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477072;
        bh=thc59NMAMwXEsx9J8JNhHe9ww4h2Y09XGKraxAOjITU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZB8VX8xt9DJPyI13c/18OE3KIZm1kwVR1ZI545JKJcSMKhBT42av/eJamY3MKGcy
         UeCpgB5zaIPjOOxAUVtDYW9mTBv68S9UcsfF8saApgkgrZQa7SgQzzJEb1x2I1uEKR
         RliYyxPj9yq52oAJOXeCltrvrw3UgJ/lC5Ttx7b8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 27/65] arm64: Fix potential race with hardware DBM in ptep_set_access_flags()
Date:   Thu, 25 Oct 2018 10:16:27 -0400
Message-Id: <20181025141705.213937-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 6d332747fa5f0a6843b56b5b129168ba909336d1 ]

In a system with DBM (dirty bit management) capable agents there is a
possible race between a CPU executing ptep_set_access_flags() (maybe
non-DBM capable) and a hardware update of the dirty state (clearing of
PTE_RDONLY). The scenario:

a) the pte is writable (PTE_WRITE set), clean (PTE_RDONLY set) and old
   (PTE_AF clear)
b) ptep_set_access_flags() is called as a result of a read access and it
   needs to set the pte to writable, clean and young (PTE_AF set)
c) a DBM-capable agent, as a result of a different write access, is
   marking the entry as young (setting PTE_AF) and dirty (clearing
   PTE_RDONLY)

The current ptep_set_access_flags() implementation would set the
PTE_RDONLY bit in the resulting value overriding the DBM update and
losing the dirty state.

This patch fixes such race by setting PTE_RDONLY to the most permissive
(lowest value) of the current entry and the new one.

Fixes: 66dbd6e61a52 ("arm64: Implement ptep_set_access_flags() for hardware AF/DBM")
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 86485415c5f0..be7f8416809f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -107,26 +107,27 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	/* only preserve the access flags and write permission */
 	pte_val(entry) &= PTE_AF | PTE_WRITE | PTE_DIRTY;
 
-	/*
-	 * PTE_RDONLY is cleared by default in the asm below, so set it in
-	 * back if necessary (read-only or clean PTE).
-	 */
+	/* set PTE_RDONLY if actual read-only or clean PTE */
 	if (!pte_write(entry) || !pte_sw_dirty(entry))
 		pte_val(entry) |= PTE_RDONLY;
 
 	/*
 	 * Setting the flags must be done atomically to avoid racing with the
-	 * hardware update of the access/dirty state.
+	 * hardware update of the access/dirty state. The PTE_RDONLY bit must
+	 * be set to the most permissive (lowest value) of *ptep and entry
+	 * (calculated as: a & b == ~(~a | ~b)).
 	 */
+	pte_val(entry) ^= PTE_RDONLY;
 	asm volatile("//	ptep_set_access_flags\n"
 	"	prfm	pstl1strm, %2\n"
 	"1:	ldxr	%0, %2\n"
-	"	and	%0, %0, %3		// clear PTE_RDONLY\n"
+	"	eor	%0, %0, %3		// negate PTE_RDONLY in *ptep\n"
 	"	orr	%0, %0, %4		// set flags\n"
+	"	eor	%0, %0, %3		// negate final PTE_RDONLY\n"
 	"	stxr	%w1, %0, %2\n"
 	"	cbnz	%w1, 1b\n"
 	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
-	: "L" (~PTE_RDONLY), "r" (pte_val(entry)));
+	: "L" (PTE_RDONLY), "r" (pte_val(entry)));
 
 	flush_tlb_fix_spurious_fault(vma, address);
 	return 1;
-- 
2.17.1

