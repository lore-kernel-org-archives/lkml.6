Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43204206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43204206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIFJpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:45:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeIFJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:45:35 -0400
Received: from localhost (unknown [172.58.40.71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6EFBB142A5A33;
        Wed,  5 Sep 2018 22:11:57 -0700 (PDT)
Date:   Wed, 05 Sep 2018 22:11:56 -0700 (PDT)
Message-Id: <20180905.221156.794134129220434079.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        torvalds@linux-foundation.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: Make groups check less stupid in
 netlink_bind()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903214051.4433-1-dima@arista.com>
References: <20180903214051.4433-1-dima@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Sep 2018 22:11:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Mon,  3 Sep 2018 22:40:51 +0100

> As Linus noted, the test for 0 is needless, groups type can follow the
> usual kernel style and 8*sizeof(unsigned long) is BITS_PER_LONG:
> 
>> The code [..] isn't technically incorrect...
>> But it is stupid.
>> Why stupid? Because the test for 0 is pointless.
>>
>> Just doing
>>        if (nlk->ngroups < 8*sizeof(groups))
>>                groups &= (1UL << nlk->ngroups) - 1;
>>
>> would have been fine and more understandable, since the "mask by shift
>> count" already does the right thing for a ngroups value of 0. Now that
>> test for zero makes me go "what's special about zero?". It turns out
>> that the answer to that is "nothing".
> [..]
>> The type of "groups" is kind of silly too.
>>
>> Yeah, "long unsigned int" isn't _technically_ wrong. But we normally
>> call that type "unsigned long".
> 
> Cleanup my piece of pointlessness.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: netdev@vger.kernel.org
> Fairly-blamed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Applied to net-next, thanks.
