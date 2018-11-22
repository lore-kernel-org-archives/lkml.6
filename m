Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8B620865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8B620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392257AbeKVQWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:22:35 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45373 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389389AbeKVQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:22:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07688008|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.DMQddPA_1542865480;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DMQddPA_1542865480)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 22 Nov 2018 13:44:40 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/2] csky: bugfix tlb_get_pgd error.
Date:   Thu, 22 Nov 2018 13:44:39 +0800
Message-Id: <1542865479-5796-1-git-send-email-ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's wrong to mask/unmask highest bit in addr to translate the vaddr
to paddr. We should use PAGE_OFFSET and PHYS_OFFSET.

Wrong implement:
  return ((get_pgd()|(1<<31)) - PHYS_OFFSET) & ~1;

When PHYS_OFFSET=0xc0000000 and get_pgd() return 0xe0000000, it'll
return 0x60000000. It's wrong and should be 0xa0000000.

Now correct it to:
  return ((get_pgd() - PHYS_OFFSET) & ~1) + PAGE_OFFSET;

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/mmu_context.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index c410aa4..b2905c0 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -16,7 +16,7 @@
 
 static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 {
-	pgd &= ~(1<<31);
+	pgd -= PAGE_OFFSET;
 	pgd += PHYS_OFFSET;
 	pgd |= 1;
 	setup_pgd(pgd, kernel);
@@ -29,7 +29,7 @@ static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 
 static inline unsigned long tlb_get_pgd(void)
 {
-	return ((get_pgd()|(1<<31)) - PHYS_OFFSET) & ~1;
+	return ((get_pgd() - PHYS_OFFSET) & ~1) + PAGE_OFFSET;
 }
 
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-- 
2.7.4

