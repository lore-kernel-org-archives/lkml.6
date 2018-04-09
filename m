Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDIMZ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:25:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750759AbeDIMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:25:26 -0400
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
To: Minchan Kim <minchan@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC: Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, "Jan Kara" <jack@suse.cz>,
        Chris Fries <cfries@google.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
Date: Mon, 9 Apr 2018 20:25:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/9 19:25, Minchan Kim wrote:
> On Mon, Apr 09, 2018 at 04:14:03AM -0700, Matthew Wilcox wrote:
>> On Mon, Apr 09, 2018 at 12:09:30PM +0900, Minchan Kim wrote:
>>> On Sun, Apr 08, 2018 at 07:49:25PM -0700, Matthew Wilcox wrote:
>>>> On Mon, Apr 09, 2018 at 10:58:15AM +0900, Minchan Kim wrote:
>>>>> It assumes shadow entry of radix tree relies on the init state
>>>>> that node->private_list allocated should be list_empty state.
>>>>> Currently, it's initailized in SLAB constructor which means
>>>>> node of radix tree would be initialized only when *slub allocates
>>>>> new page*, not *new object*. So, if some FS or subsystem pass
>>>>> gfp_mask to __GFP_ZERO, slub allocator will do memset blindly.
>>>>
>>>> Wait, what?  Who's declaring their radix tree with GFP_ZERO flags?
>>>> I don't see anyone using INIT_RADIX_TREE or RADIX_TREE or RADIX_TREE_INIT
>>>> with GFP_ZERO.
>>>
>>> Look at fs/f2fs/inode.c
>>> mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
>>>
>>> __add_to_page_cache_locked
>>>   radix_tree_maybe_preload
>>>
>>> add_to_page_cache_lru
>>>
>>> What's the wrong with setting __GFP_ZERO with mapping->gfp_mask?
>>
>> Because it's a stupid thing to do.  Pages are allocated and then filled
>> from disk.  Zeroing them before DMAing to them is just a waste of time.
> 
> Every FSes do address_space to read pages from storage? I'm not sure.

No, sometimes, we need to write meta data to new allocated block address,
then we will allocate a zeroed page in inner inode's address space, and
fill partial data in it, and leave other place with zero value which means
some fields are initial status.

There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
I have just checked them, for both of them, we can avoid using __GFP_ZERO,
and do initialization by ourselves to avoid unneeded/redundant zeroing
from mm.

To Jaegeuk, if I missed something, please let me know.

---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/node.c  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c85cccc2e800..cc63f8c448f0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -339,10 +339,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 make_now:
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (ino == F2FS_META_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9dedd4b5e077..31e5ecf98ffd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1078,6 +1078,7 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);

 	f2fs_wait_on_page_writeback(page, NODE, true);
+	memset(F2FS_NODE(page), 0, PAGE_SIZE);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
 	if (!PageUptodate(page))
@@ -2321,6 +2322,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)

 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
+	memset(F2FS_NODE(page), 0, PAGE_SIZE);
 	fill_node_footer(ipage, ino, ino, 0, true);
 	set_cold_node(page, false);

-- 

> 
> If you're right, we need to insert WARN_ON to catch up __GFP_ZERO
> on mapping_set_gfp_mask at the beginning and remove all of those
> stupid thins. 
> 
> Jaegeuk, why do you need __GFP_ZERO? Could you explain?
> 
> .
> 
