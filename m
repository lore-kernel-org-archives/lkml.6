Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67008C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFBC21725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFBC21725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeHNVja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:39:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbeHNVja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:39:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44007AD2E;
        Tue, 14 Aug 2018 18:50:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tomas Pruzina <pruzinat@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: [PATCH] x86/init: fix build with CONFIG_SWAP=n
Date:   Tue, 14 Aug 2018 20:50:47 +0200
Message-Id: <20180814185047.21139-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of generic_max_swapfile_size and arch-specific versions has
broken linking on x86 with CONFIG_SWAP=n due to undefined reference to
'generic_max_swapfile_size'. Fix it by compiling the x86-specific
max_swapfile_size() only with CONFIG_SWAP=y.

Reported-by: Tomas Pruzina <pruzinat@gmail.com>
Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org
---
 arch/x86/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 156ed8154af8..acfab322fbe0 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -914,6 +914,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 	__pte2cachemode_tbl[entry] = cache;
 }
 
+#ifdef CONFIG_SWAP
 unsigned long max_swapfile_size(void)
 {
 	unsigned long pages;
@@ -934,3 +935,4 @@ unsigned long max_swapfile_size(void)
 	}
 	return pages;
 }
+#endif
-- 
2.18.0

