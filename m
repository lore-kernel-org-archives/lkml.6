Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbeDTJqI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:46:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754470AbeDTJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:46:04 -0400
Subject: Re: [PATCH] f2fs: sepearte hot/cold in free nid
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180420015231.90679-1-yuchao0@huawei.com>
 <20180420033752.GH39280@jaegeuk-macbookpro.roam.corp.google.com>
 <4dd1cddd-02da-6ecb-de91-a21feea6f99c@huawei.com>
Message-ID: <f3074a26-01ca-6f8d-fe01-de713296f069@huawei.com>
Date: Fri, 20 Apr 2018 17:35:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <4dd1cddd-02da-6ecb-de91-a21feea6f99c@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/20 12:04, Chao Yu wrote:
> On 2018/4/20 11:37, Jaegeuk Kim wrote:
>> On 04/20, Chao Yu wrote:
>>> As most indirect node, dindirect node, and xattr node won't be updated
>>> after they are created, but inode node and other direct node will change
>>> more frequently, so store their nat entries mixedly in whole nat table
>>> will suffer:
>>> - fragment nat table soon due to different update rate
>>> - more nat block update due to fragmented nat table
>>>
>>> In order to solve above issue, we're trying to separate whole nat table to
>>> two part:
>>> a. Hot free nid area:
>>>  - range: [nid #0, nid #x)
>>>  - store node block address for
>>>    * inode node
>>>    * other direct node
>>> b. Cold free nid area:
>>>  - range: [nid #x, max nid)
>>>  - store node block address for
>>>    * indirect node
>>>    * dindirect node
>>>    * xattr node
>>>
>>> Allocation strategy example:
>>>
>>> Free nid: '-'
>>> Used nid: '='
>>>
>>> 1. Initial status:
>>> Free Nids:	|-----------------------------------------------------------------------|
>>> 		^		^					^		^
>>> Alloc Range:	|---------------|					|---------------|
>>> 		hot_start	hot_end					cold_start	cold_end
>>>
>>> 2. Free nids have ran out:
>>> Free Nids:	|===============-----------------------------------------===============|
>>> 		^		^					^		^
>>> Alloc Range:	|===============|					|===============|
>>> 		hot_start	hot_end					cold_start	cold_end
>>>
>>> 3. Expand hot/cold area range:
>>> Free Nids:	|===============-----------------------------------------===============|
>>> 		^				^	^				^
>>> Alloc Range:	|===============----------------|	|----------------===============|
>>> 		hot_start			hot_end	cold_start			cold_end
>>>
>>> 4. Hot free nids have ran out:
>>> Free Nids:	|===============================-------------------------===============|
>>> 		^				^	^				^
>>> Alloc Range:	|===============================|	|----------------===============|
>>> 		hot_start			hot_end	cold_start			cold_end
>>>
>>> 5. Expand hot area range, hot/cold area boundary has been fixed:
>>> Free Nids:	|===============================-------------------------===============|
>>> 		^					^				^
>>> Alloc Range:	|===============================--------|----------------===============|
>>> 		hot_start				hot_end(cold_start)		cold_end
>>>
>>> Run xfstests with generic/*:
>>>
>>> before
>>> node_write:	169660
>>> cp_count:	60118
>>> node/cp		2.82
>>>
>>> after:
>>> node_write:	159145
>>> cp_count:	84501
>>> node/cp:	2.64
>>
>> Nice trial tho, I don't see much benefit on this huge patch. I guess we may be
>> able to find an efficient way to achieve this issue rather than changing whole
>> stable codes.
> 
> IMO, based on this, later, we can add more allocation policy to manage free nid
> resource to get more benefit.
> 
> If you worry about code stability, we can queue this patch in dev-test branch to
> test this longer time.
> 
>>
>> How about getting a free nid in the list from head or tail separately?
> 
> I don't think this can get benefit from long time used image, since nat table
> will be fragmented anyway, then we won't know free nid in head or in tail comes
> from hot nat block or cold nat block.
> 
> Anyway, I will have a try.

A quick test result with below patch:

node_write:187837, cp_count:76431

>From 9f88ea8a36a74f1d3ed8df57ceffb1b8ae41a161 Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Fri, 20 Apr 2018 16:18:26 +0800
Subject: [PATCH] f2fs: separate hot/cold free nid simply

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/namei.c |  2 +-
 fs/f2fs/node.c  | 14 +++++++++-----
 fs/f2fs/xattr.c |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7651a118faa3..adca5e8bc19a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2800,7 +2800,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct
inode *inode,
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 			bool do_balance, enum iostat_type io_type);
 void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
+bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid, bool hot);
 void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
 int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3d59149590f7..bbf6edbb7298 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -37,7 +37,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t
mode)
 		return ERR_PTR(-ENOMEM);

 	f2fs_lock_op(sbi);
-	if (!alloc_nid(sbi, &ino)) {
+	if (!alloc_nid(sbi, &ino, true)) {
 		f2fs_unlock_op(sbi);
 		err = -ENOSPC;
 		goto fail;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ea231f8a0cce..bbaae2f3461e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -631,7 +631,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t
index, int mode)

 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
-			if (!alloc_nid(sbi, &(nids[i]))) {
+			if (!alloc_nid(sbi, &(nids[i]), i == 1)) {
 				err = -ENOSPC;
 				goto release_pages;
 			}
@@ -2108,7 +2108,7 @@ void build_free_nids(struct f2fs_sb_info *sbi, bool sync,
bool mount)
  * from second parameter of this function.
  * The returned nid could be used ino as well as nid when inode is created.
  */
-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
+bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid, bool hot)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
@@ -2129,8 +2129,12 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	/* We should not use stale free nids created by build_free_nids */
 	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
-		i = list_first_entry(&nm_i->free_nid_list,
-					struct free_nid, list);
+		if (hot)
+			i = list_first_entry(&nm_i->free_nid_list,
+						struct free_nid, list);
+		else
+			i = list_last_entry(&nm_i->free_nid_list,
+						struct free_nid, list);
 		*nid = i->nid;

 		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
@@ -2275,7 +2279,7 @@ int recover_xattr_data(struct inode *inode, struct page *page)

 recover_xnid:
 	/* 2: update xattr nid in inode */
-	if (!alloc_nid(sbi, &new_xnid))
+	if (!alloc_nid(sbi, &new_xnid, false))
 		return -ENOSPC;

 	set_new_dnode(&dn, inode, NULL, NULL, new_xnid);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index d847b2b11659..46c090614563 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -398,7 +398,7 @@ static inline int write_all_xattrs(struct inode *inode,
__u32 hsize,
 	int err = 0;

 	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
-		if (!alloc_nid(sbi, &new_nid))
+		if (!alloc_nid(sbi, &new_nid, false))
 			return -ENOSPC;

 	/* write to inline xattr */
-- 
2.15.0.55.gc2ece9dc4de6
