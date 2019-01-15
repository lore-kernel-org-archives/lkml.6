Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4069FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571682;
	bh=mp3Nx3LQGDsr7BKW1lnilv5ZfQULlLxJ6+AutYAig3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aj59rilaZcSv1eOqRd9h1Lx+jQgm/HjvJsKpep48Z9vIPmOQaXr4DS1Aac/HCka/g
	 r1WcoHRxHxzIaZcqt4lBjYak+NhgfSWwTlmapHZUCNtEgubO6KtuTVDNe83wlboxDi
	 146FBgwNfyBMlHDlMoXYECmCFvHEBQnDPVSnwpvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfAOQhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfAOQho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A089A20868;
        Tue, 15 Jan 2019 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570263;
        bh=mp3Nx3LQGDsr7BKW1lnilv5ZfQULlLxJ6+AutYAig3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRyVhggj5FAP4srnNNDa1FQaBtv3rthj5bAsXIpUg/c2Zr4rbWtGku5jZ0HM5Z4ch
         eJB2438/5RUEdoJnAHONb8Wz/F2R6EirAHiFcPjtuwwbpkp4N2netTlQuO0i0I8a7y
         4JoVxVTV9YK6k0yYox7QpFBtG0WvmKYl7WH5QeYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Su Yue <suy.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 29/51] btrfs: Check that each block group has corresponding chunk at mount time
Date:   Tue, 15 Jan 2019 17:35:25 +0100
Message-Id: <20190115154850.720466621@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

commit 514c7dca85a0bf40be984dab0b477403a6db901f upstream.

A crafted btrfs image with incorrect chunk<->block group mapping will
trigger a lot of unexpected things as the mapping is essential.

Although the problem can be caught by block group item checker
added in "btrfs: tree-checker: Verify block_group_item", it's still not
sufficient.  A sufficiently valid block group item can pass the check
added by the mentioned patch but could fail to match the existing chunk.

This patch will add extra block group -> chunk mapping check, to ensure
we have a completely matching (start, len, flags) chunk for each block
group at mount time.

Here we reuse the original helper find_first_block_group(), which is
already doing the basic bg -> chunk checks, adding further checks of the
start/len and type flags.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199837
Reported-by: Xu Wen <wen.xu@gatech.edu>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Su Yue <suy.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.4: Use root->fs_info instead of fs_info]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9487,6 +9487,8 @@ static int find_first_block_group(struct
 	int ret = 0;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
+	struct btrfs_block_group_item bg;
+	u64 flags;
 	int slot;
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
@@ -9521,8 +9523,32 @@ static int find_first_block_group(struct
 			"logical %llu len %llu found bg but no related chunk",
 					  found_key.objectid, found_key.offset);
 				ret = -ENOENT;
+			} else if (em->start != found_key.objectid ||
+				   em->len != found_key.offset) {
+				btrfs_err(root->fs_info,
+		"block group %llu len %llu mismatch with chunk %llu len %llu",
+					  found_key.objectid, found_key.offset,
+					  em->start, em->len);
+				ret = -EUCLEAN;
 			} else {
-				ret = 0;
+				read_extent_buffer(leaf, &bg,
+					btrfs_item_ptr_offset(leaf, slot),
+					sizeof(bg));
+				flags = btrfs_block_group_flags(&bg) &
+					BTRFS_BLOCK_GROUP_TYPE_MASK;
+
+				if (flags != (em->map_lookup->type &
+					      BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+					btrfs_err(root->fs_info,
+"block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
+						found_key.objectid,
+						found_key.offset, flags,
+						(BTRFS_BLOCK_GROUP_TYPE_MASK &
+						 em->map_lookup->type));
+					ret = -EUCLEAN;
+				} else {
+					ret = 0;
+				}
 			}
 			free_extent_map(em);
 			goto out;


