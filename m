Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B793C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6108A217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6108A217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHECLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:11:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58682 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbeHECLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:11:24 -0400
Received: from localhost (unknown [172.58.40.233])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 574EC140764DD;
        Sat,  4 Aug 2018 17:08:57 -0700 (PDT)
Date:   Sat, 04 Aug 2018 17:08:56 -0700 (PDT)
Message-Id: <20180804.170856.2031275734761112973.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] netlink: Don't shift on 64 for ngroups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180804235544.10347-1-dima@arista.com>
References: <20180804235544.10347-1-dima@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Aug 2018 17:08:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Sun,  5 Aug 2018 00:55:44 +0100

> @@ -1011,8 +1011,8 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
>  
>  	if (nlk->ngroups == 0)
>  		groups = 0;
> -	else
> -		groups &= (1ULL << nlk->ngroups) - 1;
> +	else if (nlk->ngroups < sizeof(long unsigned int))
> +		groups &= (1UL << nlk->ngroups) - 1;

Sizeof is in bytes, you want to compare against bits.
