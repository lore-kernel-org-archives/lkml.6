Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC599208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC599208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968093AbeFRIj4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:39:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030477AbeFRIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF983C5C;
        Mon, 18 Jun 2018 08:38:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 187/189] Btrfs: fix scrub to repair raid6 corruption
Date:   Mon, 18 Jun 2018 10:14:43 +0200
Message-Id: <20180618081216.729929955@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]

The raid6 corruption is that,
suppose that all disks can be read without problems and if the content
that was read out doesn't match its checksum, currently for raid6
btrfs at most retries twice,

- the 1st retry is to rebuild with all other stripes, it'll eventually
  be a raid5 xor rebuild,
- if the 1st fails, the 2nd retry will deliberately fail parity p so
  that it will do raid6 style rebuild,

however, the chances are that another non-parity stripe content also
has something corrupted, so that the above retries are not able to
return correct content.

We've fixed normal reads to rebuild raid6 correctly with more retries
in Patch "Btrfs: make raid6 rebuild retry more"[1], this is to fix
scrub to do the exactly same rebuild process.

[1]: https://patchwork.kernel.org/patch/10091755/

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/scrub.c |   44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -301,6 +301,11 @@ static void __scrub_blocked_if_needed(st
 static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
+static inline int scrub_is_page_on_raid56(struct scrub_page *page)
+{
+	return page->recover &&
+	       (page->recover->bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+}
 
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
 {
@@ -1323,15 +1328,34 @@ nodatasum_case:
 	 * could happen otherwise that a correct page would be
 	 * overwritten by a bad one).
 	 */
-	for (mirror_index = 0;
-	     mirror_index < BTRFS_MAX_MIRRORS &&
-	     sblocks_for_recheck[mirror_index].page_count > 0;
-	     mirror_index++) {
+	for (mirror_index = 0; ;mirror_index++) {
 		struct scrub_block *sblock_other;
 
 		if (mirror_index == failed_mirror_index)
 			continue;
-		sblock_other = sblocks_for_recheck + mirror_index;
+
+		/* raid56's mirror can be more than BTRFS_MAX_MIRRORS */
+		if (!scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
+			if (mirror_index >= BTRFS_MAX_MIRRORS)
+				break;
+			if (!sblocks_for_recheck[mirror_index].page_count)
+				break;
+
+			sblock_other = sblocks_for_recheck + mirror_index;
+		} else {
+			struct scrub_recover *r = sblock_bad->pagev[0]->recover;
+			int max_allowed = r->bbio->num_stripes -
+						r->bbio->num_tgtdevs;
+
+			if (mirror_index >= max_allowed)
+				break;
+			if (!sblocks_for_recheck[1].page_count)
+				break;
+
+			ASSERT(failed_mirror_index == 0);
+			sblock_other = sblocks_for_recheck + 1;
+			sblock_other->pagev[0]->mirror_num = 1 + mirror_index;
+		}
 
 		/* build and submit the bios, check checksums */
 		scrub_recheck_block(fs_info, sblock_other, 0);
@@ -1679,18 +1703,13 @@ static void scrub_bio_wait_endio(struct
 	complete(&ret->event);
 }
 
-static inline int scrub_is_page_on_raid56(struct scrub_page *page)
-{
-	return page->recover &&
-	       (page->recover->bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
-}
-
 static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 					struct bio *bio,
 					struct scrub_page *page)
 {
 	struct scrub_bio_ret done;
 	int ret;
+	int mirror_num;
 
 	init_completion(&done.event);
 	done.status = 0;
@@ -1698,9 +1717,10 @@ static int scrub_submit_raid56_bio_wait(
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 
+	mirror_num = page->sblock->pagev[0]->mirror_num;
 	ret = raid56_parity_recover(fs_info, bio, page->recover->bbio,
 				    page->recover->map_length,
-				    page->mirror_num, 0);
+				    mirror_num, 0);
 	if (ret)
 		return ret;
 


