Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E1CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEE420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEE420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJKUiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:38:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:41271 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeJKUiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:38:12 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 86364C009; Thu, 11 Oct 2018 15:11:00 +0200 (CEST)
Date:   Thu, 11 Oct 2018 15:10:45 +0200
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
Message-ID: <20181011131045.GA32030@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Thu, Oct 11, 2018:
> > That's still the tricky part, I'm afraid... Making a separate server
> > would have been easy because I could have reused some of my junk for the
> > actual connection handling (some rdma helper library I wrote ages
> > ago[1]), but if you're going to just embed C code you'll probably want
> > something lower level? I've never seen syzkaller use any library call
> > but I'm not even sure I would know how to create a qp without
> > libibverbs, would standard stuff be OK ?
> 
> Raw syscalls preferably.
> What does 'rxe_cfg start ens3' do on syscall level? Some netlink?

modprobe rdma_rxe (and a bunch of other rdma modules before that) then
writes the interface name in /sys/module/rdma_rxe/parameters/add
apparently; then checks it worked.
this part could be done in C directly without too much trouble, but as
long as the proper kernel configuration/modules are available

> Any libraries and utilities are hell pain in linux world. Will it work
> in Android userspace? gVisor? Who will explain all syzkaller users
> where they get this for their who-knows-what distro, which is 10 years
> old because of corp policies, and debug how their version of the
> library has a slightly incompatible version?
> For example, after figuring out that rxe_cfg actually comes from
> rdma-core (which is a separate delight on linux), my debian
> destribution failed to install it because of some conflicts around
> /etc/modprobe.d/mlx4.conf, and my ubuntu distro does not know about
> such package. And we've just started :)

The rdma ecosystem is a pain, I'll easily agree with that...

> Syscalls tend to be simpler and more reliable. If it gives ENOSUPP,
> ok, that's it. If it works, great, we can use it.

I'll have to look into it a bit more; libibverbs abstracts a lot of
stuff into per-nic userspace drivers (the files I cited in a previous
mail) and basically with the mellanox cards I'm familiar with the whole
user session looks like this:
 * common libibverbs/rdmacm code opens /dev/infiniband/rdma_cm and
/dev/infiniband/uverbs0 (plus a bunch of files to figure out abi
version, what user driver to load etc) 
 * it and the userspace driver issue "commands" over these two files' fd
to setup the connection ; some commands are standard but some are
specific to the interface and defined in the driver.
There are many facets to a connection in RDMA: a protection domain used
to register memory with the nic, a queue pair that is the actual tx/rx
connection, optionally a completion channel that will be another fd to
listen on for events that tell you something happened and finally some
memory regions to directly communicate with the nic from userspace
depending on the specific driver.
 * then there's the actual usage, more commands through the uverbs0 char
device to register the memory you'll use, and once that's done it's
entierly up to the driver - for example the mellanox lib can do
everything in userspace playing with the memory regions it registered,
but I'd wager the rxe driver does more calls through the uverbs0 fd...

Honestly I'm not keen on reimplementing all of this; the interface
itself pretty much depends on your version of the kernel (there is a
common ABI defined, but as far as specific nics are concerned if your
kernel module doesn't match the user library version you can get some
nasty surprises), and it's far from the black or white of a good ol'
ENOSUPP error.


I'll look if I can figure out if there is a common subset of verbs
commands that are standard and sufficient to setup a listening
connection and exchange data that should be supported for all devices
and would let us reimplement just that, but while I hear your point
about android and ten years in the future I think it's more likely than
ten years in the future the verb abi will have changed but libibverbs
will just have the new version implemented and hide the change :P

-- 
Dominique
