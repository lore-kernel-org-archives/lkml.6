Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA33C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAB217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BAB217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHEB1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:27:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeHEB1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:27:54 -0400
Received: from localhost (unknown [172.58.40.233])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D39514075A27;
        Sat,  4 Aug 2018 16:25:34 -0700 (PDT)
Date:   Sat, 04 Aug 2018 16:25:29 -0700 (PDT)
Message-Id: <20180804.162529.304855987892193419.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     dima@arista.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180804232102.GA3982@flashbox>
References: <20180804224956.GA5384@flashbox>
        <1533424322.2679.144.camel@arista.com>
        <20180804232102.GA3982@flashbox>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Aug 2018 16:25:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Sat, 4 Aug 2018 16:21:02 -0700

> On Sun, Aug 05, 2018 at 12:12:02AM +0100, Dmitry Safonov wrote:
>> On Sat, 2018-08-04 at 15:49 -0700, Nathan Chancellor wrote:
>> > dmesg output attached, please let me know if you need anything else.
>> 
>> Could you try with this diff instead?
>> It looks like, I'm too bad with shifts and shifted for 64 bytes.
>> 
>> -- 
>> Thanks,
>>              Dmitry
> 
>> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
>> index 7d860a22e5fb..b78bb7dc06fe 100644
>> --- a/net/netlink/af_netlink.c
>> +++ b/net/netlink/af_netlink.c
>> @@ -1011,7 +1011,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
>>  
>>  	if (nlk->ngroups == 0)
>>  		groups = 0;
>> -	else
>> +	else if (nlk->ngroups < 64)
>>  		groups &= (1ULL << nlk->ngroups) - 1;
>>  
>>  	bound = nlk->bound;
> 
> This fixed my issue. If needed:
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Dmitry please submit this formally for net+stable wit Nathan's
tested-by.

Thanks.
