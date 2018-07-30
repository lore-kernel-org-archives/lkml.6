Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEFC20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEFC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeG3IF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:05:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbeG3IF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:05:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EFBA437D6B767;
        Mon, 30 Jul 2018 14:32:24 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 30 Jul
 2018 14:32:19 +0800
Subject: Re: linux-next: build failure after merge of the staging tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
References: <20180730161622.3837cb15@canb.auug.org.au>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
Date:   Mon, 30 Jul 2018 14:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180730161622.3837cb15@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2018/7/30 14:16, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/staging/erofs/super.c: In function 'erofs_read_super':
> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>                  ^~~~~~~~~
>                  IS_RDONLY
> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>                              ^~~~~~~~~~
>                              S_NOATIME
> drivers/staging/erofs/super.c: In function 'erofs_mount':
> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
>    &priv, erofs_fill_super);
>           ^~~~~~~~~~~~~~~~
> In file included from include/linux/buffer_head.h:12:0,
>                  from drivers/staging/erofs/super.c:14:
> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>                        ^~~~~~~~~~
> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
>   return mount_bdev(fs_type, flags, dev_name,
>          ^~~~~~~~~~
> In file included from include/linux/buffer_head.h:12:0,
>                  from drivers/staging/erofs/super.c:14:
> include/linux/fs.h:2151:23: note: declared here
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>                        ^~~~~~~~~~
> drivers/staging/erofs/super.c: At top level:
> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .mount          = erofs_mount,
>                     ^~~~~~~~~~~
> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
> drivers/staging/erofs/super.c: In function 'erofs_remount':
> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>   *flags |= MS_RDONLY;
>             ^~~~~~~~~
>             IS_RDONLY
> drivers/staging/erofs/super.c: At top level:
> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .remount_fs = erofs_remount,
>                 ^~~~~~~~~~~~~
> 
> Caused by various commits creating erofs in the staging tree interacting
> with various commits redoing the mount infrastructure in the vfs tree.
> 
> I have disabed CONFIG_EROFS_FS for now:

I will fix them as soon as possible, and test it with the latest linux-next code.
It seems caused by some vfs changes.

Thanks,
Gao Xiang
