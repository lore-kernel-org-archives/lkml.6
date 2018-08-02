Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D6F21502
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6F21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeHBLaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:30:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbeHBLaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:30:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1115757F38EE7;
        Thu,  2 Aug 2018 17:40:32 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 17:39:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <gaoxiang25@huawei.com>, <sfr@canb.auug.org.au>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] staging: erofs: disable compiling temporarile
Date:   Thu, 2 Aug 2018 17:39:17 +0800
Message-ID: <20180802093917.4796-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Stephen Rothwell reported:

"After merging the staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/erofs/super.c: In function 'erofs_read_super':
drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
  sb->s_flags |= MS_RDONLY | MS_NOATIME;
                 ^~~~~~~~~
                 IS_RDONLY
drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
  sb->s_flags |= MS_RDONLY | MS_NOATIME;
                             ^~~~~~~~~~
                             S_NOATIME
drivers/staging/erofs/super.c: In function 'erofs_mount':
drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
   &priv, erofs_fill_super);
          ^~~~~~~~~~~~~~~~
In file included from include/linux/buffer_head.h:12:0,
                 from drivers/staging/erofs/super.c:14:
include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
                       ^~~~~~~~~~
drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
  return mount_bdev(fs_type, flags, dev_name,
         ^~~~~~~~~~
In file included from include/linux/buffer_head.h:12:0,
                 from drivers/staging/erofs/super.c:14:
include/linux/fs.h:2151:23: note: declared here
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
                       ^~~~~~~~~~
drivers/staging/erofs/super.c: At top level:
drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
  .mount          = erofs_mount,
                    ^~~~~~~~~~~
drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
drivers/staging/erofs/super.c: In function 'erofs_remount':
drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
  *flags |= MS_RDONLY;
            ^~~~~~~~~
            IS_RDONLY
drivers/staging/erofs/super.c: At top level:
drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
  .remount_fs = erofs_remount,
                ^~~~~~~~~~~~~

Caused by various commits creating erofs in the staging tree interacting
with various commits redoing the mount infrastructure in the vfs tree.

I have disabed CONFIG_EROFS_FS for now:"

The reason of compiling error is:

Since -next collects and merges developing patches including common vfs
stuff from multi-trees, but those patches didn't cover erofs, such as:

('vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=109b45090d7d3ce2797bb1ef7f70eead5bfe0ff3

("vfs: Require specification of size of mount data for internal mounts")
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0a191e4505a4f255e6513b49426213da69bf0e80

Above vfs related patches has not been merged in staging tree, if we
submit those erofs patches to staging mailing list and after including
them in staging-{test,nexts} tree, it can easily cause compiling error.

We worked out some patches to adjust those vfs change, but now we just
submit them to -next tree temporarily to avoid compiling error.

For potentail conflict in between erofs and vfs changes in incoming
merge window, Stephen suggested that we can disable CONFIG_EROFS_FS
temporarily to pass merge window, and after that we can do restore by
reenabling CONFIG_EROFS_FS and applying those fixing patches. Also
Greg confirmed this solution.

So, let's disable compiling erofs for a while.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 663b755bf2fb..96f614934df1 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -2,7 +2,7 @@
 
 config EROFS_FS
 	tristate "EROFS filesystem support"
-	depends on BLOCK
+	depends on BROKEN
 	help
 	  EROFS(Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
-- 
2.18.0.rc1

