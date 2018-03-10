Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeCJSgi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:36:38 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39698 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeCJSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:58 -0500
X-Google-Smtp-Source: AG47ELsIzvy01pfw5tWHQuT9GTUHxLjVpA6ZyxZPIU6FpANGbt/NdPt2TywOLHnoStd76XY6yY987w==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 34/83] Journal: NOVA light weight journal definitions.
Date: Sat, 10 Mar 2018 10:18:15 -0800
Message-Id: <1520705944-6723-35-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA uses per-CPU lite journals to provide fast atomicity guarantees
for multi-log appending and multi-word inplace updates.

NOVA uses undo journaling. Each journal is a circular buffer
of 4KB pmem page. Two pointers, journal_head and journal_tail
reside in the reserved journal block, and point to the journal page.
If the two pointers are not equal, there are uncommitted transactions
and NOVA recovers the data by replaying the journal entries.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/bbuild.c  |  1 +
 fs/nova/journal.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/nova/log.c     |  1 +
 fs/nova/super.c   |  1 +
 4 files changed, 46 insertions(+)
 create mode 100644 fs/nova/journal.h

diff --git a/fs/nova/bbuild.c b/fs/nova/bbuild.c
index 66053cb..af1b352 100644
--- a/fs/nova/bbuild.c
+++ b/fs/nova/bbuild.c
@@ -25,6 +25,7 @@
 #include <linux/random.h>
 #include <linux/delay.h>
 #include "nova.h"
+#include "journal.h"
 #include "super.h"
 #include "inode.h"
 
diff --git a/fs/nova/journal.h b/fs/nova/journal.h
new file mode 100644
index 0000000..d1d0ffb
--- /dev/null
+++ b/fs/nova/journal.h
@@ -0,0 +1,43 @@
+#ifndef __JOURNAL_H
+#define __JOURNAL_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include "nova.h"
+#include "super.h"
+
+
+/* ======================= Lite journal ========================= */
+
+#define NOVA_MAX_JOURNAL_LENGTH 128
+
+#define	JOURNAL_INODE	1
+#define	JOURNAL_ENTRY	2
+
+/* Lightweight journal entry */
+struct nova_lite_journal_entry {
+	__le64 type;       // JOURNAL_INODE or JOURNAL_ENTRY
+	__le64 data1;
+	__le64 data2;
+	__le32 padding;
+	__le32 csum;
+} __attribute((__packed__));
+
+/* Head and tail pointers into a circular queue of journal entries.  There's
+ * one of these per CPU.
+ */
+struct journal_ptr_pair {
+	__le64 journal_head;
+	__le64 journal_tail;
+};
+
+static inline
+struct journal_ptr_pair *nova_get_journal_pointers(struct super_block *sb,
+	int cpu)
+{
+	return (struct journal_ptr_pair *)((char *)nova_get_block(sb,
+		NOVA_DEF_BLOCK_SIZE_4K * JOURNAL_START) + cpu * CACHELINE_SIZE);
+}
+
+
+#endif
diff --git a/fs/nova/log.c b/fs/nova/log.c
index bdd133e..f01b7c8 100644
--- a/fs/nova/log.c
+++ b/fs/nova/log.c
@@ -16,6 +16,7 @@
  */
 
 #include "nova.h"
+#include "journal.h"
 #include "inode.h"
 #include "log.h"
 
diff --git a/fs/nova/super.c b/fs/nova/super.c
index c0427fd..d73c202 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -38,6 +38,7 @@
 #include <linux/list.h>
 #include <linux/dax.h>
 #include "nova.h"
+#include "journal.h"
 #include "super.h"
 
 int measure_timing;
-- 
2.7.4
