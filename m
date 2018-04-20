Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDTCcM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 22:32:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5963 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754003AbeDTCcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 22:32:10 -0400
From: heyunlei <heyunlei@huawei.com>
To: "Yuchao (T)" <yuchao0@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: RE: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
Thread-Topic: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
Thread-Index: AQHT2EpmA16STso0nECKEKKJWHu4ZqQI7Z9w
Date: Fri, 20 Apr 2018 02:30:04 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548377C3C@DGGEMA503-MBS.china.huawei.com>
References: <20180420015231.90679-1-yuchao0@huawei.com>
In-Reply-To: <20180420015231.90679-1-yuchao0@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.111.187.226]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Chao Yu [mailto:yuchao0@huawei.com]
>Sent: Friday, April 20, 2018 9:53 AM
>To: jaegeuk@kernel.org
>Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>Subject: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
>
>As most indirect node, dindirect node, and xattr node won't be updated
>after they are created, but inode node and other direct node will change
>more frequently, so store their nat entries mixedly in whole nat table
>will suffer:
>- fragment nat table soon due to different update rate
>- more nat block update due to fragmented nat table
>

BTW, should we enable this patch:  f2fs: reuse nids more aggressively?

I think it will decrease nat area fragment and will decrease io of nat?

>In order to solve above issue, we're trying to separate whole nat table to
>two part:
>a. Hot free nid area:
> - range: [nid #0, nid #x)
> - store node block address for
>   * inode node
>   * other direct node
>b. Cold free nid area:
> - range: [nid #x, max nid)
> - store node block address for
>   * indirect node
>   * dindirect node
>   * xattr node
>
>Allocation strategy example:
>
>Free nid: '-'
>Used nid: '='
>
>1. Initial status:
>Free Nids:	|-----------------------------------------------------------------------|
>		^		^					^		^
>Alloc Range:	|---------------|					|---------------|
>		hot_start	hot_end					cold_start	cold_end
>
>2. Free nids have ran out:
>Free Nids:	|===============-----------------------------------------===============|
>		^		^					^		^
>Alloc Range:	|===============|					|===============|
>		hot_start	hot_end					cold_start	cold_end
>
>3. Expand hot/cold area range:
>Free Nids:	|===============-----------------------------------------===============|
>		^				^	^				^
>Alloc Range:	|===============----------------|	|----------------===============|
>		hot_start			hot_end	cold_start			cold_end
>
>4. Hot free nids have ran out:
>Free Nids:	|===============================-------------------------===============|
>		^				^	^				^
>Alloc Range:	|===============================|	|----------------===============|
>		hot_start			hot_end	cold_start			cold_end
>
>5. Expand hot area range, hot/cold area boundary has been fixed:
>Free Nids:	|===============================-------------------------===============|
>		^					^				^
>Alloc Range:	|===============================--------|----------------===============|
>		hot_start				hot_end(cold_start)		cold_end
>
>Run xfstests with generic/*:
>
>before
>node_write:	169660
>cp_count:	60118
>node/cp		2.82
>
>after:
>node_write:	159145
>cp_count:	84501
>node/cp:	2.64
>
>Signed-off-by: Chao Yu <yuchao0@huawei.com>
>---
> fs/f2fs/checkpoint.c |   4 -
> fs/f2fs/debug.c      |   6 +-
> fs/f2fs/f2fs.h       |  19 +++-
> fs/f2fs/inode.c      |   2 +-
> fs/f2fs/namei.c      |   2 +-
> fs/f2fs/node.c       | 302 ++++++++++++++++++++++++++++++++-------------------
> fs/f2fs/node.h       |  17 +--
> fs/f2fs/segment.c    |   8 +-
> fs/f2fs/shrinker.c   |   3 +-
> fs/f2fs/xattr.c      |  10 +-
> 10 files changed, 221 insertions(+), 152 deletions(-)
>
>diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>index 96785ffc6181..c17feec72c74 100644
>--- a/fs/f2fs/checkpoint.c
>+++ b/fs/f2fs/checkpoint.c
>@@ -1029,14 +1029,10 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
> static void __prepare_cp_block(struct f2fs_sb_info *sbi)
> {
> 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>-	struct f2fs_nm_info *nm_i = NM_I(sbi);
>-	nid_t last_nid = nm_i->next_scan_nid;
>
>-	next_free_nid(sbi, &last_nid);
> 	ckpt->valid_block_count = cpu_to_le64(valid_user_blocks(sbi));
> 	ckpt->valid_node_count = cpu_to_le32(valid_node_count(sbi));
> 	ckpt->valid_inode_count = cpu_to_le32(valid_inode_count(sbi));
>-	ckpt->next_free_nid = cpu_to_le32(last_nid);
> }
>
> /*
>diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>index 7bb036a3bb81..b13c1d4f110f 100644
>--- a/fs/f2fs/debug.c
>+++ b/fs/f2fs/debug.c
>@@ -100,7 +100,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
> 	si->sits = MAIN_SEGS(sbi);
> 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
>-	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID];
>+	si->free_nids = NM_I(sbi)->nid_cnt[FREE_HOT_NID] +
>+				NM_I(sbi)->nid_cnt[FREE_COLD_NID];
> 	si->avail_nids = NM_I(sbi)->available_nids;
> 	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
> 	si->bg_gc = sbi->bg_gc;
>@@ -235,7 +236,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
> 	}
>
> 	/* free nids */
>-	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID] +
>+	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_HOT_NID] +
>+				NM_I(sbi)->nid_cnt[FREE_COLD_NID] +
> 				NM_I(sbi)->nid_cnt[PREALLOC_NID]) *
> 				sizeof(struct free_nid);
> 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
>diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>index de1af8dc19e5..9e2b4f84b1b2 100644
>--- a/fs/f2fs/f2fs.h
>+++ b/fs/f2fs/f2fs.h
>@@ -739,8 +739,11 @@ static inline void __try_update_largest_extent(struct inode *inode,
>  * For free nid management
>  */
> enum nid_state {
>-	FREE_NID,		/* newly added to free nid list */
>-	PREALLOC_NID,		/* it is preallocated */
>+	FREE_HOT_NID,			/* list with hot type free nids */
>+	FREE_COLD_NID,			/* list with cold type free nid */
>+	MAX_NID_TYPE,
>+	INVALID_NID_TYPE = MAX_NID_TYPE,
>+	PREALLOC_NID = MAX_NID_TYPE,	/* it is preallocated */
> 	MAX_NID_STATE,
> };
>
>@@ -764,8 +767,10 @@ struct f2fs_nm_info {
>
> 	/* free node ids management */
> 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
>-	struct list_head free_nid_list;		/* list for free nids excluding preallocated nids */
>+	struct list_head free_nid_list[MAX_NID_TYPE];	/* list for free nids excluding preallocated nids */
> 	unsigned int nid_cnt[MAX_NID_STATE];	/* the number of free node id */
>+	unsigned int nat_block_start[MAX_NID_TYPE];	/* nat block start position */
>+	unsigned int nat_block_end[MAX_NID_TYPE];	/* nat block end position */
> 	spinlock_t nid_list_lock;	/* protect nid lists ops */
> 	struct mutex build_lock;	/* lock for build free nids */
> 	unsigned char **free_nid_bitmap;
>@@ -2796,10 +2801,12 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> 			struct writeback_control *wbc, bool atomic);
> int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
> 			bool do_balance, enum iostat_type io_type);
>-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
>-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
>+bool build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount,
>+						enum nid_state state);
>+enum nid_state default_free_nid_type(struct f2fs_sb_info *sbi, nid_t nid);
>+int alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid, enum nid_state state);
> void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
>-void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
>+void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid, enum nid_state state);
> int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
> void recover_inline_xattr(struct inode *inode, struct page *page);
> int recover_xattr_data(struct inode *inode, struct page *page);
>diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>index 176f8e84bb6e..e9e1ee6c3ba1 100644
>--- a/fs/f2fs/inode.c
>+++ b/fs/f2fs/inode.c
>@@ -585,7 +585,7 @@ void f2fs_evict_inode(struct inode *inode)
> 			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> 	}
> 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
>-		alloc_nid_failed(sbi, inode->i_ino);
>+		alloc_nid_failed(sbi, inode->i_ino, FREE_HOT_NID);
> 		clear_inode_flag(inode, FI_FREE_NID);
> 	} else {
> 		f2fs_bug_on(sbi, err &&
>diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>index b5f404674cad..c049076c49e2 100644
>--- a/fs/f2fs/namei.c
>+++ b/fs/f2fs/namei.c
>@@ -37,7 +37,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
> 		return ERR_PTR(-ENOMEM);
>
> 	f2fs_lock_op(sbi);
>-	if (!alloc_nid(sbi, &ino)) {
>+	if (!alloc_nid(sbi, &ino, FREE_HOT_NID)) {
> 		f2fs_unlock_op(sbi);
> 		err = -ENOSPC;
> 		goto fail;
>diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>index bbf2c3441ac0..6b74bff5cdc1 100644
>--- a/fs/f2fs/node.c
>+++ b/fs/f2fs/node.c
>@@ -46,7 +46,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
> 	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
> 	 */
> 	if (type == FREE_NIDS) {
>-		mem_size = (nm_i->nid_cnt[FREE_NID] *
>+		mem_size = ((nm_i->nid_cnt[FREE_HOT_NID] +
>+				nm_i->nid_cnt[FREE_COLD_NID]) *
> 				sizeof(struct free_nid)) >> PAGE_SHIFT;
> 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
> 	} else if (type == NAT_ENTRIES) {
>@@ -651,10 +652,13 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
> 	/* get indirect or direct nodes */
> 	for (i = 1; i <= level; i++) {
> 		bool done = false;
>+		enum nid_state state;
>+
>+		state = (i == 1) ? FREE_HOT_NID : FREE_COLD_NID;
>
> 		if (!nids[i] && mode == ALLOC_NODE) {
> 			/* alloc new node */
>-			if (!alloc_nid(sbi, &(nids[i]))) {
>+			if (!alloc_nid(sbi, &(nids[i]), state)) {
> 				err = -ENOSPC;
> 				goto release_pages;
> 			}
>@@ -662,7 +666,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
> 			dn->nid = nids[i];
> 			npage[i] = new_node_page(dn, noffset[i]);
> 			if (IS_ERR(npage[i])) {
>-				alloc_nid_failed(sbi, nids[i]);
>+				alloc_nid_failed(sbi, nids[i], state);
> 				err = PTR_ERR(npage[i]);
> 				goto release_pages;
> 			}
>@@ -1796,10 +1800,9 @@ static int __insert_free_nid(struct f2fs_sb_info *sbi,
> 	if (err)
> 		return err;
>
>-	f2fs_bug_on(sbi, state != i->state);
> 	nm_i->nid_cnt[state]++;
>-	if (state == FREE_NID)
>-		list_add_tail(&i->list, &nm_i->free_nid_list);
>+	if (state < MAX_NID_TYPE)
>+		list_add_tail(&i->list, &nm_i->free_nid_list[state]);
> 	return 0;
> }
>
>@@ -1808,9 +1811,8 @@ static void __remove_free_nid(struct f2fs_sb_info *sbi,
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
>
>-	f2fs_bug_on(sbi, state != i->state);
> 	nm_i->nid_cnt[state]--;
>-	if (state == FREE_NID)
>+	if (state < MAX_NID_TYPE)
> 		list_del(&i->list);
> 	radix_tree_delete(&nm_i->free_nid_root, i->nid);
> }
>@@ -1820,7 +1822,6 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
>
>-	f2fs_bug_on(sbi, org_state != i->state);
> 	i->state = dst_state;
> 	nm_i->nid_cnt[org_state]--;
> 	nm_i->nid_cnt[dst_state]++;
>@@ -1829,8 +1830,9 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
> 	case PREALLOC_NID:
> 		list_del(&i->list);
> 		break;
>-	case FREE_NID:
>-		list_add_tail(&i->list, &nm_i->free_nid_list);
>+	case FREE_HOT_NID:
>+	case FREE_COLD_NID:
>+		list_add_tail(&i->list, &nm_i->free_nid_list[dst_state]);
> 		break;
> 	default:
> 		BUG_ON(1);
>@@ -1862,8 +1864,8 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
> }
>
> /* return if the nid is recognized as free */
>-static bool add_free_nid(struct f2fs_sb_info *sbi,
>-				nid_t nid, bool build, bool update)
>+static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build,
>+					bool update, enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	struct free_nid *i, *e;
>@@ -1877,7 +1879,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
>
> 	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
> 	i->nid = nid;
>-	i->state = FREE_NID;
>+	i->state = state;
>
> 	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
>
>@@ -1912,13 +1914,14 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
>
> 		e = __lookup_free_nid_list(nm_i, nid);
> 		if (e) {
>-			if (e->state == FREE_NID)
>+			if (e->state < MAX_NID_TYPE)
> 				ret = true;
> 			goto err_out;
> 		}
> 	}
> 	ret = true;
>-	err = __insert_free_nid(sbi, i, FREE_NID);
>+	if (state < MAX_NID_TYPE)
>+		err = __insert_free_nid(sbi, i, state);
> err_out:
> 	if (update) {
> 		update_free_nid_bitmap(sbi, nid, ret, build);
>@@ -1941,8 +1944,8 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>
> 	spin_lock(&nm_i->nid_list_lock);
> 	i = __lookup_free_nid_list(nm_i, nid);
>-	if (i && i->state == FREE_NID) {
>-		__remove_free_nid(sbi, i, FREE_NID);
>+	if (i && i->state < MAX_NID_TYPE) {
>+		__remove_free_nid(sbi, i, i->state);
> 		need_free = true;
> 	}
> 	spin_unlock(&nm_i->nid_list_lock);
>@@ -1951,36 +1954,33 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
> 		kmem_cache_free(free_nid_slab, i);
> }
>
>-static void scan_nat_page(struct f2fs_sb_info *sbi,
>-			struct page *nat_page, nid_t start_nid)
>+static void scan_nat_page(struct f2fs_sb_info *sbi, struct page *nat_page,
>+				unsigned int nat_ofs, enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	struct f2fs_nat_block *nat_blk = page_address(nat_page);
>-	block_t blk_addr;
>-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
>+	nid_t nid = nat_ofs * NAT_ENTRY_PER_BLOCK;
> 	int i;
>
> 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
>
>-	i = start_nid % NAT_ENTRY_PER_BLOCK;
>-
>-	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
>-		if (unlikely(start_nid >= nm_i->max_nid))
>-			break;
>+	for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++, nid++) {
>+		block_t blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
>
>-		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
> 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>+
> 		if (blk_addr == NULL_ADDR) {
>-			add_free_nid(sbi, start_nid, true, true);
>+			add_free_nid(sbi, nid, true, true, state);
> 		} else {
> 			spin_lock(&NM_I(sbi)->nid_list_lock);
>-			update_free_nid_bitmap(sbi, start_nid, false, true);
>+			update_free_nid_bitmap(sbi, nid, false, true);
> 			spin_unlock(&NM_I(sbi)->nid_list_lock);
> 		}
> 	}
> }
>
>-static void scan_curseg_cache(struct f2fs_sb_info *sbi)
>+static void scan_curseg_cache(struct f2fs_sb_info *sbi,
>+						enum nid_state state)
> {
> 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> 	struct f2fs_journal *journal = curseg->journal;
>@@ -1994,14 +1994,14 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
> 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
> 		nid = le32_to_cpu(nid_in_journal(journal, i));
> 		if (addr == NULL_ADDR)
>-			add_free_nid(sbi, nid, true, false);
>+			add_free_nid(sbi, nid, true, false, state);
> 		else
> 			remove_free_nid(sbi, nid);
> 	}
> 	up_read(&curseg->journal_rwsem);
> }
>
>-static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>+static void scan_free_nid_bits(struct f2fs_sb_info *sbi, enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	unsigned int i, idx;
>@@ -2010,6 +2010,9 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
> 	down_read(&nm_i->nat_tree_lock);
>
> 	for (i = 0; i < nm_i->nat_blocks; i++) {
>+		if (i < nm_i->nat_block_start[state] ||
>+				i >= nm_i->nat_block_end[state])
>+			continue;
> 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
> 			continue;
> 		if (!nm_i->free_nid_count[i])
>@@ -2021,90 +2024,124 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
> 				break;
>
> 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>-			add_free_nid(sbi, nid, true, false);
>+			add_free_nid(sbi, nid, true, false, state);
>
>-			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>+			if (nm_i->nid_cnt[state] >= MAX_FREE_NIDS)
> 				goto out;
> 		}
> 	}
> out:
>-	scan_curseg_cache(sbi);
>+	scan_curseg_cache(sbi, state);
>
> 	up_read(&nm_i->nat_tree_lock);
> }
>
>-static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>+void load_nat_block(struct f2fs_sb_info *sbi, enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
>-	int i = 0;
>-	nid_t nid = nm_i->next_scan_nid;
>+	unsigned int nat_ofs;
>+	unsigned int count = FREE_NID_PAGES;
>
>-	if (unlikely(nid >= nm_i->max_nid))
>-		nid = 0;
>+	if (state == FREE_HOT_NID) {
>+		nat_ofs = nm_i->nat_block_end[FREE_HOT_NID];
>+		nm_i->nat_block_end[FREE_HOT_NID] += count;
>+	} else {
>+		nm_i->nat_block_start[FREE_COLD_NID] -= count;
>+		nat_ofs = nm_i->nat_block_start[FREE_COLD_NID];
>+	}
>
>-	/* Enough entries */
>-	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
>-		return;
>+	f2fs_bug_on(sbi, nm_i->nat_block_end[FREE_HOT_NID] >
>+				nm_i->nat_block_start[FREE_COLD_NID]);
>
>-	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>-		return;
>+	/* readahead nat pages to be scanned */
>+	ra_meta_pages(sbi, nat_ofs, count, META_NAT, true);
>
>-	if (!mount) {
>-		/* try to find free nids in free_nid_bitmap */
>-		scan_free_nid_bits(sbi);
>+	for (; count > 0; count--, nat_ofs++) {
>+		struct page *page;
>
>-		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
>-			return;
>+		if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
>+			continue;
>+
>+		page = get_current_nat_page(sbi, nat_ofs * NAT_ENTRY_PER_BLOCK);
>+		scan_nat_page(sbi, page, nat_ofs, state);
>+		f2fs_put_page(page, 1);
> 	}
>+}
>
>-	/* readahead nat pages to be scanned */
>-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
>-							META_NAT, true);
>+static bool __build_free_nids(struct f2fs_sb_info *sbi, bool sync,
>+					bool mount, enum nid_state state)
>+{
>+	struct f2fs_nm_info *nm_i = NM_I(sbi);
>
>-	down_read(&nm_i->nat_tree_lock);
>+	if (nm_i->nid_cnt[state])
>+		return false;
>
>-	while (1) {
>-		if (!test_bit_le(NAT_BLOCK_OFFSET(nid),
>-						nm_i->nat_block_bitmap)) {
>-			struct page *page = get_current_nat_page(sbi, nid);
>+	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>+		return false;
>
>-			scan_nat_page(sbi, page, nid);
>-			f2fs_put_page(page, 1);
>-		}
>+	if (!mount) {
>+		/* try to find free nids in free_nid_bitmap */
>+		scan_free_nid_bits(sbi, state);
>
>-		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
>-		if (unlikely(nid >= nm_i->max_nid))
>-			nid = 0;
>+		if (nm_i->nid_cnt[state])
>+			return false;
>
>-		if (++i >= FREE_NID_PAGES)
>-			break;
>+		/* all nat blocks have been scanned */
>+		if (nm_i->nat_block_end[FREE_HOT_NID] >=
>+				nm_i->nat_block_start[FREE_COLD_NID])
>+			return true;
> 	}
>
>-	/* go to the next free nat pages to find free nids abundantly */
>-	nm_i->next_scan_nid = nid;
>+	down_read(&nm_i->nat_tree_lock);
>+
>+	/* find free nids from nat blocks */
>+	load_nat_block(sbi, state);
>
> 	/* find free nids from current sum_pages */
>-	scan_curseg_cache(sbi);
>+	scan_curseg_cache(sbi, state);
>
> 	up_read(&nm_i->nat_tree_lock);
>
>-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
>-					nm_i->ra_nid_pages, META_NAT, false);
>+	return false;
> }
>
>-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>+bool build_free_nids(struct f2fs_sb_info *sbi, bool sync,
>+					bool mount, enum nid_state state)
> {
>+	bool exhausted;
>+
> 	mutex_lock(&NM_I(sbi)->build_lock);
>-	__build_free_nids(sbi, sync, mount);
>+	exhausted = __build_free_nids(sbi, sync, mount, state);
> 	mutex_unlock(&NM_I(sbi)->build_lock);
>+
>+	return exhausted;
> }
>
>-/*
>- * If this function returns success, caller can obtain a new nid
>- * from second parameter of this function.
>- * The returned nid could be used ino as well as nid when inode is created.
>- */
>-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>+enum nid_state default_free_nid_type(struct f2fs_sb_info *sbi, nid_t nid)
>+{
>+	struct f2fs_nm_info *nm_i = NM_I(sbi);
>+	unsigned int hot_start = nm_i->nat_block_start[FREE_HOT_NID];
>+	unsigned int hot_end = nm_i->nat_block_end[FREE_HOT_NID];
>+	unsigned int cold_start = nm_i->nat_block_start[FREE_COLD_NID];
>+	unsigned int cold_end = nm_i->nat_block_end[FREE_COLD_NID];
>+
>+	if (hot_start != hot_end) {
>+		if (nid >= hot_start * NAT_ENTRY_PER_BLOCK &&
>+			nid < hot_end * NAT_ENTRY_PER_BLOCK)
>+			return FREE_HOT_NID;
>+	}
>+
>+	if (cold_start != cold_end) {
>+		if (nid >= cold_start * NAT_ENTRY_PER_BLOCK &&
>+			nid < cold_end * NAT_ENTRY_PER_BLOCK)
>+			return FREE_COLD_NID;
>+	}
>+
>+	return INVALID_NID_TYPE;
>+}
>+
>+static int __alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid,
>+						enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	struct free_nid *i = NULL;
>@@ -2112,38 +2149,61 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
> #ifdef CONFIG_F2FS_FAULT_INJECTION
> 	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
> 		f2fs_show_injection_info(FAULT_ALLOC_NID);
>-		return false;
>+		return 0;
> 	}
> #endif
> 	spin_lock(&nm_i->nid_list_lock);
>
> 	if (unlikely(nm_i->available_nids == 0)) {
> 		spin_unlock(&nm_i->nid_list_lock);
>-		return false;
>+		return 0;
> 	}
>
> 	/* We should not use stale free nids created by build_free_nids */
>-	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
>-		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
>-		i = list_first_entry(&nm_i->free_nid_list,
>+	if (nm_i->nid_cnt[state] && !on_build_free_nids(nm_i)) {
>+		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list[state]));
>+		i = list_first_entry(&nm_i->free_nid_list[state],
> 					struct free_nid, list);
> 		*nid = i->nid;
>
>-		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
>+		__move_free_nid(sbi, i, state, PREALLOC_NID);
> 		nm_i->available_nids--;
>
> 		update_free_nid_bitmap(sbi, *nid, false, false);
>
> 		spin_unlock(&nm_i->nid_list_lock);
>-		return true;
>+
>+		f2fs_bug_on(sbi, *nid >= nm_i->max_nid);
>+		return 1;
> 	}
> 	spin_unlock(&nm_i->nid_list_lock);
>
> 	/* Let's scan nat pages and its caches to get free nids */
>-	build_free_nids(sbi, true, false);
>+	if (build_free_nids(sbi, true, false, state))
>+		return -1;
> 	goto retry;
> }
>
>+/*
>+ * If this function returns success, caller can obtain a new nid
>+ * from second parameter of this function.
>+ * The returned nid could be used ino as well as nid when inode is created.
>+ */
>+int alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid, enum nid_state state)
>+{
>+	int ret;
>+
>+	ret = __alloc_nid(sbi, nid, state);
>+	if (ret >= 0)
>+		return ret;
>+
>+	ret = __alloc_nid(sbi, nid, !state);
>+	if (ret < 0)
>+		ret = 0;
>+
>+	return ret;
>+}
>+
> /*
>  * alloc_nid() should be called prior to this function.
>  */
>@@ -2164,7 +2224,8 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
> /*
>  * alloc_nid() should be called prior to this function.
>  */
>-void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>+void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid,
>+						enum nid_state state)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	struct free_nid *i;
>@@ -2181,7 +2242,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
> 		__remove_free_nid(sbi, i, PREALLOC_NID);
> 		need_free = true;
> 	} else {
>-		__move_free_nid(sbi, i, PREALLOC_NID, FREE_NID);
>+		__move_free_nid(sbi, i, PREALLOC_NID, state);
> 	}
>
> 	nm_i->available_nids++;
>@@ -2199,22 +2260,23 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	struct free_nid *i, *next;
> 	int nr = nr_shrink;
>-
>-	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>-		return 0;
>+	enum nid_state state;
>
> 	if (!mutex_trylock(&nm_i->build_lock))
> 		return 0;
>
> 	spin_lock(&nm_i->nid_list_lock);
>-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
>-		if (nr_shrink <= 0 ||
>-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>-			break;
>+	for (state = FREE_HOT_NID; state < MAX_NID_TYPE; state++) {
>+		list_for_each_entry_safe(i, next,
>+				&nm_i->free_nid_list[state], list) {
>+			if (nr_shrink <= 0 ||
>+				nm_i->nid_cnt[state] <= MAX_FREE_NIDS)
>+				break;
>
>-		__remove_free_nid(sbi, i, FREE_NID);
>-		kmem_cache_free(free_nid_slab, i);
>-		nr_shrink--;
>+			__remove_free_nid(sbi, i, state);
>+			kmem_cache_free(free_nid_slab, i);
>+			nr_shrink--;
>+		}
> 	}
> 	spin_unlock(&nm_i->nid_list_lock);
> 	mutex_unlock(&nm_i->build_lock);
>@@ -2271,13 +2333,13 @@ int recover_xattr_data(struct inode *inode, struct page *page)
>
> recover_xnid:
> 	/* 2: update xattr nid in inode */
>-	if (!alloc_nid(sbi, &new_xnid))
>+	if (!alloc_nid(sbi, &new_xnid, FREE_COLD_NID))
> 		return -ENOSPC;
>
> 	set_new_dnode(&dn, inode, NULL, NULL, new_xnid);
> 	xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
> 	if (IS_ERR(xpage)) {
>-		alloc_nid_failed(sbi, new_xnid);
>+		alloc_nid_failed(sbi, new_xnid, FREE_COLD_NID);
> 		return PTR_ERR(xpage);
> 	}
>
>@@ -2532,7 +2594,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> 		nat_reset_flag(ne);
> 		__clear_nat_cache_dirty(NM_I(sbi), set, ne);
> 		if (nat_get_blkaddr(ne) == NULL_ADDR) {
>-			add_free_nid(sbi, nid, false, true);
>+			enum nid_state state = default_free_nid_type(sbi, nid);
>+
>+			add_free_nid(sbi, nid, false, true, state);
> 		} else {
> 			spin_lock(&NM_I(sbi)->nid_list_lock);
> 			update_free_nid_bitmap(sbi, nid, false, false);
>@@ -2691,15 +2755,21 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
> 	/* not used nids: 0, node, meta, (and root counted as valid node) */
> 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
> 				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
>-	nm_i->nid_cnt[FREE_NID] = 0;
>+	nm_i->nid_cnt[FREE_HOT_NID] = 0;
>+	nm_i->nid_cnt[FREE_COLD_NID] = 0;
> 	nm_i->nid_cnt[PREALLOC_NID] = 0;
>+	nm_i->nat_block_start[FREE_HOT_NID] =
>+			nm_i->nat_block_end[FREE_HOT_NID] = 0;
>+	nm_i->nat_block_start[FREE_COLD_NID] =
>+			nm_i->nat_block_end[FREE_COLD_NID] = nm_i->nat_blocks;
> 	nm_i->nat_cnt = 0;
> 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
> 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
> 	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
>
> 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
>-	INIT_LIST_HEAD(&nm_i->free_nid_list);
>+	INIT_LIST_HEAD(&nm_i->free_nid_list[FREE_HOT_NID]);
>+	INIT_LIST_HEAD(&nm_i->free_nid_list[FREE_COLD_NID]);
> 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
> 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
> 	INIT_LIST_HEAD(&nm_i->nat_entries);
>@@ -2782,7 +2852,8 @@ int build_node_manager(struct f2fs_sb_info *sbi)
> 	/* load free nid status from nat_bits table */
> 	load_free_nid_bitmap(sbi);
>
>-	build_free_nids(sbi, true, true);
>+	build_free_nids(sbi, true, true, FREE_HOT_NID);
>+	build_free_nids(sbi, true, true, FREE_COLD_NID);
> 	return 0;
> }
>
>@@ -2794,21 +2865,26 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
> 	struct nat_entry_set *setvec[SETVEC_SIZE];
> 	nid_t nid = 0;
> 	unsigned int found;
>+	enum nid_state state;
>
> 	if (!nm_i)
> 		return;
>
> 	/* destroy free nid list */
> 	spin_lock(&nm_i->nid_list_lock);
>-	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
>-		__remove_free_nid(sbi, i, FREE_NID);
>-		spin_unlock(&nm_i->nid_list_lock);
>-		kmem_cache_free(free_nid_slab, i);
>-		spin_lock(&nm_i->nid_list_lock);
>+	for (state = FREE_HOT_NID; state < MAX_NID_TYPE; state++) {
>+		list_for_each_entry_safe(i, next_i,
>+				&nm_i->free_nid_list[state], list) {
>+			__remove_free_nid(sbi, i, state);
>+			spin_unlock(&nm_i->nid_list_lock);
>+			kmem_cache_free(free_nid_slab, i);
>+			spin_lock(&nm_i->nid_list_lock);
>+		}
>+		f2fs_bug_on(sbi, nm_i->nid_cnt[state]);
>+		f2fs_bug_on(sbi, !list_empty(&nm_i->free_nid_list[state]));
> 	}
>-	f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID]);
>+
> 	f2fs_bug_on(sbi, nm_i->nid_cnt[PREALLOC_NID]);
>-	f2fs_bug_on(sbi, !list_empty(&nm_i->free_nid_list));
> 	spin_unlock(&nm_i->nid_list_lock);
>
> 	/* destroy nat cache */
>diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
>index 2129d63ab3d7..732c8e672fe2 100644
>--- a/fs/f2fs/node.h
>+++ b/fs/f2fs/node.h
>@@ -157,24 +157,9 @@ struct nat_entry_set {
> struct free_nid {
> 	struct list_head list;	/* for free node id list */
> 	nid_t nid;		/* node id */
>-	int state;		/* in use or not: FREE_NID or PREALLOC_NID */
>+	int state;		/* in use or not */
> };
>
>-static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>-{
>-	struct f2fs_nm_info *nm_i = NM_I(sbi);
>-	struct free_nid *fnid;
>-
>-	spin_lock(&nm_i->nid_list_lock);
>-	if (nm_i->nid_cnt[FREE_NID] <= 0) {
>-		spin_unlock(&nm_i->nid_list_lock);
>-		return;
>-	}
>-	fnid = list_first_entry(&nm_i->free_nid_list, struct free_nid, list);
>-	*nid = fnid->nid;
>-	spin_unlock(&nm_i->nid_list_lock);
>-}
>-
> /*
>  * inline functions
>  */
>diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>index 720b01461adc..2ffb5c2d205e 100644
>--- a/fs/f2fs/segment.c
>+++ b/fs/f2fs/segment.c
>@@ -487,10 +487,12 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
> 	if (!available_free_memory(sbi, NAT_ENTRIES))
> 		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
>
>-	if (!available_free_memory(sbi, FREE_NIDS))
>+	if (!available_free_memory(sbi, FREE_NIDS)) {
> 		try_to_free_nids(sbi, MAX_FREE_NIDS);
>-	else
>-		build_free_nids(sbi, false, false);
>+	} else {
>+		build_free_nids(sbi, false, false, FREE_HOT_NID);
>+		build_free_nids(sbi, false, false, FREE_COLD_NID);
>+	}
>
> 	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
> 		return;
>diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
>index 0b5664a1a6cc..7b35746fb615 100644
>--- a/fs/f2fs/shrinker.c
>+++ b/fs/f2fs/shrinker.c
>@@ -28,7 +28,8 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
>
> static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
> {
>-	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
>+	long count = NM_I(sbi)->nid_cnt[FREE_HOT_NID] +
>+			NM_I(sbi)->nid_cnt[FREE_COLD_NID] - MAX_FREE_NIDS;
>
> 	return count > 0 ? count : 0;
> }
>diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>index ae2dfa709f5d..c42a670e17f6 100644
>--- a/fs/f2fs/xattr.c
>+++ b/fs/f2fs/xattr.c
>@@ -397,7 +397,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> 	int err = 0;
>
> 	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
>-		if (!alloc_nid(sbi, &new_nid))
>+		if (!alloc_nid(sbi, &new_nid, FREE_COLD_NID))
> 			return -ENOSPC;
>
> 	/* write to inline xattr */
>@@ -407,7 +407,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> 		} else {
> 			in_page = get_node_page(sbi, inode->i_ino);
> 			if (IS_ERR(in_page)) {
>-				alloc_nid_failed(sbi, new_nid);
>+				alloc_nid_failed(sbi, new_nid, FREE_COLD_NID);
> 				return PTR_ERR(in_page);
> 			}
> 			inline_addr = inline_xattr_addr(inode, in_page);
>@@ -418,7 +418,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> 		/* no need to use xattr node block */
> 		if (hsize <= inline_size) {
> 			err = truncate_xattr_node(inode);
>-			alloc_nid_failed(sbi, new_nid);
>+			alloc_nid_failed(sbi, new_nid, FREE_COLD_NID);
> 			if (err) {
> 				f2fs_put_page(in_page, 1);
> 				return err;
>@@ -434,7 +434,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> 		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
> 		if (IS_ERR(xpage)) {
> 			err = PTR_ERR(xpage);
>-			alloc_nid_failed(sbi, new_nid);
>+			alloc_nid_failed(sbi, new_nid, FREE_COLD_NID);
> 			goto in_page_out;
> 		}
> 		f2fs_bug_on(sbi, new_nid);
>@@ -445,7 +445,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> 		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
> 		if (IS_ERR(xpage)) {
> 			err = PTR_ERR(xpage);
>-			alloc_nid_failed(sbi, new_nid);
>+			alloc_nid_failed(sbi, new_nid, FREE_COLD_NID);
> 			goto in_page_out;
> 		}
> 		alloc_nid_done(sbi, new_nid);
>--
>2.15.0.55.gc2ece9dc4de6
>
>
>------------------------------------------------------------------------------
>Check out the vibrant tech community on one of the world's most
>engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>_______________________________________________
>Linux-f2fs-devel mailing list
>Linux-f2fs-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
