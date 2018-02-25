Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeBYJ3H (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 04:29:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeBYJ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 04:29:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA3521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Sun, 25 Feb 2018 01:29:04 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: expose extension_list sysfs entry
Message-ID: <20180225092904.GB13378@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180211145321.11285-1-chao@kernel.org>
 <20180211145321.11285-2-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211145321.11285-2-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> This patch adds a sysfs entry 'extension_list' to support lookup/
> add/delete item in extension list.

Hi Chao,

We need Doc change as well.

Thanks,

> 
> Lookup:
> cat /sys/fs/f2fs/<device>/extentsion_list
> 
> Add:
> echo 'extension' > /sys/fs/f2fs/<device>/extentsion_list
> 
> Delete:
> echo '!extension' > /sys/fs/f2fs/<device>/extentsion_list
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h          |  4 +++-
>  fs/f2fs/file.c          |  4 ++--
>  fs/f2fs/namei.c         | 42 +++++++++++++++++++++++++++++++++++++++---
>  fs/f2fs/super.c         |  2 +-
>  fs/f2fs/sysfs.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/f2fs_fs.h |  3 ++-
>  6 files changed, 87 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0332c44a1d93..030436be2a35 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1048,7 +1048,7 @@ struct f2fs_sb_info {
>  	struct super_block *sb;			/* pointer to VFS super block */
>  	struct proc_dir_entry *s_proc;		/* proc entry */
>  	struct f2fs_super_block *raw_super;	/* raw super block pointer */
> -	struct mutex sb_lock;			/* lock for raw super block */
> +	struct rw_semaphore sb_lock;		/* lock for raw super block */
>  	int valid_super_block;			/* valid super block no */
>  	unsigned long s_flag;				/* flags for sbi */
>  
> @@ -2612,6 +2612,8 @@ void handle_failed_inode(struct inode *inode);
>  /*
>   * namei.c
>   */
> +int update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> +								bool set);
>  struct dentry *f2fs_get_parent(struct dentry *child);
>  
>  /*
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f26a0bd17469..f64bcd0a7f73 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1969,7 +1969,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  	if (err)
>  		return err;
>  
> -	mutex_lock(&sbi->sb_lock);
> +	down_write(&sbi->sb_lock);
>  
>  	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
>  		goto got_it;
> @@ -1988,7 +1988,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  									16))
>  		err = -EFAULT;
>  out_err:
> -	mutex_unlock(&sbi->sb_lock);
> +	up_write(&sbi->sb_lock);
>  	mnt_drop_write_file(filp);
>  	return err;
>  }
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index c4c94c7e9f4f..fa8e5c06ba39 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -171,16 +171,52 @@ static int is_multimedia_file(const unsigned char *s, const char *sub)
>  static inline void set_cold_files(struct f2fs_sb_info *sbi, struct inode *inode,
>  		const unsigned char *name)
>  {
> -	int i;
> -	__u8 (*extlist)[8] = sbi->raw_super->extension_list;
> +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> +	int i, count;
> +
> +	down_read(&sbi->sb_lock);
> +
> +	count = le32_to_cpu(sbi->raw_super->extension_count);
>  
> -	int count = le32_to_cpu(sbi->raw_super->extension_count);
>  	for (i = 0; i < count; i++) {
>  		if (is_multimedia_file(name, extlist[i])) {
>  			file_set_cold(inode);
>  			break;
>  		}
>  	}
> +
> +	up_read(&sbi->sb_lock);
> +}
> +
> +int update_extension_list(struct f2fs_sb_info *sbi, const char *name, bool set)
> +{
> +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> +	int count = le32_to_cpu(sbi->raw_super->extension_count);
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (strcmp(name, extlist[i]))
> +			continue;
> +
> +		if (set)
> +			return -EINVAL;
> +
> +		memcpy(extlist[i], extlist[i + 1],
> +				F2FS_EXTENSION_LEN * (count - i - 1));
> +		memset(extlist[count - 1], 0, F2FS_EXTENSION_LEN);
> +		sbi->raw_super->extension_count = cpu_to_le32(count - 1);
> +		return 0;
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	if (count == F2FS_MAX_EXTENSION)
> +		return -EINVAL;
> +
> +	strncpy(extlist[count], name, strlen(name));
> +	sbi->raw_super->extension_count = cpu_to_le32(count + 1);
> +	return 0;
>  }
>  
>  static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1b49ad477dd9..9b17355434f6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2233,7 +2233,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->dirty_device = 0;
>  	spin_lock_init(&sbi->dev_lock);
>  
> -	mutex_init(&sbi->sb_lock);
> +	init_rwsem(&sbi->sb_lock);
>  }
>  
>  static int init_percpu_info(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 374ee5c82f94..d27b28e602a6 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -136,6 +136,18 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>  	if (!ptr)
>  		return -EINVAL;
>  
> +	if (!strcmp(a->attr.name, "extension_list")) {
> +		__u8 (*extlist)[F2FS_EXTENSION_LEN] =
> +					sbi->raw_super->extension_list;
> +		int count = le32_to_cpu(sbi->raw_super->extension_count);
> +		int len = 0, i;
> +
> +		for (i = 0; i < count; i++)
> +			len += snprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +								extlist[i]);
> +		return len;
> +	}
> +
>  	ui = (unsigned int *)(ptr + a->offset);
>  
>  	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
> @@ -154,6 +166,32 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  	if (!ptr)
>  		return -EINVAL;
>  
> +	if (!strcmp(a->attr.name, "extension_list")) {
> +		const char *name = strim((char *)buf);
> +		bool set = true;
> +
> +		if (name[0] == '!') {
> +			name++;
> +			set = false;
> +		}
> +
> +		if (strlen(name) >= F2FS_EXTENSION_LEN)
> +			return -EINVAL;
> +
> +		down_write(&sbi->sb_lock);
> +
> +		ret = update_extension_list(sbi, name, set);
> +		if (ret)
> +			goto out;
> +
> +		ret = f2fs_commit_super(sbi, false);
> +		if (ret)
> +			update_extension_list(sbi, name, !set);
> +out:
> +		up_write(&sbi->sb_lock);
> +		return ret ? ret : count;
> +	}
> +
>  	ui = (unsigned int *)(ptr + a->offset);
>  
>  	ret = kstrtoul(skip_spaces(buf), 0, &t);
> @@ -307,6 +345,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
>  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
> @@ -357,6 +396,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(readdir_ra),
>  	ATTR_LIST(gc_pin_file_thresh),
> +	ATTR_LIST(extension_list),
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	ATTR_LIST(inject_rate),
>  	ATTR_LIST(inject_type),
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index f7f09907e69d..3d03f51282ac 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -21,6 +21,7 @@
>  #define F2FS_BLKSIZE			4096	/* support only 4KB block */
>  #define F2FS_BLKSIZE_BITS		12	/* bits for F2FS_BLKSIZE */
>  #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
> +#define F2FS_EXTENSION_LEN		8	/* max size of extension */
>  #define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) >> F2FS_BLKSIZE_BITS)
>  
>  #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
> @@ -102,7 +103,7 @@ struct f2fs_super_block {
>  	__u8 uuid[16];			/* 128-bit uuid for volume */
>  	__le16 volume_name[MAX_VOLUME_NAME];	/* volume name */
>  	__le32 extension_count;		/* # of extensions below */
> -	__u8 extension_list[F2FS_MAX_EXTENSION][8];	/* extension array */
> +	__u8 extension_list[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];/* extension array */
>  	__le32 cp_payload;
>  	__u8 version[VERSION_LEN];	/* the kernel version */
>  	__u8 init_version[VERSION_LEN];	/* the initial kernel version */
> -- 
> 2.14.1.145.gb3622a4ee
