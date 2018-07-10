Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA10C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D91208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D91208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeGJVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:43:35 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGJVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:43:34 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MAvMi-1fkftZ09nY-009x7s; Tue, 10 Jul 2018 23:42:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] hfs/hfsplus: stop using timespec based interfaces
Date:   Tue, 10 Jul 2018 23:40:51 +0200
Message-Id: <20180710214131.4106527-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180710214131.4106527-1-arnd@arndb.de>
References: <20180710214131.4106527-1-arnd@arndb.de>
X-Provags-ID: V03:K1:3XOFvQONFj7UBNTNCiWf9ATyjwS7sEg/ohQirFxBUDYQgLI2Ckr
 5vsdGA7H56gLO367Kgue9lcEXxaZWpbbN3kOiQNLMJfD6mnK8QkbTAHNLOKnuV5ch1mJrVx
 EsYg/fqqAFK7zX+oaonuU18xll7wC53xDKmmIZdp/6psw5mClZF7E3B8uf0K8AUi0rOO1RF
 bKDuWEsmSgALYOa8djYdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EesImIwKzeY=:IDfrk74Eg9mOt7Vq1wfydK
 9JjwxG23RT0FJAsXBRbfGnjLIxjgIVsS/QxQ/smUlh4xZs0xZFb7AUgMKzwrBrs9n+PH4nt8Z
 Ox3+RR3xtS0EwOno996OHi8bMfLS03NNi+j3Yl+cFNsYLtv8BcLsRYNtSwon51gsz/AdEsQPF
 MIk6Uslyp7wJwSUbtViEl8py41NXYNKdw28TVfISw3gmUe4uPCpyJTiXY9uHH1+OllssdZ92X
 qwgwi4Ac6lVap8RujVexXVQQ7sehp74GeNV+qPos/+SJMa1js/P01LJgR4J0QZYW56HTVtdZO
 pnKOHLp6JnJPOGPnbmQ8tuYETPNWMVxdrkvdhgokCzATUYvtDB9/3ecHUEEFGmvBF/ixxV4ER
 eD5UCjzSgfNfG/xkuihFyd5xYsYJI8qNjB1GepJ5dsGDAdCmhTrvUQzOPKAmEdAuOZ4ZEvlMn
 4Calngt9+z6/wPOFFH74Jx4W1uLyTRg5V8rHicmPbHiz0iOIhmqmriZ+AaaaFLWEz5GhE3iql
 FOK3a9uOut1YzVQO8o2l45AMtsaaYdpqKM/QojM0Fux+gnB+qyyhiJ3s01ADF7h8bRh5TNvzv
 qfQhEN8cTI/aW2WJcJrb9oZq0vBv+nBDSnfFvus9A6bfY+7SQzNpGsKLkSgfF0CBXkcS3XjCW
 fNgBVZdH32KvrocNaaVKwn/5OSjnp98U9YhjLbqS3tKRcDCpssZIvWS7SDBCrFul3fYU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native HFS and HFS+ timestamps overflow in year 2040, two years after
the Unix y2038 overflow. On 32-bit systems, we currently go through a
conversion that overflows in 2038, while the VFS code is now capable of
representing a 64-bit time range.

This removes the unnecessary conversion, using 64-bit timestamps
consistently

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: reword changelog, combine hfs and hfs+ patches
---
 fs/hfs/hfs_fs.h         |  4 ++--
 fs/hfs/inode.c          |  4 ++--
 fs/hfsplus/hfsplus_fs.h |  4 ++--
 fs/hfsplus/inode.c      | 12 ++++++------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 1af998fb522e..45cf1bccc1f2 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -273,9 +273,9 @@ static inline __be32 __hfs_u_to_mtime(time64_t ut)
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)   (struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
+#define hfs_m_to_utime(time)   (struct timespec64){ .tv_sec = __hfs_m_to_utime(time) }
 #define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
-#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
+#define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_seconds())
 
 static inline const char *hfs_mdb_name(struct super_block *sb)
 {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2a16111d312f..b3309b83371a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
+				hfs_m_to_utime(rec->file.MdDat);
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
+				hfs_m_to_utime(rec->dir.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7f0943e540a0..677ef7f9204d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -555,8 +555,8 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
 }
 
 /* compatibility */
-#define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
+#define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
-#define hfsp_now2mt()		__hfsp_ut2mt(get_seconds())
+#define hfsp_now2mt()		__hfsp_ut2mt(ktime_get_real_seconds())
 
 #endif
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c824f702feec..c0c8d433864f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -493,9 +493,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		hfsplus_get_perms(inode, &folder->permissions, 1);
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
-		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(folder->access_date));
-		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(folder->content_mod_date));
-		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(folder->attribute_mod_date));
+		inode->i_atime = hfsp_mt2ut(folder->access_date);
+		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
+		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
 		HFSPLUS_I(inode)->create_date = folder->create_date;
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -531,9 +531,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
-		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(file->access_date));
-		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(file->content_mod_date));
-		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(file->attribute_mod_date));
+		inode->i_atime = hfsp_mt2ut(file->access_date);
+		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
+		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
 		HFSPLUS_I(inode)->create_date = file->create_date;
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
-- 
2.9.0

