Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF06C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2142086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2142086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJJXVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:21:21 -0400
Received: from nautica.notk.org ([91.121.71.147]:42144 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJJXVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:21:21 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 02FF6C009; Wed, 10 Oct 2018 17:58:30 +0200 (CEST)
Date:   Wed, 10 Oct 2018 17:58:14 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181010155814.GC20918@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Wed, Oct 10, 2018:
> > The problem is that you can't just give the client a file like trans fd;
> > you'd need to open an ""rdma socket"" (simplifying wording a bit), and
> > afaik there is no standard tool for it ; or rather, the problem is that
> > RDMA is packet based so even if there were you can't just write stuff
> > in a fd and hope it'll work, so you need a server.
> >
> > If you're interested, 9p is trivial enough that I could provide you with
> > a trivial server that works like your file (just need to reimplement
> > something that parses header to packetize it properly; so you could
> > write to its stdin for example) ; that'd require some setup in the VM
> > (configure rxe and install that tool), but it would definitely be
> > possible.
> > What do you think ?
> 
> I would like to hear more details.
> Opening a socket is not a problem. Why do we need a tool for this?

Sorry, that's my head thinking unixy and piping things :)

> I don't understand the problem with "packet-based" and what does it
> mean to have a separate server? Any why?

Packet-based means you can't just read/write in a fd and expect the
other side to know where to cut the packets to send it to the client,
but if we do it internally there's no problem. We know where to cut.

> We definitely don't want to involve a separate third-party server,
> that's very problematic for multiple reasons. But we can have a chunk
> of custom C code inside of syzkaller.
> What exactly setup we need?

The setup itself isn't that bad, it's actually pretty much trivial - on
a fedora VM I just had to run 'rxe_cfg start ens3' (virtio interface
name) and then the infiniband tools are happy e.g. ibv_devinfo should
list an interface if you have the userspace library that should have
come with rxe_cfg.
(specifically, my VM uses /etc/libibverbs.d/rxe.driver to point to the
lib, and /usr/lib64/libibverbs/librxe-rdmav16.so the lib itself)

Once tools like ibv_devinfo list the interface, it means syzkaller can
use it, and very probably means the kernel can as well; that's it.


> I guess it will make things simpler if you provide some kind of "hello
> world" C program that mounts 9p/rdma. I don't need exact messages
> (they will be same as with pipe transport, right?) nor actual server
> implementation, but just the place where to inject these packets.

That's still the tricky part, I'm afraid... Making a separate server
would have been easy because I could have reused some of my junk for the
actual connection handling (some rdma helper library I wrote ages
ago[1]), but if you're going to just embed C code you'll probably want
something lower level? I've never seen syzkaller use any library call
but I'm not even sure I would know how to create a qp without
libibverbs, would standard stuff be OK ?

I think the interface improved quite a bit since I last looked at it so
I'll need a bit of time to figure it out again but I'll send you a
simple conection with a few messages soonish™

[1] https://github.com/cea-hpc/mooshika

-- 
Dominique
