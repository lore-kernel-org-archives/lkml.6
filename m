Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B54C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B12D20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B12D20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeJNXYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37000 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cj-S1; Sun, 14 Oct 2018 16:31:07 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000D4-2Y; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Liu Bo" <bo.li.liu@oracle.com>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.234431726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/366] Btrfs: fix unexpected cow in run_delalloc_nocow
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

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

Fixes: 17d217fe970d ("Btrfs: fix nodatasum handling in balancing code")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1145,6 +1145,8 @@ static noinline int csum_exist_in_range(
 		list_del(&sums->list);
 		kfree(sums);
 	}
+	if (ret < 0)
+		return ret;
 	return 1;
 }
 
@@ -1294,10 +1296,23 @@ next_slot:
 				goto out_check;
 			if (btrfs_extent_readonly(root, disk_bytenr))
 				goto out_check;
-			if (btrfs_cross_ref_exist(trans, root, ino,
-						  found_key.offset -
-						  extent_offset, disk_bytenr))
+			ret = btrfs_cross_ref_exist(trans, root, ino,
+						    found_key.offset -
+						    extent_offset, disk_bytenr);
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
@@ -1315,8 +1330,22 @@ next_slot:
 			 * this ensure that csum for a given extent are
 			 * either valid or do not exist.
 			 */
-			if (csum_exist_in_range(root, disk_bytenr, num_bytes))
+			ret = csum_exist_in_range(root, disk_bytenr,
+						  num_bytes);
+			if (ret) {
+
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
 			nocow = 1;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			extent_end = found_key.offset +

