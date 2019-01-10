Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984E820665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAJCuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:50:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbfAJCuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:50:25 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E9BD39804EEF78570EA8;
        Thu, 10 Jan 2019 10:50:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 10:50:13 +0800
Subject: Re: [PATCH] 9p: use inode->i_lock to protect i_size_write()
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     <v9fs-developer@lists.sourceforge.net>, <lucho@ionkov.net>,
        <ericvh@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xingaopeng@huawei.com>
References: <20190109020522.105713-1-houtao1@huawei.com>
 <20190109023832.GA12389@nautica>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <831fe284-c9e9-49a4-d530-5af57c2dd9d1@huawei.com>
Date:   Thu, 10 Jan 2019 10:50:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190109023832.GA12389@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2019/1/9 10:38, Dominique Martinet wrote:
> Hou Tao wrote on Wed, Jan 09, 2019:
>> Use inode->i_lock to protect i_size_write(), else i_size_read() in
>> generic_fillattr() may loop infinitely when multiple processes invoke
>> v9fs_vfs_getattr() or v9fs_vfs_getattr_dotl() simultaneously under
>> 32-bit SMP environment, and a soft lockup will be triggered as show below:
> Hmm, I'm not familiar with the read/write seqcount code for 32 bit but I
> don't understand how locking here helps besides slowing things down (so
> if the value is constantly updated, the read thread might have a chance
> to be scheduled between two updates which was harder to do before ; and
> thus "solving" your soft lockup)
i_size_read() will call read_seqcount_begin() under 32-bit SMP environment,
and it may loop in __read_seqcount_begin() infinitely because two or more
invocations of write_seqcount_begin interleave and s->sequence becomes
an odd number. It's noted in comments of i_size_write():

/*
 * NOTE: unlike i_size_read(), i_size_write() does need locking around it
 * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
 * can be lost, resulting in subsequent i_size_read() calls spinning forever.
 */
static inline void i_size_write(struct inode *inode, loff_t i_size)
{
#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
    preempt_disable();
    write_seqcount_begin(&inode->i_size_seqcount);
    inode->i_size = i_size;
    write_seqcount_end(&inode->i_size_seqcount);
    preempt_enable();
#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
    preempt_disable();
    inode->i_size = i_size;
    preempt_enable();
#else
    inode->i_size = i_size;
#endif
}

> Instead, a better fix would be to update v9fs_stat2inode to first read
> the inode size, and only call i_size_write if it changed - I'd bet this
> also fixes the problem and looks better than locking to me.
> (Can also probably reuse stat->length instead of the following
> i_size_read for i_blocks...)
For read-only case, this fix will work. However if the inode size is changed
constantly, there will be two or more callers of i_size_write() and the soft-lockup
is still possible.

>
> On the other hand it might make sense to also lock the inode for
> stat2inode because we're dealing with partially updated inodes at time,
> but if we do this I'd rather put the locking in v9fs_stat2inode and not
> outside of it to catch all the places where it's used; but the readers
> don't lock so I'm not sure it makes much sense.
Moving lock into v9fs_stat2inode() sounds reasonable. There are callers
which don't need it (e.g. v9fs_qid_iget() uses it to fill attribute for a
newly-created inode and v9fs_mount() uses it to fill attribute for root inode),
so i will rename v9fs_stat2inode() to v9fs_stat2inode_nolock(), and wrap
v9fs_stat2inode() upon v9fs_stat2inode_nolock().

>
> There's also a window during which the inode's nlink is dropped down to
> 1 then set again appropriately if the extension is present; that's
> rather ugly and we probably should only reset it to 1 if the attribute
> wasn't set before... That can be another patch and/or I'll do it
> eventually if you don't.
I can not follow that. Do you mean inode->i_nlink may be updated concurrently
by v9fs_stat2inode() and v9fs_remove() and that will lead to corruption of i_nlink ?

I also note a race about updating of v9inode->cache_validity. It seems that it is possible
the clear of V9FS_INO_INVALID_ATTR in v9fs_remove() may lost if there are invocations of
v9fs_vfs_getattr() in the same time. We may need to ensure V9FS_INO_INVALID_ATTR is enabled
before clearing it atomically in v9fs_vfs_getattr() and i will send another patch for it.

Regards,
Tao
> I hope what I said makes sense.
>
> Thanks,


