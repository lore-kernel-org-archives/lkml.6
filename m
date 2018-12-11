Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3301C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4272133F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543220;
	bh=gKNmLvABvUveaEPIlorXQsFj/fLnbemq4KidqLiOnHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/QieKhVy87gBqUx6+5ldqAeffvJfxTqvFu0cTzjKW4PC1YoGmG/Lw54f6MHwNtwk
	 pHFLZcR4ZDm2BZj6v9meb7jNkPZmjKqw5G+QGzMTALE5vqVhP5dM9/bm+WHRGs4P++
	 PNMhMe3ofB2kk2FMiAj6u405ZqS///IlJAT+ygmY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4272133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeLKPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeLKPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3BE2086D;
        Tue, 11 Dec 2018 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543217;
        bh=gKNmLvABvUveaEPIlorXQsFj/fLnbemq4KidqLiOnHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRbWshgxsY0POTBM0ennS+VjLFMKd/O6k8+cV3rlz6bXiLQ+zEN8qDz363lfpbMrk
         JvleJk9rAbeFPlIRkM4uokDxsPg9kd9WoUYpw+s6s9xqJLtFuybpTGkbIBKNg0zx/6
         HAz48fIgNRDwLyG8r7tikFrrYUjHTqhvnScoLqLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 50/91] btrfs: Always try all copies when reading extent buffers
Date:   Tue, 11 Dec 2018 16:41:09 +0100
Message-Id: <20181211151610.015380170@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit f8397d69daef06d358430d3054662fb597e37c00 upstream.

When a metadata read is served the endio routine btree_readpage_end_io_hook
is called which eventually runs the tree-checker. If tree-checker fails
to validate the read eb then it sets EXTENT_BUFFER_CORRUPT flag. This
leads to btree_read_extent_buffer_pages wrongly assuming that all
available copies of this extent buffer are wrong and failing prematurely.
Fix this modify btree_read_extent_buffer_pages to read all copies of
the data.

This failure was exhibitted in xfstests btrfs/124 which would
spuriously fail its balance operations. The reason was that when balance
was run following re-introduction of the missing raid1 disk
__btrfs_map_block would map the read request to stripe 0, which
corresponded to devid 2 (the disk which is being removed in the test):

    item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 3553624064) itemoff 15975 itemsize 112
	length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
	io_align 65536 io_width 65536 sector_size 4096
	num_stripes 2 sub_stripes 1
		stripe 0 devid 2 offset 2156920832
		dev_uuid 8466c350-ed0c-4c3b-b17d-6379b445d5c8
		stripe 1 devid 1 offset 3553624064
		dev_uuid 1265d8db-5596-477e-af03-df08eb38d2ca

This caused read requests for a checksum item that to be routed to the
stale disk which triggered the aforementioned logic involving
EXTENT_BUFFER_CORRUPT flag. This then triggered cascading failures of
the balance operation.

Fixes: a826d6dcb32d ("Btrfs: check items for correctness as we search")
CC: stable@vger.kernel.org # 4.4+
Suggested-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -445,9 +445,9 @@ static int btree_read_extent_buffer_page
 	int mirror_num = 0;
 	int failed_mirror = 0;
 
-	clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 	io_tree = &BTRFS_I(root->fs_info->btree_inode)->io_tree;
 	while (1) {
+		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = read_extent_buffer_pages(io_tree, eb, start,
 					       WAIT_COMPLETE,
 					       btree_get_extent, mirror_num);
@@ -459,14 +459,6 @@ static int btree_read_extent_buffer_page
 				ret = -EIO;
 		}
 
-		/*
-		 * This buffer's crc is fine, but its contents are corrupted, so
-		 * there is no reason to read the other copies, they won't be
-		 * any less wrong.
-		 */
-		if (test_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags))
-			break;
-
 		num_copies = btrfs_num_copies(root->fs_info,
 					      eb->start, eb->len);
 		if (num_copies == 1)


