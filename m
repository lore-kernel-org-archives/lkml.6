Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF8C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7A120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7A120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeKLFxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51102 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730699AbeKLFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsp-0000lJ-0U; Sun, 11 Nov 2018 19:58:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001ku-GQ; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.392763317@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 274/366] fat: fix memory allocation failure handling
 of match_strdup()
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

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

commit 35033ab988c396ad7bce3b6d24060c16a9066db8 upstream.

In parse_options(), if match_strdup() failed, parse_options() leaves
opts->iocharset in unexpected state (i.e.  still pointing the freed
string).  And this can be the cause of double free.

To fix, this initialize opts->iocharset always when freeing.

Link: http://lkml.kernel.org/r/8736wp9dzc.fsf@mail.parknet.co.jp
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reported-by: syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fat/inode.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -610,13 +610,21 @@ static void fat_set_state(struct super_b
 	brelse(bh);
 }
 
+static void fat_reset_iocharset(struct fat_mount_options *opts)
+{
+	if (opts->iocharset != fat_default_iocharset) {
+		/* Note: opts->iocharset can be NULL here */
+		kfree(opts->iocharset);
+		opts->iocharset = fat_default_iocharset;
+	}
+}
+
 static void delayed_free(struct rcu_head *p)
 {
 	struct msdos_sb_info *sbi = container_of(p, struct msdos_sb_info, rcu);
 	unload_nls(sbi->nls_disk);
 	unload_nls(sbi->nls_io);
-	if (sbi->options.iocharset != fat_default_iocharset)
-		kfree(sbi->options.iocharset);
+	fat_reset_iocharset(&sbi->options);
 	kfree(sbi);
 }
 
@@ -1031,7 +1039,7 @@ static int parse_options(struct super_bl
 	opts->fs_fmask = opts->fs_dmask = current_umask();
 	opts->allow_utime = -1;
 	opts->codepage = fat_default_codepage;
-	opts->iocharset = fat_default_iocharset;
+	fat_reset_iocharset(opts);
 	if (is_vfat) {
 		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
 		opts->rodir = 0;
@@ -1181,8 +1189,7 @@ static int parse_options(struct super_bl
 
 		/* vfat specific */
 		case Opt_charset:
-			if (opts->iocharset != fat_default_iocharset)
-				kfree(opts->iocharset);
+			fat_reset_iocharset(opts);
 			iocharset = match_strdup(&args[0]);
 			if (!iocharset)
 				return -ENOMEM;
@@ -1763,8 +1770,7 @@ out_fail:
 		iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
-		kfree(sbi->options.iocharset);
+	fat_reset_iocharset(&sbi->options);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return error;

