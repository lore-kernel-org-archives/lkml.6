Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F920870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfALBxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:53:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfALBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:53:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85D3F14CCB492;
        Fri, 11 Jan 2019 17:53:04 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:53:03 -0800 (PST)
Message-Id: <20190111.175303.1528012358618102203.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     yanjun.zhu@oracle.com, keescook@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190108124518.21986-1-baijiaju1990@gmail.com>
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Jan 2019 17:53:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue,  8 Jan 2019 20:45:18 +0800

> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
> executed with nv_poll_controller().
> 
> nv_start_xmit
>   line 2321: prev_tx_ctx->skb = skb;
> 
> nv_start_xmit_optimized
>   line 2479: prev_tx_ctx->skb = skb;
> 
> nv_poll_controller
>   nv_do_nic_poll
>     line 4134: spin_lock(&np->lock);
>     nv_drain_rxtx
>       nv_drain_tx
>         nv_release_txskb
>           line 2004: dev_kfree_skb_any(tx_skb->skb);
> 
> Thus, two possible concurrency use-after-free bugs may occur.

I do not think so, the netif_tx_lock_bh() done will prevent the parallel
execution.
