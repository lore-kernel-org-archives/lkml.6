Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9F92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9F92085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeJKVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:55:51 -0400
Received: from nautica.notk.org ([91.121.71.147]:45963 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKVzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:55:50 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 532AFC009; Thu, 11 Oct 2018 16:28:23 +0200 (CEST)
Date:   Thu, 11 Oct 2018 16:28:08 +0200
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
Message-ID: <20181011142808.GC32030@nautica>
References: <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
 <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
 <20181010155814.GC20918@nautica>
 <CACT4Y+bJvxXeJxbAKCPTm0X608t302Kcq+F7Ccot3_-wx7sdog@mail.gmail.com>
 <20181011131045.GA32030@nautica>
 <CACT4Y+YvJ-KT4UxtOXpou1xpT3wBASDkt135zr2BwrRi0gv4Tw@mail.gmail.com>
 <CACT4Y+bM4DxysCzhWvhURgBVpnLR4uu+oxhLpdZ3x92cKwtAzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bM4DxysCzhWvhURgBVpnLR4uu+oxhLpdZ3x92cKwtAzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Thu, Oct 11, 2018:
> > Now we are talking!
> > We generally assume that all modules are simply compiled into kernel.
> > At least that's we have on syzbot. If somebody can't compile them in,
> > we can suggest to add modprobe into init.
> > So this boils down to just writing to /sys/module/rdma_rxe/parameters/add.
> 
> This fails for me:
> 
> root@syzkaller:~# echo -n syz1 > /sys/module/rdma_rxe/parameters/add
> [20992.905406] rdma_rxe: interface syz1 not found
> bash: echo: write error: Invalid argument

Works here, I just did:

[root@f2 ~]# modprobe rdma_rxe
[root@f2 ~]# echo -n ens3 > /sys/module/rdma_rxe/parameters/add 

dmesg says:
[   35.595534] rdma_rxe: set rxe0 active
[   35.595541] rdma_rxe: added rxe0 to ens3


Actually for a dummy interface if I try the echo directly the echo
works, and a verb device is created, and I just confirmed I can use
it... so not sure why rxe_cfg said EINVAL earlier...

[root@f2 ~]# ip link add dummy0 type dummy
[root@f2 ~]# ip link set dummy0 up
[root@f2 ~]# ip addr add 10.1.1.1/24 dev dummy0
[root@f2 ~]# modprobe rdma_rxe
[root@f2 ~]# echo -n dummy0 > /sys/module/rdma_rxe/parameters/add 


(then using my test client:
[root@f2 src]# ./rcat -s
INFO:  trans_rdma.c (879), msk_cma_event_handler: CONNECT_REQUEST
INFO:  trans_rdma.c (862), msk_cma_event_handler: ESTABLISHED
INFO:  trans_rdma.c (917), msk_cma_event_handler: DISCONNECT EVENT...

[root@f2 src]# ./rcat -c 10.1.1.1
INFO:  trans_rdma.c (862), msk_cma_event_handler: ESTABLISHED
^C
)


I assume your syz1 interface is a tap device as you were saying earlier?
Got anything in dmesg?

-- 
Dominique
