Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166420C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2166420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeGLGXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:23:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:34344 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeGLGXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:23:24 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id F41119A18F;
        Thu, 12 Jul 2018 15:15:20 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6C6FJvn001018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jul 2018 15:15:20 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6C6FJiS024347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jul 2018 15:15:19 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w6C6FJ7R024346;
        Thu, 12 Jul 2018 15:15:19 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable@vger.kernel.org,
        syzbot <syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] fat: Fix memory allocation failure handling of match_strdup()
References: <00000000000097c8ab0570bead4a@google.com>
Date:   Thu, 12 Jul 2018 15:15:19 +0900
In-Reply-To: <00000000000097c8ab0570bead4a@google.com> (syzbot's message of
        "Wed, 11 Jul 2018 12:59:02 -0700")
Message-ID: <8736wp9dzc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In parse_options(), if match_strdup() failed, parse_options() leaves
opts->iocharset in unexpected state (i.e. still pointing the freed
string). And this can be the cause of double free.

To fix, this initialize opts->iocharset always when freeing.

Reported-by: syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff -puN fs/fat/inode.c~fat-fix-kmalloc-failure fs/fat/inode.c
--- linux/fs/fat/inode.c~fat-fix-kmalloc-failure	2018-07-12 12:20:30.388600735 +0900
+++ linux-hirofumi/fs/fat/inode.c	2018-07-12 15:09:48.764070539 +0900
@@ -703,13 +703,21 @@ static void fat_set_state(struct super_b
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
 
@@ -1124,7 +1132,7 @@ static int parse_options(struct super_bl
 	opts->fs_fmask = opts->fs_dmask = current_umask();
 	opts->allow_utime = -1;
 	opts->codepage = fat_default_codepage;
-	opts->iocharset = fat_default_iocharset;
+	fat_reset_iocharset(opts);
 	if (is_vfat) {
 		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
 		opts->rodir = 0;
@@ -1281,8 +1289,7 @@ static int parse_options(struct super_bl
 
 		/* vfat specific */
 		case Opt_charset:
-			if (opts->iocharset != fat_default_iocharset)
-				kfree(opts->iocharset);
+			fat_reset_iocharset(opts);
 			iocharset = match_strdup(&args[0]);
 			if (!iocharset)
 				return -ENOMEM;
@@ -1873,8 +1880,7 @@ out_fail:
 		iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
-		kfree(sbi->options.iocharset);
+	fat_reset_iocharset(&sbi->options);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return error;
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
