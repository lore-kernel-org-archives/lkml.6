Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeAaCCR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbeAaCCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:02:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975162173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Tue, 30 Jan 2018 18:02:13 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: support {d,id,did,x}node checksum
Message-ID: <20180131020213.GA86468@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180127094301.29154-1-yuchao0@huawei.com>
 <20180127094301.29154-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127094301.29154-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/27, Chao Yu wrote:
> This patch adds to support {d,id,did,x}node checksum in kernel side.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h          | 15 +++++++-
>  fs/f2fs/inode.c         | 98 +++++++++++++++++++++++++++++++------------------
>  fs/f2fs/node.c          |  2 +-
>  fs/f2fs/segment.c       |  2 +-
>  fs/f2fs/sysfs.c         |  7 ++++
>  include/linux/f2fs_fs.h | 10 ++++-
>  6 files changed, 93 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6f5e41657c62..ad48d389fea4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -128,6 +128,7 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_QUOTA_INO		0x0080
>  #define F2FS_FEATURE_INODE_CRTIME	0x0100
>  #define F2FS_FEATURE_EXTENDED_NODE	0x0200
> +#define F2FS_FEATURE_NODE_CHECKSUM	0x0400
>  
>  #define F2FS_HAS_FEATURE(sb, mask)					\
>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -2570,6 +2571,11 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>  		sizeof((f2fs_inode)->field))			\
>  		<= (F2FS_OLD_ATTRIBUTE_SIZE + extra_isize))	\
>  
> +#define F2FS_FITS_IN_NODE(extra_nsize, field)		\
> +		((offsetof(struct f2fs_node, footer) -	\
> +		offsetof(struct f2fs_node, field))	\
> +		<= (extra_nsize))			\
> +
>  static inline void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
>  {
>  	int i;
> @@ -2616,8 +2622,8 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
>   * inode.c
>   */
>  void f2fs_set_inode_flags(struct inode *inode);
> -bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
> -void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
> +bool f2fs_node_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
> +void f2fs_node_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
>  struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
>  struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
>  int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
> @@ -3252,6 +3258,11 @@ static inline int f2fs_sb_has_extended_node(struct super_block *sb)
>  	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_EXTENDED_NODE);
>  }
>  
> +static inline int f2fs_sb_has_node_checksum(struct super_block *sb)
> +{
> +	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_NODE_CHECKSUM);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>  			struct block_device *bdev, block_t blkaddr)
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index f5b5606ca273..f879f0a65986 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -111,75 +111,103 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
>  	return;
>  }
>  
> -static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page)
> +static bool f2fs_enable_node_chksum(struct f2fs_sb_info *sbi, struct page *page)
>  {
> -	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
> -	int extra_isize = le32_to_cpu(ri->i_extra_isize);
> -
> -	if (!f2fs_sb_has_inode_chksum(sbi->sb))
> -		return false;
> -
> -	if (!RAW_IS_INODE(F2FS_NODE(page)) || !(ri->i_inline & F2FS_EXTRA_ATTR))
> -		return false;
> -
> -	if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
> -		return false;
> +	if (IS_INODE(page)) {
> +		struct f2fs_inode *ri = &F2FS_NODE(page)->i;
> +		int extra_isize = le32_to_cpu(ri->i_extra_isize);
> +
> +		if (!(ri->i_inline & F2FS_EXTRA_ATTR))
> +			return false;
> +		if (!f2fs_sb_has_inode_chksum(sbi->sb))
> +			return false;
> +		if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
> +			return false;
> +	} else {
> +		if (!f2fs_sb_has_extended_node(sbi->sb))
> +			return false;

What if we want to add more entries in addition to node_checksum? Do we have
to add a new feature flag at every time? How about adding a layout value instead
of extra_nsize? For example, layout #1 means node_checksum with extra_nsize=X?

> +		if (!f2fs_sb_has_node_checksum(sbi->sb))
> +			return false;
> +		if (!F2FS_FITS_IN_NODE(sbi->extra_nsize, node_checksum))
> +			return false;
> +	}
>  
>  	return true;
>  }
>  
> -static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct page *page)
> +static __u32 f2fs_node_chksum(struct f2fs_sb_info *sbi, struct page *page)
>  {
>  	struct f2fs_node *node = F2FS_NODE(page);
> -	struct f2fs_inode *ri = &node->i;
> -	__le32 ino = node->footer.ino;
> -	__le32 gen = ri->i_generation;
> -	__u32 chksum, chksum_seed;
> -	__u32 dummy_cs = 0;
> -	unsigned int offset = offsetof(struct f2fs_inode, i_inode_checksum);
> -	unsigned int cs_size = sizeof(dummy_cs);
> +	__le32 append, ino = node->footer.ino;
> +	__u32 chksum, chksum_seed, dummy_cs = 0;
> +	unsigned int offset, cs_size = sizeof(dummy_cs);
> +	bool is_inode = RAW_IS_INODE(node);
> +
> +	if (is_inode) {
> +		append = node->i.i_generation;
> +		offset = offsetof(struct f2fs_inode, i_inode_checksum);
> +	} else {
> +		append = node->footer.nid;
> +		offset = offsetof(struct f2fs_node, node_checksum);
> +	}
>  
>  	chksum = f2fs_chksum(sbi, sbi->s_chksum_seed, (__u8 *)&ino,
>  							sizeof(ino));
> -	chksum_seed = f2fs_chksum(sbi, chksum, (__u8 *)&gen, sizeof(gen));
> +	chksum_seed = f2fs_chksum(sbi, chksum, (__u8 *)&append, sizeof(append));
>  
> -	chksum = f2fs_chksum(sbi, chksum_seed, (__u8 *)ri, offset);
> +	chksum = f2fs_chksum(sbi, chksum_seed, (__u8 *)node, offset);
>  	chksum = f2fs_chksum(sbi, chksum, (__u8 *)&dummy_cs, cs_size);
>  	offset += cs_size;
> -	chksum = f2fs_chksum(sbi, chksum, (__u8 *)ri + offset,
> +	chksum = f2fs_chksum(sbi, chksum, (__u8 *)node + offset,
>  						F2FS_BLKSIZE - offset);
>  	return chksum;
>  }
>  
> -bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
> +bool f2fs_node_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
>  {
> -	struct f2fs_inode *ri;
> +	struct f2fs_node *rn;
>  	__u32 provided, calculated;
>  
> -	if (!f2fs_enable_inode_chksum(sbi, page) ||
> +	if (!f2fs_enable_node_chksum(sbi, page) ||
>  			PageDirty(page) || PageWriteback(page))
>  		return true;
>  
> -	ri = &F2FS_NODE(page)->i;
> -	provided = le32_to_cpu(ri->i_inode_checksum);
> -	calculated = f2fs_inode_chksum(sbi, page);
> +	rn = F2FS_NODE(page);
> +	if (RAW_IS_INODE(rn))
> +		provided = le32_to_cpu(rn->i.i_inode_checksum);
> +	else
> +		provided = le32_to_cpu(rn->node_checksum);
> +	calculated = f2fs_node_chksum(sbi, page);
>  
>  	if (provided != calculated)
>  		f2fs_msg(sbi->sb, KERN_WARNING,
> -			"checksum invalid, ino = %x, %x vs. %x",
> -			ino_of_node(page), provided, calculated);
> +			"checksum invalid, ino = %u, nid = %u, %x vs. %x",
> +			ino_of_node(page), nid_of_node(page),
> +			provided, calculated);
> +
> +	else
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"checksum is valid, ino = %u, nid = %u, %x vs. %x",
> +			ino_of_node(page), nid_of_node(page),
> +			provided, calculated);

Need to clean up.

>  
>  	return provided == calculated;
>  }
>  
> -void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
> +void f2fs_node_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
>  {
> -	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
> +	struct f2fs_node *rn = F2FS_NODE(page);
> +	__le32 chksum;
>  
> -	if (!f2fs_enable_inode_chksum(sbi, page))
> +	if (!f2fs_enable_node_chksum(sbi, page))
>  		return;
>  
> -	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
> +	chksum = cpu_to_le32(f2fs_node_chksum(sbi, page));
> +
> +	if (RAW_IS_INODE(rn))
> +		rn->i.i_inode_checksum = chksum;
> +	else
> +		rn->node_checksum = chksum;
>  }
>  
>  static int do_read_inode(struct inode *inode)
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index bc8424babf36..613e6bc65f9c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1194,7 +1194,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>  		goto out_err;
>  	}
>  
> -	if (!f2fs_inode_chksum_verify(sbi, page)) {
> +	if (!f2fs_node_chksum_verify(sbi, page)) {
>  		err = -EBADMSG;
>  		goto out_err;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ba8cd4e5ad75..5aa2c24cdcd8 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2678,7 +2678,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	if (page && IS_NODESEG(type)) {
>  		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
>  
> -		f2fs_inode_chksum_set(sbi, page);
> +		f2fs_node_chksum_set(sbi, page);
>  	}
>  
>  	if (add_list) {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f25a6fc0a17e..24d3b82c7bf0 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -119,6 +119,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>  	if (f2fs_sb_has_extended_node(sb))
>  		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "extended_node");
> +	if (f2fs_sb_has_node_checksum(sb))
> +		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "node_checksum");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>  	return len;
>  }
> @@ -240,6 +243,7 @@ enum feat_id {
>  	FEAT_QUOTA_INO,
>  	FEAT_INODE_CRTIME,
>  	FEAT_EXTENDED_NODE,
> +	FEAT_NODE_CHECKSUM,
>  };
>  
>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -256,6 +260,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	case FEAT_QUOTA_INO:
>  	case FEAT_INODE_CRTIME:
>  	case FEAT_EXTENDED_NODE:
> +	case FEAT_NODE_CHECKSUM:
>  		return snprintf(buf, PAGE_SIZE, "supported\n");
>  	}
>  	return 0;
> @@ -335,6 +340,7 @@ F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
>  F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
>  F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
>  F2FS_FEATURE_RO_ATTR(extended_node, FEAT_EXTENDED_NODE);
> +F2FS_FEATURE_RO_ATTR(node_checksum, FEAT_NODE_CHECKSUM);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
> @@ -390,6 +396,7 @@ static struct attribute *f2fs_feat_attrs[] = {
>  	ATTR_LIST(quota_ino),
>  	ATTR_LIST(inode_crtime),
>  	ATTR_LIST(extended_node),
> +	ATTR_LIST(node_checksum),
>  	NULL,
>  };
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index a6bacfdd378d..941b5330c504 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -295,8 +295,14 @@ struct f2fs_node {
>  	/* can be one of three types: inode, direct, and indirect types */
>  	union {
>  		struct f2fs_inode i;
> -		struct direct_node dn;
> -		struct indirect_node in;
> +		union {
> +			struct {
> +				__le32 data[1017];
> +				__le32 node_checksum;

What does 1017 mean? We need to make this structure more flexibly for new
entries. Like this?
		union {
			struct node_v1;
			struct node_v2;
			struct node_v3;
			...
			struct direct_node dn;
			struct indirect_node in;
		};
	};

	struct node_v1 {
		__le32 data[DEF_ADDRS_PER_BLOCK - V1_NSIZE=1];
		__le32 node_checksum;
	}

	struct node_v2 {
		__le32 data[DEF_ADDRS_PER_BLOCK - V2_NSIZE=500];
		__le32 comp[V2_NSIZE];
	}
	...

> +			};
> +			struct direct_node dn;
> +			struct indirect_node in;
> +		};
>  	};
>  	struct node_footer footer;
>  } __packed;
> -- 
> 2.15.0.55.gc2ece9dc4de6
