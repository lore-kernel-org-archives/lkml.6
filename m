Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2BC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C321480
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvpY7Sjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06C321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeJPMDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbeJPMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE1221470;
        Tue, 16 Oct 2018 04:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663301;
        bh=mqHNeRzUca1bXvCRofSUFK1YYRJ96qWEmEI+djwPOYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvpY7SjxL+TblrflkusA6d4ZzfFholNphvtXE6tVR5UZtXQD7lAerelx/JeiWyUmj
         JAR+ULHgVWm3jssvlTE4Sl+ZyWf7J8NTrO9SV7r083cYFv7atwKZJ8I7iUWrYAsaAj
         /jYOuuOxBciwaQTL0mZcFXwI1a5sqmwnUT2eMSmo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Larry Chen <lchen@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 60/61] ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()
Date:   Tue, 16 Oct 2018 00:14:02 -0400
Message-Id: <20181016041403.135678-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Chen <lchen@suse.com>

[ Upstream commit 69eb7765b9c6902444c89c54e7043242faf981e5 ]

ocfs2_duplicate_clusters_by_page() may crash if one of the extent's pages
is dirty.  When a page has not been written back, it is still in dirty
state.  If ocfs2_duplicate_clusters_by_page() is called against the dirty
page, the crash happens.

To fix this bug, we can just unlock the page and wait until the page until
its not dirty.

The following is the backtrace:

kernel BUG at /root/code/ocfs2/refcounttree.c:2961!
[exception RIP: ocfs2_duplicate_clusters_by_page+822]
__ocfs2_move_extent+0x80/0x450 [ocfs2]
? __ocfs2_claim_clusters+0x130/0x250 [ocfs2]
ocfs2_defrag_extent+0x5b8/0x5e0 [ocfs2]
__ocfs2_move_extents_range+0x2a4/0x470 [ocfs2]
ocfs2_move_extents+0x180/0x3b0 [ocfs2]
? ocfs2_wait_for_recovery+0x13/0x70 [ocfs2]
ocfs2_ioctl_move_extents+0x133/0x2d0 [ocfs2]
ocfs2_ioctl+0x253/0x640 [ocfs2]
do_vfs_ioctl+0x90/0x5f0
SyS_ioctl+0x74/0x80
do_syscall_64+0x74/0x140
entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Once we find the page is dirty, we do not wait until it's clean, rather we
use write_one_page() to write it back

Link: http://lkml.kernel.org/r/20180829074740.9438-1-lchen@suse.com
[lchen@suse.com: update comments]
  Link: http://lkml.kernel.org/r/20180830075041.14879-1-lchen@suse.com
[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Larry Chen <lchen@suse.com>
Acked-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/refcounttree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 1b1283f07941..824f407df1db 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2946,6 +2946,7 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		if (map_end & (PAGE_SIZE - 1))
 			to = map_end & (PAGE_SIZE - 1);
 
+retry:
 		page = find_or_create_page(mapping, page_index, GFP_NOFS);
 		if (!page) {
 			ret = -ENOMEM;
@@ -2954,11 +2955,18 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		}
 
 		/*
-		 * In case PAGE_SIZE <= CLUSTER_SIZE, This page
-		 * can't be dirtied before we CoW it out.
+		 * In case PAGE_SIZE <= CLUSTER_SIZE, we do not expect a dirty
+		 * page, so write it back.
 		 */
-		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize)
-			BUG_ON(PageDirty(page));
+		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
+			if (PageDirty(page)) {
+				/*
+				 * write_on_page will unlock the page on return
+				 */
+				ret = write_one_page(page);
+				goto retry;
+			}
+		}
 
 		if (!PageUptodate(page)) {
 			ret = block_read_full_page(page, ocfs2_get_block);
-- 
2.17.1

