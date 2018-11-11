Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5BC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87E720871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wgOZxtg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbeKLJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:36:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733287AbeKLITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1458B21508;
        Sun, 11 Nov 2018 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975347;
        bh=t5yhJs0bKTIUPKjqJU7rMie4sBwpCIm6LZtyu5QZ/nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgOZxtg0kM7JrO6wKVS7qgOT2PCOyPGO5N467jhO1PFfucZf59dYHnxJR4fXbr0bw
         exs7ZSRpoqxz2hFgNjya/YDAB/8KgWVrrN0kEhF+9IIxiKkjmrEVay1jQEVk05JLLj
         c98FaCHWw/P2yAo9fHLimffF/M1uDC4XUqmbarXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 355/361] Btrfs: fix use-after-free during inode eviction
Date:   Sun, 11 Nov 2018 14:21:42 -0800
Message-Id: <20181111221701.865262704@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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

commit 421f0922a2cfb0c75acd9746454aaa576c711a65 upstream.

At inode.c:evict_inode_truncate_pages(), when we iterate over the
inode's extent states, we access an extent state record's "state" field
after we unlocked the inode's io tree lock. This can lead to a
use-after-free issue because after we unlock the io tree that extent
state record might have been freed due to being merged into another
adjacent extent state record (a previous inflight bio for a read
operation finished in the meanwhile which unlocked a range in the io
tree and cause a merge of extent state records, as explained in the
comment before the while loop added in commit 6ca0709756710 ("Btrfs: fix
hang during inode eviction due to concurrent readahead")).

Fix this by keeping a copy of the extent state's flags in a local
variable and using it after unlocking the io tree.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201189
Fixes: b9d0b38928e2 ("btrfs: Add handler for invalidate page")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5283,11 +5283,13 @@ static void evict_inode_truncate_pages(s
 		struct extent_state *cached_state = NULL;
 		u64 start;
 		u64 end;
+		unsigned state_flags;
 
 		node = rb_first(&io_tree->state);
 		state = rb_entry(node, struct extent_state, rb_node);
 		start = state->start;
 		end = state->end;
+		state_flags = state->state;
 		spin_unlock(&io_tree->lock);
 
 		lock_extent_bits(io_tree, start, end, &cached_state);
@@ -5300,7 +5302,7 @@ static void evict_inode_truncate_pages(s
 		 *
 		 * Note, end is the bytenr of last byte, so we need + 1 here.
 		 */
-		if (state->state & EXTENT_DELALLOC)
+		if (state_flags & EXTENT_DELALLOC)
 			btrfs_qgroup_free_data(inode, NULL, start, end - start + 1);
 
 		clear_extent_bit(io_tree, start, end,


