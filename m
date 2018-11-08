Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2263ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D02147D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wOZavfY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1D02147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbeKIHh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeKIHhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7730620892;
        Thu,  8 Nov 2018 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714425;
        bh=aKoEw8oP+Jgel6C28qhr9GK8pSof0pSC8i0lpUSwko4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOZavfY5JNKa9affXm2zevc+meE4uzD7KnQb5dzXc8V8h/3EJMdjPdUpWIIwEGSWZ
         eS/hVZIojUNd+x1RlxgLkpvrJ1Qk/jLPj8fxww9cIvdasbuWYlTFCaDqE6mIuzMDf/
         L8nIlirl6gNu1JpfaZ9Tc1T5Ivxe4wiMBtiAGkPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/114] arm64: Fix potential race with hardware DBM in ptep_set_access_flags()
Date:   Thu,  8 Nov 2018 13:51:00 -0800
Message-Id: <20181108215105.255949409@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



