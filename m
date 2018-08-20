Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D255521534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D255521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHTI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 04:29:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbeHTI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 04:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75FE6AE16;
        Mon, 20 Aug 2018 05:15:03 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
Date:   Mon, 20 Aug 2018 07:14:56 +0200
Message-Id: <20180820051456.20779-3-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180820051456.20779-1-jgross@suse.com>
References: <20180820051456.20779-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using only 32-bit writes for the pte will result in an intermediate
L1TF vulnerable PTE. When running as a Xen PV guest this will at once
switch the guest to shadow mode resulting in a loss of performance.

Use arch_atomic64_xchg() instead which will perform the requested
operation atomically with all 64 bits.

Some performance considerations according to:

https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf

The main number should be the latency, as there is no tight loop around
native_ptep_get_and_clear().

"lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
memory operand) isn't mentioned in that document. "lock xadd" (with xadd
having 3 cycles less latency than xchg) has a latency of 11, so we can
assume a latency of 14 for "lock xchg".

Signed-off-by: Juergen Gross <jgross@suse.com>
---
In case adding about 6 cycles for native_ptep_get_and_clear() is believed
to be too bad I can modify the patch to add a paravirt function for that
purpose in order to add the overhead for Xen guests only (in fact the
overhead for Xen guests will be less, as only one instruction writing to
the PTE has to be emulated by the hypervisor).
---
 arch/x86/include/asm/pgtable-3level.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index a564084c6141..7919ae4e27d8 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
+#include <asm/atomic64_32.h>
+
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -148,14 +150,14 @@ static inline void pud_clear(pud_t *pudp)
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
-	pte_t res;
+	union {
+		pte_t pte;
+		long long val;
+	} res;
 
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low = xchg(&ptep->pte_low, 0);
-	res.pte_high = ptep->pte_high;
-	ptep->pte_high = 0;
+	res.val = arch_atomic64_xchg((atomic64_t *)ptep, 0);
 
-	return res;
+	return res.pte;
 }
 #else
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
-- 
2.13.7

