Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE0C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E5020831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E5020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKCHs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:48:26 -0400
Received: from nautica.notk.org ([91.121.71.147]:32895 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKCHs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:48:26 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id F41ECC009; Fri,  2 Nov 2018 23:39:23 +0100 (CET)
Date:   Fri, 2 Nov 2018 23:39:08 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: WARNING in kmem_cache_create_usercopy
Message-ID: <20181102223908.GA9565@nautica>
References: <0000000000009d4c780579b04ee4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000009d4c780579b04ee4@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote on Fri, Nov 02, 2018:
> RIP: 0010:kmem_cache_create_usercopy+0xad/0x240 mm/slab_common.c:473
> Code: 44 89 f0 25 00 60 de 04 45 85 ed 89 45 cc 75 0b 8b 45 d0 85 c0
> 0f 85 8e 01 00 00 44 39 eb 72 0a 89 d8 44 29 e8 3b 45 d0 73 7e <0f>
> 0b c7 45 d0 00 00 00 00 4c 8b 45 10 44 89 fa 89 de 4c 89 e7 8b
> RSP: 0018:ffff8801bc23f5d0 EFLAGS: 00010213
> RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000006
> RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffffffff88b04b20
> RBP: ffff8801bc23f608 R08: fffffbfff1283a2d R09: fffffbfff1283a2c
> R10: ffff8801bc23f5c0 R11: ffffffff8941d167 R12: ffffffff88b04b20
> R13: 00000000fffffffd R14: 0000000000000000 R15: 0000000000000000
>  p9_client_create+0xa58/0x1769 net/9p/client.c:1054

No lower bound on msize, the reproducer gives a reply from the
pseudo-server with msize=8 and we happily take it, underflowing the
msize - 11 (hdr+4) argument to kmem_cache_create_usercopy...
This probably never worked anyway, but we now get a warning :)


We need to add a sane lower bound to msize as well as the current upper
bound set in the transport.
We have some header sizes in 9p.h for IO header overhead (P9_IOHDRSZ to
24 for example) but I think that's too low in practice; stuff like
readdir will require more than this to get a single entry... We can
request the server to ask for at least 4k?
9p would probably work with less (e.g. 1k; I'd rather not have to
figgure the minimum length we need to get each messages to work in its
minimal form) but honestly even with 4k the perforamnces will be
terrible, so tempted to go with that...

I'll send a patch imposing 4k next week unless someone else does first,
or replies indicate different preferences.


@Dmitry: semi-related, the C reproducer (
https://syzkaller.appspot.com/x/repro.c?x=1701f831400000 ) has a lot of
"readable" letters spelled out as "\x63..." or chars as 0x3d - it's fine
for generated code and that might be easier for the intermediate
representation syzkaller works with, but do you know something handy
that would help convert these to readable strings?
e.g. "\x63\x61\x63\x68\x65\x3d\xc0\x6d\x61\x70" could be written
"cache=\xc0map", and 0x3d as '=' (hm I guess the later would not always
make sense to convert so probably best left as is, but it gets annoying
pretty fast with longer strings)

-- 
Dominique
