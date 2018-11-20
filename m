Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDCAC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E402087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E402087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKTV5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:57:49 -0500
Received: from nautica.notk.org ([91.121.71.147]:48633 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeKTV5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:57:49 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 299F6C009; Tue, 20 Nov 2018 12:29:08 +0100 (CET)
Date:   Tue, 20 Nov 2018 12:28:53 +0100
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
Message-ID: <20181120112853.GA1155@nautica>
References: <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica>
 <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <20181011141928.GB32030@nautica>
 <CACT4Y+byESz-LuzM07ik6-VVHoD7OhO_BB0qOLNUZ4j-ao9CFA@mail.gmail.com>
 <20181012150855.GA22149@nautica>
 <20181117084649.GA24182@nautica>
 <CACT4Y+YzEUouqi7daSBcJWak67rEdMEichWHpeZH-ggO+fD_nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YzEUouqi7daSBcJWak67rEdMEichWHpeZH-ggO+fD_nw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Tue, Nov 20, 2018:
> I don't understand most of the words here, so I probably won't be of help.
> 
> Leon told me that there is some kind of software emulation RDMA
> interface (CONFIG_RDMA_RXE?). Maybe it can be used to create an
> emulated RDMA interface per test process and use it to communicate
> with 9p client?

Yes, rxe is what you made me look into and is what I was talking about
here - the problem is I can't seem to figure how to use it *as udp*
within a single machine.

With two VMs or a remote outside of the VM when I try to open a RDMA
connection with that software emulation I get nicely understandable udp
packets ; but within a single VM there is nothing visible at the udp
layer, even if I explicitely configure multiple interfaces and try to
use one as rxe and another without it that would act as "outside" -- the
kernel doesn't send anything to the normal interface like it normally
would.

There might be other ways around it (I'm starting to think very ugly
things like really pretend to connect to an IP outside of the VM, but
capture the outgoing traffic with pcap and forge the replies), but I'd
rather not have to go to this extent...

-- 
Dominique
