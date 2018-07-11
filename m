Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916D0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B14620BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B14620BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbeGKNYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:24:16 -0400
Received: from foss.arm.com ([217.140.101.70]:35648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733078AbeGKNYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:24:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14667A9;
        Wed, 11 Jul 2018 06:19:57 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66A013F5AD;
        Wed, 11 Jul 2018 06:19:56 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, james.morse@arm.com,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH] proc/kcore: Use __pa_symbol() for KCORE_TEXT list entries
Date:   Wed, 11 Jul 2018 14:19:44 +0100
Message-Id: <20180711131944.15252-1-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elf_kcore_store_hdr() uses __pa() to find the physical address
of KCORE_RAM or KCORE_TEXT entries exported as program headers.

This trips CONFIG_DEBUG_VIRTUAL's checks, as the KCORE_TEXT
entries are not in the linear map.

Handle these two cases separately, using __pa_symbol() for the
KCORE_TEXT entries.

Signed-off-by: James Morse <james.morse@arm.com>
---
This will clash with a series from Omar:
https://lkml.org/lkml/2018/7/6/868

 fs/proc/kcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e64ecb9f2720..66c373230e60 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -384,8 +384,10 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
 		phdr->p_vaddr	= (size_t)m->addr;
-		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+		if (m->type == KCORE_RAM)
 			phdr->p_paddr	= __pa(m->addr);
+		else if (m->type == KCORE_TEXT)
+			phdr->p_paddr	= __pa_symbol(m->addr);
 		else
 			phdr->p_paddr	= (elf_addr_t)-1;
 		phdr->p_filesz	= phdr->p_memsz	= m->size;
-- 
2.18.0

