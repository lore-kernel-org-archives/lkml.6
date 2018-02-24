Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBXScf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:32:35 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35613 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeBXScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:32:33 -0500
X-Google-Smtp-Source: AH8x227ln7QIbZJWCPTHp7/sofO5LfXKuZEv+NJLOmOD19Pr5gB/icKfcZUMIO+Z2uMhS+g7R7ytKQ==
Date: Sat, 24 Feb 2018 10:32:30 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Yunlong Song <yunlong.song@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com,
        yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com,
        shengyong1@huawei.com, heyunlei@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: allocate buffer for decrypting filename to avoid
 panic
Message-ID: <20180224183230.GA933@zzz.localdomain>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

On Sat, Feb 24, 2018 at 05:14:58PM +0800, Yunlong Song wrote:
> In some platforms (such as arm), high memory is used, then the
> decrypting filename will cause panic, the reason see commit
> 569cf1876a32e574ba8a7fb825cd91bafd003882 ("f2fs crypto: allocate buffer
> for decrypting filename"):
> 
>  We got dentry pages from high_mem, and its address space directly goes into the
>  decryption path via f2fs_fname_disk_to_usr.
>  But, sg_init_one assumes the address is not from high_mem, so we can get this
>  panic since it doesn't call kmap_high but kunmap_high is triggered at the end.
> 
>  kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
>  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>  ...
>   (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
>   (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
>   (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
>   (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
>   (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
>   (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
>   (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
>   (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
>   (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
>   (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
>   (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)
> 
> Howerver, later patches:
> commit 922ec355f86365388203672119b5bca346a45085 ("f2fs crypto: avoid
> unneeded memory allocation when {en/de}crypting symlink")
> commit e06f86e61d7a67fe6e826010f57aa39c674f4b1b ("f2fs crypto: avoid
> unneeded memory allocation in ->readdir")
> 
> reverts the codes, which causes panic again in arm, so let's add the old
> patch again.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/dir.c   |  7 +++++++
>  fs/f2fs/namei.c | 10 +++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index f00b5ed..c0cf3e7b 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -825,9 +825,16 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>  			int save_len = fstr->len;
>  			int err;
>  
> +			de_name.name = kmalloc(de_name.len, GFP_NOFS);
> +			if (!de_name.name)
> +				return -ENOMEM;
> +
> +			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
> +
>  			err = fscrypt_fname_disk_to_usr(d->inode,
>  						(u32)de->hash_code, 0,
>  						&de_name, fstr);
> +			kfree(de_name.name);
>  			if (err)
>  				return err;
>  
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index c4c94c7..2cb70c1 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1170,8 +1170,13 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>  
>  	/* Symlink is encrypted */
>  	sd = (struct fscrypt_symlink_data *)caddr;
> -	cstr.name = sd->encrypted_path;
>  	cstr.len = le16_to_cpu(sd->len);
> +	cstr.name = kmalloc(cstr.len, GFP_NOFS);
> +	if (!cstr.name) {
> +		res = -ENOMEM;
> +		goto errout;
> +	}
> +	memcpy(cstr.name, sd->encrypted_path, cstr.len);
>  
>  	/* this is broken symlink case */
>  	if (unlikely(cstr.len == 0)) {
> @@ -1198,6 +1203,8 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>  		goto errout;
>  	}
>  
> +	kfree(cstr.name);
> +
>  	paddr = pstr.name;
>  
>  	/* Null-terminate the name */
> @@ -1207,6 +1214,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>  	set_delayed_call(done, kfree_link, paddr);
>  	return paddr;
>  errout:
> +	kfree(cstr.name);
>  	fscrypt_fname_free_buffer(&pstr);
>  	put_page(cpage);
>  	return ERR_PTR(res);
> -- 
> 1.8.5.2
> 

The pagecache for symlinks in f2fs already uses lowmem only, so the change to
->get_link() isn't needed.  Also that part of the patch doesn't apply to
upstream.

For directories we may need your fix.  Note: kmalloc + memcpy should be replaced
with kmemdup.  But alternatively, directory pages could be restricted to lowmem
which would match ext4.

Eric
