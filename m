Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F491C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78B22147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864940;
	bh=hcQPy9akd9Ds2ZsZKWEKTCMBWQsNNqC9DLv1uH/6Mgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CxUwTnb3SI0M0Vk2KVYz7dH+JcDTK/+dbpjseppoJLHCAFcsR0KmUqgSmDWtUqlIO
	 jrOpsiaB5Vw8DmsBzB7bf22U63d7NgjYhsp8J9iGoAu3mGzvTCopcTSRGPp4f/jPPT
	 gYvjH7gbHX25BsOo2qij1SMPOhvc5JQGPh0ZLabg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfAGMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfAGMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3E420449;
        Mon,  7 Jan 2019 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864936;
        bh=hcQPy9akd9Ds2ZsZKWEKTCMBWQsNNqC9DLv1uH/6Mgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3sW624Jnpf5l3b9zF3dFanb38YvcmH4jktcSy4StNJu7GKjUZX7lIRDcSq9DE+L3
         FVUYEKllqIQbRJ04S0IDErBy5PZl5mVetgRXXN9FlPI899/5Tiwi5oX9P23Lw1S8lR
         eCzQKoHdvMqnhBFW4GFkTZs3O9UuKx2sJz2J1N/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.20 104/145] f2fs: read page index before freeing
Date:   Mon,  7 Jan 2019 13:32:21 +0100
Message-Id: <20190107104450.880567933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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
@@ -826,6 +826,7 @@ static int truncate_node(struct dnode_of
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
 	int err;
+	pgoff_t index;
 
 	err = f2fs_get_node_info(sbi, dn->nid, &ni);
 	if (err)
@@ -845,10 +846,11 @@ static int truncate_node(struct dnode_of
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);


