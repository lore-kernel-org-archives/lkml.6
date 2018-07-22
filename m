Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C89D20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C89D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeGVSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:05:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbeGVSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:05:16 -0400
Received: from localhost (unknown [172.58.43.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 261CB128F4E9A;
        Sun, 22 Jul 2018 10:07:56 -0700 (PDT)
Date:   Sun, 22 Jul 2018 10:07:55 -0700 (PDT)
Message-Id: <20180722.100755.19840167505550163.davem@davemloft.net>
To:     fw@strlen.de
Cc:     cscnull@gmail.com, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        johannes.berg@intel.com, Jason@zx2c4.com, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, xiyou.wangcong@gmail.com, dsahern@gmail.com,
        netfilter-devel@vger.kernel.org, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: fix memory leak of dump
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
References: <20180722143354.23722-1-cscnull@gmail.com>
        <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 22 Jul 2018 10:07:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Sun, 22 Jul 2018 18:39:25 +0200

> 3. change meaning of ->done() so its always called once ->start()
>    was invoked (and returned 0), this requires audit of all
>    places that provide .done to make sure they won't trip.
> 
> 3) seems to be what Tom intended when he added .start, so probably
> best to investigate that first.

Hmmm...

Any time ->start() succeeds, we set cb_running to true.

From that point forward, ->done() will be called at some point at all
of the locations that check if cb_running is true and set it to false.

This may be deferred all the way to socket destruction, but it will
eventually happens.

Nothing sets cb_running to false without invoking the ->done()
callback.

Just because the individual dump invocations don't call ->done() does
not mean it will not eventually happen.  The dump callbacks, and thus
the state data, is live across multiple rounds of recvmsg() calls by
the user and that is as-designed.
