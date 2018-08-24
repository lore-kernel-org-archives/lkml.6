Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A13C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359CE21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359CE21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeHXT1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:27:51 -0400
Received: from foss.arm.com ([217.140.101.70]:32806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbeHXT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:27:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E082F15A2;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B233F3F763;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A76191AE321F; Fri, 24 Aug 2018 16:52:47 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 01/11] arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
Date:   Fri, 24 Aug 2018 16:52:36 +0100
Message-Id: <1535125966-7666-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_tlb_kernel_range() is only ever used to invalidate last-level
entries, so we can restrict the scope of the TLB invalidation
instruction.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a4a1901140ee..7e2a35424ca4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -199,7 +199,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
-		__tlbi(vaae1is, addr);
+		__tlbi(vaale1is, addr);
 	dsb(ish);
 	isb();
 }
-- 
2.1.4

