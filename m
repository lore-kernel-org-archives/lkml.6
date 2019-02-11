Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98BF20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895151;
	bh=FLP7ULt8mik9/HW4EwuiDypxb07f0ft++hOsLH1TkqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a96De3gboPDy+pw+C6DPcslUK+NnA7sIos+3dq0wFZrePXjwBHN9OHWV/U7949rUs
	 4mVaRlW4pZqLu1YBzKUk2NJlt9OKQeJkJE+qOFn4/eLYzWpRkvzgwYXegMz4aoN5AB
	 iPCc34O351OMiEHGEz0hVNsS2wbbo/9IrxTnGHs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBKOZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfBKOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A52B2075C;
        Mon, 11 Feb 2019 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895141;
        bh=FLP7ULt8mik9/HW4EwuiDypxb07f0ft++hOsLH1TkqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yswSbqLYrM3lFj+i/YBbq/YTxC3uTnmHMoT5JU+SX76pJgpdzyvq+/39eqld4Rshu
         GXTzQNf3jYyNdeFDGKcnPVwnF3WtlLAvH5sXFlSLZlLmzo+Shyyt26CC2QRXWgKLbE
         FeIy2qwNokNIL+AS9iRdRYlmM+QNn6/zW2EuSZ1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 079/352] f2fs: avoid GC causing encrypted file corrupted
Date:   Mon, 11 Feb 2019 15:15:06 +0100
Message-Id: <20190211141851.060068928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9bf1a3f73927492c8be127b642197125e9d52be8 ]

The encrypted file may be corrupted by GC in following case:

Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
segment 2,

Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |

Before page 1 is written back and if segment 2 become a victim, then
page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
during the GC process of Time 2, f2fs should wait for page 1 written back
before reading it, or move_data_block will read a garbage block from
blkaddr B since page is not written back to blkaddr B yet.

Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
ra_data_block to read encrypted block, but it forgets to add
f2fs_wait_on_page_writeback to avoid racing between GC and flush.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241fb8537..c96e7c6354ef 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -658,6 +658,14 @@ got_it:
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
+	/*
+	 * don't cache encrypted data into meta inode until previous dirty
+	 * data were writebacked to avoid racing between GC and flush.
+	 */
+	f2fs_wait_on_page_writeback(page, DATA, true);
+
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
 					dn.data_blkaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
@@ -745,6 +753,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
 	if (err)
 		goto put_out;
-- 
2.19.1



