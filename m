Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3013EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5FA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfA2Wyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:54:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2Wyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:54:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F0687AE8B;
        Tue, 29 Jan 2019 22:54:50 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2518D5D96F;
        Tue, 29 Jan 2019 22:54:44 +0000 (UTC)
Date:   Tue, 29 Jan 2019 17:54:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Message-ID: <20190129175145-mutt-send-email-mst@kernel.org>
References: <20190128070505.18335-1-jasowang@redhat.com>
 <20190128.225444.1929870241029842289.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128.225444.1929870241029842289.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 22:54:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:54:44PM -0800, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Mon, 28 Jan 2019 15:05:05 +0800
> 
> > After batched used ring updating was introduced in commit e2b3b35eb989
> > ("vhost_net: batch used ring update in rx"). We tend to batch heads in
> > vq->heads for more than one packet. But the quota passed to
> > get_rx_bufs() was not correctly limited, which can result a OOB write
> > in vq->heads.
> > 
> >         headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
> >                     vhost_len, &in, vq_log, &log,
> >                     likely(mergeable) ? UIO_MAXIOV : 1);
> > 
> > UIO_MAXIOV was still used which is wrong since we could have batched
> > used in vq->heads, this will cause OOB if the next buffer needs more
> > than 960 (1024 (UIO_MAXIOV) - 64 (VHOST_NET_BATCH)) heads after we've
> > batched 64 (VHOST_NET_BATCH) heads:
>  ...
> > Fixing this by allocating UIO_MAXIOV + VHOST_NET_BATCH iovs for
> > vhost-net. This is done through set the limitation through
> > vhost_dev_init(), then set_owner can allocate the number of iov in a
> > per device manner.
> > 
> > This fixes CVE-2018-16880.
> > 
> > Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Applied and queued up for -stable, thanks!

Wow it seems we are down to hours round time post to queue.
It would be hard to keep up that rate generally.
However, I am guessing this was already in downstreams, and it's a CVE,
so I guess it's a no brainer and review wasn't really necessary - was
that the idea? Just checking.

-- 
MST
