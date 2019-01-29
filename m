Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F70C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A04220882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfA2XKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:10:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2XK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:10:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D246514F19FB8;
        Tue, 29 Jan 2019 15:10:28 -0800 (PST)
Date:   Tue, 29 Jan 2019 15:10:26 -0800 (PST)
Message-Id: <20190129.151026.358327408932275252.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190129175145-mutt-send-email-mst@kernel.org>
References: <20190128070505.18335-1-jasowang@redhat.com>
        <20190128.225444.1929870241029842289.davem@davemloft.net>
        <20190129175145-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Jan 2019 15:10:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 29 Jan 2019 17:54:44 -0500

> On Mon, Jan 28, 2019 at 10:54:44PM -0800, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Mon, 28 Jan 2019 15:05:05 +0800
>> 
>> > After batched used ring updating was introduced in commit e2b3b35eb989
>> > ("vhost_net: batch used ring update in rx"). We tend to batch heads in
>> > vq->heads for more than one packet. But the quota passed to
>> > get_rx_bufs() was not correctly limited, which can result a OOB write
>> > in vq->heads.
>> > 
>> >         headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
>> >                     vhost_len, &in, vq_log, &log,
>> >                     likely(mergeable) ? UIO_MAXIOV : 1);
>> > 
>> > UIO_MAXIOV was still used which is wrong since we could have batched
>> > used in vq->heads, this will cause OOB if the next buffer needs more
>> > than 960 (1024 (UIO_MAXIOV) - 64 (VHOST_NET_BATCH)) heads after we've
>> > batched 64 (VHOST_NET_BATCH) heads:
>>  ...
>> > Fixing this by allocating UIO_MAXIOV + VHOST_NET_BATCH iovs for
>> > vhost-net. This is done through set the limitation through
>> > vhost_dev_init(), then set_owner can allocate the number of iov in a
>> > per device manner.
>> > 
>> > This fixes CVE-2018-16880.
>> > 
>> > Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> 
>> Applied and queued up for -stable, thanks!
> 
> Wow it seems we are down to hours round time post to queue.
> It would be hard to keep up that rate generally.
> However, I am guessing this was already in downstreams, and it's a CVE,
> so I guess it's a no brainer and review wasn't really necessary - was
> that the idea? Just checking.

Yeah the CVE pushed my hand a little bit, and I knew I was going to send Linus
a pull request today because David Watson needs some TLS changes in net-next.
