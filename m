Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A1AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AE121850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kHnZhgEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfB0WcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:32:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36627 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfB0WcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:32:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so21304926qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BwRNT+NYpDumPyDWkKY99dBVD182B+9MzQU77FnCN40=;
        b=kHnZhgEJDbKSFZwy8E1s64zMyJtZoqW7QogBB3DpNcwIVTEWKCRK6yNhYpqTrPwPwX
         gkEPmV8OU1bPNr30yFqW8AlR65naH1SUmxG+uvOIPzqSq1PLWIDFotg7HKMag0w7COFB
         CcjITo35WMBQGbpdynUfAI3ohDOr7LNAY2/s5UqyD2bIxJaLjSCLZeD+4XnwFSQSftxQ
         2qwjKHIaQOonpa7KzsjoEkvTdvaoPa6GfhLdX2J3dSGalV+oRE/j4kgMhicM6qbxRoUs
         tRstVE1KdHkLYRMxFezL12+TqISljpGwUC3NByxlxIryPO59iMfdQE1LdW1B1PUEbRPl
         zvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BwRNT+NYpDumPyDWkKY99dBVD182B+9MzQU77FnCN40=;
        b=hCCaR6heAD2Tmg38T2kzXS+HNi+W110Mgl3v/DVbVw7db5kMXczI2LKzNaeaVM3Xqw
         rNY50lK6A/Js2x2FZmCEsxUj8Lufc465Td8Sfcrrd2A+NQ4nSG3JvX8+svN+wJVd7lSj
         K5SUn6f17ve1xLvlJti7JIF3GzQEd7Q41OhKEeoaKqIGRRPC3V2OEhTFpCCY9e4Lz8Ob
         K6O+FbUn/5wqTQo8k5lUQV4ZQifUl14Mc2ryDzN3gi8bFvopjS9BH2BHgCAMOPSfzpJw
         j84mihfe43TuEB9L73Sf+nsM0UZBsqWsGUB2hO8NiAoNjv5AtgbhxdanihMIvCbZZGHX
         15BQ==
X-Gm-Message-State: AHQUAuZdiTIj/H5+tHqDnxxgw21+8IUu+W9Z9qkICLgj0kGBiXcsaq0L
        e6MTmGOJrTMCOpgjmQYdFPyqYw==
X-Google-Smtp-Source: APXvYqxKFRSPXOa/tVaB39iDzPtwc91E5sHuTtaT9KNc+SHShz0DX6tfEs7XLSyUHn30k48i3STZ3w==
X-Received: by 2002:aed:3b92:: with SMTP id r18mr3672415qte.7.1551306719927;
        Wed, 27 Feb 2019 14:31:59 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a133sm8884784qkg.66.2019.02.27.14.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 14:31:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86: fix "old_pte" set but not used
Date:   Wed, 27 Feb 2019 17:31:45 -0500
Message-Id: <20190227223145.78239-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/mm/pageattr.c: In function '__should_split_large_page':
arch/x86/mm/pageattr.c:741:17: warning: variable 'old_pte' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/pageattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 14e6119838a6..4c570612e24e 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -738,7 +738,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, old_pte, *tmp;
+	pte_t new_pte, *tmp;
 	enum pg_level level;
 
 	/*
@@ -781,7 +781,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * Convert protection attributes to 4k-format, as cpa->mask* are set
 	 * up accordingly.
 	 */
-	old_pte = *kpte;
+
 	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
-- 
2.17.2 (Apple Git-113)

