Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED221479
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0fLy/LkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CED221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbeKTC7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKTC7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C190B20989;
        Mon, 19 Nov 2018 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645334;
        bh=5RmWss2svd/hVniwv37FTp0eTGSCqZmtgdBgXskEbyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fLy/LkB1Jk0Zq8mVTwcS4Qv5b7Z0Or+Qp/Mk8aLV0Tvqmw46fJMpM0cBU/IEeJJ5
         iN/hlVPGVDjWPg1dqflaW3zIKTmdgTUQg/bRXGjDZqXnwyg3ggbwzIw7AK6dBu+CEt
         jx8kG7jPgH1jhkUr/RDd0Bfthk6Xm1xAx5PxV6Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 124/205] Btrfs: fix missing data checksums after a ranged fsync (msync)
Date:   Mon, 19 Nov 2018 17:27:11 +0100
Message-Id: <20181119162636.426695453@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit 008c6753f7e070c77c70d708a6bf0255b4381763 upstream.

Recently we got a massive simplification for fsync, where for the fast
path we no longer log new extents while their respective ordered extents
are still running.

However that simplification introduced a subtle regression for the case
where we use a ranged fsync (msync). Consider the following example:

               CPU 0                                    CPU 1

                                            mmap write to range [2Mb, 4Mb[
  mmap write to range [512Kb, 1Mb[
  msync range [512K, 1Mb[
    --> triggers fast fsync
        (BTRFS_INODE_NEEDS_FULL_SYNC
         not set)
    --> creates extent map A for this
        range and adds it to list of
        modified extents
    --> starts ordered extent A for
        this range
    --> waits for it to complete

                                            writeback triggered for range
                                            [2Mb, 4Mb[
                                              --> create extent map B and
                                                  adds it to the list of
                                                  modified extents
                                              --> creates ordered extent B

    --> start looking for and logging
        modified extents
    --> logs extent maps A and B
    --> finds checksums for extent A
        in the csum tree, but not for
        extent B
  fsync (msync) finishes

                                              --> ordered extent B
                                                  finishes and its
                                                  checksums are added
                                                  to the csum tree

                                <power cut>

After replaying the log, we have the extent covering the range [2Mb, 4Mb[
but do not have the data checksum items covering that file range.

This happens because at the very beginning of an fsync (btrfs_sync_file())
we start and wait for IO in the given range [512Kb, 1Mb[ and therefore
wait for any ordered extents in that range to complete before we start
logging the extents. However if right before we start logging the extent
in our range [512Kb, 1Mb[, writeback is started for any other dirty range,
such as the range [2Mb, 4Mb[ due to memory pressure or a concurrent fsync
or msync (btrfs_sync_file() starts writeback before acquiring the inode's
lock), an ordered extent is created for that other range and a new extent
map is created to represent that range and added to the inode's list of
modified extents.

That means that we will see that other extent in that list when collecting
extents for logging (done at btrfs_log_changed_extents()) and log the
extent before the respective ordered extent finishes - namely before the
checksum items are added to the checksums tree, which is where
log_extent_csums() looks for the checksums, therefore making us log an
extent without logging its checksums. Before that massive simplification
of fsync, this wasn't a problem because besides looking for checkums in
the checksums tree, we also looked for them in any ordered extent still
running.

The consequence of data checksums missing for a file range is that users
attempting to read the affected file range will get -EIO errors and dmesg
reports the following:

 [10188.358136] BTRFS info (device sdc): no csum found for inode 297 start 57344
 [10188.359278] BTRFS warning (device sdc): csum failed root 5 ino 297 off 57344 csum 0x98f94189 expected csum 0x00000000 mirror 1

So fix this by skipping extents outside of our logging range at
btrfs_log_changed_extents() and leaving them on the list of modified
extents so that any subsequent ranged fsync may collect them if needed.
Also, if we find a hole extent outside of the range still log it, just
to prevent having gaps between extent items after replaying the log,
otherwise fsck will complain when we are not using the NO_HOLES feature
(fstest btrfs/056 triggers such case).

Fixes: e7175a692765 ("btrfs: remove the wait ordered logic in the log_one_extent path")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4399,6 +4399,23 @@ static int btrfs_log_changed_extents(str
 	logged_end = end;
 
 	list_for_each_entry_safe(em, n, &tree->modified_extents, list) {
+		/*
+		 * Skip extents outside our logging range. It's important to do
+		 * it for correctness because if we don't ignore them, we may
+		 * log them before their ordered extent completes, and therefore
+		 * we could log them without logging their respective checksums
+		 * (the checksum items are added to the csum tree at the very
+		 * end of btrfs_finish_ordered_io()). Also leave such extents
+		 * outside of our range in the list, since we may have another
+		 * ranged fsync in the near future that needs them. If an extent
+		 * outside our range corresponds to a hole, log it to avoid
+		 * leaving gaps between extents (fsck will complain when we are
+		 * not using the NO_HOLES feature).
+		 */
+		if ((em->start > end || em->start + em->len <= start) &&
+		    em->block_start != EXTENT_MAP_HOLE)
+			continue;
+
 		list_del_init(&em->list);
 		/*
 		 * Just an arbitrary number, this can be really CPU intensive


