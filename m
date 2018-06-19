Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A5420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A5420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966967AbeFSQDd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:03:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33533 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:03:28 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MOETY-1fapPp2sgW-005ZXD; Tue, 19 Jun 2018 18:03:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hfsplus: return inode birthtime for statx
Date:   Tue, 19 Jun 2018 18:02:09 +0200
Message-Id: <20180619160223.4108556-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619160223.4108556-1-arnd@arndb.de>
References: <20180619160223.4108556-1-arnd@arndb.de>
X-Provags-ID: V03:K1:lXw6D43eZ1lgc1qQLcDqzztwJfREYdLFEFc8N66QqYoWRGMiz9v
 xXboL2uJtqZ80BdLGnPZKOtq5gExaIJcMy7qI93NFXxSj7KlWG3OwPr8BWG0+D/x9DqjXiG
 0r0eWhL/u8an2jrwqMH+VxQTDOJyh8eDc7tOvAA9A//qQksiMN73Y2vrtVYFGecq2eBmOpL
 OPuLXf35onQKxszKZhaRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vkiWz0Z8T68=:E8agSrRpvrALGkM1j2dkLb
 70ntZ4azE3NrmT9tyQ3LVN5UlpVT9LLgSGXWLeaflD8iv+N6CshK5vYW5ygJ+r6Mf4MvPcWUd
 dw5CL0hso8p3N1I8VOYgYnNip3Pc6lOFzJx3Um7I6gyFkwYe4LL3KXu61zW40RU2yW8tdvnDN
 fnin0sfo3JEkU/TiZ5Fz+ZU6TGHO5RHJ7bxwGaJ/utzGtW0lVufs144/2rpSNXfampZ5VGSYn
 sOTpwM2k0JEawwHDEXtLO1uzqjMoDGiKOK5lB8K4TW1Z4ZvST091Hs2/3fr/sDubUdDrK0oaF
 Twzp5KBewcPTkPzoAp2+DhaPYRRAb3/dYfzI+X2RUAuw3MARFcsQDEyGfPar6joytRA1YQIjt
 68M8U65rX4bm6rBdFpAaLy4QeZBjcTOZLyQMaAnk2Hu+OIGwRn/j0wxaR1HQ9xy+xSphG86a7
 MxyJ8y6iC6qGNi1/S9TBHxXrRLcYtSbbpW2LJ3Q7bTY2pJC8QJSRxAA8fEZpCwGVLXc8bwGhr
 KyLicegs6o35TIJO4T0eaRCFJQZS/1OPQa/l8v73up7kNOsZ+XwONDFZb0kJ8DY/JVLDAbJ+N
 8w2QD16TNmj8zYreH72dEQv+5j4uEX3syO98RQQ/YQCnPV12845iOJk2TJrNXo/W6MK+ymu5q
 fx1nTHyKqrqR7UOFxjAVxmp/nwDqeY6oWkhYfb/DgvRDZtUk88wJ6IWI1iNNzVZrcMJk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the data in the kernel, so we might just as well provide it to
user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hfsplus/dir.c        |  1 +
 fs/hfsplus/hfsplus_fs.h |  2 ++
 fs/hfsplus/inode.c      | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index b5254378f011..df14b6dd5b5a 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -566,6 +566,7 @@ const struct inode_operations hfsplus_dir_inode_operations = {
 	.symlink		= hfsplus_symlink,
 	.mknod			= hfsplus_mknod,
 	.rename			= hfsplus_rename,
+	.getattr		= hfsplus_getattr,
 	.listxattr		= hfsplus_listxattr,
 #ifdef CONFIG_HFSPLUS_FS_POSIX_ACL
 	.get_acl		= hfsplus_get_posix_acl,
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 646c207be38d..1a6b469f8d22 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -489,6 +489,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd);
 int hfsplus_cat_write_inode(struct inode *inode);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
+int hfsplus_getattr(const struct path *path, struct kstat *stat,
+		    u32 request_mask, unsigned int query_flags);
 
 /* ioctl.c */
 long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c0c8d433864f..f9bb568f9479 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -276,6 +276,19 @@ static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
 	return 0;
 }
 
+int hfsplus_getattr(const struct path *path, struct kstat *stat,
+		     u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	generic_fillattr(inode, stat);
+
+	stat->btime = hfsp_mt2ut(HFSPLUS_I(inode)->create_date);
+	stat->result_mask |= STATX_BTIME;
+
+	return 0;
+}
+
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync)
 {
@@ -335,6 +348,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 
 static const struct inode_operations hfsplus_file_inode_operations = {
 	.setattr	= hfsplus_setattr,
+	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
 #ifdef CONFIG_HFSPLUS_FS_POSIX_ACL
 	.get_acl	= hfsplus_get_posix_acl,
-- 
2.9.0

