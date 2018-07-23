Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008BA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008BA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeGWN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbeGWN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:00 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AE13BE1;
        Mon, 23 Jul 2018 12:28:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Ashwin Chaugule <ashwinch@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 23/63] mm/huge_memory.c: fix data loss when splitting a file pmd
Date:   Mon, 23 Jul 2018 14:24:29 +0200
Message-Id: <20180723122447.241712157@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit e1f1b1572e8db87a56609fd05bef76f98f0e456a upstream.

__split_huge_pmd_locked() must check if the cleared huge pmd was dirty,
and propagate that to PageDirty: otherwise, data may be lost when a huge
tmpfs page is modified then split then reclaimed.

How has this taken so long to be noticed?  Because there was no problem
when the huge page is written by a write system call (shmem_write_end()
calls set_page_dirty()), nor when the page is allocated for a write fault
(fault_dirty_shared_page() calls set_page_dirty()); but when allocated for
a read fault (which MAP_POPULATE simulates), no set_page_dirty().

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1807111741430.1106@eggly.anvils
Fixes: d21b9e57c74c ("thp: handle file pages in split_huge_pmd()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-by: Ashwin Chaugule <ashwinch@google.com>
Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2087,6 +2087,8 @@ static void __split_huge_pmd_locked(stru
 		if (vma_is_dax(vma))
 			return;
 		page = pmd_page(_pmd);
+		if (!PageDirty(page) && pmd_dirty(_pmd))
+			set_page_dirty(page);
 		if (!PageReferenced(page) && pmd_young(_pmd))
 			SetPageReferenced(page);
 		page_remove_rmap(page, true);


