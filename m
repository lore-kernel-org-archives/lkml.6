Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F130C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225082080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfABDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:32:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfABDcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 22:32:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52BF5C049580;
        Wed,  2 Jan 2019 03:32:14 +0000 (UTC)
Received: from [10.72.12.55] (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08745103BAB8;
        Wed,  2 Jan 2019 03:32:05 +0000 (UTC)
Subject: Re: KASAN: slab-out-of-bounds Read in tun_net_xmit (2)
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        syzbot <syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, peterpenkov96@gmail.com,
        sd@queasysnail.net, syzkaller-bugs@googlegroups.com,
        willemb@google.com
References: <0000000000008fe18f05711982f1@google.com>
 <0000000000005c921a057e4114a2@google.com>
 <20181231105143.2b2d2b63@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <45aa7f12-ca23-fa23-5d74-985abedb7d8a@redhat.com>
Date:   Wed, 2 Jan 2019 11:32:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181231105143.2b2d2b63@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 02 Jan 2019 03:32:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/31 下午5:51, Jesper Dangaard Brouer wrote:
> Hi MST and Jason,
>
> Could you please take a look at this?  This bug is caused by a thread
> resizing the tun-queue (via tun_queue_resize -> ptr_ring_resize_multiple).
> And error happens in tun_net_xmit -> ptr_ring_produce.  My guess is bug
> happens when reading r->queue in ptr_ring_produce.
>
> I've look at the code (see diff comments below), but I cannot spot the
> issue as the (implicit) memory barrier of a spinlock should cover the
> cases I can imagine.


Hi:

Cong sent a patch for this and looks like it was fixed in 
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=aff6db454599d62191aabc208930e891748e4322.

Thanks

