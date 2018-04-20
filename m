Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeDTQed (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:34:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48271 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbeDTQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:34:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T.Z-jf-_1524242039;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: kirill.shutemov@linux.intel.com, hughd@google.com, hch@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 PATCH] mm: shmem: make stat.st_blksize return huge page size if THP is on
Date: Sat, 21 Apr 2018 00:33:59 +0800
Message-Id: <1524242039-64997-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
filesystem with huge page support anymore. tmpfs can use huge page via
THP when mounting by "huge=" mount option.

When applications use huge page on hugetlbfs, it just need check the
filesystem magic number, but it is not enough for tmpfs. Make
stat.st_blksize return huge page size if it is mounted by appropriate
"huge=" option.

Some applications could benefit from this change, for example QEMU.
When use mmap file as guest VM backend memory, QEMU typically mmap the
file size plus one extra page. If the file is on hugetlbfs the extra
page is huge page size (i.e. 2MB), but it is still 4KB on tmpfs even
though THP is enabled. tmpfs THP requires VMA is huge page aligned, so
if 4KB page is used THP will not be used at all. The below /proc/meminfo
fragment shows the THP use of QEMU with 4K page:

ShmemHugePages:   679936 kB
ShmemPmdMapped:        0 kB

By reading st_blksize, tmpfs can use huge page, then /proc/meminfo looks
like:

ShmemHugePages:    77824 kB
ShmemPmdMapped:     6144 kB

statfs.f_bsize still returns 4KB for tmpfs since THP could be split, and it
also may fallback to 4KB page silently if there is not enough huge page.
Furthermore, different f_bsize makes max_blocks and free_blocks
calculation harder but without too much benefit. Returning huge page
size via stat.st_blksize sounds good enough.

Since PUD size huge page for THP has not been supported, now it just
returns HPAGE_PMD_SIZE.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
v2 --> v1:
* Adopted the suggestion from hch to return huge page size via st_blksize
  instead of creating a new flag.

 mm/shmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b859192..3704258 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
 
 static struct vfsmount *shm_mnt;
+static bool is_huge = false;
 
 #ifdef CONFIG_SHMEM
 /*
@@ -995,6 +996,8 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		spin_unlock_irq(&info->lock);
 	}
 	generic_fillattr(inode, stat);
+	if (is_huge)
+		stat->blksize = HPAGE_PMD_SIZE;
 	return 0;
 }
 
@@ -3574,6 +3577,7 @@ static int shmem_parse_options(char *options, struct shmem_sb_info *sbinfo,
 					huge != SHMEM_HUGE_NEVER)
 				goto bad_val;
 			sbinfo->huge = huge;
+			is_huge = true;
 #endif
 #ifdef CONFIG_NUMA
 		} else if (!strcmp(this_char,"mpol")) {
-- 
1.8.3.1
