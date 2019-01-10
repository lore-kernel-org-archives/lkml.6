Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FEBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171D206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfAJESZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:18:25 -0500
Received: from nautica.notk.org ([91.121.71.147]:58342 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfAJESZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:18:25 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A04F6C01B; Thu, 10 Jan 2019 05:18:20 +0100 (CET)
Date:   Thu, 10 Jan 2019 05:18:05 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net, lucho@ionkov.net,
        ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingaopeng@huawei.com
Subject: Re: [PATCH] 9p: use inode->i_lock to protect i_size_write()
Message-ID: <20190110041805.GA7316@nautica>
References: <20190109020522.105713-1-houtao1@huawei.com>
 <20190109023832.GA12389@nautica>
 <831fe284-c9e9-49a4-d530-5af57c2dd9d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <831fe284-c9e9-49a4-d530-5af57c2dd9d1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hou Tao wrote on Thu, Jan 10, 2019:
> > Hmm, I'm not familiar with the read/write seqcount code for 32 bit but I
> > don't understand how locking here helps besides slowing things down (so
> > if the value is constantly updated, the read thread might have a chance
> > to be scheduled between two updates which was harder to do before ; and
> > thus "solving" your soft lockup)
>
> i_size_read() will call read_seqcount_begin() under 32-bit SMP environment,
> and it may loop in __read_seqcount_begin() infinitely because two or more
> invocations of write_seqcount_begin interleave and s->sequence becomes
> an odd number. It's noted in comments of i_size_write():
> 
> /*
>  * NOTE: unlike i_size_read(), i_size_write() does need locking around it
>  * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
>  * can be lost, resulting in subsequent i_size_read() calls spinning forever.
>  */

I see, I wasn't aware of how seqcount worked in details but it is a
simple seq++ with barrier so that does indeed need locking.
I had misunderstood the lockup reason as simply the value being updated
all the time.

> > Instead, a better fix would be to update v9fs_stat2inode to first read
> > the inode size, and only call i_size_write if it changed - I'd bet this
> > also fixes the problem and looks better than locking to me.
> > (Can also probably reuse stat->length instead of the following
> > i_size_read for i_blocks...)
>
> For read-only case, this fix will work. However if the inode size is changed
> constantly, there will be two or more callers of i_size_write() and the soft-lockup
> is still possible.

You are right. We can still do this as an optimization to not take the
lock in the read-only case, but otherwise it's safe to forget about this
comment.
 
> > On the other hand it might make sense to also lock the inode for
> > stat2inode because we're dealing with partially updated inodes at time,
> > but if we do this I'd rather put the locking in v9fs_stat2inode and not
> > outside of it to catch all the places where it's used; but the readers
> > don't lock so I'm not sure it makes much sense.
>
> Moving lock into v9fs_stat2inode() sounds reasonable. There are callers
> which don't need it (e.g. v9fs_qid_iget() uses it to fill attribute for a
> newly-created inode and v9fs_mount() uses it to fill attribute for root inode),
> so i will rename v9fs_stat2inode() to v9fs_stat2inode_nolock(), and wrap
> v9fs_stat2inode() upon v9fs_stat2inode_nolock().

If it's a newly created inode there is no contention and the spinlock
has virtually no cost ; and v9fs_mount's root inode is the same.
Let's keep this simple and always lock around i_size_write.

> > There's also a window during which the inode's nlink is dropped down to
> > 1 then set again appropriately if the extension is present; that's
> > rather ugly and we probably should only reset it to 1 if the attribute
> > wasn't set before... That can be another patch and/or I'll do it
> > eventually if you don't.
>
> I can not follow that. Do you mean inode->i_nlink may be updated concurrently
> by v9fs_stat2inode() and v9fs_remove() and that will lead to corruption of i_nlink ?

Not corruption, but the value can be incoherent for a short while.
If another thread looks at nlink continuously it can see the value being
reset to 1 for a short time when there really is no reason to.

I think this isn't as important as the other issues you've raised, so
don't worry about this point unless you want to.

> I also note a race about updating of v9inode->cache_validity. It seems
> that it is possible the clear of V9FS_INO_INVALID_ATTR in
> v9fs_remove() may lost if there are invocations of v9fs_vfs_getattr()
> in the same time. We may need to ensure V9FS_INO_INVALID_ATTR is
> enabled before clearing it atomically in v9fs_vfs_getattr() and i will
> send another patch for it.

There are many places setting this flag but that appears correct this
isn't safe.

It's more complicated than what you're saying though, e.g. even if the
flag was already set at the start of v9fs_vfs_getattr, if another thread
"sets it again" while it is running we need not to unset it -- so
basically this needs to be a 3-value:
 - valid
 - invalid
 - invalid-being-refreshed

v9fs_invalidate_inode_attr would set it to invalid regardless of the
previous state.
start of v9fs_vfs_getattr would set it to invalid-being-refreshed (iff
it was invalid? always?)
end of v9fs_vfs_getattr/v9fs_stat2inode would set it back to valid iff
it is invalid-being-refreshed.


You cannot clear the flag at the start of v9fs_vfs_getattr() because
another getattr in parallel needs to know it cannot trust the cached
value; currently that parallel getattr call would issue another stat
request to the server but if we implement this we could wait until the
flag becomes valid (I'm not sure if it's appropriate to poll the value
even if we yield, so this might need a mutex or other lock that can
sleep though...); well, for now it's ok to behave like we currently do
and also proceed on to refresh the attribute in that other thread, we
can think about handling it better incrementally

Thanks,
-- 
Dominique
