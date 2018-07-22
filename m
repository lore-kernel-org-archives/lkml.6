Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF206ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9112F20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeGVPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 11:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeGVPeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 11:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 121AB87A75;
        Sun, 22 Jul 2018 14:37:08 +0000 (UTC)
Received: from redhat.com (ovpn-120-237.rdu2.redhat.com [10.10.120.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id C80BE2156897;
        Sun, 22 Jul 2018 14:37:06 +0000 (UTC)
Date:   Sun, 22 Jul 2018 17:37:05 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] TX used ring batched updating for vhost
Message-ID: <20180722173622-mutt-send-email-mst@kernel.org>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 22 Jul 2018 14:37:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 22 Jul 2018 14:37:08 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 08:15:12AM +0800, Jason Wang wrote:
> Hi:
> 
> This series implement batch updating of used ring for TX. This help to
> reduce the cache contention on used ring. The idea is first split
> datacopy path from zerocopy, and do only batching for datacopy. This
> is because zercopy had already supported its own batching.
> 
> TX PPS was increased 25.8% and Netperf TCP does not show obvious
> differences.
> 
> The split of datapath will also be helpful for future implementation
> like in order completion.
> 
> Please review.
> 
> Thanks

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'm very happy with the split, the mixed data path became hard to
maintain.

> Jason Wang (9):
>   vhost_net: drop unnecessary parameter
>   vhost_net: introduce helper to initialize tx iov iter
>   vhost_net: introduce vhost_exceeds_weight()
>   vhost_net: introduce get_tx_bufs()
>   vhost_net: introduce tx_can_batch()
>   vhost_net: split out datacopy logic
>   vhost_net: rename vhost_rx_signal_used() to vhost_net_signal_used()
>   vhost_net: rename VHOST_RX_BATCH to VHOST_NET_BATCH
>   vhost_net: batch update used ring for datacopy TX
> 
>  drivers/vhost/net.c | 249 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 179 insertions(+), 70 deletions(-)
> 
> -- 
> 2.7.4
