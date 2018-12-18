Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2217C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B709A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLRVKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:10:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:10:00 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67B13CA0;
        Tue, 18 Dec 2018 21:09:59 +0000 (UTC)
Date:   Tue, 18 Dec 2018 13:09:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        DmitryVyukov <dvyukov@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-Id: <20181218130958.88ac9d638c717a1ab1db9dc3@linux-foundation.org>
In-Reply-To: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
References: <00000000000051e9c2057d31a563@google.com>
        <20181217072144.GQ2217@ZenIV.linux.org.uk>
        <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
        <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 19:34:57 +0800 Ian Kent <raven@themaw.net> wrote:

> > See 
> > https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > 
> > I think this will fix it, I'll forward it to Andrew if you agree:
> 
> Actually, looking at it again the above patch is plain not needed,
> dropping it and updating the patch which follows it in the series
> is what needs to be done.
> 
> Andrew, what should I do to make this easiest for you to handle,
> a respost with v2 in the subject of the patch affected by dropping
> the above patch?

I dropped the patch and fixed up the fallout.

The patch wasn't true anyway.  "There is no check at all for a failure
to allocate the root inode in autofs_fill_super(), handle it." In fact,
d_make_root(NULL) will just return NULL and autofs_fill_super() handles
that appropriately.

However let's note that when autofs_get_inode() or d_make_root() fail,
autofs_fill_super() will return -EINVAL.  Should have been -ENOMEM, I
guess?

