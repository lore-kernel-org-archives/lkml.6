Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF81C282CB
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A792133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA0Slo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:41:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfA0Sln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:41:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA5E01086DD9D;
        Sun, 27 Jan 2019 10:41:42 -0800 (PST)
Date:   Sun, 27 Jan 2019 10:41:42 -0800 (PST)
Message-Id: <20190127.104142.813336159923265386.davem@davemloft.net>
To:     dvyukov@gmail.com
Cc:     f6bvp@free.fr, linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        dvyukov@google.com,
        syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rose: fix NULL ax25_cb kernel panic
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190125104640.253862-1-dvyukov@gmail.com>
References: <20190125104640.253862-1-dvyukov@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 27 Jan 2019 10:41:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@gmail.com>
Date: Fri, 25 Jan 2019 11:46:40 +0100

> From: Bernard Pidoux <f6bvp@free.fr>
> 
> When an internally generated frame is handled by rose_xmit(),
> rose_route_frame() is called:
> 
>         if (!rose_route_frame(skb, NULL)) {
>                 dev_kfree_skb(skb);
>                 stats->tx_errors++;
>                 return NETDEV_TX_OK;
>         }
> 
> We have the same code sequence in Net/Rom where an internally generated
> frame is handled by nr_xmit() calling nr_route_frame(skb, NULL).
> However, in this function NULL argument is tested while it is not in
> rose_route_frame().
> Then kernel panic occurs later on when calling ax25cmp() with a NULL
> ax25_cb argument as reported many times and recently with syzbot.
> 
> We need to test if ax25 is NULL before using it.
> 
> Testing:
> Built kernel with CONFIG_ROSE=y.
> 
> Signed-off-by: Bernard Pidoux <f6bvp@free.fr>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com

Applied and queued up for -stable, thanks.
