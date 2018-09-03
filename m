Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEA22077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEA22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeICVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8285D18;
        Mon,  3 Sep 2018 17:33:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.18 042/123] ext4: use ext4_warning() for sb_getblk failure
Date:   Mon,  3 Sep 2018 18:56:26 +0200
Message-Id: <20180903165721.247516296@linuxfoundation.org>
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

From: Wang Shilong <wshilong@ddn.com>

commit 5ef2a69993676a0dfd49bf60ae1323eb8a288366 upstream.

Out of memory should not be considered as critical errors; so replace
ext4_error() with ext4_warnig().

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |    6 +++---
 fs/ext4/ialloc.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -426,9 +426,9 @@ ext4_read_block_bitmap_nowait(struct sup
 	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
-		ext4_error(sb, "Cannot get buffer for block bitmap - "
-			   "block_group = %u, block_bitmap = %llu",
-			   block_group, bitmap_blk);
+		ext4_warning(sb, "Cannot get buffer for block bitmap - "
+			     "block_group = %u, block_bitmap = %llu",
+			     block_group, bitmap_blk);
 		return ERR_PTR(-ENOMEM);
 	}
 
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -138,9 +138,9 @@ ext4_read_inode_bitmap(struct super_bloc
 	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
-		ext4_error(sb, "Cannot read inode bitmap - "
-			    "block_group = %u, inode_bitmap = %llu",
-			    block_group, bitmap_blk);
+		ext4_warning(sb, "Cannot read inode bitmap - "
+			     "block_group = %u, inode_bitmap = %llu",
+			     block_group, bitmap_blk);
 		return ERR_PTR(-ENOMEM);
 	}
 	if (bitmap_uptodate(bh))


