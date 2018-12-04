Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A131C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07A120851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsUrc95y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07A120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeLDLCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbeLDLCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CA92087F;
        Tue,  4 Dec 2018 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921358;
        bh=TjzVIOUuR3gAOeYdcvxJ5fICl9hAizOKd99TGtnor1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsUrc95yZf1EV0fWePI3oq7UErATRH3aN16CwS7XqsCvQTcHBjYmWnjGI1AlzmCFX
         m4q8UQGkQunykzJ/dzhuLQgHAFQomhImgcnyOr2KN7UJykT50JDD93qiJQD0HG0tKn
         auca65O0+UDB32VaGTEaUQm5XMrDb2MgWhVimROM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Su Yue <suy.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/146] btrfs: Check that each block group has corresponding chunk at mount time
Date:   Tue,  4 Dec 2018 11:48:47 +0100
Message-Id: <20181204103728.515606170@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fdc42eddccc2..83791d13c204 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9828,6 +9828,8 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
+	struct btrfs_block_group_item bg;
+	u64 flags;
 	int slot;
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
@@ -9862,8 +9864,32 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 			"logical %llu len %llu found bg but no related chunk",
 					  found_key.objectid, found_key.offset);
 				ret = -ENOENT;
+			} else if (em->start != found_key.objectid ||
+				   em->len != found_key.offset) {
+				btrfs_err(fs_info,
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
+					btrfs_err(fs_info,
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
-- 
2.17.1



