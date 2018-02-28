Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeB1FsO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeB1FsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:48:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFFC214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Tue, 27 Feb 2018 21:48:10 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com,
        miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Revert "f2fs crypto: avoid unneeded memory allocation
 in ->readdir"
Message-ID: <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
 <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

As Eric pointed out, how do you think using nohighmem for directory likewise
ext4, which looks like more efficient? Actually, we don't need to do this in
most of recent kernels, right?

Thanks,

On 02/28, Yunlong Song wrote:
> This reverts commit e06f86e61d7a67fe6e826010f57aa39c674f4b1b.
> 
> Conflicts:
> 	fs/f2fs/dir.c
> 
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
> Howerver, later patch:
> commit e06f86e61d7a ("f2fs crypto: avoid unneeded memory allocation in ->readdir")
> reverts the codes, which causes panic again in arm, so fix it back to the old version.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index f00b5ed..de2e295 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -825,9 +825,16 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>  			int save_len = fstr->len;
>  			int err;
>  
> +			de_name.name = f2fs_kmalloc(sbi, de_name.len, GFP_NOFS);
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
> -- 
> 1.8.5.2
