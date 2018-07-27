Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CD1208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CD1208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbeG0Ls7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:48:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbeG0Ls6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:48:58 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75C0CCD1;
        Fri, 27 Jul 2018 10:27:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 02/27] fat: fix memory allocation failure handling of match_strdup()
Date:   Fri, 27 Jul 2018 12:26:39 +0200
Message-Id: <20180727102649.135411430@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1774,8 +1781,7 @@ out_fail:
 		iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
-		kfree(sbi->options.iocharset);
+	fat_reset_iocharset(&sbi->options);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return error;


