Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106A62190B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeL2FPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:15:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeL2FPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:15:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8CB71341222A;
        Fri, 28 Dec 2018 21:15:04 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:15:03 -0800 (PST)
Message-Id: <20181228.211503.1983080144355610600.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ipv4: fib_rules: Fix possible infinite loop in
 fib_empty_table
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226083420.20436-1-yuehaibing@huawei.com>
References: <20181226083420.20436-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:15:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Dec 2018 16:34:20 +0800

> diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
> index f8eb78d..1567e12 100644
> --- a/net/ipv4/fib_rules.c
> +++ b/net/ipv4/fib_rules.c
> @@ -200,9 +200,13 @@ static struct fib_table *fib_empty_table(struct net *net)
>  {
>  	u32 id;
>  
> -	for (id = 1; id <= RT_TABLE_MAX; id++)
> +	for (id = 1; id <= RT_TABLE_MAX; id++) {
>  		if (!fib_get_table(net, id))
>  			return fib_new_table(net, id);
> +
> +		if (id == RT_TABLE_MAX)
> +			break;
> +	}
>  	return NULL;
>  }

The loop now has two exit conditions, one of which (by your analysis
is completely impossible).

Please clean this up into a loop with better structure and no
impossible tests.  One approach could be simply:

	id = 1;
	while (1) {
	...
		if (id++ == RT_TABLE_MAX)
			break;
	}

Or even:

	id = 0;
	while (++id) {
	...
	}
