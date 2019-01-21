Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA51C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2A2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079015;
	bh=E2qShN04BfcfO3jBKRJrOdNdR4V0GX7dH+5hMemG9tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gier78GkBYYTkDAbf3koQLAu0SL9vs8++YB0LqWum+4Dpk4HJmNmjfQCktSdVy9Ss
	 4O3zUYsomHrsSDMFUyjoNGPNmTEgaBfQ1ZznNA8ch9oTLnWbJ4axRNxJ6SZAmBaOtt
	 7iIkyfmQuKYfiLkR8UxWfI3Y2/kQkck7KR7tiAPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfAUN4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731753AbfAUNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE1E2084C;
        Mon, 21 Jan 2019 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078937;
        bh=E2qShN04BfcfO3jBKRJrOdNdR4V0GX7dH+5hMemG9tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAr6u/q1m9ggyTFHhJjnIiZZRM8NoqX6F+0MmvnYle+0KRYJIk8k+HAR0HmPoLRjL
         6y/hS2fOHRO3l9bKJ5Vl4dj0vIgI5GYXJKbYckfXItcd4038YdBUa/pNND62g28zfl
         Gr9FJB0IiWqlAcRDRzzVcyAnYZ6v70wBnzMXxVrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 06/51] Revert "f2fs: do not recover from previous remained wrong dnodes"
Date:   Mon, 21 Jan 2019 14:44:02 +0100
Message-Id: <20190121122454.081401886@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

commit d47b8715953ad0cf82bb0a9d30d7b11d83bc9c11 upstream.

i_times of inode will be set with current system time which can be
configured through 'date', so it's not safe to judge dnode block as
garbage data or unchanged inode depend on i_times.

Now, we have used enhanced 'cp_ver + cp' crc method to verify valid
dnode block, so I expect recoverying invalid dnode is almost not
possible.

This reverts commit 807b1e1c8e08452948495b1a9985ab46d329e5c2.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/recovery.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -196,32 +196,6 @@ static void recover_inode(struct inode *
 			ino_of_node(page), name);
 }
 
-static bool is_same_inode(struct inode *inode, struct page *ipage)
-{
-	struct f2fs_inode *ri = F2FS_INODE(ipage);
-	struct timespec disk;
-
-	if (!IS_INODE(ipage))
-		return true;
-
-	disk.tv_sec = le64_to_cpu(ri->i_ctime);
-	disk.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
-	if (timespec_compare(&inode->i_ctime, &disk) > 0)
-		return false;
-
-	disk.tv_sec = le64_to_cpu(ri->i_atime);
-	disk.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
-	if (timespec_compare(&inode->i_atime, &disk) > 0)
-		return false;
-
-	disk.tv_sec = le64_to_cpu(ri->i_mtime);
-	disk.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
-	if (timespec_compare(&inode->i_mtime, &disk) > 0)
-		return false;
-
-	return true;
-}
-
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	struct curseg_info *curseg;
@@ -248,10 +222,7 @@ static int find_fsync_dnodes(struct f2fs
 			goto next;
 
 		entry = get_fsync_inode(head, ino_of_node(page));
-		if (entry) {
-			if (!is_same_inode(entry->inode, page))
-				goto next;
-		} else {
+		if (!entry) {
 			if (IS_INODE(page) && is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)


