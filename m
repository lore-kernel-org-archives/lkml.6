Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347EAECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838920883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E838920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeGLWCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:02:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeGLWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:02:24 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E2B51008E588;
        Thu, 12 Jul 2018 14:50:54 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:50:53 -0700 (PDT)
Message-Id: <20180712.145053.375746969660293612.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        harsh@chelsio.com, herbert@gondor.apana.org.au,
        atul.gupta@chelsio.com, gustavo@embeddedor.com, werner@chelsio.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] [RESEND, net-next, v2] tcp: use monotonic timestamps
 for PAWS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711101757.3929777-1-arnd@arndb.de>
References: <20180711101757.3929777-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 14:50:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Jul 2018 12:16:12 +0200

> Using get_seconds() for timestamps is deprecated since it can lead
> to overflows on 32-bit systems. While the interface generally doesn't
> overflow until year 2106, the specific implementation of the TCP PAWS
> algorithm breaks in 2038 when the intermediate signed 32-bit timestamps
> overflow.
> 
> A related problem is that the local timestamps in CLOCK_REALTIME form
> lead to unexpected behavior when settimeofday is called to set the system
> clock backwards or forwards by more than 24 days.
> 
> While the first problem could be solved by using an overflow-safe method
> of comparing the timestamps, a nicer solution is to use a monotonic
> clocksource with ktime_get_seconds() that simply doesn't overflow (at
> least not until 136 years after boot) and that doesn't change during
> settimeofday().
> 
> To make 32-bit and 64-bit architectures behave the same way here, and
> also save a few bytes in the tcp_options_received structure, I'm changing
> the type to a 32-bit integer, which is now safe on all architectures.
> 
> Finally, the ts_recent_stamp field also (confusingly) gets used to store
> a jiffies value in tcp_synq_overflow()/tcp_synq_no_recent_overflow().
> This is currently safe, but changing the type to 32-bit requires
> some small changes there to keep it working.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use time_before32()/time_after32() everywhere as suggested
>     Eric Dumazet in https://lore.kernel.org/lkml/67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com/

Applied.
