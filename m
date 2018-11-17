Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C282080C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C282080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeKRGSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:18:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34322 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:18:51 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E5C901420C0C6;
        Sat, 17 Nov 2018 12:01:05 -0800 (PST)
Date:   Sat, 17 Nov 2018 12:01:05 -0800 (PST)
Message-Id: <20181117.120105.1022512033566284108.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vhost_net: mitigate page reference
 counting during page frag refill
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115094310.17307-1-jasowang@redhat.com>
References: <20181115094310.17307-1-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 12:01:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Nov 2018 17:43:09 +0800

> We do a get_page() which involves a atomic operation. This patch tries
> to mitigate a per packet atomic operation by maintaining a reference
> bias which is initially USHRT_MAX. Each time a page is got, instead of
> calling get_page() we decrease the bias and when we find it's time to
> use a new page we will decrease the bias at one time through
> __page_cache_drain_cache().
> 
> Testpmd(virtio_user + vhost_net) + XDP_DROP on TAP shows about 1.6%
> improvement.
> 
> Before: 4.63Mpps
> After:  4.71Mpps
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
