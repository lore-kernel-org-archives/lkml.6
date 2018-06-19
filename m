Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A77CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBEA20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBEA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966924AbeFSQDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:03:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:03:07 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lgt3C-1g1skI0j02-00oIGr; Tue, 19 Jun 2018 18:02:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hfsplus: stop using timespec based interfaces
Date:   Tue, 19 Jun 2018 18:02:08 +0200
Message-Id: <20180619160223.4108556-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619160223.4108556-1-arnd@arndb.de>
References: <20180619160223.4108556-1-arnd@arndb.de>
X-Provags-ID: V03:K1:DeSI1oNEvn7y5VgzwAyDnZ5vWeRfKiDKSfNY1O/7Npr0FZUmNHk
 3aS9mQERqoxDMZ+Al2a0km86nN9jXowtpYUX1KEbsPcI1gCVfrSs13SmpgufYI3U+FSsAF/
 tJQmH6WSElOGfWmuju+S8wafu7w5jL2JXdW9j2ArLoUGY6FxOgNo9TvwkQ6MdrpxnzK9DBq
 2SQAVObEM8TbReK17W2bA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iZE5c1VzwwE=:eIrg+pxUxvXtiyYl7vl0LI
 PTHfdg0aaSOf35AzBEnPsLBHvnbDZjFS1GtCnF88Lsw5KyHKFEgKACsOwRLFMlfcx+SySlgq5
 VyydHZ1lGhq0KRd6gfZjBlK+FF0BqSNhZWLUi5B5WsMFOsaDLC9XmF4ao2gwWzJz8LFca+2oy
 hRPqa7rCIPiqrIu4gqipCq4AbD6KCuGgVBpKwIJtQNkr/8k2zZhvPq3ZSbd8Gy6QvlelVw9ie
 qNeyrGW0WAdizmPehdZz6OSdqIY3ZrsZCykdvD6IOqXU43wF+PSYPrlEgVRoCTpIO/woMP9ml
 l6d8MM7zniuRHiPG3UzYI9+7+OUF2L+g0NN8TE59ttPd+xo4Ht/K0am2kaDAQoGXyMvgxRFc1
 MGAeGpRE41w+ONbZV3oEdt686axlZImsI3InWSYXr5FVrEE7tP2Z2sFua//OhelaC+2KfN5C7
 owJa9iMJ3rdtN0Im83ghmxn6+vHrfvRM5Yz9t1XK7EG5ZRgzMfU/OlmQFcOAgtEjvHiC7NTzR
 uGas3oEzY9QnApUIPz1NvGx2is4+sBH078/fnRC9GIGMe50+5hNbr+I3kU/yRDJo+/saZXJTc
 nmvs65Rr4XFsmHpZYPxfB9BnW9dr+qpNd+abZ3PEYcqMaP6NIw+8+ON0AJUpTvtBc+O3PB6yK
 P0InXfo9SATyjbQunV++wU4hO07h1eSWyg5JuPURHJoN9zlq4Ek72gPD5h6w1YUN3sqo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native HFS+ timestamps overflow in year 2040, two years after the Unix
y2038 overflow. However, the way that the conversion between on-disk
timestamps and in-kernel timestamps was implemented, 64-bit machines
actually ended up converting negative UTC timestamps (1902 through 1969)
into times between 2038 and 2106.

Rather than making all machines faithfully represent timestamps in the
ancient past but break after 2040, this changes the file system to
always use the unsigned UTC interpretation, reading back times between
1970 and 2106.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hfsplus/hfsplus_fs.h |  7 ++++---
 fs/hfsplus/inode.c      | 12 ++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index d9255abafb81..646c207be38d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -530,13 +530,14 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
-/* time macros */
+/* time macros: convert between 1904-2040 and 1970-2106 range,
+ * pre-1970 timestamps are interpreted as post-2038 times after wrap-around */
 #define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
 #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
 
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

