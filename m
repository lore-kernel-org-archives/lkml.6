Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D91C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F262089D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZHp6QbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F262089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeH1PMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:12:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44842 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeH1PMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:12:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so592281pgp.11;
        Tue, 28 Aug 2018 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqIy7bFKrUvh3N2mZhaZbdyHPW+hgwvBa4i30Nw8Ybc=;
        b=BZHp6QbN59dTJzQoscwjj/i43FAP0Gjci3ePWXPKsGC8C1C6frC6pwM7ZO9Og1acP6
         kalOnMjZXknjI8Nx28NzpbS+Bf3PiNWazSfTSbEb5Tfl+239vryJxYCtq1UZm1KWzn0H
         LErHEmA5WLAWDKAGAxnCjAXNSt84PWxsr1fyECPVZJQ/WqwNnCqAHpj1BOcu3dssf1Xt
         ri+KTIc8FfxXuQLLx0wAF3iLM12t2IOTD2KNAaa3tt6ARchgJ8OtW2orWdvTnAmDuRT0
         34rrzhoTIK0LlmWUaEsu/2lFprRk1Z7eQ/jprd4BLoyNtsG+l4id/94KNevuGHZiRKdN
         ojKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqIy7bFKrUvh3N2mZhaZbdyHPW+hgwvBa4i30Nw8Ybc=;
        b=NxtFrsUVPRQrqKXvs1whjF8IngdGmrTJvhoPw9/9tf1RWS7EsvoUXXp6xEp1fNfhBK
         wyVIl/7ZEB0wyWq163wS0419tuSlLmDRW6YWIGjwN5nfE0LoDp9sFM9aQsXhleAleMIn
         48mQ8KCFvzgJ4Zg0wQHwQVY3OGLU++LVO1E5G+kPnkQd/C77VwIVVigJO1fvVNWDB+Qn
         loH+JUWi3xyiKSYx8aIRKn/BgHXvsfWqW6Ku/CpiC77IklKmAWN2pyem99RIz5yTdCj6
         4u+eiD0a0TZZca9GA/M6tvdH9QusKNeyOoNg1rR31mwMpXb6yJGI1HoiPaa0t+KuAuQo
         N6ag==
X-Gm-Message-State: APzg51DWZsNozU2pcAo9kRm/VqJAHvITrzThyyir5epyHJmdskB1oaUB
        rjmunrvW5/HhQimIXYSH3TG279+M
X-Google-Smtp-Source: ANB0Vda1rxfWQ20CAFltZX59amKlHwbHH1qDC49g8kZHwadojwF7gpVndoanEo69eLkZduJDG3UbpQ==
X-Received: by 2002:a63:5751:: with SMTP id h17-v6mr1085425pgm.423.1535455249468;
        Tue, 28 Aug 2018 04:20:49 -0700 (PDT)
Received: from roar.au.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3287917pgj.84.2018.08.28.04.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:20:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] mm/cow: don't bother write protectig already write-protected huge pages
Date:   Tue, 28 Aug 2018 21:20:32 +1000
Message-Id: <20180828112034.30875-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828112034.30875-1-npiggin@gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the THP equivalent for 1b2de5d039c8 ("mm/cow: don't bother write
protecting already write-protected pages").

Explicit hugetlb pages don't get the same treatment because they don't
appear to have the right accessor functions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9592cbd8530a..d9bae12978ef 100644
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
-- 
2.18.0

