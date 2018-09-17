Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B140ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FFA2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FFA2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeIREhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:05 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2FCFFC77;
        Mon, 17 Sep 2018 23:07:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 020/158] Btrfs: fix data corruption when deduplicating between different files
Date:   Tue, 18 Sep 2018 00:40:50 +0200
Message-Id: <20180917211711.769840046@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit de02b9f6bb65a6a1848f346f7a3617b7a9b930c0 upstream.

If we deduplicate extents between two different files we can end up
corrupting data if the source range ends at the size of the source file,
the source file's size is not aligned to the filesystem's block size
and the destination range does not go past the size of the destination
file size.

Example:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ xfs_io -f -c "pwrite -S 0x6b 0 2518890" /mnt/foo
  # The first byte with a value of 0xae starts at an offset (2518890)
  # which is not a multiple of the sector size.
  $ xfs_io -c "pwrite -S 0xae 2518890 102398" /mnt/foo

  # Confirm the file content is full of bytes with values 0x6b and 0xae.
  $ od -t x1 /mnt/foo
  0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  *
  11467540 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
  11467560 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
  *
  11777540 ae ae ae ae ae ae ae ae
  11777550

  # Create a second file with a length not aligned to the sector size,
  # whose bytes all have the value 0x6b, so that its extent(s) can be
  # deduplicated with the first file.
  $ xfs_io -f -c "pwrite -S 0x6b 0 557771" /mnt/bar

  # Now deduplicate the entire second file into a range of the first file
  # that also has all bytes with the value 0x6b. The destination range's
  # end offset must not be aligned to the sector size and must be less
  # then the offset of the first byte with the value 0xae (byte at offset
  # 2518890).
  $ xfs_io -c "dedupe /mnt/bar 0 1957888 557771" /mnt/foo

  # The bytes in the range starting at offset 2515659 (end of the
  # deduplication range) and ending at offset 2519040 (start offset
  # rounded up to the block size) must all have the value 0xae (and not
  # replaced with 0x00 values). In other words, we should have exactly
  # the same data we had before we asked for deduplication.
  $ od -t x1 /mnt/foo
  0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  *
  11467540 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
  11467560 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
  *
  11777540 ae ae ae ae ae ae ae ae
  11777550

  # Unmount the filesystem and mount it again. This guarantees any file
  # data in the page cache is dropped.
  $ umount /dev/sdb
  $ mount /dev/sdb /mnt

  $ od -t x1 /mnt/foo
  0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  *
  11461300 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00
  11461320 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  *
  11470000 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
  *
  11777540 ae ae ae ae ae ae ae ae
  11777550

  # The bytes in range 2515659 to 2519040 have a value of 0x00 and not a
  # value of 0xae, data corruption happened due to the deduplication
  # operation.

So fix this by rounding down, to the sector size, the length used for the
deduplication when the following conditions are met:

  1) Source file's range ends at its i_size;
  2) Source file's i_size is not aligned to the sector size;
  3) Destination range does not cross the i_size of the destination file.

Fixes: e1d227a42ea2 ("btrfs: Handle unaligned length in extent_same")
CC: stable@vger.kernel.org # 4.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3463,6 +3463,25 @@ static int btrfs_extent_same_range(struc
 
 		same_lock_start = min_t(u64, loff, dst_loff);
 		same_lock_len = max_t(u64, loff, dst_loff) + len - same_lock_start;
+	} else {
+		/*
+		 * If the source and destination inodes are different, the
+		 * source's range end offset matches the source's i_size, that
+		 * i_size is not a multiple of the sector size, and the
+		 * destination range does not go past the destination's i_size,
+		 * we must round down the length to the nearest sector size
+		 * multiple. If we don't do this adjustment we end replacing
+		 * with zeroes the bytes in the range that starts at the
+		 * deduplication range's end offset and ends at the next sector
+		 * size multiple.
+		 */
+		if (loff + olen == i_size_read(src) &&
+		    dst_loff + len < i_size_read(dst)) {
+			const u64 sz = BTRFS_I(src)->root->fs_info->sectorsize;
+
+			len = round_down(i_size_read(src), sz) - loff;
+			olen = len;
+		}
 	}
 
 again:


