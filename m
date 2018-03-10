Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeCJSUw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:20:52 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35548 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeCJSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:47 -0500
X-Google-Smtp-Source: AG47ELtJbqcQFzn42WT51zByu52Z6IDueQQKBXyo5ZpExq/Jhcwxu6zPxOgcWW74dBoNcQmD0tkg8w==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 25/83] Support get normal inode address and inode table extentsion.
Date: Sat, 10 Mar 2018 10:18:06 -0800
Message-Id: <1520705944-6723-26-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Inodes are assigned to per-CPU inode tables in a round-robin way:

If there are four cores, then

CPU 0's inode table contains inode 0, inode 4, inode 8, ...
CPU 1's inode table contains inode 1, inode 5, inode 9, ...
CPU 2's inode table contains inode 2, inode 6, inode 10, ...
CPU 3's inode table contains inode 3, inode 7, inode 11, ...

So given an inode number, the inode table and inode position
can be easily calculated.

If NOVA runs out of 2MB inode table size, it will allocate a new
2MB log page and links it to the tail of the previous inode table.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
index 42816ff..4e2842d 100644
--- a/fs/nova/inode.c
+++ b/fs/nova/inode.c
@@ -167,18 +167,81 @@ static int nova_read_inode(struct super_block *sb, struct inode *inode,
 	return ret;
 }
 
-/* Get the address in PMEM of an inode by inode number.  Allocate additional
+/*
+ * Get the address in PMEM of an inode by inode number.  Allocate additional
  * block to store additional inodes if necessary.
  */
 int nova_get_inode_address(struct super_block *sb, u64 ino,
 	u64 *pi_addr, int extendable)
 {
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct nova_inode_info_header sih;
+	struct inode_table *inode_table;
+	unsigned int data_bits;
+	unsigned int num_inodes_bits;
+	u64 curr;
+	unsigned int superpage_count;
+	u64 internal_ino;
+	int cpuid;
+	int extended = 0;
+	unsigned int index;
+	unsigned int i = 0;
+	unsigned long blocknr;
+	unsigned long curr_addr;
+	int allocated;
+
 	if (ino < NOVA_NORMAL_INODE_START) {
 		*pi_addr = nova_get_reserved_inode_addr(sb, ino);
 		return 0;
 	}
 
-	*pi_addr = 0;
+	sih.ino = NOVA_INODETABLE_INO;
+	sih.i_blk_type = NOVA_BLOCK_TYPE_2M;
+	data_bits = blk_type_to_shift[sih.i_blk_type];
+	num_inodes_bits = data_bits - NOVA_INODE_BITS;
+
+	cpuid = ino % sbi->cpus;
+	internal_ino = ino / sbi->cpus;
+
+	inode_table = nova_get_inode_table(sb, cpuid);
+	superpage_count = internal_ino >> num_inodes_bits;
+	index = internal_ino & ((1 << num_inodes_bits) - 1);
+
+	curr = inode_table->log_head;
+	if (curr == 0)
+		return -EINVAL;
+
+	for (i = 0; i < superpage_count; i++) {
+		if (curr == 0)
+			return -EINVAL;
+
+		curr_addr = (unsigned long)nova_get_block(sb, curr);
+		/* Next page pointer in the last 8 bytes of the superpage */
+		curr_addr += nova_inode_blk_size(&sih) - 8;
+		curr = *(u64 *)(curr_addr);
+
+		if (curr == 0) {
+			if (extendable == 0)
+				return -EINVAL;
+
+			extended = 1;
+
+			allocated = nova_new_log_blocks(sb, &sih, &blocknr,
+				1, ALLOC_INIT_ZERO, cpuid, ALLOC_FROM_HEAD);
+
+			if (allocated != 1)
+				return allocated;
+
+			curr = nova_get_block_off(sb, blocknr,
+						NOVA_BLOCK_TYPE_2M);
+			*(u64 *)(curr_addr) = curr;
+			nova_flush_buffer((void *)curr_addr,
+						NOVA_INODE_SIZE, 1);
+		}
+	}
+
+	*pi_addr = curr + index * NOVA_INODE_SIZE;
+
 	return 0;
 }
 
-- 
2.7.4
