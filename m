Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C96CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2AC2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeKQTLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 14:11:47 -0500
Received: from nautica.notk.org ([91.121.71.147]:46075 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeKQTLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 14:11:47 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B7FBFC009; Sat, 17 Nov 2018 09:55:46 +0100 (CET)
Date:   Sat, 17 Nov 2018 09:55:31 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: WARNING: refcount bug in p9_req_put
Message-ID: <20181117085531.GB24182@nautica>
References: <000000000000eb6a8e057ab79f82@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000eb6a8e057ab79f82@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote on Thu, Nov 15, 2018:
> RIP: 0010:refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
> Code: 89 de e8 ea 1a ed fd 84 db 74 07 31 db e9 4d ff ff ff e8 0a 1a
> ed fd 48 c7 c7 20 ae 60 88 c6 05 7b fd 7e 06 01 e8 67 7d b6 fd <0f>
> 0b 31 db e9 2c ff ff ff 48 89 cf e8 a6 67 30 fe e9 41 fe ff ff
> RSP: 0018:ffff88817e87f330 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90005e51000
> RDX: 00000000000222c2 RSI: ffffffff8165e7e5 RDI: 0000000000000005
> RBP: ffff88817e87f418 R08: ffff8881866ba640 R09: ffffed103b5c5020
> R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff88817c7a7008
> R13: 00000000ffffffff R14: ffff88817e87f3f0 R15: ffff8881c1dc9d68
>  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
>  kref_put include/linux/kref.h:69 [inline]
>  p9_req_put+0x20/0x60 net/9p/client.c:395
>  p9_conn_destroy net/9p/trans_fd.c:880 [inline]
>  p9_fd_close+0x39f/0x6b0 net/9p/trans_fd.c:913
>  p9_client_create+0xbd0/0x1674 net/9p/client.c:1062
>  v9fs_session_init+0x217/0x1bb0 fs/9p/v9fs.c:421

So the latest ref put I added on destroy for m->rreq looks like it's not
always a good idea... The worker thread is supposed to be stoped at this
point so I'm not sure what went wrong, but while looking at this I found
a race with the read work function and the cancelled callback --
although that would cause a list corruption so it's not what happened
here.

Will think on it a bit more, and try to reproduce by adding some random
delays to make some races more likely.
I'll fix the race in trans_fd's cancelled after/together with the
async flush patches, I've got something working except for cancelled on
this end so will probably submit something around next week after I've
had time to test a bit more extensively

-- 
Dominique
