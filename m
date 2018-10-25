Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C74C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CE920840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0iHyx3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeJYWuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbeJYWuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1325020868;
        Thu, 25 Oct 2018 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477044;
        bh=GlgbpS+Mil5Q++YFFNntIzJXVwpG9kmImRs665ah7b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0iHyx3GBIhigIwCUB46AhgEjBItbkY8KI7UVnfItAO3TvfOkbZksKmL1SBtYxrPW
         It6A4uAfct34hO4xd6tYoeIbhJn2P0Ui6nbt9kJ7YFyWziWGvIsBLGawgb7dQ8VjzL
         qoO0jigyknUME4xdq8RzzhATiVqQ7xVqRE3mmmXw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Matthew Wilcox <willy@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/65] radix-tree: fix radix_tree_iter_retry() for tagged iterators.
Date:   Thu, 25 Oct 2018 10:16:09 -0400
Message-Id: <20181025141705.213937-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

[ Upstream commit 3cb9185c67304b2a7ea9be73e7d13df6fb2793a1 ]

radix_tree_iter_retry() resets slot to NULL, but it doesn't reset tags.
Then NULL slot and non-zero iter.tags passed to radix_tree_next_slot()
leading to crash:

  RIP: radix_tree_next_slot include/linux/radix-tree.h:473
    find_get_pages_tag+0x334/0x930 mm/filemap.c:1452
  ....
  Call Trace:
    pagevec_lookup_tag+0x3a/0x80 mm/swap.c:960
    mpage_prepare_extent_to_map+0x321/0xa90 fs/ext4/inode.c:2516
    ext4_writepages+0x10be/0x2b20 fs/ext4/inode.c:2736
    do_writepages+0x97/0x100 mm/page-writeback.c:2364
    __filemap_fdatawrite_range+0x248/0x2e0 mm/filemap.c:300
    filemap_write_and_wait_range+0x121/0x1b0 mm/filemap.c:490
    ext4_sync_file+0x34d/0xdb0 fs/ext4/fsync.c:115
    vfs_fsync_range+0x10a/0x250 fs/sync.c:195
    vfs_fsync fs/sync.c:209
    do_fsync+0x42/0x70 fs/sync.c:219
    SYSC_fdatasync fs/sync.c:232
    SyS_fdatasync+0x19/0x20 fs/sync.c:230
    entry_SYSCALL_64_fastpath+0x23/0xc1 arch/x86/entry/entry_64.S:207

We must reset iterator's tags to bail out from radix_tree_next_slot()
and go to the slow-path in radix_tree_next_chunk().

Fixes: 46437f9a554f ("radix-tree: fix race in gang lookup")
Link: http://lkml.kernel.org/r/1468495196-10604-1-git-send-email-aryabinin@virtuozzo.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Matthew Wilcox <willy@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/radix-tree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 5d5174b59802..673dee29a9b9 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -382,6 +382,7 @@ static inline __must_check
 void **radix_tree_iter_retry(struct radix_tree_iter *iter)
 {
 	iter->next_index = iter->index;
+	iter->tags = 0;
 	return NULL;
 }
 
-- 
2.17.1

