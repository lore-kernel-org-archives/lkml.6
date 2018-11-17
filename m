Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1AB2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1AB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeKQTDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 14:03:05 -0500
Received: from nautica.notk.org ([91.121.71.147]:38578 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeKQTDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 14:03:05 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E4CC2C009; Sat, 17 Nov 2018 09:47:04 +0100 (CET)
Date:   Sat, 17 Nov 2018 09:46:49 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: 9p/RDMA for syzkaller (Was: BUG: corrupted list in p9_read_work)
Message-ID: <20181117084649.GA24182@nautica>
References: <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica>
 <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <20181011141928.GB32030@nautica>
 <CACT4Y+byESz-LuzM07ik6-VVHoD7OhO_BB0qOLNUZ4j-ao9CFA@mail.gmail.com>
 <20181012150855.GA22149@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012150855.GA22149@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Fri, Oct 12, 2018:
> Hmm, good point; I hadn't looked at the network level how this is
> emulated.
> When I use a single VM I do not see anything with tcpdump on any
> interface, so I assume the kernel short-cuts the interface in this case.
> When communicating between two machines there obviously is traffic; it
> appears to be transported over udp - I see the messages I sent in plain
> text in the dump and there is only a handful of packets for the whole
> connecting and teardown so it's definitely much simpler.
> 
> This might have some knob I am not aware of to force the driver to send
> udp in the local setup, if we can it's going to be much easier to
> reimplement the rxe emulation protocol with raw syscalls than what I was
> describing earlier...

I've taken a little bit of time to look at this.
Unfortunately, I haven't been able to find any knob to make a
single-machine setup send UDP over an interface; would have hoped that
playing with multiple interfaces might be a way around this (e.g. use
the rxe driver on one interface and listen on the udp port on the other
one), but I couldn't get this to work and don't see anything in the code
that hints it might be configurable.
It seems to realize that the remote IP is assigned locally anyway and
while I cannot "bind" to an address that wasn't added to the rxe driver
at the rdma_cm level, trying to connect to it never sends any packet to
a ncat listening on 4791/udp on that interface...
If anyone has an idea, it'd be great!

Protocole-wise, once we get that to work it doesn't look very difficult
to implement some basic "accept connection and send acks/replies" small
server, but we need the first part to work...


-- 
Dominique
