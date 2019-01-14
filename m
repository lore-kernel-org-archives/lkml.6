Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF9B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfANLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfANLmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F1E8D1031F99B6B5CF33;
        Mon, 14 Jan 2019 19:41:59 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan 2019 19:41:53
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 1/5] staging: erofs: add document
Date:   Mon, 14 Jan 2019 19:40:22 +0800
Message-ID: <20190114114026.11728-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190114114026.11728-1-gaoxiang25@huawei.com>
References: <20190114114026.11728-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents key feature, usage, and on-disk design of erofs.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 .../erofs/Documentation/filesystems/erofs.txt      | 195 +++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 drivers/staging/erofs/Documentation/filesystems/erofs.txt

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
new file mode 100644
index 000000000000..2e1bda8b5f83
--- /dev/null
+++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
@@ -0,0 +1,195 @@
+Overview
+========
+
+EROFS file-system stands for Enhanced Read-Only File System. Different
+from other read-only file systems, it aims to be designed for flexibility,
+scalability, but be kept simple and high performance.
+
+Here is the main features of EROFS:
+ - Little endian on-disk design;
+
+ - Currently 4KB block size (nobh) and therefore maximum 16TB address space;
+
+ - Metadata & data could be mixed by design;
+
+ - 2 inode versions for different requirements:
+                          v1            v2
+   Inode metadata size:   32 bytes      64 bytes
+   Max file size:         4 GB          16 EB (also limited by max. vol size)
+   Max uids/gids:         65536         4294967296
+   File creation time:    no            yes (64 + 32-bit timestamp)
+   Max hardlinks:         65536         4294967296
+   Metadata reserved:     4 bytes       14 bytes
+
+ - Support extended attributes (xattrs)
+
+ - Support xattr inline and tail-end data inline for all files;
+
+ - Support transparent file compression as an option:
+   LZ4 algorithm with 4 KB fixed-output compression for high performance;
+
+The following git tree provides the file system user-space tools under
+development (ex, formatting tool mkfs.erofs):
+>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+Bugs and patches are welcome, please kindly help us and send to the following
+linux-erofs mailing list:
+>> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
+
+Note that EROFS is still working in progress as a Linux staging driver,
+Cc the staging mailing list as well is highly recommended:
+>> Linux Driver Project Developer List <devel@driverdev.osuosl.org>
+
+Mount options
+=============
+
+fault_injection=%d     Enable fault injection in all supported types with
+                       specified injection rate. Supported injection type:
+                       Type_Name                Type_Value
+                       FAULT_KMALLOC            0x000000001
+(no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
+                       by default if CONFIG_EROFS_FS_XATTR is selected.
+(no)acl                Setup POSIX Access Control List. Note: acl is enabled
+                       by default if CONFIG_EROFS_FS_POSIX_ACL is selected.
+
+On-disk details
+===============
+
+Summary
+-------
+Different from other read-only file systems, an EROFS volume is designed
+to be as simple as possible:
+
+                                |-> aligned with the block size
+   ____________________________________________________________
+  | |SB| | ... | Metadata | ... | Data | Metadata | ... | Data |
+  |_|__|_|_____|__________|_____|______|__________|_____|______|
+  0 +1K
+
+All data areas should be aligned with the block size, but metadata areas
+may not. All metadatas can be now observed in two different spaces (views):
+ 1. Inode metadata space
+    Each valid inode should be aligned with an inode slot, which is a fixed
+    value (32 bytes) and designed to be kept in line with v1 inode size.
+
+    Each inode can be directly found with the following formula:
+         inode offset = meta_blkaddr * block_size + 32 * nid
+
+                                |-> aligned with 8B
+                                           |-> followed closely
+    + meta_blkaddr blocks                                      |-> another slot
+     _____________________________________________________________________
+    |  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
+    |________|_______|(optional)|(optional)|__(optional)_|_____|__________
+             |-> aligned with the inode slot size
+                  .                   .
+                .                         .
+              .                              .
+            .                                    .
+          .                                         .
+        .                                              .
+      .____________________________________________________|-> aligned with 4B
+      | xattr_ibody_header | shared xattrs | inline xattrs |
+      |____________________|_______________|_______________|
+      |->    12 bytes    <-|->x * 4 bytes<-|               .
+                          .                .                 .
+                    .                      .                   .
+               .                           .                     .
+           ._______________________________.______________________.
+           | id | id | id | id |  ... | id | ent | ... | ent| ... |
+           |____|____|____|____|______|____|_____|_____|____|_____|
+                                           |-> aligned with 4B
+                                                       |-> aligned with 4B
+
+    Inode could be 32 or 64 bytes, which can be distinguished from a common
+    field which all inode versions have -- i_advise:
+
+        __________________               __________________
+       |     i_advise     |             |     i_advise     |
+       |__________________|             |__________________|
+       |        ...       |             |        ...       |
+       |                  |             |                  |
+       |__________________| 32 bytes    |                  |
+                                        |                  |
+                                        |__________________| 64 bytes
+
+    Xattrs, extents, data inline are followed by the corresponding inode with
+    proper alignes, and they could be optional for different data mappings,
+    _currently_ there are totally 3 valid data mappings supported:
+
+     1) flat file data without data inline (no extent);
+     2) fixed-output size data compression (must have extents);
+     3) flat file data with tail-end data inline (no extent);
+
+    The size of the optional xattrs is indicated by i_xattr_count in inode
+    header. Large xattrs or xattrs shared by many different files can be
+    stored in shared xattrs metadata rather than inlined right after inode.
+
+ 2. Shared xattrs metadata space
+    Shared xattrs space is similar to the above inode space, started with
+    a specific block indicated by xattr_blkaddr, organized one by one with
+    proper align.
+
+    Each share xattr can also be directly found by the following formula:
+         xattr offset = xattr_blkaddr * block_size + 4 * xattr_id
+
+                           |-> aligned by  4 bytes
+    + xattr_blkaddr blocks                     |-> aligned with 4 bytes
+     _________________________________________________________________________
+    |  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
+    |________|_____________|_____________|_____|______________|_______________
+
+Directories
+-----------
+All directories are now organized in a compact on-disk format. Note that
+each directory block is divided into index and name areas in order to support
+random file lookup, and all directory entries are _strictly_ recorded in
+alphabetical order in order to support improved prefix binary search
+algorithm (could refer to the related source code).
+
+                 ___________________________
+                /                           |
+               /              ______________|________________
+              /              /              | namelen1       | namelenN-1
+ ____________.______________._______________v________________v__________
+| dirent | dirent | ... | dirent | filename | filename | ... | filename |
+|___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
+     \                           ^
+      \                          |                           * could have
+       \                         |                             trailing '\0'
+        \________________________| namelen0
+
+                             Directory block
+
+Note that apart from the offset of the first filename, namelen0 also indicates
+the total number of directory entries in this block since it is no need to
+introduce another on-disk field at all.
+
+Compression
+-----------
+Currently, EROFS supports 4KB fixed-output clustersize transparent file
+compression, as illustrated below:
+
+         |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
+         clusterofs                      clusterofs            clusterofs
+         |                               |                     |   logical data
+_________v_______________________________v_____________________v_______________
+... |    .        |             |        .    |             |  .          | ...
+____|____.________|_____________|________.____|_____________|__.__________|____
+    |-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
+         size          size          size          size          size
+          .                             .                .                   .
+           .                       .               .                  .
+            .                  .              .                .
+      _______._____________._____________._____________._____________________
+         ... |             |             |             | ... physical data
+      _______|_____________|_____________|_____________|_____________________
+             |-> cluster <-|-> cluster <-|-> cluster <-|
+                  size          size          size
+
+Currently each on-disk physical cluster can contain 4KB (un)compressed data
+at most. For each logical cluster, there is a corresponding on-disk index to
+describe its cluster type, physical cluster address, el.
+
+See "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
+
-- 
2.14.4

