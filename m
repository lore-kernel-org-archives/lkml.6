Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6A214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z3OWu3r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLDKzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeLDKzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39D82146D;
        Tue,  4 Dec 2018 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920942;
        bh=vm/x5S6HsiAquvIAiDNLEIGC6+8LxWzJ0Bgj6Rn71+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3OWu3r2wnBca25wHo+0tm+akCzTEYBYKxDx7Ggi+KhDfXiEG6eSjefHO9n3qDAko
         QEufMvGtmqm5I9p9FmS6s/xUighttPBB+vl52Nb3Zn+djUITC/R18zCG1XIClZuNL6
         0MbdSTRc/AE0UM0vA7qnXACzhnRMlihhrji+THuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/139] mm/huge_memory: splitting set mapping+index before unfreeze
Date:   Tue,  4 Dec 2018 11:48:03 +0100
Message-Id: <20181204103650.049827290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 173d9d9fd3ddae84c110fea8aedf1f26af6be9ec upstream.

Huge tmpfs stress testing has occasionally hit shmem_undo_range()'s
VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page).

Move the setting of mapping and index up before the page_ref_unfreeze()
in __split_huge_page_tail() to fix this: so that a page cache lookup
cannot get a reference while the tail's mapping and index are unstable.

In fact, might as well move them up before the smp_wmb(): I don't see an
actual need for that, but if I'm missing something, this way round is
safer than the other, and no less efficient.

You might argue that VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page) is
misplaced, and should be left until after the trylock_page(); but left as
is has not crashed since, and gives more stringent assurance.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261516380.2275@eggly.anvils
Fixes: e9b61f19858a5 ("thp: reintroduce split_huge_page()")
Requires: 605ca5ede764 ("mm/huge_memory.c: reorder operations in __split_huge_page_tail()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ef573d719eb4..c12b441a99f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2373,6 +2373,12 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_unevictable) |
 			 (1L << PG_dirty)));
 
+	/* ->mapping in first tail page is compound_mapcount */
+	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
+			page_tail);
+	page_tail->mapping = head->mapping;
+	page_tail->index = head->index + tail;
+
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
 
@@ -2393,12 +2399,6 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	if (page_is_idle(head))
 		set_page_idle(page_tail);
 
-	/* ->mapping in first tail page is compound_mapcount */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	page_tail->mapping = head->mapping;
-
-	page_tail->index = head->index + tail;
 	page_cpupid_xchg_last(page_tail, page_cpupid_last(head));
 
 	/*
-- 
2.17.1



