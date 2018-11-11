Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB94C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB70214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0nPUmxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB70214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391051AbeKLIir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404369AbeKLIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B141722353;
        Sun, 11 Nov 2018 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975602;
        bh=+hkaSOwKNjNd0W6KwOhKGDVPSeQGCUoVg1Pwl4pGjPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0nPUmxfmd3bthUyPVgVdhxJ6y0g73dv1W8ie8ZGVqneuUGZbHGRy0cRNq42skgQo
         FYPwuPjX+rOS0XQ5NUHQso/ZezW3mF6H6I9FPV+9PpID9gqEYDo61vxUrlKKKLU8QB
         KzlRk8lO74X9zGQScWMjTs7xXmVwiFA4IgXTcPNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 220/222] Btrfs: fix fsync after hole punching when using no-holes feature
Date:   Sun, 11 Nov 2018 14:25:17 -0800
Message-Id: <20181111221705.925278597@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit 4ee3fad34a9cc2cf33303dfbd0cf554248651c86 upstream.

When we have the no-holes mode enabled and fsync a file after punching a
hole in it, we can end up not logging the whole hole range in the log tree.
This happens if the file has extent items that span more than one leaf and
we punch a hole that covers a range that starts in a leaf but does not go
beyond the offset of the first extent in the next leaf.

Example:

  $ mkfs.btrfs -f -O no-holes -n 65536 /dev/sdb
  $ mount /dev/sdb /mnt
  $ for ((i = 0; i <= 831; i++)); do
	offset=$((i * 2 * 256 * 1024))
	xfs_io -f -c "pwrite -S 0xab -b 256K $offset 256K" \
		/mnt/foobar >/dev/null
    done
  $ sync

  # We now have 2 leafs in our filesystem fs tree, the first leaf has an
  # item corresponding the extent at file offset 216530944 and the second
  # leaf has a first item corresponding to the extent at offset 217055232.
  # Now we punch a hole that partially covers the range of the extent at
  # offset 216530944 but does go beyond the offset 217055232.

  $ xfs_io -c "fpunch $((216530944 + 128 * 1024 - 4000)) 256K" /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar

  <power fail>

  # mount to replay the log
  $ mount /dev/sdb /mnt

  # Before this patch, only the subrange [216658016, 216662016[ (length of
  # 4000 bytes) was logged, leaving an incorrect file layout after log
  # replay.

Fix this by checking if there is a hole between the last extent item that
we processed and the first extent item in the next leaf, and if there is
one, log an explicit hole extent item.

Fixes: 16e7549f045d ("Btrfs: incompatible format change to remove hole extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3978,6 +3978,36 @@ fill_holes:
 			break;
 		*last_extent = extent_end;
 	}
+
+	/*
+	 * Check if there is a hole between the last extent found in our leaf
+	 * and the first extent in the next leaf. If there is one, we need to
+	 * log an explicit hole so that at replay time we can punch the hole.
+	 */
+	if (ret == 0 &&
+	    key.objectid == btrfs_ino(inode) &&
+	    key.type == BTRFS_EXTENT_DATA_KEY &&
+	    i == btrfs_header_nritems(src_path->nodes[0])) {
+		ret = btrfs_next_leaf(inode->root, src_path);
+		need_find_last_extent = true;
+		if (ret > 0) {
+			ret = 0;
+		} else if (ret == 0) {
+			btrfs_item_key_to_cpu(src_path->nodes[0], &key,
+					      src_path->slots[0]);
+			if (key.objectid == btrfs_ino(inode) &&
+			    key.type == BTRFS_EXTENT_DATA_KEY &&
+			    *last_extent < key.offset) {
+				const u64 len = key.offset - *last_extent;
+
+				ret = btrfs_insert_file_extent(trans, log,
+							       btrfs_ino(inode),
+							       *last_extent, 0,
+							       0, len, 0, len,
+							       0, 0, 0);
+			}
+		}
+	}
 	/*
 	 * Need to let the callers know we dropped the path so they should
 	 * re-search.


