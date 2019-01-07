Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52185217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867178;
	bh=RfV5UDLhfxZVCakSdT2yhgb/21g1PPvpwnJ7kls+fTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C5bhQjyHWlZ4DcyKyhw/i/2oOSpEPHORGR+OLBqDYVN3DFkrC438xWi8e3q/lykGS
	 qCrQVO72hnwusHpGlOE81Lmy3EiaBT7VxaQNN+Ti+xPmbICMhXeKkT/Z82bJDkMXAq
	 irKtNYEei+kOpzE5OJUDzNtrnfxDv9u5UwkVBx2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfAGNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfAGM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0458E206BB;
        Mon,  7 Jan 2019 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865864;
        bh=RfV5UDLhfxZVCakSdT2yhgb/21g1PPvpwnJ7kls+fTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLKTW3Z1uPFkEBhe3Y0b6kvsUa76IhPCV5qMvHxEZ+AjOdNyd3VRextJQmT6zSbwe
         sqE+uccEcBGrbYR7gH2fivgOA3qrqvvzaVpPm4Dvnwo3Z/BVU48KV9OChWvAB2PADg
         Cudq5DW7dRJS2oxl6X8VBRPTZ18mYcuUyOiaSnBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.19 138/170] f2fs: read page index before freeing
Date:   Mon,  7 Jan 2019 13:32:45 +0100
Message-Id: <20190107104509.252793949@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/node.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -827,6 +827,7 @@ static int truncate_node(struct dnode_of
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
 	int err;
+	pgoff_t index;
 
 	err = f2fs_get_node_info(sbi, dn->nid, &ni);
 	if (err)
@@ -846,10 +847,11 @@ static int truncate_node(struct dnode_of
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);


