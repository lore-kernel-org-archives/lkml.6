Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755007AbeCSDNq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 23:13:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeCSDNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 23:13:44 -0400
Subject: Re: [PATCH] f2fs: don't put dentry page in pagecache into highmem
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
From: Yunlong Song <yunlong.song@huawei.com>
Message-ID: <2b5f342b-70e4-04cd-c4ed-13c8abd06af8@huawei.com>
Date: Mon, 19 Mar 2018 11:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jaegeuk,
     I find this patch is removed from current branch of dev-test
recently, why? Any bugs?

On 2018/2/28 20:31, Yunlong Song wrote:
> Previous dentry page uses highmem, which will cause panic in platforms
> using highmem (such as arm), since the address space of dentry pages
> from highmem directly goes into the decryption path via the function
> fscrypt_fname_disk_to_usr. But sg_init_one assumes the address is not
> from highmem, and then cause panic since it doesn't call kmap_high but
> kunmap_high is triggered at the end. To fix this problem in a simple
> way, this patch avoids to put dentry page in pagecache into highmem.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fs/f2fs/dir.c           | 23 +++++------------------
>   fs/f2fs/f2fs.h          |  6 ------
>   fs/f2fs/inline.c        |  3 +--
>   fs/f2fs/inode.c         |  2 +-
>   fs/f2fs/namei.c         | 14 +-------------
>   fs/f2fs/recovery.c      | 11 +++++------
>   include/linux/f2fs_fs.h |  1 -
>   7 files changed, 13 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index f00b5ed..797eb05 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -94,14 +94,12 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
>   	struct f2fs_dir_entry *de;
>   	struct f2fs_dentry_ptr d;
>   
> -	dentry_blk = (struct f2fs_dentry_block *)kmap(dentry_page);
> +	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
>   
>   	make_dentry_ptr_block(NULL, &d, dentry_blk);
>   	de = find_target_dentry(fname, namehash, max_slots, &d);
>   	if (de)
>   		*res_page = dentry_page;
> -	else
> -		kunmap(dentry_page);
>   
>   	return de;
>   }
> @@ -287,7 +285,6 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
>   	de = f2fs_find_entry(dir, qstr, page);
>   	if (de) {
>   		res = le32_to_cpu(de->ino);
> -		f2fs_dentry_kunmap(dir, *page);
>   		f2fs_put_page(*page, 0);
>   	}
>   
> @@ -302,7 +299,6 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>   	f2fs_wait_on_page_writeback(page, type, true);
>   	de->ino = cpu_to_le32(inode->i_ino);
>   	set_de_type(de, inode->i_mode);
> -	f2fs_dentry_kunmap(dir, page);
>   	set_page_dirty(page);
>   
>   	dir->i_mtime = dir->i_ctime = current_time(dir);
> @@ -350,13 +346,11 @@ static int make_empty_dir(struct inode *inode,
>   	if (IS_ERR(dentry_page))
>   		return PTR_ERR(dentry_page);
>   
> -	dentry_blk = kmap_atomic(dentry_page);
> +	dentry_blk = page_address(dentry_page);
>   
>   	make_dentry_ptr_block(NULL, &d, dentry_blk);
>   	do_make_empty_dir(inode, parent, &d);
>   
> -	kunmap_atomic(dentry_blk);
> -
>   	set_page_dirty(dentry_page);
>   	f2fs_put_page(dentry_page, 1);
>   	return 0;
> @@ -547,13 +541,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>   		if (IS_ERR(dentry_page))
>   			return PTR_ERR(dentry_page);
>   
> -		dentry_blk = kmap(dentry_page);
> +		dentry_blk = page_address(dentry_page);
>   		bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
>   						slots, NR_DENTRY_IN_BLOCK);
>   		if (bit_pos < NR_DENTRY_IN_BLOCK)
>   			goto add_dentry;
>   
> -		kunmap(dentry_page);
>   		f2fs_put_page(dentry_page, 1);
>   	}
>   
> @@ -588,7 +581,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>   	if (inode)
>   		up_write(&F2FS_I(inode)->i_sem);
>   
> -	kunmap(dentry_page);
>   	f2fs_put_page(dentry_page, 1);
>   
>   	return err;
> @@ -642,7 +634,6 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
>   		F2FS_I(dir)->task = NULL;
>   	}
>   	if (de) {
> -		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
>   		err = -EEXIST;
>   	} else if (IS_ERR(page)) {
> @@ -730,7 +721,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>   	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
>   			NR_DENTRY_IN_BLOCK,
>   			0);
> -	kunmap(page); /* kunmap - pair of f2fs_find_entry */
>   	set_page_dirty(page);
>   
>   	dir->i_ctime = dir->i_mtime = current_time(dir);
> @@ -775,7 +765,7 @@ bool f2fs_empty_dir(struct inode *dir)
>   				return false;
>   		}
>   
> -		dentry_blk = kmap_atomic(dentry_page);
> +		dentry_blk = page_address(dentry_page);
>   		if (bidx == 0)
>   			bit_pos = 2;
>   		else
> @@ -783,7 +773,6 @@ bool f2fs_empty_dir(struct inode *dir)
>   		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
>   						NR_DENTRY_IN_BLOCK,
>   						bit_pos);
> -		kunmap_atomic(dentry_blk);
>   
>   		f2fs_put_page(dentry_page, 1);
>   
> @@ -901,19 +890,17 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>   			}
>   		}
>   
> -		dentry_blk = kmap(dentry_page);
> +		dentry_blk = page_address(dentry_page);
>   
>   		make_dentry_ptr_block(inode, &d, dentry_blk);
>   
>   		err = f2fs_fill_dentries(ctx, &d,
>   				n * NR_DENTRY_IN_BLOCK, &fstr);
>   		if (err) {
> -			kunmap(dentry_page);
>   			f2fs_put_page(dentry_page, 1);
>   			break;
>   		}
>   
> -		kunmap(dentry_page);
>   		f2fs_put_page(dentry_page, 1);
>   	}
>   out_free:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dbe87c7..d57b7dd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2413,12 +2413,6 @@ static inline int f2fs_has_inline_dentry(struct inode *inode)
>   	return is_inode_flag_set(inode, FI_INLINE_DENTRY);
>   }
>   
> -static inline void f2fs_dentry_kunmap(struct inode *dir, struct page *page)
> -{
> -	if (!f2fs_has_inline_dentry(dir))
> -		kunmap(page);
> -}
> -
>   static inline int is_file(struct inode *inode, int type)
>   {
>   	return F2FS_I(inode)->i_advise & type;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 90e38d8..3b77d64 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -369,7 +369,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
>   	f2fs_wait_on_page_writeback(page, DATA, true);
>   	zero_user_segment(page, MAX_INLINE_DATA(dir), PAGE_SIZE);
>   
> -	dentry_blk = kmap_atomic(page);
> +	dentry_blk = page_address(page);
>   
>   	make_dentry_ptr_inline(dir, &src, inline_dentry);
>   	make_dentry_ptr_block(dir, &dst, dentry_blk);
> @@ -386,7 +386,6 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
>   	memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
>   	memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
>   
> -	kunmap_atomic(dentry_blk);
>   	if (!PageUptodate(page))
>   		SetPageUptodate(page);
>   	set_page_dirty(page);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 89c838b..10be247 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -328,7 +328,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>   		inode->i_op = &f2fs_dir_inode_operations;
>   		inode->i_fop = &f2fs_dir_operations;
>   		inode->i_mapping->a_ops = &f2fs_dblock_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
> +		inode_nohighmem(inode);
>   	} else if (S_ISLNK(inode->i_mode)) {
>   		if (f2fs_encrypted_inode(inode))
>   			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index c4c94c7..2754af7 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -317,7 +317,6 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
>   
>   	de = f2fs_find_entry(dir, &dot, &page);
>   	if (de) {
> -		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
>   	} else if (IS_ERR(page)) {
>   		err = PTR_ERR(page);
> @@ -330,7 +329,6 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
>   
>   	de = f2fs_find_entry(dir, &dotdot, &page);
>   	if (de) {
> -		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
>   	} else if (IS_ERR(page)) {
>   		err = PTR_ERR(page);
> @@ -377,7 +375,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>   	}
>   
>   	ino = le32_to_cpu(de->ino);
> -	f2fs_dentry_kunmap(dir, page);
>   	f2fs_put_page(page, 0);
>   
>   	inode = f2fs_iget(dir->i_sb, ino);
> @@ -452,7 +449,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>   	err = acquire_orphan_inode(sbi);
>   	if (err) {
>   		f2fs_unlock_op(sbi);
> -		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
>   		goto fail;
>   	}
> @@ -613,7 +609,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>   	inode->i_op = &f2fs_dir_inode_operations;
>   	inode->i_fop = &f2fs_dir_operations;
>   	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> -	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
> +	inode_nohighmem(inode);
>   
>   	set_inode_flag(inode, FI_INC_LINK);
>   	f2fs_lock_op(sbi);
> @@ -931,7 +927,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>   			f2fs_set_link(old_inode, old_dir_entry,
>   						old_dir_page, new_dir);
>   		} else {
> -			f2fs_dentry_kunmap(old_inode, old_dir_page);
>   			f2fs_put_page(old_dir_page, 0);
>   		}
>   		f2fs_i_links_write(old_dir, false);
> @@ -947,7 +942,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>   put_out_dir:
>   	f2fs_unlock_op(sbi);
>   	if (new_page) {
> -		f2fs_dentry_kunmap(new_dir, new_page);
>   		f2fs_put_page(new_page, 0);
>   	}
>   out_whiteout:
> @@ -955,11 +949,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>   		iput(whiteout);
>   out_dir:
>   	if (old_dir_entry) {
> -		f2fs_dentry_kunmap(old_inode, old_dir_page);
>   		f2fs_put_page(old_dir_page, 0);
>   	}
>   out_old:
> -	f2fs_dentry_kunmap(old_dir, old_page);
>   	f2fs_put_page(old_page, 0);
>   out:
>   	return err;
> @@ -1101,19 +1093,15 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	return 0;
>   out_new_dir:
>   	if (new_dir_entry) {
> -		f2fs_dentry_kunmap(new_inode, new_dir_page);
>   		f2fs_put_page(new_dir_page, 0);
>   	}
>   out_old_dir:
>   	if (old_dir_entry) {
> -		f2fs_dentry_kunmap(old_inode, old_dir_page);
>   		f2fs_put_page(old_dir_page, 0);
>   	}
>   out_new:
> -	f2fs_dentry_kunmap(new_dir, new_page);
>   	f2fs_put_page(new_page, 0);
>   out_old:
> -	f2fs_dentry_kunmap(old_dir, old_page);
>   	f2fs_put_page(old_page, 0);
>   out:
>   	return err;
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 337f336..c5e5c45 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -144,7 +144,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>   retry:
>   	de = __f2fs_find_entry(dir, &fname, &page);
>   	if (de && inode->i_ino == le32_to_cpu(de->ino))
> -		goto out_unmap_put;
> +		goto out_put;
>   
>   	if (de) {
>   		einode = f2fs_iget_retry(inode->i_sb, le32_to_cpu(de->ino));
> @@ -153,19 +153,19 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>   			err = PTR_ERR(einode);
>   			if (err == -ENOENT)
>   				err = -EEXIST;
> -			goto out_unmap_put;
> +			goto out_put;
>   		}
>   
>   		err = dquot_initialize(einode);
>   		if (err) {
>   			iput(einode);
> -			goto out_unmap_put;
> +			goto out_put;
>   		}
>   
>   		err = acquire_orphan_inode(F2FS_I_SB(inode));
>   		if (err) {
>   			iput(einode);
> -			goto out_unmap_put;
> +			goto out_put;
>   		}
>   		f2fs_delete_entry(de, page, dir, einode);
>   		iput(einode);
> @@ -180,8 +180,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>   		goto retry;
>   	goto out;
>   
> -out_unmap_put:
> -	f2fs_dentry_kunmap(dir, page);
> +out_put:
>   	f2fs_put_page(page, 0);
>   out:
>   	if (file_enc_name(inode))
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index f7f0990..96c9bdb 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -46,7 +46,6 @@
>   
>   /* This flag is used by node and meta inodes, and by recovery */
>   #define GFP_F2FS_ZERO		(GFP_NOFS | __GFP_ZERO)
> -#define GFP_F2FS_HIGH_ZERO	(GFP_NOFS | __GFP_ZERO | __GFP_HIGHMEM)
>   
>   /*
>    * For further optimization on multi-head logs, on-disk layout supports maximum
> 

-- 
Thanks,
Yunlong Song
