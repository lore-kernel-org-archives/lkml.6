Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0FA20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107815;
	bh=HMAPDKrJxOskXBpcbtWTzohcd41VGDS/SCXHp0q0Zfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7BnVvPz8fONLqlxxJQPsdXUISZBT/rdcEkUEu8ib021vcc1uCEUpt7TqUcwgeH++
	 BzIJmcdFZ7xuufixox7ovHAEK8s1bO+NA4oXRsHVS8JtmX/feBUwHHq8cVelFzsRVL
	 rsIwxqs6AJ/sNSpIv8pGA7MiAHM9VRAw5xtC69do=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0FA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeLFOrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbeLFOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805B7214DB;
        Thu,  6 Dec 2018 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107642;
        bh=HMAPDKrJxOskXBpcbtWTzohcd41VGDS/SCXHp0q0Zfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjBsCT/GZkGr1Q/GmDz9iyFgWWzChGvWhb/cJIOeVHKPXTaAGpXAKJvbWuif3Rrw4
         0zDgvBzc8JzatjYTZ3+IdmtRJUpfvB66X13aaW4nnqGi1k4ufphZUbCmPUFl9sUq+v
         z3gIOE2A9FJAEQyfjITknBTrd5YDXb85EJDzOXcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 084/101] f2fs: fix race condition in between free nid allocator/initializer
Date:   Thu,  6 Dec 2018 15:39:23 +0100
Message-Id: <20181206143017.524708368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

commit 30a61ddf8117c26ac5b295e1233eaa9629a94ca3 upstream.

In below concurrent case, allocated nid can be loaded into free nid cache
and be allocated again.

Thread A				Thread B
- f2fs_create
 - f2fs_new_inode
  - alloc_nid
   - __insert_nid_to_list(ALLOC_NID_LIST)
					- f2fs_balance_fs_bg
					 - build_free_nids
					  - __build_free_nids
					   - scan_nat_page
					    - add_free_nid
					     - __lookup_nat_cache
 - f2fs_add_link
  - init_inode_metadata
   - new_inode_page
    - new_node_page
     - set_node_addr
 - alloc_nid_done
  - __remove_nid_from_list(ALLOC_NID_LIST)
					     - __insert_nid_to_list(FREE_NID_LIST)

This patch makes nat cache lookup and free nid list operation being atomical
to avoid this race condition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.9:
 - add_free_nid() returns 0 in case of any error (except low memory)
 - Tree/list addition has not been moved into __insert_nid_to_list()]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |   62 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 19 deletions(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1704,8 +1704,9 @@ static void __del_from_free_nid_list(str
 static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i;
+	struct free_nid *i, *e;
 	struct nat_entry *ne;
+	int err = -EINVAL;
 
 	if (!available_free_memory(sbi, FREE_NIDS))
 		return -1;
@@ -1714,35 +1715,58 @@ static int add_free_nid(struct f2fs_sb_i
 	if (unlikely(nid == 0))
 		return 0;
 
-	if (build) {
-		/* do not add allocated nids */
-		ne = __lookup_nat_cache(nm_i, nid);
-		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
-				nat_get_blkaddr(ne) != NULL_ADDR))
-			return 0;
-	}
-
 	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
 	i->nid = nid;
 	i->state = NID_NEW;
 
-	if (radix_tree_preload(GFP_NOFS)) {
-		kmem_cache_free(free_nid_slab, i);
-		return 0;
-	}
+	if (radix_tree_preload(GFP_NOFS))
+		goto err;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i)) {
-		spin_unlock(&nm_i->free_nid_list_lock);
-		radix_tree_preload_end();
-		kmem_cache_free(free_nid_slab, i);
-		return 0;
+
+	if (build) {
+		/*
+		 *   Thread A             Thread B
+		 *  - f2fs_create
+		 *   - f2fs_new_inode
+		 *    - alloc_nid
+		 *     - __insert_nid_to_list(ALLOC_NID_LIST)
+		 *                     - f2fs_balance_fs_bg
+		 *                      - build_free_nids
+		 *                       - __build_free_nids
+		 *                        - scan_nat_page
+		 *                         - add_free_nid
+		 *                          - __lookup_nat_cache
+		 *  - f2fs_add_link
+		 *   - init_inode_metadata
+		 *    - new_inode_page
+		 *     - new_node_page
+		 *      - set_node_addr
+		 *  - alloc_nid_done
+		 *   - __remove_nid_from_list(ALLOC_NID_LIST)
+		 *                         - __insert_nid_to_list(FREE_NID_LIST)
+		 */
+		ne = __lookup_nat_cache(nm_i, nid);
+		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
+				nat_get_blkaddr(ne) != NULL_ADDR))
+			goto err_out;
+
+		e = __lookup_free_nid_list(nm_i, nid);
+		if (e)
+			goto err_out;
 	}
+	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i))
+		goto err_out;
+	err = 0;
 	list_add_tail(&i->list, &nm_i->free_nid_list);
 	nm_i->fcnt++;
+err_out:
 	spin_unlock(&nm_i->free_nid_list_lock);
 	radix_tree_preload_end();
-	return 1;
+err:
+	if (err)
+		kmem_cache_free(free_nid_slab, i);
+	return !err;
 }
 
 static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)


