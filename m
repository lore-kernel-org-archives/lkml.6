Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA2E2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeK1Wr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:47:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38410 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbeK1Wrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434f4j6zC1z9v09t;
        Wed, 28 Nov 2018 12:46:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hhnOQS7TcJ3v; Wed, 28 Nov 2018 12:46:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434f4j6X7fz9v09s;
        Wed, 28 Nov 2018 12:46:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2FE58B867;
        Wed, 28 Nov 2018 12:46:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kBGIKJGmNZxQ; Wed, 28 Nov 2018 12:46:25 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCA068B853;
        Wed, 28 Nov 2018 12:46:25 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AEEB969B1B; Wed, 28 Nov 2018 11:46:25 +0000 (UTC)
Message-Id: <66ac546242226a4cecaf910876bea0377520c6ae.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 02/16] powerpc/8xx: Remove PTE_ATOMIC_UPDATES
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 11:46:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1bc54c03117b9 ("powerpc: rework 4xx PTE access and TLB miss")
introduced non atomic PTE updates and started the work of removing
PTE updates in TLB miss handlers, but kept PTE_ATOMIC_UPDATES for the
8xx with the following comment:
/* Until my rework is finished, 8xx still needs atomic PTE updates */

commit fe11dc3f9628e ("powerpc/8xx: Update TLB asm so it behaves as
linux mm expects") removed all PTE updates done in TLB miss handlers

Therefore, atomic PTE updates are not needed anymore for the 8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 6bfe041ef59d..c9e4b2d90f65 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -65,9 +65,6 @@
 
 #define _PTE_NONE_MASK	0
 
-/* Until my rework is finished, 8xx still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
 #ifdef CONFIG_PPC_16K_PAGES
 #define _PAGE_PSIZE	_PAGE_SPS
 #else
-- 
2.13.3

