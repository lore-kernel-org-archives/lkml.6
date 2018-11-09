Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F42086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBrLpFYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495F42086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKIQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:40 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33683 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:39 -0500
Received: by mail-pl1-f177.google.com with SMTP id w22-v6so509470plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l5JKmNzvuS6iydaU7R8RUszNW4wpAmUInCK2c9kGsbo=;
        b=QBrLpFYqjQqSzfJK2rEnyXBfL6T8klW/IUbhJN3W/bGV0Gs55PMBGD1XAm4vdoWuhW
         xf4dHw2MQxKoaq8pFc+jw7EO6rK/0YkYCShBfJ33coD4lXrLFHhgmE1Jx9XravpmDPPR
         YO6xbHyJ2TlyuJ92Mtb4EDzFvaPtJM8YRanNfSxFWtMOOE5noY3ktidEsJBt2l+ZSrKk
         RMy+Rc3+UozEdlhcIVzGzvOrGYlbYEvOVfZArTIoIBHKloWHs952T5vjavHdoAjc2wYq
         sjjPl1iEBJ2G94QrJQxRalQCeTANjlCRJxMqp+vXw4iOUjbtklGwoLlPtABb3y3V4MMy
         mcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=l5JKmNzvuS6iydaU7R8RUszNW4wpAmUInCK2c9kGsbo=;
        b=Zm5V7lY/T8jqkw1M1ciFnyMPlhKJwJV7IcWYfbuTmKRBhcnuGl+dLB7FMkIVjx9GY5
         lO4CiyMLxj0rLhhMgLORfiJiybtppotUqOFxERg72p/oONsy2sxZSKuxKhX0cTWlF0ma
         VSPSxei2ora6BY89L8tZ4DV2bZtFP49xy3fbdtI3GOwG1Pf2GY+dlQ4FslADfejVe4J/
         kO9LMG3k9H+n8o62attkAJj9+OAGMT+9W17BzYiBoHSKCOMjAgveN+SlDnSpZpX/0HVS
         U+4y8w9N+NKOZbkgNYa0wcq86NZOK4tG1Viq2GsR1DVnw09qskb/zI+2I6AphAP32lqe
         5QMw==
X-Gm-Message-State: AGRZ1gIsqi5MN9MkmuLennD8XXta2FjTIrqJbdiyx60xVh8BLKxrwIGU
        RUj1pbrvSOpyTT4unhMQWA==
X-Google-Smtp-Source: AJdET5dgd3jDkoTeItxOkwHKWaCdYuYsaDeMUfeKi/y49QAwEpmRbauWlBf6nr8MS45dyDvKJOatCw==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr7455402plr.122.1541746051224;
        Thu, 08 Nov 2018 22:47:31 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:30 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 01/11] mm: hwpoison: cleanup unused PageHuge() check
Date:   Fri,  9 Nov 2018 15:47:05 +0900
Message-Id: <1541746035-13408-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure() forks to memory_failure_hugetlb() for hugetlb pages,
so a PageHuge() check after the fork should not be necessary.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index 0cd3de3..9f09bf3 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -1357,10 +1357,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
 	 * correctly, we save a copy of the page flags at this time.
 	 */
-	if (PageHuge(p))
-		page_flags = hpage->flags;
-	else
-		page_flags = p->flags;
+	page_flags = p->flags;
 
 	/*
 	 * unpoison always clear PG_hwpoison inside page lock
-- 
2.7.0

