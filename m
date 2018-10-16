Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC7C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99425208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SSJVZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99425208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJPVEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:04:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41505 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeJPVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:04:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so11017476plr.8;
        Tue, 16 Oct 2018 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbOXilnyHM7Y3HZf42CmhT0al3ZotZPzM5/9KSS+Wl0=;
        b=A/SSJVZxVxROnzdtTJGd3Rl0mtQnn0aeP262cO0PG37AB5aJFbY1kcl0Q9RVU+AsSN
         hnGdUUZtKTqK8l4cdbSjbZ9BUzn/hPxOFdEPN4vlGKIB25R+NFVzhjzkDFWSAaFBLaSt
         xrSM6/l6UKnNfWzsSJg7ulrXaZrJXIUqdvEaGukSxIoLvU3Es6tmC1I+PECGOfrldZKg
         NLn/cJoSesrvsErHZ4uFkC2dmA03+a8M23DZATqifHAalHpK02AeaGxYq3X86uOI4su5
         c7wNfOzT0sZv7rpzm5n9vvCGcZMKbl4VkQEOnVbCI02AICWJXxrRFSVG1IEGRym457Rs
         WgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbOXilnyHM7Y3HZf42CmhT0al3ZotZPzM5/9KSS+Wl0=;
        b=nONtEo00VeRknEfvRmzpP2UhmYeudMvLoLQvt3sk+a+EboZPrwAJhVN2463nzsGxtF
         zDsw2wFIdo3ll56+TSsoGaT7F3A06Ii/0dt7OBkL9BX3+x1xRfZ9JmSTOPB3PiA96t9Z
         C4ss2R3V+xMo8Q75BGzkssYHqpLQTW+22eEoBYmmJOfvfrRkLpI4ytkF9rDeoGMdfuRQ
         gc+VqeytiXgxUGEOqjhlA/a07P0XaEigdelsUn6oZRv6E2gaaoYPfM6VnmdvSdpq4oaM
         8bgOU6RTMxv3r8KPGTtvOylB64DQpD4Kec5f2EkeR/e8T2GBZ3z7WxfLjYpDir21qK1r
         M8rg==
X-Gm-Message-State: ABuFfogVEukx5M/iuvi0BvCVZrYdQVM+CMk4lknmeNZb1K/hxOv1u22o
        x3YggMIbP+FKWOuKHA9UlcY+9Q+N
X-Google-Smtp-Source: ACcGV625ozmXlwQNgWm1xWhrstSjyDp7scuMStIV7BLFGcBHbvseOYBjb3efegUxYSoldpVrEtpcww==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr21817926plp.332.1539695646081;
        Tue, 16 Oct 2018 06:14:06 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:14:05 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 2/5] mm/cow: don't bother write protecting already write-protected huge pages
Date:   Tue, 16 Oct 2018 23:13:40 +1000
Message-Id: <20181016131343.20556-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the HugePage / THP equivalent for 1b2de5d039c8 ("mm/cow: don't
bother write protecting already write-protected pages").

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 14 ++++++++++----
 mm/hugetlb.c     |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58269f8ba7c4..0fb0e3025f98 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -973,8 +973,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
-	pmd = pmd_mkold(pmd_wrprotect(pmd));
+	if (pmd_write(pmd)) {
+		pmdp_set_wrprotect(src_mm, addr, src_pmd);
+		pmd = pmd_wrprotect(pmd);
+	}
+	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1064,8 +1067,11 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
-	pudp_set_wrprotect(src_mm, addr, src_pud);
-	pud = pud_mkold(pud_wrprotect(pud));
+	if (pud_write(pud)) {
+		pudp_set_wrprotect(src_mm, addr, src_pud);
+		pud = pud_wrprotect(pud);
+	}
+	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c390f5a5207..54a4dcb6ee21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3287,7 +3287,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
-			if (cow) {
+			if (cow && huge_pte_write(entry)) {
 				/*
 				 * No need to notify as we are downgrading page
 				 * table protection not changing it to point
-- 
2.18.0

