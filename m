Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA83B2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA83B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJJWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:03:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:50540 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeJJWDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:03:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 33598C009; Wed, 10 Oct 2018 16:41:14 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:40:59 +0200
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
Message-ID: <20181010144059.GA20918@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Wed, Oct 10, 2018:
> How can they be faked?
> If we could create a private rdma/virtio stub instance per test
> process, then we could I think easily use that instance for 9p. But is
> it possible?

"RDMA" itself can be faked pretty easily nowadays, there's a "rxe"
driver that is soft RDMA over ethernet and can run over anything.

The problem is that you can't just give the client a file like trans fd;
you'd need to open an ""rdma socket"" (simplifying wording a bit), and
afaik there is no standard tool for it ; or rather, the problem is that
RDMA is packet based so even if there were you can't just write stuff
in a fd and hope it'll work, so you need a server.

If you're interested, 9p is trivial enough that I could provide you with
a trivial server that works like your file (just need to reimplement
something that parses header to packetize it properly; so you could
write to its stdin for example) ; that'd require some setup in the VM
(configure rxe and install that tool), but it would definitely be
possible.
What do you think ?


For virtio, I'm not as familiar with the environment so I do not know if
there are ways to fake it as easily unfortunately.

> Testing on real hardware is mostly outside of our priorities at the
> moment. I mean syzkaller itself can be run on anything, and one could
> extend descriptions to use a known rdma interface and run on a real
> hardware. But we can't afford this at the moment.

Sure, I understand that.

> As far as I understand RDMA maintainers run syzkaller on real
> hardware, but I don't know if they are up to including 9p into
> testing. +Leon

I'd be interested in knowing what kind of tests runs there :)

-- 
Dominique Martinet
