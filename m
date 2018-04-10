Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeDJXw2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:52:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45108 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeDJXw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:52:27 -0400
Subject: Re: [PATCH v3 2/3] mm/shmem: update file sealing comments and file
 checking
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180409230505.18953-1-mike.kravetz@oracle.com>
 <20180409230505.18953-3-mike.kravetz@oracle.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b03b3f04-638f-2262-8bda-2291ea8cad26@oracle.com>
Date: Tue, 10 Apr 2018 16:51:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180409230505.18953-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In response to Matthew's question about patch 3, I went back and cleaned
up all comments, definitions and function names that will be moved to the
new memfd files.  No functional changes from previous version.  This will
require a new version of patch 3.

>From f9f98e0d6fd87af4b48befbad757467f834a868c Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 9 Apr 2018 13:04:38 -0700
Subject: [PATCH 2/3] mm/shmem: update file sealing comments and file checking

In preparation for memfd code restructure, update comments,
definitions and function names dealing with file sealing to
indicate that tmpfs and hugetlbfs are the supported filesystems.
Also, change file pointer checks in memfd_file_seals_ptr
to use defined interfaces instead of directly referencing
file_operation structs.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/shmem.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c7bad16fe884..a8bff40a10cd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2621,12 +2621,13 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 
 /*
  * We need a tag: a new tag would expand every radix_tree_node by 8 bytes,
- * so reuse a tag which we firmly believe is never set or cleared on shmem.
+ * so reuse a tag which we firmly believe is never set or cleared on tmpfs
+ * or hugetlbfs because they are memory only filesystems.
  */
-#define SHMEM_TAG_PINNED        PAGECACHE_TAG_TOWRITE
+#define MEMFD_TAG_PINNED        PAGECACHE_TAG_TOWRITE
 #define LAST_SCAN               4       /* about 150ms max */
 
-static void shmem_tag_pins(struct address_space *mapping)
+static void memfd_tag_pins(struct address_space *mapping)
 {
 	struct radix_tree_iter iter;
 	void __rcu **slot;
@@ -2647,7 +2648,7 @@ static void shmem_tag_pins(struct address_space *mapping)
 		} else if (page_count(page) - page_mapcount(page) > 1) {
 			spin_lock_irq(&mapping->tree_lock);
 			radix_tree_tag_set(&mapping->page_tree, iter.index,
-					   SHMEM_TAG_PINNED);
+					   MEMFD_TAG_PINNED);
 			spin_unlock_irq(&mapping->tree_lock);
 		}
 
@@ -2668,7 +2669,7 @@ static void shmem_tag_pins(struct address_space *mapping)
  * The caller must guarantee that no new user will acquire writable references
  * to those pages to avoid races.
  */
-static int shmem_wait_for_pins(struct address_space *mapping)
+static int memfd_wait_for_pins(struct address_space *mapping)
 {
 	struct radix_tree_iter iter;
 	void __rcu **slot;
@@ -2676,11 +2677,11 @@ static int shmem_wait_for_pins(struct address_space *mapping)
 	struct page *page;
 	int error, scan;
 
-	shmem_tag_pins(mapping);
+	memfd_tag_pins(mapping);
 
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
-		if (!radix_tree_tagged(&mapping->page_tree, SHMEM_TAG_PINNED))
+		if (!radix_tree_tagged(&mapping->page_tree, MEMFD_TAG_PINNED))
 			break;
 
 		if (!scan)
@@ -2691,7 +2692,7 @@ static int shmem_wait_for_pins(struct address_space *mapping)
 		start = 0;
 		rcu_read_lock();
 		radix_tree_for_each_tagged(slot, &mapping->page_tree, &iter,
-					   start, SHMEM_TAG_PINNED) {
+					   start, MEMFD_TAG_PINNED) {
 
 			page = radix_tree_deref_slot(slot);
 			if (radix_tree_exception(page)) {
@@ -2718,7 +2719,7 @@ static int shmem_wait_for_pins(struct address_space *mapping)
 
 			spin_lock_irq(&mapping->tree_lock);
 			radix_tree_tag_clear(&mapping->page_tree,
-					     iter.index, SHMEM_TAG_PINNED);
+					     iter.index, MEMFD_TAG_PINNED);
 			spin_unlock_irq(&mapping->tree_lock);
 continue_resched:
 			if (need_resched()) {
@@ -2734,11 +2735,11 @@ static int shmem_wait_for_pins(struct address_space *mapping)
 
 static unsigned int *memfd_file_seals_ptr(struct file *file)
 {
-	if (file->f_op == &shmem_file_operations)
+	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
 
 #ifdef CONFIG_HUGETLBFS
-	if (file->f_op == &hugetlbfs_file_operations)
+	if (is_file_hugepages(file))
 		return &HUGETLBFS_I(file_inode(file))->seals;
 #endif
 
@@ -2758,16 +2759,17 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 
 	/*
 	 * SEALING
-	 * Sealing allows multiple parties to share a shmem-file but restrict
-	 * access to a specific subset of file operations. Seals can only be
-	 * added, but never removed. This way, mutually untrusted parties can
-	 * share common memory regions with a well-defined policy. A malicious
-	 * peer can thus never perform unwanted operations on a shared object.
+	 * Sealing allows multiple parties to share a tmpfs or hugetlbfs file
+	 * but restrict access to a specific subset of file operations. Seals
+	 * can only be added, but never removed. This way, mutually untrusted
+	 * parties can share common memory regions with a well-defined policy.
+	 * A malicious peer can thus never perform unwanted operations on a
+	 * shared object.
 	 *
-	 * Seals are only supported on special shmem-files and always affect
-	 * the whole underlying inode. Once a seal is set, it may prevent some
-	 * kinds of access to the file. Currently, the following seals are
-	 * defined:
+	 * Seals are only supported on special tmpfs or hugetlbfs files and
+	 * always affect the whole underlying inode. Once a seal is set, it
+	 * may prevent some kinds of access to the file. Currently, the
+	 * following seals are defined:
 	 *   SEAL_SEAL: Prevent further seals from being set on this file
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
@@ -2781,9 +2783,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 * added.
 	 *
 	 * Semantics of sealing are only defined on volatile files. Only
-	 * anonymous shmem files support sealing. More importantly, seals are
-	 * never written to disk. Therefore, there's no plan to support it on
-	 * other file types.
+	 * anonymous tmpfs and hugetlbfs files support sealing. More
+	 * importantly, seals are never written to disk. Therefore, there's
+	 * no plan to support it on other file types.
 	 */
 
 	if (!(file->f_mode & FMODE_WRITE))
@@ -2809,7 +2811,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		if (error)
 			goto unlock;
 
-		error = shmem_wait_for_pins(file->f_mapping);
+		error = memfd_wait_for_pins(file->f_mapping);
 		if (error) {
 			mapping_allow_writable(file->f_mapping);
 			goto unlock;
-- 
2.13.6
