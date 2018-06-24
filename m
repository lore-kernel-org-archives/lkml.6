Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA7C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D1208AF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4D1208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeFXPoH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:44:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeFXPoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:44:04 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 594D62C;
        Sun, 24 Jun 2018 15:44:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.17 16/70] ext4: fix hole length detection in ext4_ind_map_blocks()
Date:   Sun, 24 Jun 2018 23:22:08 +0800
Message-Id: <20180624142741.506887976@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 2ee3ee06a8fd792765fa3267ddf928997797eec5 upstream.

When ext4_ind_map_blocks() computes a length of a hole, it doesn't count
with the fact that mapped offset may be somewhere in the middle of the
completely empty subtree. In such case it will return too large length
of the hole which then results in lseek(SEEK_DATA) to end up returning
an incorrect offset beyond the end of the hole.

Fix the problem by correctly taking offset within a subtree into account
when computing a length of a hole.

Fixes: facab4d9711e7aa3532cb82643803e8f1b9518e8
CC: stable@vger.kernel.org
Reported-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/indirect.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -561,10 +561,16 @@ int ext4_ind_map_blocks(handle_t *handle
 		unsigned epb = inode->i_sb->s_blocksize / sizeof(u32);
 		int i;
 
-		/* Count number blocks in a subtree under 'partial' */
-		count = 1;
-		for (i = 0; partial + i != chain + depth - 1; i++)
-			count *= epb;
+		/*
+		 * Count number blocks in a subtree under 'partial'. At each
+		 * level we count number of complete empty subtrees beyond
+		 * current offset and then descend into the subtree only
+		 * partially beyond current offset.
+		 */
+		count = 0;
+		for (i = partial - chain + 1; i < depth; i++)
+			count = count * epb + (epb - offsets[i] - 1);
+		count++;
 		/* Fill in size of a hole we found */
 		map->m_pblk = 0;
 		map->m_len = min_t(unsigned int, map->m_len, count);


