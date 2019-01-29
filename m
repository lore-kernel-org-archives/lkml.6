Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C1220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762623;
	bh=o+0/0iuj3d8raXHlzPd5/dmcvnQCEzz3wmzXxYqQmHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVuja594c7fdBwg6SFSwo20e0/0y5U6RJOv5hLl4trjAYpebXhV3hPMtQYXoBBYLw
	 ybNXlCXlC58clKeyvXnkwGf0Ad1uGz7nfBnNtFw6/dPPIc5/o/kcnVWrIs2sevA7UW
	 e/kdYiPAVoXfayajzowxTKc0VsaUHD/YBJUsbsZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfA2LuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfA2LuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A1E2184D;
        Tue, 29 Jan 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762615;
        bh=o+0/0iuj3d8raXHlzPd5/dmcvnQCEzz3wmzXxYqQmHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJfR4XuTOFjl0ZhE6vph3ObwrktaSJ/N/chh9hNMGB+efvmIAyOGCnLphZV4FgVZX
         rFiTEl6TXyl8pjBhBZBv761WcPNAWcD3A7+BqnoYiCOuL+AhVWn049zmcZQYdljtw3
         95Nj0aGDgB+7IcG5FRBLQa6QFAAWOJAznmZaSyxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 66/68] f2fs: read page index before freeing
Date:   Tue, 29 Jan 2019 12:36:28 +0100
Message-Id: <20190129113138.151887427@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>

commit 0ea295dd853e0879a9a30ab61f923c26be35b902 upstream.

The function truncate_node frees the page with f2fs_put_page. However,
the page index is read after that. So, the patch reads the index before
freeing the page.

Fixes: bf39c00a9a7f ("f2fs: drop obsolete node page when it is truncated")
Cc: <stable@vger.kernel.org>
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -694,6 +694,7 @@ static void truncate_node(struct dnode_o
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
+	pgoff_t index;
 
 	get_node_info(sbi, dn->nid, &ni);
 	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
@@ -712,10 +713,11 @@ static void truncate_node(struct dnode_o
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);


