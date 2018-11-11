Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A08EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C8320871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C8320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbeKLFte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:49:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51288 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730811AbeKLFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:34 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000oU-15; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001f0-4q; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Pranay Kr. Srivastava" <pranjas@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.589811113@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 216/366] ext4: Fix WARN_ON_ONCE in ext4_commit_super()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Pranay Kr. Srivastava" <pranjas@gmail.com>

commit 4743f83990614af6adb09ea7aa3c37b78c4031ab upstream.

If there are racing calls to ext4_commit_super() it's possible for
another writeback of the superblock to result in the buffer being
marked with an error after we check if the buffer is marked as having
a write error and the buffer up-to-date flag is set again.  If that
happens mark_buffer_dirty() can end up throwing a WARN_ON_ONCE.

Fix this by moving this check to write before we call
write_buffer_dirty(), and keeping the buffer locked during this whole
sequence.

Signed-off-by: Pranay Kr. Srivastava <pranjas@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4653,20 +4653,6 @@ static int ext4_commit_super(struct supe
 
 	if (!sbh || block_device_ejected(sb))
 		return error;
-	if (buffer_write_io_error(sbh)) {
-		/*
-		 * Oh, dear.  A previous attempt to write the
-		 * superblock failed.  This could happen because the
-		 * USB device was yanked out.  Or it could happen to
-		 * be a transient write error and maybe the block will
-		 * be remapped.  Nothing we can do but to retry the
-		 * write and hope for the best.
-		 */
-		ext4_msg(sb, KERN_ERR, "previous I/O error to "
-		       "superblock detected");
-		clear_buffer_write_io_error(sbh);
-		set_buffer_uptodate(sbh);
-	}
 	/*
 	 * If the file system is mounted read-only, don't update the
 	 * superblock write time.  This avoids updating the superblock
@@ -4695,7 +4681,23 @@ static int ext4_commit_super(struct supe
 				&EXT4_SB(sb)->s_freeinodes_counter));
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
+	lock_buffer(sbh);
+	if (buffer_write_io_error(sbh)) {
+		/*
+		 * Oh, dear.  A previous attempt to write the
+		 * superblock failed.  This could happen because the
+		 * USB device was yanked out.  Or it could happen to
+		 * be a transient write error and maybe the block will
+		 * be remapped.  Nothing we can do but to retry the
+		 * write and hope for the best.
+		 */
+		ext4_msg(sb, KERN_ERR, "previous I/O error to "
+		       "superblock detected");
+		clear_buffer_write_io_error(sbh);
+		set_buffer_uptodate(sbh);
+	}
 	mark_buffer_dirty(sbh);
+	unlock_buffer(sbh);
 	if (sync) {
 		error = sync_dirty_buffer(sbh);
 		if (error)

