Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA20C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570588;
	bh=YpBtg/uWIaYRLUcaN9PYInSlbBMG8RISeZKiURfmPrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gg5lDDDYSswrdddHQe//iP4Ic1CZQq7vJcjjOEcLOL7eZGjIf4hTHkUagvZB0UMDP
	 5Gb7dEQoPBmYmry6uK2WKDY1Bw4SqFj2gpSsQ49ySMGVsIavhAyKO7VzzjqA+aCBiE
	 +ywS9kOPV3pK3A63jyCVhf+73Ba72gbNxvB4KRG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfAOQnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbfAOQnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD7A20645;
        Tue, 15 Jan 2019 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570583;
        bh=YpBtg/uWIaYRLUcaN9PYInSlbBMG8RISeZKiURfmPrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTx+tzpYOOVaHscyK6ZJb4RyU7kTitEOFspxd1CZyHGEQf3WirihFdjkVn4HoycPw
         3VqzXUsnVvOs0xhxH6emxh4KcARDYypX+Bm/ow2pFMSY0jpoqZFFYM3G7tZM7/eqUF
         53RG6gi8vsIPZbs3xQYQ0lBXmIW51kxlhrFwKz4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 48/50] Btrfs: fix access to available allocation bits when starting balance
Date:   Tue, 15 Jan 2019 17:36:24 +0100
Message-Id: <20190115154912.725236193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 5a8067c0d17feb7579db0476191417b441a8996e upstream.

The available allocation bits members from struct btrfs_fs_info are
protected by a sequence lock, and when starting balance we access them
incorrectly in two different ways:

1) In the read sequence lock loop at btrfs_balance() we use the values we
   read from fs_info->avail_*_alloc_bits and we can immediately do actions
   that have side effects and can not be undone (printing a message and
   jumping to a label). This is wrong because a retry might be needed, so
   our actions must not have side effects and must be repeatable as long
   as read_seqretry() returns a non-zero value. In other words, we were
   essentially ignoring the sequence lock;

2) Right below the read sequence lock loop, we were reading the values
   from avail_metadata_alloc_bits and avail_data_alloc_bits without any
   protection from concurrent writers, that is, reading them outside of
   the read sequence lock critical section.

So fix this by making sure we only read the available allocation bits
while in a read sequence lock critical section and that what we do in the
critical section is repeatable (has nothing that can not be undone) so
that any eventual retry that is needed is handled properly.

Fixes: de98ced9e743 ("Btrfs: use seqlock to protect fs_info->avail_{data, metadata, system}_alloc_bits")
Fixes: 14506127979a ("btrfs: fix a bogus warning when converting only data or metadata")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3712,6 +3712,7 @@ int btrfs_balance(struct btrfs_fs_info *
 	int ret;
 	u64 num_devices;
 	unsigned seq;
+	bool reducing_integrity;
 
 	if (btrfs_fs_closing(fs_info) ||
 	    atomic_read(&fs_info->balance_pause_req) ||
@@ -3796,24 +3797,30 @@ int btrfs_balance(struct btrfs_fs_info *
 		     !(bctl->sys.target & allowed)) ||
 		    ((bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) &&
 		     (fs_info->avail_metadata_alloc_bits & allowed) &&
-		     !(bctl->meta.target & allowed))) {
-			if (bctl->flags & BTRFS_BALANCE_FORCE) {
-				btrfs_info(fs_info,
-				"balance: force reducing metadata integrity");
-			} else {
-				btrfs_err(fs_info,
-	"balance: reduces metadata integrity, use --force if you want this");
-				ret = -EINVAL;
-				goto out;
-			}
-		}
+		     !(bctl->meta.target & allowed)))
+			reducing_integrity = true;
+		else
+			reducing_integrity = false;
+
+		/* if we're not converting, the target field is uninitialized */
+		meta_target = (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+			bctl->meta.target : fs_info->avail_metadata_alloc_bits;
+		data_target = (bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+			bctl->data.target : fs_info->avail_data_alloc_bits;
 	} while (read_seqretry(&fs_info->profiles_lock, seq));
 
-	/* if we're not converting, the target field is uninitialized */
-	meta_target = (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
-		bctl->meta.target : fs_info->avail_metadata_alloc_bits;
-	data_target = (bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
-		bctl->data.target : fs_info->avail_data_alloc_bits;
+	if (reducing_integrity) {
+		if (bctl->flags & BTRFS_BALANCE_FORCE) {
+			btrfs_info(fs_info,
+				   "balance: force reducing metadata integrity");
+		} else {
+			btrfs_err(fs_info,
+	  "balance: reduces metadata integrity, use --force if you want this");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	if (btrfs_get_num_tolerated_disk_barrier_failures(meta_target) <
 		btrfs_get_num_tolerated_disk_barrier_failures(data_target)) {
 		int meta_index = btrfs_bg_flags_to_raid_index(meta_target);


