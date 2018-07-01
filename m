Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA18C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA85251AD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA85251AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965368AbeGAQ0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:26:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965127AbeGAQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:26:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E41EACD;
        Sun,  1 Jul 2018 16:26:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 054/101] Btrfs: fix unexpected cow in run_delalloc_nocow
Date:   Sun,  1 Jul 2018 18:21:40 +0200
Message-Id: <20180701160759.300817208@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
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

From: Liu Bo <bo.li.liu@oracle.com>

commit 5811375325420052fcadd944792a416a43072b7f upstream.

Fstests generic/475 provides a way to fail metadata reads while
checking if checksum exists for the inode inside run_delalloc_nocow(),
and csum_exist_in_range() interprets error (-EIO) as inode having
checksum and makes its caller enter the cow path.

In case of free space inode, this ends up with a warning in
cow_file_range().

The same problem applies to btrfs_cross_ref_exist() since it may also
read metadata in between.

With this, run_delalloc_nocow() bails out when errors occur at the two
places.

cc: <stable@vger.kernel.org> v2.6.28+
Fixes: 17d217fe970d ("Btrfs: fix nodatasum handling in balancing code")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/btrfs/inode.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1230,6 +1230,8 @@ static noinline int csum_exist_in_range(
 		list_del(&sums->list);
 		kfree(sums);
 	}
+	if (ret < 0)
+		return ret;
 	return 1;
 }
 
@@ -1381,10 +1383,23 @@ next_slot:
 				goto out_check;
 			if (btrfs_extent_readonly(root, disk_bytenr))
 				goto out_check;
-			if (btrfs_cross_ref_exist(trans, root, ino,
+			ret = btrfs_cross_ref_exist(trans, root, ino,
 						  found_key.offset -
-						  extent_offset, disk_bytenr))
+						  extent_offset, disk_bytenr);
+			if (ret) {
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start != (u64)-1)
+						cur_offset = cow_start;
+					goto error;
+				}
+
+				WARN_ON_ONCE(nolock);
 				goto out_check;
+			}
 			disk_bytenr += extent_offset;
 			disk_bytenr += cur_offset - found_key.offset;
 			num_bytes = min(end + 1, extent_end) - cur_offset;
@@ -1402,8 +1417,20 @@ next_slot:
 			 * this ensure that csum for a given extent are
 			 * either valid or do not exist.
 			 */
-			if (csum_exist_in_range(root, disk_bytenr, num_bytes))
+			ret = csum_exist_in_range(root, disk_bytenr, num_bytes);
+			if (ret) {
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start != (u64)-1)
+						cur_offset = cow_start;
+					goto error;
+				}
+				WARN_ON_ONCE(nolock);
 				goto out_check;
+			}
 			if (!btrfs_inc_nocow_writers(root->fs_info,
 						     disk_bytenr))
 				goto out_check;


