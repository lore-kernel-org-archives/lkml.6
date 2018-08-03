Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB47C46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAA21711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAA21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeHCD3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:29:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731899AbeHCD3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:29:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62DC94489F394;
        Fri,  3 Aug 2018 09:35:51 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 09:35:46 +0800
Subject: Re: [PATCH v3] staging: erofs: disable compiling temporarile
To:     Greg KH <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>
CC:     <devel@driverdev.osuosl.org>, Gao Xiang <gaoxiang25@huawei.com>,
        <sfr@canb.auug.org.au>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20180802143455.9214-1-chao@kernel.org>
 <20180802173319.GB24125@kroah.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4f4df005-b894-e64b-e7f0-a0415db56109@huawei.com>
Date:   Fri, 3 Aug 2018 09:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802173319.GB24125@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/3 1:33, Greg KH wrote:
> On Thu, Aug 02, 2018 at 10:34:55PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> As Stephen Rothwell reported:
>>
>> "After merging the staging tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/staging/erofs/super.c: In function 'erofs_read_super':
>> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>>                  ^~~~~~~~~
>>                  IS_RDONLY
>> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>>                              ^~~~~~~~~~
>>                              S_NOATIME
>> drivers/staging/erofs/super.c: In function 'erofs_mount':
>> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
>>    &priv, erofs_fill_super);
>>           ^~~~~~~~~~~~~~~~
>> In file included from include/linux/buffer_head.h:12:0,
>>                  from drivers/staging/erofs/super.c:14:
>> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>>                        ^~~~~~~~~~
>> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
>>   return mount_bdev(fs_type, flags, dev_name,
>>          ^~~~~~~~~~
>> In file included from include/linux/buffer_head.h:12:0,
>>                  from drivers/staging/erofs/super.c:14:
>> include/linux/fs.h:2151:23: note: declared here
>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>>                        ^~~~~~~~~~
>> drivers/staging/erofs/super.c: At top level:
>> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>   .mount          = erofs_mount,
>>                     ^~~~~~~~~~~
>> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
>> drivers/staging/erofs/super.c: In function 'erofs_remount':
>> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>>   *flags |= MS_RDONLY;
>>             ^~~~~~~~~
>>             IS_RDONLY
>> drivers/staging/erofs/super.c: At top level:
>> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>   .remount_fs = erofs_remount,
>>                 ^~~~~~~~~~~~~
>>
>> Caused by various commits creating erofs in the staging tree interacting
>> with various commits redoing the mount infrastructure in the vfs tree.
>>
>> I have disabed CONFIG_EROFS_FS for now:"
>>
>> The reason of compiling error is:
>>
>> Since -next collects and merges developing patches including common vfs
>> stuff from multi-trees, but those patches didn't cover erofs, such as:
>>
>> ('vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
>> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=109b45090d7d3ce2797bb1ef7f70eead5bfe0ff3
>>
>> ("vfs: Require specification of size of mount data for internal mounts")
>> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0a191e4505a4f255e6513b49426213da69bf0e80
>>
>> Above vfs related patches has not been merged in staging tree, if we
>> submit those erofs patches to staging mailing list and after including
>> them in staging-{test,nexts} tree, it can easily cause compiling error.
>>
>> We worked out some patches to adjust those vfs change, but now we just
>> submit them to -next tree temporarily to avoid compiling error.
>>
>> For potentail conflict in between erofs and vfs changes in incoming
>> merge window, Stephen suggested that we can disable CONFIG_EROFS_FS
>> temporarily to pass merge window, and after that we can do restore by
>> reenabling CONFIG_EROFS_FS and applying those fixing patches. Also
>> Greg confirmed this solution.
>>
>> So, let's disable compiling erofs for a while.
>>
>> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3: remain "depends on BLOCK".
>>  drivers/staging/erofs/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
>> index 663b755bf2fb..b37d994aa687 100644
>> --- a/drivers/staging/erofs/Kconfig
>> +++ b/drivers/staging/erofs/Kconfig
>> @@ -3,6 +3,7 @@
>>  config EROFS_FS
>>  	tristate "EROFS filesystem support"
>>  	depends on BLOCK
>> +	depends on BROKEN
>>  	help
>>  	  EROFS(Enhanced Read-Only File System) is a lightweight
>>  	  read-only file system with modern designs (eg. page-sized
> 
> Sorry, I already took the first version in my tree.  Don't worry about

I can see it in staging tree, thanks for quickly applying.

> it for now you can fix this up after 4.19-rc1 is out when we enable the
> filesystem again.

OK, we will prepare for it.

Thanks,

> 
> thanks,
> 
> greg k-h
> 
> .
> 

