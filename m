Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C4D2172A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C4D2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390232AbeHGVsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:48:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbeHGVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:48:19 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0BB9E13EABC15;
        Tue,  7 Aug 2018 12:32:26 -0700 (PDT)
Date:   Tue, 07 Aug 2018 12:32:25 -0700 (PDT)
Message-Id: <20180807.123225.174635984138364812.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] tcp: propagate gso_segs to the new skb
 built in tcp collapse
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533464707-11777-1-git-send-email-laoar.shao@gmail.com>
References: <1533464707-11777-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Aug 2018 12:32:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun,  5 Aug 2018 18:25:07 +0800

> The gso_segs of the new built SKB in tcp collapse is inited to 0,
> that makes us hard to know the accurate segments number of this new SKB.
> We'd better propagate the gso_segs of the collapsed SKB to the new built
> one, so when this SKB is dropped (for example when doing tcp prune) the
> sk_drops will be added to the correct value.
> 
> If the collapsed SKB is fully copied to the new built one, we just add its
> gso_segs to the new SKB.
> While if the collapsed SKB is partially copied to the new built SKB,
> we have to caculate how many segments are copied.
> Furthemore, we have to reset the gso_segs of this SKB if is is partially
> copied, so in the next round when the left segments are copied it could
> propagate the correct value.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Eric, please review.

If partial copies are common, I wonder how much sense it makes to try to
avoid the DIV_ROUND_UP() operations.
