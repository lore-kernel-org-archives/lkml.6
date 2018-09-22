Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0ECC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F42157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F42157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392047AbeIVGKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44231 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391930AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008Ba-3t; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rm-VC; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.183237158@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 26/63] ext4: verify the depth of extent tree in
 ext4_find_extent()
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

commit bc890a60247171294acc0bd67d211fa4b88d40ba upstream.

If there is a corupted file system where the claimed depth of the
extent tree is -1, this can cause a massive buffer overrun leading to
sadness.

This addresses CVE-2018-10877.

https://bugzilla.kernel.org/show_bug.cgi?id=199417

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: return -EIO instead of -EFSCORRUPTED]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/ext4_extents.h | 1 +
 fs/ext4/extents.c      | 6 ++++++
 2 files changed, 7 insertions(+)

--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -103,6 +103,7 @@ struct ext4_extent_header {
 };
 
 #define EXT4_EXT_MAGIC		cpu_to_le16(0xf30a)
+#define EXT4_MAX_EXTENT_DEPTH 5
 
 #define EXT4_EXTENT_TAIL_OFFSET(hdr) \
 	(sizeof(struct ext4_extent_header) + \
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -851,6 +851,12 @@ ext4_ext_find_extent(struct inode *inode
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
+	if (depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		EXT4_ERROR_INODE(inode, "inode has invalid extent depth: %d",
+				 depth);
+		ret = -EIO;
+		goto err;
+	}
 
 	/* account possible depth increase */
 	if (!path) {

