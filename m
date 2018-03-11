Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCKMMx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:12:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46902 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeCKMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:12:51 -0400
X-Google-Smtp-Source: AG47ELtdMpRMlJZ1K/sXy1Hf3dlp5Yb+yHkrAE420L3iFG2RJuAzzRK+wr+5/1vTFRSxGrlPg8dfsQ==
Subject: Re: [RFC v2 16/83] Initialize block map and free lists in
 nova_init().
To: Andiry Xu <jix024@eng.ucsd.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-17-git-send-email-jix024@eng.ucsd.edu>
From: Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <3c1e2c80-ad39-c10f-a4c3-9228ebed776e@gmail.com>
Date: Sun, 11 Mar 2018 14:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520705944-6723-17-git-send-email-jix024@eng.ucsd.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2018 20:17, Andiry Xu wrote:
> From: Andiry Xu <jix024@cs.ucsd.edu>
> 
> NOVA divides the pmem range equally among per-CPU free lists,
> and format the red-black trees by inserting the initial free range.
> 
> Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
> ---
>  fs/nova/balloc.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nova/balloc.h |  13 ++++-
>  fs/nova/super.c  |   2 +
>  3 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nova/balloc.c b/fs/nova/balloc.c
> index 450c942..cb627db 100644
> --- a/fs/nova/balloc.c
> +++ b/fs/nova/balloc.c
> @@ -55,4 +55,165 @@ void nova_delete_free_lists(struct super_block *sb)
>  	sbi->free_lists = NULL;
>  }
>  
> +// Initialize a free list.  Each CPU gets an equal share of the block space to
> +// manage.
> +static void nova_init_free_list(struct super_block *sb,
> +	struct free_list *free_list, int index)
> +{
> +	struct nova_sb_info *sbi = NOVA_SB(sb);
> +	unsigned long per_list_blocks;
> +
> +	per_list_blocks = sbi->num_blocks / sbi->cpus;

nit: You've already initialised per_list_blocks in nova_init_blockmap,
which calls this function. So just reference it, rather than performing
the the divison every time

> +
> +	free_list->block_start = per_list_blocks * index;
> +	free_list->block_end = free_list->block_start +
> +					per_list_blocks - 1;
> +	if (index == 0)
> +		free_list->block_start += sbi->head_reserved_blocks;
> +	if (index == sbi->cpus - 1)
> +		free_list->block_end -= sbi->tail_reserved_blocks;
> +}
> +
> +inline struct nova_range_node *nova_alloc_blocknode(struct super_block *sb)
> +{
> +	return nova_alloc_range_node(sb);
> +}
> +
> +inline void nova_free_blocknode(struct super_block *sb,
> +	struct nova_range_node *node)
> +{
> +	nova_free_range_node(node);
> +}
> +
> +void nova_init_blockmap(struct super_block *sb, int recovery)
> +{
> +	struct nova_sb_info *sbi = NOVA_SB(sb);
> +	struct rb_root *tree;
> +	struct nova_range_node *blknode;
> +	struct free_list *free_list;
> +	int i;
> +	int ret;
> +
> +	/* Divide the block range among per-CPU free lists */
> +	sbi->per_list_blocks = sbi->num_blocks / sbi->cpus;
> +	for (i = 0; i < sbi->cpus; i++) {
> +		free_list = nova_get_free_list(sb, i);
> +		tree = &(free_list->block_free_tree);
> +		nova_init_free_list(sb, free_list, i);
> +
> +		/* For recovery, update these fields later */
> +		if (recovery == 0) {
> +			free_list->num_free_blocks = free_list->block_end -
> +						free_list->block_start + 1;
> +
> +			blknode = nova_alloc_blocknode(sb);
> +			if (blknode == NULL)
> +				return;
> +			blknode->range_low = free_list->block_start;
> +			blknode->range_high = free_list->block_end;
> +			ret = nova_insert_blocktree(sbi, tree, blknode);
> +			if (ret) {
> +				nova_err(sb, "%s failed\n", __func__);
> +				nova_free_blocknode(sb, blknode);
> +				return;
> +			}
> +			free_list->first_node = blknode;
> +			free_list->last_node = blknode;
> +			free_list->num_blocknode = 1;
> +		}
> +
> +		nova_dbgv("%s: free list %d: block start %lu, end %lu, %lu free blocks\n",
> +			  __func__, i,
> +			  free_list->block_start,
> +			  free_list->block_end,
> +			  free_list->num_free_blocks);
> +	}
> +}
> +
> +static inline int nova_rbtree_compare_rangenode(struct nova_range_node *curr,
> +	unsigned long range_low)
> +{
> +	if (range_low < curr->range_low)
> +		return -1;
> +	if (range_low > curr->range_high)
> +		return 1;
>  
> +	return 0;
> +}
> +
> +int nova_find_range_node(struct nova_sb_info *sbi,
> +	struct rb_root *tree, unsigned long range_low,
> +	struct nova_range_node **ret_node)

Instead of having a **ret_node pointer as an argument, just make the
function return struct nova_range *node and have callers check for null:

struct nova_range_node *node = nova_find_range_node(sbi, tree, range);

if (ret) {
//do stuff with *node
}

> +{
> +	struct nova_range_node *curr = NULL;
> +	struct rb_node *temp;
> +	int compVal;
> +	int ret = 0;
> +
> +	temp = tree->rb_node;
> +
> +	while (temp) {
> +		curr = container_of(temp, struct nova_range_node, node);
> +		compVal = nova_rbtree_compare_rangenode(curr, range_low);
> +
> +		if (compVal == -1) {
> +			temp = temp->rb_left;
> +		} else if (compVal == 1) {
> +			temp = temp->rb_right;
> +		} else {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	*ret_node = curr;
> +	return ret;
> +}
> +
> +
> +int nova_insert_range_node(struct rb_root *tree,
> +	struct nova_range_node *new_node)
> +{
> +	struct nova_range_node *curr;
> +	struct rb_node **temp, *parent;
> +	int compVal;
> +
> +	temp = &(tree->rb_node);
> +	parent = NULL;
> +
> +	while (*temp) {
> +		curr = container_of(*temp, struct nova_range_node, node);
> +		compVal = nova_rbtree_compare_rangenode(curr,
> +					new_node->range_low);
> +		parent = *temp;
> +
> +		if (compVal == -1) {
> +			temp = &((*temp)->rb_left);
> +		} else if (compVal == 1) {
> +			temp = &((*temp)->rb_right);
> +		} else {
> +			nova_dbg("%s: entry %lu - %lu already exists: %lu - %lu\n",
> +				 __func__, new_node->range_low,
> +				new_node->range_high, curr->range_low,
> +				curr->range_high);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	rb_link_node(&new_node->node, parent, temp);
> +	rb_insert_color(&new_node->node, tree);
> +
> +	return 0;
> +}
> +
> +inline int nova_insert_blocktree(struct nova_sb_info *sbi,
> +	struct rb_root *tree, struct nova_range_node *new_node)
> +{
> +	int ret;
> +
> +	ret = nova_insert_range_node(tree, new_node);
> +	if (ret)
> +		nova_dbg("ERROR: %s failed %d\n", __func__, ret);
> +
> +	return ret;
> +}
> diff --git a/fs/nova/balloc.h b/fs/nova/balloc.h
> index e7c7a1d..57a93e4 100644
> --- a/fs/nova/balloc.h
> +++ b/fs/nova/balloc.h
> @@ -62,5 +62,16 @@ enum alloc_type {
>  
>  int nova_alloc_block_free_lists(struct super_block *sb);
>  void nova_delete_free_lists(struct super_block *sb);
> -
> +inline struct nova_range_node *nova_alloc_blocknode(struct super_block *sb);
> +inline void nova_free_blocknode(struct super_block *sb,
> +	struct nova_range_node *bnode);
> +extern void nova_init_blockmap(struct super_block *sb, int recovery);
> +inline int nova_insert_blocktree(struct nova_sb_info *sbi,
> +	struct rb_root *tree, struct nova_range_node *new_node);
> +
> +extern int nova_insert_range_node(struct rb_root *tree,
> +				  struct nova_range_node *new_node);
> +extern int nova_find_range_node(struct nova_sb_info *sbi,
> +				struct rb_root *tree, unsigned long range_low,
> +				struct nova_range_node **ret_node);
>  #endif
> diff --git a/fs/nova/super.c b/fs/nova/super.c
> index 43b24a7..9762f26 100644
> --- a/fs/nova/super.c
> +++ b/fs/nova/super.c
> @@ -376,6 +376,8 @@ static struct nova_inode *nova_init(struct super_block *sb,
>  	pi->nova_ino = NOVA_BLOCKNODE_INO;
>  	nova_flush_buffer(pi, CACHELINE_SIZE, 1);
>  
> +	nova_init_blockmap(sb, 0);
> +
>  	sbi->nova_sb->s_size = cpu_to_le64(size);
>  	sbi->nova_sb->s_blocksize = cpu_to_le32(blocksize);
>  	sbi->nova_sb->s_magic = cpu_to_le32(NOVA_SUPER_MAGIC);
> 
