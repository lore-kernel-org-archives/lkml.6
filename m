Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161030AbeBNRPd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:15:33 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40545 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033317AbeBNRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:15:30 -0500
X-Google-Smtp-Source: AH8x224n+L0lTbJqDz6CzshDls2rZjY5JFL3jtHyL2imIiPnhDbCzcGx90m8yYjGtnxsZmZQMkI4jA==
Date: Wed, 14 Feb 2018 11:15:16 -0600
From: Dennis Zhou <dennisszhou@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Subject: Re: lost connection to test machine (4)
Message-ID: <20180214171516.GA64980@localhost.attlocal.net>
References: <001a113f8734783e94056505f8fd@google.com>
 <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
 <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 06:00:13PM +0100, Daniel Borkmann wrote:
> 
> [ +Dennis, +Tejun ]
> 
> Looks like we're stuck in percpu allocator with key/value size of 4 bytes
> each and large number of entries (max_entries) in the reproducer in above
> link.
> 
> Could we have some __GFP_NORETRY semantics and let allocations fail instead
> of triggering OOM killer?

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git master

As I don't have a great idea how to best test this, I'm going to just
run it against syzbot. Locally simple allocation tests seem fine. Though
it may require the second patch as well to enable pass through of the
following flags.

I will send a patchset if the syzbot results look good. This changes the
balance path to use __GFP_NORETRY and __GFP_NOWARN.

Thanks,
Dennis

---
 mm/percpu-km.c |  8 ++++----
 mm/percpu-vm.c | 18 +++++++++++-------
 mm/percpu.c    | 45 ++++++++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index d2a7664..0d88d7b 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -34,7 +34,7 @@
 #include <linux/log2.h>
 
 static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
-			       int page_start, int page_end)
+			       int page_start, int page_end, gfp_t gfp)
 {
 	return 0;
 }
@@ -45,18 +45,18 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 	/* nada */
 }
 
-static struct pcpu_chunk *pcpu_create_chunk(void)
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 {
 	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
 	struct pcpu_chunk *chunk;
 	struct page *pages;
 	int i;
 
-	chunk = pcpu_alloc_chunk();
+	chunk = pcpu_alloc_chunk(gfp);
 	if (!chunk)
 		return NULL;
 
-	pages = alloc_pages(GFP_KERNEL, order_base_2(nr_pages));
+	pages = alloc_pages(gfp | GFP_KERNEL, order_base_2(nr_pages));
 	if (!pages) {
 		pcpu_free_chunk(chunk);
 		return NULL;
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 9158e5a..ea9906a 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -37,7 +37,7 @@ static struct page **pcpu_get_pages(void)
 	lockdep_assert_held(&pcpu_alloc_mutex);
 
 	if (!pages)
-		pages = pcpu_mem_zalloc(pages_size);
+		pages = pcpu_mem_zalloc(pages_size, 0);
 	return pages;
 }
 
@@ -73,18 +73,21 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
  * @pages: array to put the allocated pages into, indexed by pcpu_page_idx()
  * @page_start: page index of the first page to be allocated
  * @page_end: page index of the last page to be allocated + 1
+ * @gfp: allocation flags passed to the underlying allocator
  *
  * Allocate pages [@page_start,@page_end) into @pages for all units.
  * The allocation is for @chunk.  Percpu core doesn't care about the
  * content of @pages and will pass it verbatim to pcpu_map_pages().
  */
 static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
-			    struct page **pages, int page_start, int page_end)
+			    struct page **pages, int page_start, int page_end,
+			    gfp_t gfp)
 {
-	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM;
 	unsigned int cpu, tcpu;
 	int i;
 
+	gfp |=  GFP_KERNEL | __GFP_HIGHMEM;
+
 	for_each_possible_cpu(cpu) {
 		for (i = page_start; i < page_end; i++) {
 			struct page **pagep = &pages[pcpu_page_idx(cpu, i)];
@@ -262,6 +265,7 @@ static void pcpu_post_map_flush(struct pcpu_chunk *chunk,
  * @chunk: chunk of interest
  * @page_start: the start page
  * @page_end: the end page
+ * @gfp: allocation flags passed to the underlying memory allocator
  *
  * For each cpu, populate and map pages [@page_start,@page_end) into
  * @chunk.
@@ -270,7 +274,7 @@ static void pcpu_post_map_flush(struct pcpu_chunk *chunk,
  * pcpu_alloc_mutex, does GFP_KERNEL allocation.
  */
 static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
-			       int page_start, int page_end)
+			       int page_start, int page_end, gfp_t gfp)
 {
 	struct page **pages;
 
@@ -278,7 +282,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 	if (!pages)
 		return -ENOMEM;
 
-	if (pcpu_alloc_pages(chunk, pages, page_start, page_end))
+	if (pcpu_alloc_pages(chunk, pages, page_start, page_end, gfp))
 		return -ENOMEM;
 
 	if (pcpu_map_pages(chunk, pages, page_start, page_end)) {
@@ -325,12 +329,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 	pcpu_free_pages(chunk, pages, page_start, page_end);
 }
 
-static struct pcpu_chunk *pcpu_create_chunk(void)
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 {
 	struct pcpu_chunk *chunk;
 	struct vm_struct **vms;
 
-	chunk = pcpu_alloc_chunk();
+	chunk = pcpu_alloc_chunk(gfp);
 	if (!chunk)
 		return NULL;
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf..ecb9193 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -447,10 +447,12 @@ static void pcpu_next_fit_region(struct pcpu_chunk *chunk, int alloc_bits,
 /**
  * pcpu_mem_zalloc - allocate memory
  * @size: bytes to allocate
+ * @gfp: allocation flags
  *
  * Allocate @size bytes.  If @size is smaller than PAGE_SIZE,
- * kzalloc() is used; otherwise, vzalloc() is used.  The returned
- * memory is always zeroed.
+ * kzalloc() is used; otherwise, the equivalent of vzalloc() is used.
+ * This is to facilitate passing through flags such as __GFP_NOREPLY.
+ * The returned memory is always zeroed.
  *
  * CONTEXT:
  * Does GFP_KERNEL allocation.
@@ -458,15 +460,16 @@ static void pcpu_next_fit_region(struct pcpu_chunk *chunk, int alloc_bits,
  * RETURNS:
  * Pointer to the allocated area on success, NULL on failure.
  */
-static void *pcpu_mem_zalloc(size_t size)
+static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
 {
 	if (WARN_ON_ONCE(!slab_is_available()))
 		return NULL;
 
 	if (size <= PAGE_SIZE)
-		return kzalloc(size, GFP_KERNEL);
+		return kzalloc(size, gfp | GFP_KERNEL);
 	else
-		return vzalloc(size);
+		return __vmalloc(size, gfp | GFP_KERNEL | __GFP_ZERO,
+				 PAGE_KERNEL);
 }
 
 /**
@@ -1154,12 +1157,12 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 	return chunk;
 }
 
-static struct pcpu_chunk *pcpu_alloc_chunk(void)
+static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 {
 	struct pcpu_chunk *chunk;
 	int region_bits;
 
-	chunk = pcpu_mem_zalloc(pcpu_chunk_struct_size);
+	chunk = pcpu_mem_zalloc(pcpu_chunk_struct_size, gfp);
 	if (!chunk)
 		return NULL;
 
@@ -1168,17 +1171,17 @@ static struct pcpu_chunk *pcpu_alloc_chunk(void)
 	region_bits = pcpu_chunk_map_bits(chunk);
 
 	chunk->alloc_map = pcpu_mem_zalloc(BITS_TO_LONGS(region_bits) *
-					   sizeof(chunk->alloc_map[0]));
+					   sizeof(chunk->alloc_map[0]), gfp);
 	if (!chunk->alloc_map)
 		goto alloc_map_fail;
 
 	chunk->bound_map = pcpu_mem_zalloc(BITS_TO_LONGS(region_bits + 1) *
-					   sizeof(chunk->bound_map[0]));
+					   sizeof(chunk->bound_map[0]), gfp);
 	if (!chunk->bound_map)
 		goto bound_map_fail;
 
 	chunk->md_blocks = pcpu_mem_zalloc(pcpu_chunk_nr_blocks(chunk) *
-					   sizeof(chunk->md_blocks[0]));
+					   sizeof(chunk->md_blocks[0]), gfp);
 	if (!chunk->md_blocks)
 		goto md_blocks_fail;
 
@@ -1277,9 +1280,10 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
  * pcpu_addr_to_page		- translate address to physical address
  * pcpu_verify_alloc_info	- check alloc_info is acceptable during init
  */
-static int pcpu_populate_chunk(struct pcpu_chunk *chunk, int off, int size);
+static int pcpu_populate_chunk(struct pcpu_chunk *chunk, int off, int size,
+			       gfp_t gfp);
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk, int off, int size);
-static struct pcpu_chunk *pcpu_create_chunk(void);
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
 static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
 static struct page *pcpu_addr_to_page(void *addr);
 static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai);
@@ -1421,7 +1425,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	}
 
 	if (list_empty(&pcpu_slot[pcpu_nr_slots - 1])) {
-		chunk = pcpu_create_chunk();
+		chunk = pcpu_create_chunk(0);
 		if (!chunk) {
 			err = "failed to allocate new chunk";
 			goto fail;
@@ -1450,7 +1454,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 					   page_start, page_end) {
 			WARN_ON(chunk->immutable);
 
-			ret = pcpu_populate_chunk(chunk, rs, re);
+			ret = pcpu_populate_chunk(chunk, rs, re, 0);
 
 			spin_lock_irqsave(&pcpu_lock, flags);
 			if (ret) {
@@ -1561,10 +1565,17 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
  * pcpu_balance_workfn - manage the amount of free chunks and populated pages
  * @work: unused
  *
- * Reclaim all fully free chunks except for the first one.
+ * Reclaim all fully free chunks except for the first one.  This is also
+ * responsible for maintaining the pool of empty populated pages.  However,
+ * it is possible that this is called when physical memory is scarce causing
+ * OOM killer to be triggered.  We should avoid doing so until an actual
+ * allocation causes the failure as it is possible that requests can be
+ * serviced from already backed regions.
  */
 static void pcpu_balance_workfn(struct work_struct *work)
 {
+	/* gfp flags passed to underlying allocators */
+	gfp_t gfp = __GFP_NOWARN | __GFP_NORETRY;
 	LIST_HEAD(to_free);
 	struct list_head *free_head = &pcpu_slot[pcpu_nr_slots - 1];
 	struct pcpu_chunk *chunk, *next;
@@ -1645,7 +1656,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
 					   chunk->nr_pages) {
 			int nr = min(re - rs, nr_to_pop);
 
-			ret = pcpu_populate_chunk(chunk, rs, rs + nr);
+			ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
 			if (!ret) {
 				nr_to_pop -= nr;
 				spin_lock_irq(&pcpu_lock);
@@ -1662,7 +1673,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
 
 	if (nr_to_pop) {
 		/* ran out of chunks to populate, create a new one and retry */
-		chunk = pcpu_create_chunk();
+		chunk = pcpu_create_chunk(gfp);
 		if (chunk) {
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_relocate(chunk, -1);
-- 
1.8.3.1
