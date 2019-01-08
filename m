Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1DC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7390E2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976628;
	bh=ZUPS2Q4/6NITXJFqTv69olSNSwwiCpjrBEWSTeZMVos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CEEQpty2ZibyHsicaiSHo/NkVLzCi34nlbcesxlXoKHJlg21ZyWIePh5oH2Vhlyl8
	 UHD0MB12rCbxce2G4bCjjLq0AF41QtHx+7TjT3z6hL6SdzfZV2fMe3yXTb9APOSQth
	 z6ASdy32YWs3UXZ8hLq7dmriRyA3expXrx51NaMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfAHTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731782AbfAHTdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6FB2176F;
        Tue,  8 Jan 2019 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976021;
        bh=ZUPS2Q4/6NITXJFqTv69olSNSwwiCpjrBEWSTeZMVos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjKybdkvoMuY6nJzjJ6aHKdUknmwg/zKPzJRG4Wb76GvA8NwOnIaXkcni8Izcssr/
         kqkkBoBwlz9QSJvm0AD+hmAof8YWv+KDm2kZOGyp6i8goROWAfDxOUozEhd/09Tb68
         +UQPUFbXdj6Fv7T5F/3EvFfbBQ87DhJpSzj1CbBE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Foster <bfoster@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 51/53] mm/page-writeback.c: don't break integrity writeback on ->writepage() error
Date:   Tue,  8 Jan 2019 14:32:19 -0500
Message-Id: <20190108193222.123316-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 3fa750dcf29e8606e3969d13d8e188cc1c0f511d ]

write_cache_pages() is used in both background and integrity writeback
scenarios by various filesystems.  Background writeback is mostly
concerned with cleaning a certain number of dirty pages based on various
mm heuristics.  It may not write the full set of dirty pages or wait for
I/O to complete.  Integrity writeback is responsible for persisting a set
of dirty pages before the writeback job completes.  For example, an
fsync() call must perform integrity writeback to ensure data is on disk
before the call returns.

write_cache_pages() unconditionally breaks out of its processing loop in
the event of a ->writepage() error.  This is fine for background
writeback, which had no strict requirements and will eventually come
around again.  This can cause problems for integrity writeback on
filesystems that might need to clean up state associated with failed page
writeouts.  For example, XFS performs internal delayed allocation
accounting before returning a ->writepage() error, where applicable.  If
the current writeback happens to be associated with an unmount and
write_cache_pages() completes the writeback prematurely due to error, the
filesystem is unmounted in an inconsistent state if dirty+delalloc pages
still exist.

To handle this problem, update write_cache_pages() to always process the
full set of pages for integrity writeback regardless of ->writepage()
errors.  Save the first encountered error and return it to the caller once
complete.  This facilitates XFS (or any other fs that expects integrity
writeback to process the entire set of dirty pages) to clean up its
internal state completely in the event of persistent mapping errors.
Background writeback continues to exit on the first error encountered.

[akpm@linux-foundation.org: fix typo in comment]
Link: http://lkml.kernel.org/r/20181116134304.32440-1-bfoster@redhat.com
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page-writeback.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3175ac850a53..e001de5ac50c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2157,6 +2157,7 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0;
+	int error;
 	struct pagevec pvec;
 	int nr_pages;
 	pgoff_t uninitialized_var(writeback_index);
@@ -2253,25 +2254,31 @@ int write_cache_pages(struct address_space *mapping,
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-			ret = (*writepage)(page, wbc, data);
-			if (unlikely(ret)) {
-				if (ret == AOP_WRITEPAGE_ACTIVATE) {
+			error = (*writepage)(page, wbc, data);
+			if (unlikely(error)) {
+				/*
+				 * Handle errors according to the type of
+				 * writeback. There's no need to continue for
+				 * background writeback. Just push done_index
+				 * past this page so media errors won't choke
+				 * writeout for the entire file. For integrity
+				 * writeback, we must process the entire dirty
+				 * set regardless of errors because the fs may
+				 * still have state to clear for each page. In
+				 * that case we continue processing and return
+				 * the first error.
+				 */
+				if (error == AOP_WRITEPAGE_ACTIVATE) {
 					unlock_page(page);
-					ret = 0;
-				} else {
-					/*
-					 * done_index is set past this page,
-					 * so media errors will not choke
-					 * background writeout for the entire
-					 * file. This has consequences for
-					 * range_cyclic semantics (ie. it may
-					 * not be suitable for data integrity
-					 * writeout).
-					 */
+					error = 0;
+				} else if (wbc->sync_mode != WB_SYNC_ALL) {
+					ret = error;
 					done_index = page->index + 1;
 					done = 1;
 					break;
 				}
+				if (!ret)
+					ret = error;
 			}
 
 			/*
-- 
2.19.1

