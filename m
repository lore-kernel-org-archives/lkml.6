Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3623220883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfAIMUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:20:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:42354 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbfAIMUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:20:44 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghCqZ-0004hI-Tg; Wed, 09 Jan 2019 15:20:35 +0300
Subject: [PATCH 3/3] mm: Pass FGP_NOWAIT in generic_file_buffered_read and
 enable ext4
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        ktkhai@virtuozzo.com, darrick.wong@oracle.com, mhocko@suse.com,
        aryabinin@virtuozzo.com, guro@fb.com, mgorman@techsingularity.net,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 15:20:35 +0300
Message-ID: <154703643564.32690.8416317230641240199.stgit@localhost.localdomain>
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All page-obtaining functions, which are used by ext4, look
to go thru pagecache_get_page() path, so all taken uncharged
pages will be properly charged. Thus, we enable AS_KEEP_MEMCG_RECLAIM
for ext4 regular files.

Since memcg accounting requires page lock, and function
generic_file_buffered_read() is the only of ext4-used
functions, which does not care about FGP_NOWAIT, we make
it use find_get_page_flags() and pass the flag. This allows
pagecache_get_page() to use lock_page(), when it's possible.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/ext4/inode.c |    1 +
 mm/filemap.c    |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b1d7ddd70eee..2fc9e4a7c0db 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5065,6 +5065,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
+		set_bit(AS_KEEP_MEMCG_RECLAIM, &inode->i_mapping->flags);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext4_dir_inode_operations;
 		inode->i_fop = &ext4_dir_operations;
diff --git a/mm/filemap.c b/mm/filemap.c
index 2603c44fc74a..46922003811f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2061,6 +2061,11 @@ static void shrink_readahead_size_eio(struct file *filp,
 	ra->ra_pages /= 4;
 }
 
+static int kiocb_fgp_flags(struct kiocb *iocb)
+{
+	return (iocb->ki_flags & IOCB_NOWAIT) ? FGP_NOWAIT : 0;
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2111,7 +2116,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			goto out;
 		}
 
-		page = find_get_page(mapping, index);
+		page = find_get_page_flags(mapping, index,
+					   kiocb_fgp_flags(iocb));
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;

