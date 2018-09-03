Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5870C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C62077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9C62077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeICVxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A3A6D16;
        Mon,  3 Sep 2018 17:32:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 020/123] Btrfs: send, fix incorrect file layout after hole punching beyond eof
Date:   Mon,  3 Sep 2018 18:56:04 +0200
Message-Id: <20180903165720.352404711@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 22d3151c2c4cb517a309154d1e828a28106508c7 upstream.

When doing an incremental send, if we have a file in the parent snapshot
that has prealloc extents beyond EOF and in the send snapshot it got a
hole punch that partially covers the prealloc extents, the send stream,
when replayed by a receiver, can result in a file that has a size bigger
than it should and filled with zeroes past the correct EOF.

For example:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ xfs_io -f -c "falloc -k 0 4M" /mnt/foobar
  $ xfs_io -c "pwrite -S 0xea 0 1M" /mnt/foobar

  $ btrfs subvolume snapshot -r /mnt /mnt/snap1
  $ btrfs send -f /tmp/1.send /mnt/snap1

  $ xfs_io -c "fpunch 1M 2M" /mnt/foobar

  $ btrfs subvolume snapshot -r /mnt /mnt/snap2
  $ btrfs send -f /tmp/2.send -p /mnt/snap1 /mnt/snap2

  $ stat --format %s /mnt/snap2/foobar
  1048576
  $ md5sum /mnt/snap2/foobar
  d31659e82e87798acd4669a1e0a19d4f  /mnt/snap2/foobar

  $ umount /mnt
  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ btrfs receive -f /mnt/1.snap /mnt
  $ btrfs receive -f /mnt/2.snap /mnt

  $ stat --format %s /mnt/snap2/foobar
  3145728
  # --> should be 1Mb and not 3Mb (which was the end offset of hole
  #     punch operation)
  $ md5sum /mnt/snap2/foobar
  117baf295297c2a995f92da725b0b651  /mnt/snap2/foobar
  # --> should be d31659e82e87798acd4669a1e0a19d4f as in the original fs

This issue actually happens only since commit ffa7c4296e93 ("Btrfs: send,
do not issue unnecessary truncate operations"), but before that commit we
were issuing a write operation full of zeroes (to "punch" a hole) which
was extending the file size beyond the correct value and then immediately
issue a truncate operation to the correct size and undoing the previous
write operation. Since the send protocol does not support fallocate, for
extent preallocation and hole punching, fix this by not even attempting
to send a "hole" (regular write full of zeroes) if it starts at an offset
greater then or equals to the file's size. This approach, besides being
much more simple then making send issue the truncate operation, adds the
benefit of avoiding the useless pair of write of zeroes and truncate
operations, saving time and IO at the receiver and reducing the size of
the send stream.

A test case for fstests follows soon.

Fixes: ffa7c4296e93 ("Btrfs: send, do not issue unnecessary truncate operations")
CC: stable@vger.kernel.org # 4.17+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/send.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5007,6 +5007,15 @@ static int send_hole(struct send_ctx *sc
 	u64 len;
 	int ret = 0;
 
+	/*
+	 * A hole that starts at EOF or beyond it. Since we do not yet support
+	 * fallocate (for extent preallocation and hole punching), sending a
+	 * write of zeroes starting at EOF or beyond would later require issuing
+	 * a truncate operation which would undo the write and achieve nothing.
+	 */
+	if (offset >= sctx->cur_inode_size)
+		return 0;
+
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, end - offset);
 


