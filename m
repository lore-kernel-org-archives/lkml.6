Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1CBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B912080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B912080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeKLF4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52102 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLF4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:46 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000tu-RD; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Pi-PJ; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Amir Goldstein" <amir73il@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.871694187@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 046/366] ext4: do not update s_last_mounted of a
 frozen fs
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

From: Amir Goldstein <amir73il@gmail.com>

commit db6516a5e7ddb6dc72d167b920f2f272596ea22d upstream.

If fs is frozen after mount and before the first file open, the
update of s_last_mounted bypasses freeze protection and prints out
a WARNING splat:

$ mount /vdf
$ fsfreeze -f /vdf
$ cat /vdf/foo

[   31.578555] WARNING: CPU: 1 PID: 1415 at
fs/ext4/ext4_jbd2.c:53 ext4_journal_check_start+0x48/0x82

[   31.614016] Call Trace:
[   31.614997]  __ext4_journal_start_sb+0xe4/0x1a4
[   31.616771]  ? ext4_file_open+0xb6/0x189
[   31.618094]  ext4_file_open+0xb6/0x189

If fs is frozen, skip s_last_mounted update.

[backport hint: to apply to stable tree, need to apply also patches
 vfs: add the sb_start_intwrite_trylock() helper
 ext4: factor out helper ext4_sample_last_mounted()]

Fixes: bc0b0d6d69ee ("ext4: update the s_last_mounted field in the superblock")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -220,7 +220,7 @@ static int ext4_sample_last_mounted(stru
 	if (likely(sbi->s_mount_flags & EXT4_MF_MNTDIR_SAMPLED))
 		return 0;
 
-	if (sb->s_flags & MS_RDONLY)
+	if (sb->s_flags & MS_RDONLY || !sb_start_intwrite_trylock(sb))
 		return 0;
 
 	sbi->s_mount_flags |= EXT4_MF_MNTDIR_SAMPLED;
@@ -234,21 +234,25 @@ static int ext4_sample_last_mounted(stru
 	path.mnt = mnt;
 	path.dentry = mnt->mnt_root;
 	cp = d_path(&path, buf, sizeof(buf));
+	err = 0;
 	if (IS_ERR(cp))
-		return 0;
+		goto out;
 
 	handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, 1);
+	err = PTR_ERR(handle);
 	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+		goto out;
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
 	if (err)
-		goto out;
+		goto out_journal;
 	strlcpy(sbi->s_es->s_last_mounted, cp,
 		sizeof(sbi->s_es->s_last_mounted));
 	ext4_handle_dirty_super(handle, sb);
-out:
+out_journal:
 	ext4_journal_stop(handle);
+out:
+	sb_end_intwrite(sb);
 	return err;
 }
 

