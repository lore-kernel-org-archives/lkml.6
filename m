Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B1C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4E6217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4E6217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeHECKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:10:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeHECKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:10:24 -0400
Received: from localhost (unknown [172.58.40.233])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01A36140764DD;
        Sat,  4 Aug 2018 17:07:56 -0700 (PDT)
Date:   Sat, 04 Aug 2018 17:07:53 -0700 (PDT)
Message-Id: <20180804.170753.739714742014742080.davem@davemloft.net>
To:     dima@arista.com
Cc:     natechancellor@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533426268.2679.152.camel@arista.com>
References: <1533425198.2679.148.camel@arista.com>
        <20180804.163348.896647113172060665.davem@davemloft.net>
        <1533426268.2679.152.camel@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Aug 2018 17:07:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Sun, 05 Aug 2018 00:44:28 +0100

> On Sat, 2018-08-04 at 16:33 -0700, David Miller wrote:
>> From: Dmitry Safonov <dima@arista.com>
>> Date: Sun, 05 Aug 2018 00:26:38 +0100
>> 
>> > Thanks for the testing, sorry again for the breakage.
>> > Will send the patch shortly (with sizeof(unsigned long long)
>> instead of
>> > hard-coded 64). Hopefully, not too late.
>> 
>> 'groups' is "long unsigned int" not "unsigned long long"
>> 
>>         long unsigned int groups = nladdr->nl_groups;
>> 
>> And nladdr->nl_groups is specified as "__u32"
>> 
>> So the size of the relevant bits is actually strictly 32-bit.
>> 
>> This makes also the "ULL" in your constant specification incorrect as
>> well.
>> 
>> So much crazy stuff going on here :-/
> 
> Right, I misslooked that..
> How does this work on Android then?
> I doubt they changed uabi.

We can have many more than 32 multicast group subscriptions.

That's why the memberships are also stored in the nlk->groups[] array.

I'm --><--- this close to simply reverting all of your changes, the
missed masking seems to be quite harmless.
