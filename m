Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB532C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0338721570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0338721570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.bg
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeHTQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:10:57 -0400
Received: from ja.ssi.bg ([178.16.129.10]:38064 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726712AbeHTQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:10:57 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id w7KCtG3J005926;
        Mon, 20 Aug 2018 15:55:16 +0300
Date:   Mon, 20 Aug 2018 15:55:16 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>
cc:     ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
In-Reply-To: <0000000000007d22100573d66078@google.com>
Message-ID: <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
References: <0000000000007d22100573d66078@google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sun, 19 Aug 2018, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    d7857ae43dcc Add linux-next specific files for 20180817
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c72fce400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4b10cd1ea76bb092
> dashboard link: https://syzkaller.appspot.com/bug?extid=30209ea299c09d8785c9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15df679a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15242741400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com
> 
> IPVS: stopping master sync thread 4657 ...
> IPVS: stopping master sync thread 4663 ...
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0, id
> IPVS: = 0
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0, id
> IPVS: = 0
> IPVS: stopping master sync thread 4664 ...
> unregister_netdevice: waiting for lo to become free. Usage count = 1

	Well, only IPVS and tun in the game? But IPVS does not
take any dev references for sync threads. Can it be a problem
in tun? For example, a side effects from dst_cache_reset?
May be dst_release is called too late? Here is what should happen
on unregistration:

- NETDEV_UNREGISTER event: rt_flush_dev changes dst->dev with lo
but dst is not released

- ndo_uninit/ip_tunnel_uninit: dst_cache_reset is called which
does nothing!?! May be dst_release call is needed here.

- no more references are expected here ...

- netdev_run_todo -> netdev_wait_allrefs: loop here due to refcnt!=0

- dev->priv_destructor (ip_tunnel_dev_free) calls dst_cache_destroy
where dst_release is used but it is not reached because we loop in
netdev_wait_allrefs above

- dst_cache_destroy: really call dst_release

	In fact, after calling rt_flush_dev and replacing the
dst->dev we should reach dev->priv_destructor (ip_tunnel_dev_free)
for tun device where dst_release for lo should be called. But may be 
something prevents it, exit batching?

Regards

--
Julian Anastasov <ja@ssi.bg>
