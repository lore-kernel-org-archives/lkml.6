Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF99214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeLXDr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 22:47:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeLXDr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 22:47:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75D819909DF77;
        Mon, 24 Dec 2018 11:47:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.33.43) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 11:47:51 +0800
Subject: Re: [PATCH] debugfs: remove inc_nlink in debugfs_create_automount
To:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181222084536.21305-1-yangerkun@huawei.com>
 <20181222112512.GA27683@kroah.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <c97fd5c9-c9aa-7f27-30fb-115e59f17389@huawei.com>
Date:   Mon, 24 Dec 2018 11:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181222112512.GA27683@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.33.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote on 2018/12/22 19:25:
> On Sat, Dec 22, 2018 at 04:45:36PM +0800, yangerkun wrote:
>> Remove inc_nlink in debugfs_create_automount, or this inode will never
>> be free.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/debugfs/inode.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index 13b01351dd1c..9294238e364f 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -551,12 +551,11 @@ struct dentry *debugfs_create_automount(const char *name,
>>   	if (unlikely(!inode))
>>   		return failed_creating(dentry);
>>   
>> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>>   	make_empty_dir_inode(inode);
>>   	inode->i_flags |= S_AUTOMOUNT;
>>   	inode->i_private = data;
>>   	dentry->d_fsdata = (void *)f;
>> -	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>> -	inc_nlink(inode);
> 
> Again, have you tested this and how?  How did you find this issue?
> 
> thanks,
> 
> greg k-h
> 
> .
> 
Thanks a lot for Al Viro's explain.

I was confusing about i_nlink and i_count before, so after insert and 
remove module show as below, i think the inode can still exist with 
nlink will be 1.

So the only problem is that the nlink should be 2 for a empty dir, and 
for debugfs,the influence is that the stat for the dir. Right?

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/debugfs.h>

static char *name = "test-dir";
module_param(name, charp, 0644);
MODULE_PARM_DESC(name, "Get an string(char *) value from user...\n");

struct inode *inode;

int init_module(void)
{
     struct dentry *dentry;

     dentry = debugfs_create_automount(name, NULL, NULL, NULL);
     inode = dentry->d_inode;
     debugfs_remove(dentry);
     return 0;
}

void cleanup_module(void)
{
     printk("%d\n", inode->i_nlink);
}

MODULE_LICENSE("GPL");

Thanks,
Kun.

