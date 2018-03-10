Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCJSU2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32994 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbeCJSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:24 -0500
X-Google-Smtp-Source: AG47ELv4bTPLYwlmEo7IH3tMaYE9q/UrGkRq8GNBt2iOl+eHL6UyJJIZBEu2+UrOwM0Io7HqEVzlww==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 07/83] Initialize inode_info and rebuild inode information in nova_iget().
Date: Sat, 10 Mar 2018 10:17:48 -0800
Message-Id: <1520705944-6723-8-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Incomplete nova_rebuild_inode() implemenation.
nova_rebuild_inode() will go through the inode log and rebuild
radix tree and metadata. Leave for later patches.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/bbuild.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/bbuild.h  |  7 +++++++
 fs/nova/inode.c   |  6 ++++++
 fs/nova/nova.h    | 10 ++++++++++
 fs/nova/rebuild.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 fs/nova/bbuild.c
 create mode 100644 fs/nova/bbuild.h
 create mode 100644 fs/nova/rebuild.c

diff --git a/fs/nova/bbuild.c b/fs/nova/bbuild.c
new file mode 100644
index 0000000..8bc0545
--- /dev/null
+++ b/fs/nova/bbuild.c
@@ -0,0 +1,53 @@
+/*
+ * NOVA Recovery routines.
+ *
+ * Copyright 2015-2016 Regents of the University of California,
+ * UCSD Non-Volatile Systems Lab, Andiry Xu <jix024@cs.ucsd.edu>
+ * Copyright 2012-2013 Intel Corporation
+ * Copyright 2009-2011 Marco Stornelli <marco.stornelli@gmail.com>
+ * Copyright 2003 Sony Corporation
+ * Copyright 2003 Matsushita Electric Industrial Co., Ltd.
+ * 2003-2004 (c) MontaVista Software, Inc. , Steve Longerbeam
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/fs.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include "nova.h"
+#include "super.h"
+#include "inode.h"
+
+void nova_init_header(struct super_block *sb,
+	struct nova_inode_info_header *sih, u16 i_mode)
+{
+	sih->log_pages = 0;
+	sih->i_size = 0;
+	sih->ino = 0;
+	sih->i_blocks = 0;
+	sih->pi_addr = 0;
+	INIT_RADIX_TREE(&sih->tree, GFP_ATOMIC);
+	sih->i_mode = i_mode;
+	sih->i_flags = 0;
+	sih->valid_entries = 0;
+	sih->num_entries = 0;
+	sih->last_setattr = 0;
+	sih->last_link_change = 0;
+	sih->last_dentry = 0;
+	sih->trans_id = 0;
+	sih->log_head = 0;
+	sih->log_tail = 0;
+	sih->i_blk_type = NOVA_DEFAULT_BLOCK_TYPE;
+	init_rwsem(&sih->i_sem);
+}
+
diff --git a/fs/nova/bbuild.h b/fs/nova/bbuild.h
new file mode 100644
index 0000000..162a832
--- /dev/null
+++ b/fs/nova/bbuild.h
@@ -0,0 +1,7 @@
+#ifndef __BBUILD_H
+#define __BBUILD_H
+
+void nova_init_header(struct super_block *sb,
+	struct nova_inode_info_header *sih, u16 i_mode);
+
+#endif
diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index bfdc5dc..f7d6410 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -158,6 +158,12 @@ struct inode *nova_iget(struct super_block *sb, unsigned long ino)
 		goto fail;
 	}
 
+	err = nova_rebuild_inode(sb, si, ino, pi_addr, 1);
+	if (err) {
+		nova_dbg("%s: failed to rebuild inode %lu\n", __func__, ino);
+		goto fail;
+	}
+
 	err = nova_read_inode(sb, inode, pi_addr);
 	if (unlikely(err)) {
 		nova_dbg("%s: failed to read inode %lu\n", __func__, ino);
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 5eb696c..ded9fe8 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -296,4 +296,14 @@ static inline u64 nova_get_epoch_id(struct super_block *sb)
 }
 
 #include "inode.h"
+#include "bbuild.h"
+
+/* ====================================================== */
+/* ==============  Function prototypes  ================= */
+/* ====================================================== */
+
+/* rebuild.c */
+int nova_rebuild_inode(struct super_block *sb, struct nova_inode_info *si,
+	u64 ino, u64 pi_addr, int rebuild_dir);
+
 #endif /* __NOVA_H */
diff --git a/fs/nova/rebuild.c b/fs/nova/rebuild.c
new file mode 100644
index 0000000..0595851
--- /dev/null
+++ b/fs/nova/rebuild.c
@@ -0,0 +1,48 @@
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Inode rebuild methods.
+ *
+ * Copyright 2015-2016 Regents of the University of California,
+ * UCSD Non-Volatile Systems Lab, Andiry Xu <jix024@cs.ucsd.edu>
+ * Copyright 2012-2013 Intel Corporation
+ * Copyright 2009-2011 Marco Stornelli <marco.stornelli@gmail.com>
+ * Copyright 2003 Sony Corporation
+ * Copyright 2003 Matsushita Electric Industrial Co., Ltd.
+ * 2003-2004 (c) MontaVista Software, Inc. , Steve Longerbeam
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include "nova.h"
+#include "inode.h"
+
+/* initialize nova inode header and other DRAM data structures */
+int nova_rebuild_inode(struct super_block *sb, struct nova_inode_info *si,
+	u64 ino, u64 pi_addr, int rebuild_dir)
+{
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode *pi;
+
+	pi = (struct nova_inode *)nova_get_block(sb, pi_addr);
+	// We need this valid in case we need to evict the inode.
+
+	nova_init_header(sb, sih, __le16_to_cpu(pi->i_mode));
+	sih->pi_addr = pi_addr;
+
+	if (pi->deleted == 1) {
+		nova_dbgv("%s: inode %llu has been deleted.\n", __func__, ino);
+		return -ESTALE;
+	}
+
+	nova_dbgv("%s: inode %llu, addr 0x%llx, valid %d, head 0x%llx, tail 0x%llx\n",
+			__func__, ino, pi_addr, pi->valid,
+			pi->log_head, pi->log_tail);
+
+	sih->ino = ino;
+
+	/* Traverse the log */
+	return 0;
+}
+
-- 
2.7.4
