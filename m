Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27724ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7F520824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7F520824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJYBjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:39:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:39:32 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 49B58143A3225;
        Wed, 24 Oct 2018 10:10:40 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:10:28 -0700 (PDT)
Message-Id: <20181024.101028.1211941922121897721.davem@davemloft.net>
To:     wanghaifine@gmail.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change judgment len position
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181024154729.5312-1-wanghaifine@gmail.com>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Oct 2018 10:10:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghaifine@gmail.com>
Date: Wed, 24 Oct 2018 23:47:29 +0800

> To determine whether len is less than zero, it should be put before 
> the function min_t, because the return value of min_t is not likely 
> to be less than zero.
> 
> Signed-off-by: Wang Hai <wanghaifine@gmail.com>
> ---
>  net/ipv4/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 10c624639..49af9fdc3 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3301,11 +3301,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
>  	struct net *net = sock_net(sk);
>  	int val, len;
>  
> +	len = min_t(unsigned int, len, sizeof(int));
> +
>  	if (get_user(len, optlen))
>  		return -EFAULT;

You can't be serious?

'len' has no value before the get_user() call.
