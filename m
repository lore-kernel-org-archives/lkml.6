Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60521C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC35218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeL2FbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:31:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40344 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeL2FbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:31:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0021C1341222A;
        Fri, 28 Dec 2018 21:31:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:31:03 -0800 (PST)
Message-Id: <20181228.213103.793343860286706296.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     m.grzeschik@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: arcnet: Fix a possible concurrency
 use-after-free bug in arcnet_reply_tasklet()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181227020142.18190-1-baijiaju1990@gmail.com>
References: <20181227020142.18190-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:31:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Thu, 27 Dec 2018 10:01:42 +0800

> @@ -401,6 +401,7 @@ static void arcnet_reply_tasklet(unsigned long data)
>  	struct sock_exterr_skb *serr;
>  	struct sock *sk;
>  	int ret;
> +	unsigned long flags;
>  
>  	local_irq_disable();
>  	skb = lp->outgoing.skb;
> @@ -426,10 +427,14 @@ static void arcnet_reply_tasklet(unsigned long data)
>  	serr->ee.ee_data = skb_shinfo(skb)->tskey;
>  	serr->ee.ee_info = lp->reply_status;
>  
> +	spin_lock_irqsave(&lp->lock, flags);
> +
>  	/* finally erasing outgoing skb */
>  	dev_kfree_skb(lp->outgoing.skb);
>  	lp->outgoing.skb = NULL;
>  
> +	spin_unlock_irqrestore(&lp->lock, flags);
> +
>  	ackskb->dev = lp->dev;
>  
>  	ret = sock_queue_err_skb(sk, ackskb);

This is not the correct fix.

You need to instead replace the existing local_irq_*() calls in the
function with the spinlock stuff.
