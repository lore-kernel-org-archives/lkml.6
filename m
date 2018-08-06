Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90DDC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404B6217B7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404B6217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbeHFWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:52:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHFWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:52:03 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6174C136A4AA3;
        Mon,  6 Aug 2018 13:41:17 -0700 (PDT)
Date:   Mon, 06 Aug 2018 13:41:16 -0700 (PDT)
Message-Id: <20180806.134116.1016660959593702560.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, yanhaishuang@cmss.chinamobile.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: fix the calculation of
 sysctl_max_tw_buckets in tcp_sk_init()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533556020-20778-1-git-send-email-laoar.shao@gmail.com>
References: <1533556020-20778-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 13:41:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon,  6 Aug 2018 19:47:00 +0800

> tcp_hashinfo.ehash_mask is always an odd number, which is set in function
> alloc_large_system_hash(). See bellow,
> 	if (_hash_mask)
> 		*_hash_mask = (1 << log2qty) - 1; <<< always odd number
> 
> Hence the local variable 'cnt' is a even number, as a result of that it is
> no difference to do the incrementation here.
> 
> Maybe the compiler could also optimize it, but this code is a little ugly.
> 
> Fix: fee83d09 ("ipv4: Namespaceify tcp_max_syn_backlog knob")

The correct tag is "Fixes: "

> @@ -2543,7 +2543,7 @@ static int __net_init tcp_sk_init(struct net *net)
>  	net->ipv4.sysctl_tcp_tw_reuse = 2;
>  
>  	cnt = tcp_hashinfo.ehash_mask + 1;
> -	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = (cnt + 1) / 2;
> +	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = cnt / 2;
>  	net->ipv4.tcp_death_row.hashinfo = &tcp_hashinfo;

This is completely harmless, and does no harm.

You aren't "fixing" anything.
