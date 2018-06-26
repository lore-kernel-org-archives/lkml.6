Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3226D2C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmtOzd1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B3226D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeFZR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:29:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35456 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbeFZR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so7931601pgp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4dk3RISvVUYKAwx+nhQj+18f/GSWWmRX4KNIq6K7ohc=;
        b=NmtOzd1dM87AU13253h8IUPWsQV8e02gMS+qQKnDSORiwTtGI42EvUEeSJpvmsZWnZ
         ofrlYAKGe5gGADUTu5+ElJH4RDHRegBRhbCP5PycxSpcx3Z9HrpP0SVgK4Fo4KoPBIOo
         eOJ/ReEDQwmUJMQbzghaWdNw8Ig7hePD+UmkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4dk3RISvVUYKAwx+nhQj+18f/GSWWmRX4KNIq6K7ohc=;
        b=KKgNhvuggUJw5AJtnTvV0/EVp+Y/ahIdA9fCPKx5rB0BhEdla3lE6amsOgnq8bAGzb
         +Jn4M2L/7gt4UOiQyqAOfIgyRlTpAgYEHie4L8v3V1Tux7nS7DrUHb5tHvxQZoBPstya
         qZV2MTOmGcme7Wzwu9Jgqw9qbeN6Hd7RXnuygL41dIh2McOAT/b6Cu+5DCBgOneq/mG+
         vjwP5tHLqemUqhuBNed7at/p34558tNMXApvir9UlaJ8U+1BRb/QmCh3y9Xq4OI/Xsk9
         TMnjBpaGd2GXx7mIE9h8oK4mOoU6lJB8Vu1RIiNe+GhYEvNpz4MWKWJ6+UFCCRAitVKC
         cZ5Q==
X-Gm-Message-State: APt69E0AJuWl8e8bVebL7cvzfs3THK5pplwb0pwaokkwqFBi0SSDuDCA
        L4O+43MLrn8tzIZGKZ8vG5UB+A==
X-Google-Smtp-Source: AAOMgpdgDSzPQd/ZmJ8vPTODqeUT86b5MW+FwVZ4pAbACyaiGi6jQ6yfh6ORsoMvs5zHWZTH9SbJSA==
X-Received: by 2002:a62:2605:: with SMTP id m5-v6mr2446938pfm.223.1530034164498;
        Tue, 26 Jun 2018 10:29:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h9-v6sm7322470pfj.77.2018.06.26.10.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:29:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] NTFS: mft: Remove VLA usage
Date:   Tue, 26 Jun 2018 10:29:09 -0700
Message-Id: <20180626172909.41453-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626172909.41453-1-keescook@chromium.org>
References: <20180626172909.41453-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates the maximum size stack buffer. Existing checks already require
that blocksize >= NTFS_BLOCK_SIZE and mft_record_size <= PAGE_SIZE, so
max_bhs can be at most PAGE_SIZE / NTFS_BLOCK_SIZE. Sanity checks are
added for robustness.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ntfs/mft.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 32c523cf5a2d..fb14d17666c8 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -35,6 +35,8 @@
 #include "mft.h"
 #include "ntfs.h"
 
+#define MAX_BHS	(PAGE_SIZE / NTFS_BLOCK_SIZE)
+
 /**
  * map_mft_record_page - map the page in which a specific mft record resides
  * @ni:		ntfs inode whose mft record page to map
@@ -469,7 +471,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 	struct page *page;
 	unsigned int blocksize = vol->sb->s_blocksize;
 	int max_bhs = vol->mft_record_size / blocksize;
-	struct buffer_head *bhs[max_bhs];
+	struct buffer_head *bhs[MAX_BHS];
 	struct buffer_head *bh, *head;
 	u8 *kmirr;
 	runlist_element *rl;
@@ -479,6 +481,8 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 
 	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	BUG_ON(!max_bhs);
+	if (WARN_ON(max_bhs > MAX_BHS))
+		return -EINVAL;
 	if (unlikely(!vol->mftmirr_ino)) {
 		/* This could happen during umount... */
 		err = ntfs_sync_mft_mirror_umount(vol, mft_no, m);
@@ -674,7 +678,7 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 	unsigned int blocksize = vol->sb->s_blocksize;
 	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
 	int max_bhs = vol->mft_record_size / blocksize;
-	struct buffer_head *bhs[max_bhs];
+	struct buffer_head *bhs[MAX_BHS];
 	struct buffer_head *bh, *head;
 	runlist_element *rl;
 	unsigned int block_start, block_end, m_start, m_end;
@@ -684,6 +688,10 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 	BUG_ON(NInoAttr(ni));
 	BUG_ON(!max_bhs);
 	BUG_ON(!PageLocked(page));
+	if (WARN_ON(max_bhs > MAX_BHS)) {
+		err = -EINVAL;
+		goto err_out;
+	}
 	/*
 	 * If the ntfs_inode is clean no need to do anything.  If it is dirty,
 	 * mark it as clean now so that it can be redirtied later on if needed.
-- 
2.17.1

