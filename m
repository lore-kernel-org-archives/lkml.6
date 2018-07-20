Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC020854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AC020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbeGTNVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:21:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbeGTNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:21:24 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6437EBC1;
        Fri, 20 Jul 2018 12:29:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Chen <alex.chen@huawei.com>,
        Jun Piao <piaojun@huawei.com>,
        Joseph Qi <jiangqi903@gmail.com>, Gang He <ghe@suse.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4.9 09/66] ocfs2: ip_alloc_sem should be taken in ocfs2_get_block()
Date:   Fri, 20 Jul 2018 14:13:26 +0200
Message-Id: <20180720121407.793919098@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: alex chen <alex.chen@huawei.com>

commit 3e4c56d41eef5595035872a2ec5a483f42e8917f upstream.

ip_alloc_sem should be taken in ocfs2_get_block() when reading file in
DIRECT mode to prevent concurrent access to extent tree with
ocfs2_dio_end_io_write(), which may cause BUGON in the following
situation:

read file 'A'                                  end_io of writing file 'A'
vfs_read
 __vfs_read
  ocfs2_file_read_iter
   generic_file_read_iter
    ocfs2_direct_IO
     __blockdev_direct_IO
      do_blockdev_direct_IO
       do_direct_IO
        get_more_blocks
         ocfs2_get_block
          ocfs2_extent_map_get_blocks
           ocfs2_get_clusters
            ocfs2_get_clusters_nocache()
             ocfs2_search_extent_list
              return the index of record which
              contains the v_cluster, that is
              v_cluster > rec[i]->e_cpos.
                                                ocfs2_dio_end_io
                                                 ocfs2_dio_end_io_write
                                                  down_write(&oi->ip_alloc_sem);
                                                  ocfs2_mark_extent_written
                                                   ocfs2_change_extent_flag
                                                    ocfs2_split_extent
                                                     ...
                                                 --> modify the rec[i]->e_cpos, resulting
                                                     in v_cluster < rec[i]->e_cpos.
             BUG_ON(v_cluster < le32_to_cpu(rec->e_cpos))

[alex.chen@huawei.com: v3]
  Link: http://lkml.kernel.org/r/59EF3614.6050008@huawei.com
Link: http://lkml.kernel.org/r/59EF3614.6050008@huawei.com
Fixes: c15471f79506 ("ocfs2: fix sparse file & data ordering issue in direct io")
Signed-off-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Gang He <ghe@suse.com>
Acked-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/aops.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -134,6 +134,19 @@ bail:
 	return err;
 }
 
+static int ocfs2_lock_get_block(struct inode *inode, sector_t iblock,
+		    struct buffer_head *bh_result, int create)
+{
+	int ret = 0;
+	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+
+	down_read(&oi->ip_alloc_sem);
+	ret = ocfs2_get_block(inode, iblock, bh_result, create);
+	up_read(&oi->ip_alloc_sem);
+
+	return ret;
+}
+
 int ocfs2_get_block(struct inode *inode, sector_t iblock,
 		    struct buffer_head *bh_result, int create)
 {
@@ -2120,7 +2133,7 @@ static void ocfs2_dio_free_write_ctx(str
  * called like this: dio->get_blocks(dio->inode, fs_startblk,
  * 					fs_count, map_bh, dio->rw == WRITE);
  */
-static int ocfs2_dio_get_block(struct inode *inode, sector_t iblock,
+static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 			       struct buffer_head *bh_result, int create)
 {
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
@@ -2146,12 +2159,9 @@ static int ocfs2_dio_get_block(struct in
 	 * while file size will be changed.
 	 */
 	if (pos + total_len <= i_size_read(inode)) {
-		down_read(&oi->ip_alloc_sem);
-		/* This is the fast path for re-write. */
-		ret = ocfs2_get_block(inode, iblock, bh_result, create);
-
-		up_read(&oi->ip_alloc_sem);
 
+		/* This is the fast path for re-write. */
+		ret = ocfs2_lock_get_block(inode, iblock, bh_result, create);
 		if (buffer_mapped(bh_result) &&
 		    !buffer_new(bh_result) &&
 		    ret == 0)
@@ -2416,9 +2426,9 @@ static ssize_t ocfs2_direct_IO(struct ki
 		return 0;
 
 	if (iov_iter_rw(iter) == READ)
-		get_block = ocfs2_get_block;
+		get_block = ocfs2_lock_get_block;
 	else
-		get_block = ocfs2_dio_get_block;
+		get_block = ocfs2_dio_wr_get_block;
 
 	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
 				    iter, get_block,


