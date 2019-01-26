Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB73EC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B8221902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAZCsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 21:48:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfAZCsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 21:48:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CBA3035207AF64052123;
        Sat, 26 Jan 2019 10:48:50 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 10:48:42 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
Date:   Sat, 26 Jan 2019 10:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190125161007.4447-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/26 0:10, Gao Xiang wrote:
> Let's add .get_acl() to read the file's acl from its xattrs
> to make POSIX ACL usable.
> 
> Here is the on-disk detail,
> fullname: system.posix_acl_access
> struct erofs_xattr_entry:
>         .e_name_len = 0
>         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
> 
> fullname: system.posix_acl_default
> struct erofs_xattr_entry:
> 	.e_name_len = 0
> 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v2:
>  - add the missing SB_POSIXACL flag;
>  - fix the on-disk detail, use .e_name_len == 0 and proper prefix value;
>  - tested ok with xattr enabled erofs_mkfs;
> 
>  .../erofs/Documentation/filesystems/erofs.txt      |  2 ++
>  drivers/staging/erofs/inode.c                      |  3 ++
>  drivers/staging/erofs/namei.c                      |  1 +
>  drivers/staging/erofs/super.c                      |  8 +++++
>  drivers/staging/erofs/xattr.c                      | 37 ++++++++++++++++++++++
>  drivers/staging/erofs/xattr.h                      |  6 ++++
>  6 files changed, 57 insertions(+)
> 
> diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> index 803988d74c21..961ec4da7705 100644
> --- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> +++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> @@ -36,6 +36,8 @@ Here is the main features of EROFS:
>  
>   - Support xattr inline and tail-end data inline for all files;
>  
> + - Support POSIX.1e ACLs by using xattrs;
> +
>   - Support transparent file compression as an option:
>     LZ4 algorithm with 4 KB fixed-output compression for high performance;
>  
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 4f04f7c38cf2..924b8dfc7a8f 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -287,6 +287,7 @@ const struct inode_operations erofs_generic_iops = {
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
>  #endif
> +	.get_acl = erofs_get_acl,
>  };
>  
>  const struct inode_operations erofs_symlink_iops = {
> @@ -294,6 +295,7 @@ const struct inode_operations erofs_symlink_iops = {
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
>  #endif
> +	.get_acl = erofs_get_acl,
>  };
>  
>  const struct inode_operations erofs_fast_symlink_iops = {
> @@ -301,5 +303,6 @@ const struct inode_operations erofs_fast_symlink_iops = {
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
>  #endif
> +	.get_acl = erofs_get_acl,
>  };
>  
> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> index 7fed1f996ab0..b1752adc5934 100644
> --- a/drivers/staging/erofs/namei.c
> +++ b/drivers/staging/erofs/namei.c
> @@ -238,5 +238,6 @@ const struct inode_operations erofs_dir_iops = {
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	.listxattr = erofs_listxattr,
>  #endif
> +	.get_acl = erofs_get_acl,
>  };
>  
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 176fca2af379..54cd7dac0a1f 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -398,6 +398,14 @@ static int erofs_read_super(struct super_block *sb,
>  	if (!silent)
>  		infoln("root inode @ nid %llu", ROOT_NID(sbi));
>  
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +	/* Update the POSIXACL Flag */
> +	if (test_opt(sbi, POSIX_ACL))
> +		sb->s_flags |= SB_POSIXACL;
> +	else
> +		sb->s_flags &= ~SB_POSIXACL;
> +#endif
> +
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
>  #endif
> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> index 7de46690d972..6759485ae862 100644
> --- a/drivers/staging/erofs/xattr.c
> +++ b/drivers/staging/erofs/xattr.c
> @@ -643,3 +643,40 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  	return shared_listxattr(&it);
>  }
>  
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +struct posix_acl *erofs_get_acl(struct inode *inode, int type)
> +{
> +	struct posix_acl *acl;
> +	int ea_prefix, rc;
> +	char *value = NULL;
> +
> +	switch(type) {
> +	case ACL_TYPE_ACCESS:
> +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
> +		break;
> +	case ACL_TYPE_DEFAULT:
> +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
> +		break;
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	rc = erofs_getxattr(inode, ea_prefix, "", NULL, 0);
> +	if (rc > 0) {
> +		value = kvmalloc(rc, GFP_KERNEL);

erofs_kmalloc() is enough?

Thanks,

> +		if (!value)
> +			return ERR_PTR(-ENOMEM);
> +		rc = erofs_getxattr(inode, ea_prefix, "", value, rc);
> +	}
> +
> +	if (rc == -ENOATTR)
> +		acl = NULL;
> +	else if (rc < 0)
> +		acl = ERR_PTR(rc);
> +	else
> +		acl = posix_acl_from_xattr(&init_user_ns, value, rc);
> +	kvfree(value);
> +	return acl;
> +}
> +#endif
> +
> diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
> index 634dae9aaa0b..35ba5ac2139a 100644
> --- a/drivers/staging/erofs/xattr.h
> +++ b/drivers/staging/erofs/xattr.h
> @@ -87,5 +87,11 @@ static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
>  }
>  #endif
>  
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +struct posix_acl *erofs_get_acl(struct inode *inode, int type);
> +#else
> +#define erofs_get_acl	(NULL)
> +#endif
> +
>  #endif
>  
> 

