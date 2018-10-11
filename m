Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA3C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C63C20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C63C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeJKVrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:47:09 -0400
Received: from nautica.notk.org ([91.121.71.147]:40946 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeJKVrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:47:09 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D5044C009; Thu, 11 Oct 2018 16:19:43 +0200 (CEST)
Date:   Thu, 11 Oct 2018 16:19:28 +0200
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
Subject: 9p/RDMA for syzkaller (Was: BUG: corrupted list in p9_read_work)
Message-ID: <20181011141928.GB32030@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica>
 <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Thu, Oct 11, 2018:
> But again we don't need to support all of the available hardware.

I agree with that, I just have no idea what the "librxe-rdmav16.so" lib
could be doing and described something I am slightly more familiar with
(e.g. libmlx5)
I talked about a common subset of the verb abi because I didn't want to
look into what it's doing, but if it's not enough there's always that
possibility.


> For example, we are testing net stack from external side using tun.
> tun is a very simple, virtual abstraction of a network card. It allows
> us to test all of generic net stack starting from L2 without messing
> with any real drivers and their differences entirely. I had impression
> that we are talking about something similar here too. Or not?

That sounds about right, rxe is a software implementation that should
work on most network interfaces ; at least from what I tried it worked
on a VM's virtio net down to my laptop's wifi interface so it's a good
start... I'm not saying all because I just tried a dummy interface and
that returned EINVAL.
The only point I disagree is the 'very simple', even getting that to
work will be a far cry from a socket() call... :)


> Also I am a bit missing context about rdma<->9p interface. Do we need
> to setup all these ring buffers to satisfy the parts that 9p needs? Is
> it that 9p actually reads data directly from these ring buffers? Or
> there is some higher-level rdma interface that 9p uses?

It needs an "RDMA_PS_TCP" connection established, that requires
everything I described unfortunately...
Once that's established we need to register some memory to the driver
and post some recv buffers (even if we won't read it, the client would
get errors if we aren't ready to receive anything - at least it does
with real hardware), and also use some registered memory to send data.

Thinking back though I think that my server implementation isn't very
far from the raw level in what I'm doing, I recall libibverbs fallback
implementation (e.g. if the driver lib doesn't implement it otherwise)
of the functions I looked at like ibv_post_send to mostly be just
serializing the arguments, slapping the command from an enum in front of
it and sending it to the kernel, so it might be enough to just
reimplement that shim in or figure a way to generate the binary commands
once and then use these values; now I'm comparing two runs of strace of
my test server I definitely see a pattern.

I'll give it a try but don't expect something fast, and it's probably
not going to be very pretty either...

To give a concrete example, here are all the read/write/fcntl calls
looking just at /dev/infiniband in a hello world program that just
establishes connection (server side), receive and send two messages and
quits:


This part apparently sets up the listening connection of the server:

1430  1539262699.126025 openat(AT_FDCWD, "/dev/infiniband/rdma_cm", O_RDWR|O_CLOEXEC) = 3
1430  1539262699.126155 write(3, "\0\0\0\0\30\0\4\0@m'\1\0\0\0\0\344\327\375\271\374\177\0\0?\1\2\0\0\0\0\0", 32) = 32
1430  1539262699.126192 write(3, "\24\0\0\0\210\0\0\0\0\0\0\0000\0\0\0\33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\6\0\0\377\377\377\377\377\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 144) = 144
1430  1539262699.126223 write(3, "\23\0\0\0\20\0\20\1 \326\375\271\374\177\0\0\0\0\0\0\0\0\0\0", 24) = 24
1430  1539262699.126250 write(3, "\23\0\0\0\20\0\20\1 \326\375\271\374\177\0\0\0\0\0\0\2\0\0\0", 24) = 24
1430  1539262699.126274 write(3, "\1\0\0\0\20\0\4\0\324\327\375\271\374\177\0\0\0\0\0\0\0\0\0\0", 24) = 24
1430  1539262699.126303 close(3)        = 0
1430  1539262699.126360 openat(AT_FDCWD, "/dev/infiniband/rdma_cm", O_RDWR|O_CLOEXEC) = 3
1430  1539262699.126429 write(3, "\0\0\0\0\30\0\4\0\240\217'\1\0\0\0\0t\330\375\271\374\177\0\0\6\1\2\0\0\0\0\0", 32) = 32
1430  1539262699.126472 write(3, "\24\0\0\0\210\0\0\0\0\0\0\0\34\0\0\0\n\0\4\323\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 144) = 144
1430  1539262699.126501 write(3, "\23\0\0\0\20\0\20\1p\326\375\271\374\177\0\0\0\0\0\0\0\0\0\0", 24) = 24
1430  1539262699.126534 write(3, "\23\0\0\0\20\0\20\1p\326\375\271\374\177\0\0\0\0\0\0\2\0\0\0", 24) = 24
1430  1539262699.127119 write(3, "\7\0\0\0\10\0\0\0\0\0\0\0@\0\0\0", 16) = 16
1430  1539262699.127149 write(3, "\23\0\0\0\20\0\20\1`\327\375\271\374\177\0\0\0\0\0\0\0\0\0\0", 24) = 24
1430  1539262699.127319 fcntl(3, F_GETFL) = 0x8002 (flags O_RDWR|O_LARGEFILE)
1430  1539262699.127348 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE <unfinished ...>

Then the client connects (had some epoll on read on fd 3, but no read?!)

1446  1539262706.268685 write(3, "\f\0\0\0\10\0H\1\200\307\211\302G\177\0\0", 16) = 16
1446  1539262706.268718 write(3, "\23\0\0\0\20\0\20\1\240\304\211\302G\177\0\0\2\0\0\0\0\0\0\0", 24) = 24
1446  1539262706.269440 openat(AT_FDCWD, "/dev/infiniband/uverbs0", O_RDWR|O_CLOEXEC) = 5
1446  1539262706.269474 write(5, "\0\0\0\0\4\0\2\0H\302\211\302G\177\0\0", 16) = 16
1446  1539262706.269503 write(5, "\1\0\0\0\4\0,\0\220\301\211\302G\177\0\0", 16) = 16
1446  1539262706.269545 write(5, "\2\0\0\0\6\0\n\0\20\302\211\302G\177\0\0\1\0\0\0\0\0\0\0", 24) = 24
1446  1539262706.269571 write(5, "\3\0\0\0\4\0\1\0\314\303\211\302G\177\0\0", 16) = 16
1446  1539262706.269596 write(3, "\23\0\0\0\20\0\20\1\240\304\211\302G\177\0\0\2\0\0\0\2\0\0\0", 24) = 24
1446  1539262706.269618 write(3, "\23\0\0\0\20\0\270\1\200\303\211\302G\177\0\0\2\0\0\0\1\0\0\0", 24) = 24
1430  1539262706.269801 write(5, "\3\0\0\0\4\0\1\0\354\330\375\271\374\177\0\0", 16) = 16
1430  1539262706.269944 write(5, "\21\0\0\0\4\0\1\0T\330\375\271\374\177\0\0", 16) = 16
1430  1539262706.270000 write(5, "\22\0\0\0\n\0\6\0 \330\375\271\374\177\0\0`\232'\1\0\0\0\0006\0\0\0\0\0\0\0\7\0\0\0\0\0\0\0", 40) = 40
1430  1539262706.270203 write(5, "\27\0\0\0\4\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
1430  1539262706.270262 write(5, "\30\0\0\0\20\0\20\0000\327\375\271\374\177\0\0\20\233'\1\0\0\0\0\1\0\0\0\2\0\0\0\2\0\0\0\0\0\0\0002\0\0\0\4\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0\1\2\0\0", 64) = 64
1430  1539262706.270482 write(3, "\v\0\0\0\20\0\220\0p\326\375\271\374\177\0\0\2\0\0\0\1\0\0\0", 24) = 24
1430  1539262706.270546 write(5, "\32\0\0\0\36\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\09\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\16\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0", 120) = 120
1430  1539262706.270677 write(5, "\t\0\0\0\f\0\3\0\224\330\375\271\374\177\0\0\20p)\302G\177\0\0\0\0@\0\0\0\0\0\20p)\302G\177\0\0\1\0\0\0\1\0\0\0", 48) = 48
1430  1539262706.271973 write(5, "\t\0\0\0\f\0\3\0D\330\375\271\374\177\0\0\210\362&\1\0\0\0\0\1\0\0\0\0\0\0\0\210\362&\1\0\0\0\0\1\0\0\0\1\0\0\0", 48) = 48
1430  1539262706.272060 write(3, "\v\0\0\0\20\0\220\0000\325\375\271\374\177\0\0\2\0\0\0\1\0\0\0", 24) = 24
1430  1539262706.272110 write(5, "\32\0\0\0\36\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\09\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\16\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0", 120) = 120
1430  1539262706.272159 write(3, "\v\0\0\0\20\0\220\0000\325\375\271\374\177\0\0\2\0\0\0\2\0\0\0", 24) = 24
1430  1539262706.272205 write(5, "\32\0\0\0\36\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\n*\21f\0\0\0\0\0\0\0\0\1@\0\0\0\7\1\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\201\221\22\0\0\0\0\0\340\t\351\0\0\0\0\0\23\0\0\0\0\0\0\0\0\0\0\0\2\0\3\0\0\0\1\0\0\0\0\0\0\0\0\0", 120) = 120
1430  1539262706.272439 write(3, "\v\0\0\0\20\0\220\0000\325\375\271\374\177\0\0\2\0\0\0\3\0\0\0", 24) = 24
1430  1539262706.272496 write(5, "\32\0\0\0\36\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\1.\1\0\0\0\0\0\0\0\0\0\364((\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\0\1\0\0\0\23\7\7\0\0\0\0", 120) = 120
1430  1539262706.272565 write(3, "\10\0\0\0 \1\0\0\220\f\0\274G\177\0\0\24\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\1\0\0\n\1\2\0\0\0\0\0\0\0", 296) = 296
1446  1539262706.272962 write(3, "\f\0\0\0\10\0H\1\200\307\211\302G\177\0\0", 16) = 16
1430  1539262706.274144 write(5, "\t\0\0\0\f\0\3\0D\330\375\271\374\177\0\0`\0\351\301G\177\0\0\0\0 \0\0\0\0\0`\0\351\301G\177\0\0\1\0\0\0\1\0\0\0", 48) = 48


Some data is exchanged (we don't see the data as it's in buffers whose
address was given earlier):

1464  1539262714.529679 write(5, "\27\0\0\0\4\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
1464  1539262714.530059 write(5, "\34\0\0\0\10\0\1\0lT)\302G\177\0\0\3\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0", 32) = 32
1464  1539262714.530634 write(5, "\27\0\0\0\4\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
1430  1539262719.331307 write(5, "\34\0\0\0\10\0\1\0\374\327\375\271\374\177\0\0\3\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0", 32) = 32
1464  1539262719.332113 write(5, "\27\0\0\0\4\0\0\0\2\0\0\0\0\0\0\0", 16) = 16

And disconnect:

1430  1539262721.192844 write(5, "\r\0\0\0\3\0\0\0\6\0\0\0", 12) = 12
1430  1539262721.193186 write(5, "\r\0\0\0\3\0\0\0\5\0\0\0", 12) = 12
1430  1539262721.193324 write(5, "\32\0\0\0\36\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 120) = 120
1430  1539262721.193567 write(3, "\n\0\0\0\4\0\0\0\2\0\0\0", 12) = 12
1446  1539262721.256556 write(3, "\f\0\0\0\10\0H\1\200\307\211\302G\177\0\0", 16) = 16
1430  1539262721.257618 write(3, "\1\0\0\0\20\0\4\0\204\327\375\271\374\177\0\0\2\0\0\0\0\0\0\0", 24) = 24
1430  1539262721.257769 write(5, "\4\0\0\0\3\0\0\0\0\0\0\0", 12) = 12
1430  1539262721.258369 write(5, "\27\0\0\0\4\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
1430  1539262721.258667 write(5, "\33\0\0\0\6\0\1\0T\327\375\271\374\177\0\0\3\0\0\0\0\0\0\0", 24) = 24
1430  1539262721.259223 write(5, "\24\0\0\0\6\0\2\08\327\375\271\374\177\0\0\2\0\0\0\0\0\0\0", 24) = 24
1430  1539262721.260476 write(3, "\1\0\0\0\20\0\4\0D\330\375\271\374\177\0\0\0\0\0\0\0\0\0\0", 24) = 24
1430  1539262721.260726 close(3)        = 0
1430  1539262721.261082 write(5, "\4\0\0\0\3\0\0\0\1\0\0\0", 12) = -1 EBUSY (Device or resource busy)
1430  1539262721.358728 write(5, "\r\0\0\0\3\0\0\0\4\0\0\0", 12) = 12


I don't see any read on these fd despite epoll being set to wait for
read events on these so I'm not quite sure where ibverbs knows if the
commands worked or not, but hopefully that illustrats that it's slightly
more complex than just socket/bind/listen/accept/write/close! :) 

-- 
Dominique
