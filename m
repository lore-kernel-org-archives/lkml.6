Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896ACC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7356A214C5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7356A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeJEXRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:03 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeJEXRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:03 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDy9C-1fyau30pYS-00A0Za; Fri, 05 Oct 2018 18:17:27 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDy9C-1fyau30pYS-00A0Za; Fri, 05 Oct 2018 18:17:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hugetlb: fix ARM 3level page tables
Date:   Fri,  5 Oct 2018 18:16:58 +0200
Message-Id: <20181005161722.904274-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:+2XsToNchgBTSBUJPox6HDh12Rsb0+4Z6WR4YIKjJJG4wpv3DLO
 Wkjhcw1tpjUoRat94v9jQ3Ra7eEqJ2lmOPzvPGIvv7dSmH5lJHLGcVBFAQvh49SVk8j3W74
 AsHOhPFA9ynRItVI4lNhKzOtVHcOpLMuKnF2qgVTUmtaqHUzufXOj5ZPFmWWo18zjoyubA6
 CGvYSZ6OcGIZ0tLg+SLDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eDG+3pQc0L8=:iJGSA+FAcp8LRF4VrlCb3v
 HbNT+oT/2JdqiQG049NjoWhN42bQenY0n6kk3Wm0VZVsuPB7IEbaWRx0G39PrFeZ+fSC9HeRx
 Nw6UvqS261mPq0GE4UW22Wk/6YS798yCyRTeNT0+CqLQEKdxHujBp4Osz9DemGnyxQOaKUmco
 O28Pc6Qd6wwGe4n/8yr6MV2hJCzY/+XN/I+T91eH/Wewan6bTUg+LI2aw6PNC5WF2Zt0Sg+2I
 ejeQk+ikInv/TFmPefpvqVO/ps9CIBVWmS47q5JJKdGgPpxuaI2a8o95HhzjuaQVMkKfkaj6B
 ZDfjgQaC7oBP+Ux/EEf9IyPolqhkzi87EhfSM8M9bscmoA5oVyC0gB4TSCKBNBL/t6w3RH8Tv
 S9AeHBJyituaIbMWbl/gUNeNGXzf/J1CT0UGuRewRJWLTD+LmF/ZJBqpQF41hShVaD6Cw0iXU
 Ey7Vq/TAYPy0/hDCIo1DNCJCCXJNinauF5bIXoEgJY44ifdUAyxHW1fdOPFABusFN7FxLctsR
 rAdI98yoH2RqXymZobrbHysWHXWgWuO4C5MK7jUSDW6S0rGnPDtkIHPDwX9AM6j2bm28ZyIuZ
 8KFmME0oUj/q618YS/fQVKHEJjvO0rkcOQy7bVhyXqxUokJ4bnr4hxKE+FwGgdql+hM0nbfvC
 CBHu9idLo0Xx98U5/EsXc6byM9Cr5lB/gyTGFI0raYi1y+ElcJq/ocMhif4mR0sGdaJs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
leading to an extraneous definition of huge_ptep_get:

In file included from arch/arm/include/asm/hugetlb.h:28,
                 from include/linux/hugetlb.h:456,
                 from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
 static inline pte_t huge_ptep_get(pte_t *ptep)

Change the header file inclusions to be in the correct order for
this to work.

Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/hugetlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 3fcef21ff2c2..b67256c22b08 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -23,9 +23,8 @@
 #define _ASM_ARM_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 #include <asm/hugetlb-3level.h>
+#include <asm-generic/hugetlb.h>
 
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
-- 
2.18.0

