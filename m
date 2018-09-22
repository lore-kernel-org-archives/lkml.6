Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56501C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39A92157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39A92157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392179AbeIVGMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:12:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392013AbeIVGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BR-7D; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sQ-8p; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.83694568@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 34/63] ext4: clear i_data in ext4_inode_info when
 removing inline data
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 6e8ab72a812396996035a37e5ca4b3b99b5d214b upstream.

When converting from an inode from storing the data in-line to a data
block, ext4_destroy_inline_data_nolock() was only clearing the on-disk
copy of the i_blocks[] array.  It was not clearing copy of the
i_blocks[] in ext4_inode_info, in i_data[], which is the copy actually
used by ext4_map_blocks().

This didn't matter much if we are using extents, since the extents
header would be invalid and thus the extents could would re-initialize
the extents tree.  But if we are using indirect blocks, the previous
contents of the i_blocks array will be treated as block numbers, with
potentially catastrophic results to the file system integrity and/or
user data.

This gets worse if the file system is using a 1k block size and
s_first_data is zero, but even without this, the file system can get
quite badly corrupted.

This addresses CVE-2018-10881.

https://bugzilla.kernel.org/show_bug.cgi?id=200015

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inline.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -438,6 +438,7 @@ static int ext4_destroy_inline_data_nolo
 
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
+	memset(ei->i_data, 0, EXT4_MIN_INLINE_DATA_SIZE);
 
 	if (EXT4_HAS_INCOMPAT_FEATURE(inode->i_sb,
 				      EXT4_FEATURE_INCOMPAT_EXTENTS)) {

