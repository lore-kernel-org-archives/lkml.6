Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD202C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8412E27A81
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ADThAW/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412E27A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967487AbeF1X7Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:59:24 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57367 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967460AbeF1X7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:59:19 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 305C010C0745;
        Thu, 28 Jun 2018 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530230358; bh=wB5LVDlsvaiC+I7+qgEpinI6T53E3Fc+ibflRQIKlEc=;
        h=From:To:Cc:Subject:Date:From;
        b=ADThAW/dZlIHXNFioMBrrr3+RXgivvYAjTiydakOy7QwHatx/EF3EHNDlslOv884j
         zOxDuypr2jGbC6SgDE27drFR1M8QYNworU208Epzb2hlzx+OGHdOcrTEwBYQap0F1R
         PL4+BfiqAuRUrviXQveh3yQo/T8xQkRCEklsgyo1VaBz2ZM2hAAe+PP/cUERNDQClI
         p4ncaUKCXSABupRV7V5X2GwrGTMqPF3W0z2MfWGSzg65tfuPN0W9ISAtZo+pXMrTqW
         dWlo3JMjzemxFIB1J73hjxmGyKPbISjpAxRuZmbOlJsZIt7HxRWSaAjSiJDoRSObLG
         yFk+WvgDOqx1w==
Received: from abrodkin-7480l.internal.synopsys.com (abrodkin-7480l.internal.synopsys.com [10.9.128.133])
        by mailhost.synopsys.com (Postfix) with ESMTP id 14F003D3F;
        Thu, 28 Jun 2018 16:59:18 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARC: Fix __swp_offset() implementation
Date:   Thu, 28 Jun 2018 16:59:14 -0700
Message-Id: <20180628235914.20706-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encode offset from swapcache page in __swp_entry() this way, see [1]:
| /* Encode swap {type,off} tuple into PTE
|  * We reserve 13 bits for 5-bit @type, keeping bits 12-5 zero, ensuring that
|  * PAGE_PRESENT is zero in a PTE holding swap "identifier"
|  */
| #define __swp_entry(type, off)	((swp_entry_t) { \
| 					((type) & 0x1f) | ((off) << 13) })

But decode in __swp_offset() as:
| #define __swp_offset(pte_lookalike)	((pte_lookalike).val << 13)
which is obviously wrong, we should ">> 13" instead.

This basically fixes swap usage on ARC finally.

| # mkswap /dev/sda2
|
| # swapon -a -e /dev/sda2
| Adding 500728k swap on /dev/sda2.  Priority:-2 extents:1 across:500728k
|
| # free
|              total       used       free     shared    buffers     cached
| Mem:        765104      13456     751648       4736          8       4736
| -/+ buffers/cache:       8712     756392
| Swap:       500728          0     500728

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/include/asm/pgtable.h#n375

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: stable@vger.kernel.org
---
 arch/arc/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 08fe33830d4b..77676e18da69 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -379,7 +379,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 
 /* Decode a PTE containing swap "identifier "into constituents */
 #define __swp_type(pte_lookalike)	(((pte_lookalike).val) & 0x1f)
-#define __swp_offset(pte_lookalike)	((pte_lookalike).val << 13)
+#define __swp_offset(pte_lookalike)	((pte_lookalike).val >> 13)
 
 /* NOPs, to keep generic kernel happy */
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-- 
2.17.1

