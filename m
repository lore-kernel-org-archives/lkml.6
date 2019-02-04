Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99DC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4D217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276698;
	bh=i48464cinWC5TosbCUD07XNyxCa8mIZtn99M3GU7eTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DiAKJy4sBzzyACERJ9AFNavFRJTsjC32lg/fhGbmPLmXCWM/I6PY1+9JWu3zrxnDQ
	 CD+UxtcqyU5gqGszA2T6yZVrxJ/QplHWHrKQuHd5I4dKbvIAiu4X2psyWTdKPUIUeU
	 qb1MOiwVSA5FDuYxW1rHauJ2kym08w+wRqaM12EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfBDKiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfBDKiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033BE217D6;
        Mon,  4 Feb 2019 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276694;
        bh=i48464cinWC5TosbCUD07XNyxCa8mIZtn99M3GU7eTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydrfPpiG2jFAF0lMs+U1kOrrkhMw2dHoVHkzHxwAjdQBYQo/zfP/zv6WaVZ3RB11c
         atlzvPRcmkgAFr2hTse0x1nFUukJjP4XEta8PJrQi/Mn/54dMt2bNBPsiHSMy39r33
         IsBl1vKWGvtpVmjTZEwZ8z4+RAHzV4yRBPt3ujhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3.18 16/31] f2fs: read page index before freeing
Date:   Mon,  4 Feb 2019 11:36:31 +0100
Message-Id: <20190204103601.189956408@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -565,6 +565,7 @@ static void truncate_node(struct dnode_o
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
+	pgoff_t index;
 
 	get_node_info(sbi, dn->nid, &ni);
 	if (dn->inode->i_blocks == 0) {
@@ -588,10 +589,11 @@ invalidate:
 	clear_node_page_dirty(dn->node_page);
 	F2FS_SET_SB_DIRT(sbi);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);


