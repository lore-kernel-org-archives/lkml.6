Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6885FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9F220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9F220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeG3MUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:20:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56513 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbeG3MUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:20:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E83F929A2712D;
        Mon, 30 Jul 2018 18:46:18 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 30 Jul
 2018 18:46:13 +0800
Subject: Re: linux-next: build failure after merge of the staging tree
To:     David Howells <dhowells@redhat.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
References: <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <20180730161622.3837cb15@canb.auug.org.au>
 <2379.1532944057@warthog.procyon.org.uk>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b4645de1-a58f-7615-4f47-7a3fd8c7e056@huawei.com>
Date:   Mon, 30 Jul 2018 18:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <2379.1532944057@warthog.procyon.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for your reply :)

On 2018/7/30 17:47, David Howells wrote:
> Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
>>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
> 
> This should be using SB_* rather than MS_* for interaction with sb->s_flags.

Yes, I saw the related discussion and your submission in the linux-fsdevel mailing list last year. :D
The code of erofs once had to support from 3.13 ~ the current kernel, therefore I didn't turn MS_RDONLY into SB_RDONLY.
But it seems that "vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled" tends to remove them all.

I have submitted a patch to linux-erofs mailing list for preview.
https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html

> 
>>> drivers/staging/erofs/super.c: In function 'erofs_mount':
>>> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
>>>    &priv, erofs_fill_super);
>>>           ^~~~~~~~~~~~~~~~
>>> In file included from include/linux/buffer_head.h:12:0,
>>>                  from drivers/staging/erofs/super.c:14:
>>> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
>>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>>>                        ^~~~~~~~~~
>>> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
>>>   return mount_bdev(fs_type, flags, dev_name,
>>>          ^~~~~~~~~~
> 
> There's a patch in Al Viro's tree that passes a size_t argument indicating the
> size of the mount data from mount down into the filesystem and into the
> helpers as the data may be on a kernel stack or in kernel .rodata rather than
> in a full page of its own.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> 
> Currently this is commit 0a191e4505a4f255e6513b49426213da69bf0e80
> 
> vfs: Require specification of size of mount data for internal mounts

I just fixed according to the latest linux-next tree (the same patchset, also for preview)
https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000284.html

Once I tend to use void *data to pass more mount arguments on stack, eg.

struct erofs_mount_private {
	const char *dev_name;
	char *options;
};
...
struct erofs_mount_private priv = {
	.dev_name = dev_name,
	.options = data
};
return mount_bdev(fs_type, flags, dev_name, &priv, erofs_fill_super);


However, I have no idea if it is safe to do so in the future, so I also change it into a more stardard way.


BTW, It seems that Greg's staging tree doesn't have Al Viro's submission...
And I have little experience to handle that, so I just ask Chao for help...


Thanks for your kindly reminder :)

Thanks,
Gao Xiang

> 
> David
> 
