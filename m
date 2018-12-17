Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ABBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6664206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeLQHVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:21:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50578 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeLQHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:21:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gYnDk-0000cv-DJ; Mon, 17 Dec 2018 07:21:44 +0000
Date:   Mon, 17 Dec 2018 07:21:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20181217072144.GQ2217@ZenIV.linux.org.uk>
References: <00000000000051e9c2057d31a563@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000051e9c2057d31a563@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> 
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc mm/slab.c:3365 [inline]
>  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
>  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:1566!
>  d_alloc_anon fs/dcache.c:1698 [inline]
>  d_make_root+0x43/0xc0 fs/dcache.c:1885
>  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273

Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.
iput() can be called by d_make_root(), provided that dentry allocation
fails.  So the most straightforward interpretation would be that we
had an allocation failure (injected?), followed by iput() of the inode
passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
of that inode somehow, which should be impossible short of seriously
buggered inode refcounting somewhere - the inode has just been returned
by new_inode(), which clears i_state, and it would have to have passed
clear_inode() (i.e. has been through inode eviction) since then...
