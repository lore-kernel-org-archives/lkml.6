Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4499AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071D82082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1wZUJiyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071D82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeLDLKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbeLDLJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301DF2082D;
        Tue,  4 Dec 2018 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921764;
        bh=9xvrgCeLTJV9pciQlm2ndmGwwxZ5NxpCNeDXhj5OoQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wZUJiyGqyrlvOlB7WBWxrjvEIhiIGJL2Dd6IeslakXxbX0bo8a/DpoDYF9NBvj1I
         BaoRwX1/lNHhViWcZuMQofPXo5FyO5WShvbGiR5VOSa+MRGkwaZnukRsnEzzf4tiUe
         Nf/fP5z0fzkSn+QwQZvROsJBiaOwjjp11FtLGUFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 40/50] mm: use swp_offset as key in shmem_replace_page()
Date:   Tue,  4 Dec 2018 11:50:35 +0100
Message-Id: <20181204103716.503139565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

commit c1cb20d43728aa9b5393bd8d489bc85c142949b2 upstream.

We changed the key of swap cache tree from swp_entry_t.val to
swp_offset.  We need to do so in shmem_replace_page() as well.

Hugh said:
 "shmem_replace_page() has been wrong since the day I wrote it: good
  enough to work on swap "type" 0, which is all most people ever use
  (especially those few who need shmem_replace_page() at all), but
  broken once there are any non-0 swp_type bits set in the higher order
  bits"

Link: http://lkml.kernel.org/r/20181121215442.138545-1-yuzhao@google.com
Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>	[4.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1494,11 +1494,13 @@ static int shmem_replace_page(struct pag
 {
 	struct page *oldpage, *newpage;
 	struct address_space *swap_mapping;
+	swp_entry_t entry;
 	pgoff_t swap_index;
 	int error;
 
 	oldpage = *pagep;
-	swap_index = page_private(oldpage);
+	entry.val = page_private(oldpage);
+	swap_index = swp_offset(entry);
 	swap_mapping = page_mapping(oldpage);
 
 	/*
@@ -1517,7 +1519,7 @@ static int shmem_replace_page(struct pag
 	__SetPageLocked(newpage);
 	__SetPageSwapBacked(newpage);
 	SetPageUptodate(newpage);
-	set_page_private(newpage, swap_index);
+	set_page_private(newpage, entry.val);
 	SetPageSwapCache(newpage);
 
 	/*


