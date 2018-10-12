Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4851C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeJLWmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:42:08 -0400
Received: from nautica.notk.org ([91.121.71.147]:33220 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbeJLWmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:42:08 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6D95BC009; Fri, 12 Oct 2018 17:09:10 +0200 (CEST)
Date:   Fri, 12 Oct 2018 17:08:55 +0200
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
Subject: Re: 9p/RDMA for syzkaller (Was: BUG: corrupted list in p9_read_work)
Message-ID: <20181012150855.GA22149@nautica>
References: <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica>
 <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <20181011141928.GB32030@nautica>
 <CACT4Y+byESz-LuzM07ik6-VVHoD7OhO_BB0qOLNUZ4j-ao9CFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+byESz-LuzM07ik6-VVHoD7OhO_BB0qOLNUZ4j-ao9CFA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Fri, Oct 12, 2018:
> > I don't see any read on these fd despite epoll being set to wait for
> > read events on these so I'm not quite sure where ibverbs knows if the
> > commands worked or not, but hopefully that illustrats that it's slightly
> > more complex than just socket/bind/listen/accept/write/close! :)
> 
> Yes, it seems so.
> 
> I guess I am still missing the big picture somewhat.
> If we do "echo -n FOO > /sys/module/rdma_rxe/parameters/add" and let's
> say FOO is a tun device. Does it mean that we will send/receive
> packets from the tun? If yes, that would make things simpler. And do
> we still need ring buffers in that case? If not and we still send/recv
> via in-memory ring buffers, then why do we need tun at all?

Hmm, good point; I hadn't looked at the network level how this is
emulated.
When I use a single VM I do not see anything with tcpdump on any
interface, so I assume the kernel short-cuts the interface in this case.
When communicating between two machines there obviously is traffic; it
appears to be transported over udp - I see the messages I sent in plain
text in the dump and there is only a handful of packets for the whole
connecting and teardown so it's definitely much simpler.

This might have some knob I am not aware of to force the driver to send
udp in the local setup, if we can it's going to be much easier to
reimplement the rxe emulation protocol with raw syscalls than what I was
describing earlier...

> Leon, maybe you know how to setup a stub rdma that we could use as 9p
> transport? If we do this, I guess it will also expose lots of
> interesting rdma code paths for testing.

I'm doing this on my free time atm so I can't invest too much, would
love some help if you're aware of anything :)

-- 
Dominique
