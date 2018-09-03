Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B203C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69A420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeICVz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:28 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 284ADD16;
        Mon,  3 Sep 2018 17:34:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.18 045/123] ext4: fix race when setting the bitmap corrupted flag
Date:   Mon,  3 Sep 2018 18:56:29 +0200
Message-Id: <20180903165721.373576375@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Shilong <wshilong@ddn.com>

commit 9af0b3d1257756394ebbd06b14937b557e3a756b upstream.

Whenever we hit block or inode bitmap corruptions we set
bit and then reduce this block group free inode/clusters
counter to expose right available space.

However some of ext4_mark_group_bitmap_corrupted() is called
inside group spinlock, some are not, this could make it happen
that we double reduce one block group free counters from system.

Always hold group spinlock for it could fix it, but it looks
a little heavy, we could use test_and_set_bit() to fix race
problems here.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -776,26 +776,26 @@ void ext4_mark_group_bitmap_corrupted(st
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group, NULL);
+	int ret;
 
-	if ((flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) &&
-	    !EXT4_MB_GRP_BBITMAP_CORRUPT(grp)) {
-		percpu_counter_sub(&sbi->s_freeclusters_counter,
-					grp->bb_free);
-		set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
-			&grp->bb_state);
+	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
+		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
+					    &grp->bb_state);
+		if (!ret)
+			percpu_counter_sub(&sbi->s_freeclusters_counter,
+					   grp->bb_free);
 	}
 
-	if ((flags & EXT4_GROUP_INFO_IBITMAP_CORRUPT) &&
-	    !EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
-		if (gdp) {
+	if (flags & EXT4_GROUP_INFO_IBITMAP_CORRUPT) {
+		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT,
+					    &grp->bb_state);
+		if (!ret && gdp) {
 			int count;
 
 			count = ext4_free_inodes_count(sb, gdp);
 			percpu_counter_sub(&sbi->s_freeinodes_counter,
 					   count);
 		}
-		set_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT,
-			&grp->bb_state);
 	}
 }
 


