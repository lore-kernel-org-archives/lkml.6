Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5741C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E791223CA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0DOLbq/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E791223CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404364AbeKLIXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbeKLIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F65208A3;
        Sun, 11 Nov 2018 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975600;
        bh=6NYavegaDhYpR12VTyCvOnuppdRrdnC6cAQLS3RKbq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DOLbq/5oNems0OhyrT/DeKAVIEXjY0lROd3BRpuKB5UaIME+OpB22brY47mmxtL1
         8pWZ3sl7m/CzfghpqcZuoaZKdUmifL1kNdfmJNJsazf/jIcRdVj5bAaTESj3CaPmdQ
         pjX/BFy5L131JObs0cBuTDqmmKOIMEf1mhgv2rzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 215/222] btrfs: only free reserved extent if we didnt insert it
Date:   Sun, 11 Nov 2018 14:25:12 -0800
Message-Id: <20181111221705.648298106@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 49940bdd57779c78462da7aa5a8650b2fea8c2ff upstream.

When we insert the file extent once the ordered extent completes we free
the reserved extent reservation as it'll have been migrated to the
bytes_used counter.  However if we error out after this step we'll still
clear the reserved extent reservation, resulting in a negative
accounting of the reserved bytes for the block group and space info.
Fix this by only doing the free if we didn't successfully insert a file
extent for this extent.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2966,6 +2966,7 @@ static int btrfs_finish_ordered_io(struc
 	bool truncated = false;
 	bool range_locked = false;
 	bool clear_new_delalloc_bytes = false;
+	bool clear_reserved_extent = true;
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 	    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags) &&
@@ -3069,10 +3070,12 @@ static int btrfs_finish_ordered_io(struc
 						logical_len, logical_len,
 						compress_type, 0, 0,
 						BTRFS_FILE_EXTENT_REG);
-		if (!ret)
+		if (!ret) {
+			clear_reserved_extent = false;
 			btrfs_release_delalloc_bytes(fs_info,
 						     ordered_extent->start,
 						     ordered_extent->disk_len);
+		}
 	}
 	unpin_extent_cache(&BTRFS_I(inode)->extent_tree,
 			   ordered_extent->file_offset, ordered_extent->len,
@@ -3132,8 +3135,13 @@ out:
 		 * wrong we need to return the space for this ordered extent
 		 * back to the allocator.  We only free the extent in the
 		 * truncated case if we didn't write out the extent at all.
+		 *
+		 * If we made it past insert_reserved_file_extent before we
+		 * errored out then we don't need to do this as the accounting
+		 * has already been done.
 		 */
 		if ((ret || !logical_len) &&
+		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))
 			btrfs_free_reserved_extent(fs_info,


