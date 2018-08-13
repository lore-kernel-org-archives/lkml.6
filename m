Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D0B21898
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D0B21898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeHMKSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeHMKSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:18:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6E44AEED;
        Mon, 13 Aug 2018 07:37:46 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 11/11] x86/paravirt: remove unneeded mmu related paravirt ops bits
Date:   Mon, 13 Aug 2018 09:37:39 +0200
Message-Id: <20180813073739.26108-12-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have 32-bit code for CONFIG_PGTABLE_LEVELS >= 4.
Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4ceb3708fe06..0499f17ca480 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -501,25 +501,14 @@ static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
 
-	if (sizeof(pudval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pudval_t, mmu.make_pud, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
+	ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
 
 	return (pud_t) { ret };
 }
 
 static inline pudval_t pud_val(pud_t pud)
 {
-	pudval_t ret;
-
-	if (sizeof(pudval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pudval_t, mmu.pud_val,
-				    pud.pud, (u64)pud.pud >> 32);
-	else
-		ret =  PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
-
-	return ret;
+	return PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -531,10 +520,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	p4dval_t val = native_p4d_val(p4d);
 
-	if (sizeof(p4dval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_p4d, p4dp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_p4d, p4dp, val);
+	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-- 
2.13.7

