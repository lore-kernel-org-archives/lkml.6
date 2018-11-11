Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7762CC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB1E2175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYeQVDYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB1E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbeKLIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389975AbeKLIVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF90223CB;
        Sun, 11 Nov 2018 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975511;
        bh=CWOOIsDMRk+cGpPVuMmVx2vWLJWOuGzE9js7GdoqOVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYeQVDYPqC4I7uYjq5W1MLZdpqbpz4fnyI0QSpKSUgoMW1cWpk+BFGt0/ES+RFWzv
         TVwFUt6Uhn6BThis0SCDKg1Co4UL5ETGiAbV1UU5y9/G63nQvChwyRoB6xgCrjfRLp
         if19cuYloeCdFckERcuJjWcWJ5yiK7D++Za73rnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 337/350] Btrfs: fix assertion on fsync of regular file when using no-holes feature
Date:   Sun, 11 Nov 2018 14:23:21 -0800
Message-Id: <20181111221722.197203481@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

commit 7ed586d0a8241e81d58c656c5b315f781fa6fc97 upstream.

When using the NO_HOLES feature and logging a regular file, we were
expecting that if we find an inline extent, that either its size in RAM
(uncompressed and unenconded) matches the size of the file or if it does
not, that it matches the sector size and it represents compressed data.
This assertion does not cover a case where the length of the inline extent
is smaller than the sector size and also smaller the file's size, such
case is possible through fallocate. Example:

  $ mkfs.btrfs -f -O no-holes /dev/sdb
  $ mount /dev/sdb /mnt

  $ xfs_io -f -c "pwrite -S 0xb60 0 21" /mnt/foobar
  $ xfs_io -c "falloc 40 40" /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar

In the above example we trigger the assertion because the inline extent's
length is 21 bytes while the file size is 80 bytes. The fallocate() call
merely updated the file's size and did not touch the existing inline
extent, as expected.

So fix this by adjusting the assertion so that an inline extent length
smaller than the file size is valid if the file size is smaller than the
filesystem's sector size.

A test case for fstests follows soon.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Fixes: a89ca6f24ffe ("Btrfs: fix fsync after truncate when no_holes feature is enabled")
CC: stable@vger.kernel.org # 4.14+
Link: https://lore.kernel.org/linux-btrfs/CAE5jQCfRSBC7n4pUTFJcmHh109=gwyT9mFkCOL+NKfzswmR=_Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4803,7 +4803,8 @@ static int btrfs_log_trailing_hole(struc
 			ASSERT(len == i_size ||
 			       (len == fs_info->sectorsize &&
 				btrfs_file_extent_compression(leaf, extent) !=
-				BTRFS_COMPRESS_NONE));
+				BTRFS_COMPRESS_NONE) ||
+			       (len < i_size && i_size < fs_info->sectorsize));
 			return 0;
 		}
 


