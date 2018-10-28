Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE26C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277382082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277382082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJ2Car (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:30:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47754 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeJ2Caq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:30:46 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E38112130A6E;
        Sun, 28 Oct 2018 10:45:27 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:45:24 -0700 (PDT)
Message-Id: <20181028.104524.345213764443487772.davem@davemloft.net>
To:     oleksandr@natalenko.name
Cc:     dave.taht@gmail.com, hkallweit1@gmail.com, toke@toke.dk,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <3d749bf1ec48ee9f4172b23bde84ec4b@natalenko.name>
References: <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
        <20181027.214426.537959459795607171.davem@davemloft.net>
        <3d749bf1ec48ee9f4172b23bde84ec4b@natalenko.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Oct 2018 10:45:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sun, 28 Oct 2018 13:22:09 +0100

> Hi.
> 
> On 28.10.2018 05:44, David Miller wrote:
>> Does this fix it?
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 022ad73d6253..77d43ae2a7bb 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -5457,7 +5457,7 @@ static void gro_flush_oldest(struct list_head
>> *head)
>>  	/* Do not adjust napi->gro_hash[].count, caller is adding a new
>>  	 * SKB to the chain.
>>  	 */
>> -	list_del(&oldest->list);
>> +	skb_list_del_init(oldest);
>>  	napi_gro_complete(oldest);
>>  }
> 
> Yes, but I had to apply both a8305bff6852 and 992cba7e276d too to get
> it compiled. With these 3 patches the panic is not triggered any more
> while having GRO enabled.
> 
> Thanks!

Thanks for testing, I'll queue this up for -stable too:

From ece23711dd956cd5053c9cb03e9fe0668f9c8894 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 28 Oct 2018 10:35:12 -0700
Subject: [PATCH] net: Properly unlink GRO packets on overflow.

Just like with normal GRO processing, we have to initialize
skb->next to NULL when we unlink overflow packets from the
GRO hash lists.

Fixes: d4546c2509b1 ("net: Convert GRO SKB handling to list_head.")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 022ad73d6253..77d43ae2a7bb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5457,7 +5457,7 @@ static void gro_flush_oldest(struct list_head *head)
 	/* Do not adjust napi->gro_hash[].count, caller is adding a new
 	 * SKB to the chain.
 	 */
-	list_del(&oldest->list);
+	skb_list_del_init(oldest);
 	napi_gro_complete(oldest);
 }
 
-- 
2.17.2

