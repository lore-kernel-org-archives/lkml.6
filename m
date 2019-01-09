Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D740C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447220883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfAICiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:38:50 -0500
Received: from nautica.notk.org ([91.121.71.147]:38592 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfAICit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:38:49 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AC4A7C01B; Wed,  9 Jan 2019 03:38:47 +0100 (CET)
Date:   Wed, 9 Jan 2019 03:38:32 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net, lucho@ionkov.net,
        ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingaopeng@huawei.com
Subject: Re: [PATCH] 9p: use inode->i_lock to protect i_size_write()
Message-ID: <20190109023832.GA12389@nautica>
References: <20190109020522.105713-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109020522.105713-1-houtao1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hou Tao wrote on Wed, Jan 09, 2019:
> Use inode->i_lock to protect i_size_write(), else i_size_read() in
> generic_fillattr() may loop infinitely when multiple processes invoke
> v9fs_vfs_getattr() or v9fs_vfs_getattr_dotl() simultaneously under
> 32-bit SMP environment, and a soft lockup will be triggered as show below:

Hmm, I'm not familiar with the read/write seqcount code for 32 bit but I
don't understand how locking here helps besides slowing things down (so
if the value is constantly updated, the read thread might have a chance
to be scheduled between two updates which was harder to do before ; and
thus "solving" your soft lockup)

Instead, a better fix would be to update v9fs_stat2inode to first read
the inode size, and only call i_size_write if it changed - I'd bet this
also fixes the problem and looks better than locking to me.
(Can also probably reuse stat->length instead of the following
i_size_read for i_blocks...)



On the other hand it might make sense to also lock the inode for
stat2inode because we're dealing with partially updated inodes at time,
but if we do this I'd rather put the locking in v9fs_stat2inode and not
outside of it to catch all the places where it's used; but the readers
don't lock so I'm not sure it makes much sense.

There's also a window during which the inode's nlink is dropped down to
1 then set again appropriately if the extension is present; that's
rather ugly and we probably should only reset it to 1 if the attribute
wasn't set before... That can be another patch and/or I'll do it
eventually if you don't.

I hope what I said makes sense.

Thanks,
-- 
Dominique Martinet | Asmadeus
