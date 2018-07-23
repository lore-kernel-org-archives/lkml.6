Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6803ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B15520883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbeGWN0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:26:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:26:41 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3F9DBDB;
        Mon, 23 Jul 2018 12:25:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 13/63] fat: fix memory allocation failure handling of match_strdup()
Date:   Mon, 23 Jul 2018 14:24:19 +0200
Message-Id: <20180723122446.882646333@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

commit 35033ab988c396ad7bce3b6d24060c16a9066db8 upstream.

In parse_options(), if match_strdup() failed, parse_options() leaves
opts->iocharset in unexpected state (i.e.  still pointing the freed
string).  And this can be the cause of double free.

To fix, this initialize opts->iocharset always when freeing.

Link: http://lkml.kernel.org/r/8736wp9dzc.fsf@mail.parknet.co.jp
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reported-by: syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fat/inode.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -697,13 +697,21 @@ static void fat_set_state(struct super_b
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
 
@@ -1118,7 +1126,7 @@ static int parse_options(struct super_bl
 	opts->fs_fmask = opts->fs_dmask = current_umask();
 	opts->allow_utime = -1;
 	opts->codepage = fat_default_codepage;
-	opts->iocharset = fat_default_iocharset;
+	fat_reset_iocharset(opts);
 	if (is_vfat) {
 		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
 		opts->rodir = 0;
@@ -1275,8 +1283,7 @@ static int parse_options(struct super_bl
 
 		/* vfat specific */
 		case Opt_charset:
-			if (opts->iocharset != fat_default_iocharset)
-				kfree(opts->iocharset);
+			fat_reset_iocharset(opts);
 			iocharset = match_strdup(&args[0]);
 			if (!iocharset)
 				return -ENOMEM;
@@ -1867,8 +1874,7 @@ out_fail:
 		iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
-		kfree(sbi->options.iocharset);
+	fat_reset_iocharset(&sbi->options);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return error;


