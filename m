Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DAF20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DAF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeGVRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:36:58 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:33408 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbeGVRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:36:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fhHOH-0003nn-6N; Sun, 22 Jul 2018 18:39:25 +0200
Date:   Sun, 22 Jul 2018 18:39:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Shaochun Chen <cscnull@gmail.com>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, johannes.berg@intel.com, Jason@zx2c4.com,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        xiyou.wangcong@gmail.com, dsahern@gmail.com,
        netfilter-devel@vger.kernel.org, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: fix memory leak of dump
Message-ID: <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
References: <20180722143354.23722-1-cscnull@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722143354.23722-1-cscnull@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaochun Chen <cscnull@gmail.com> wrote:

[ CC ing Tom, as he added ->start() ]

> 1) if netlink_dump_start start fail, the memory of c->data will leak.
> so free manually after netlink_dump_start return error.
> 
> 2) In netlink_dump_start, ignore the return of netlink_dump.
> Because if cb_running is set to true, cb->dump will be call in anyway.
> so if netlink_dump_start start successfully, just return -EINTR.

This now requires ->start() to not return -EINVAL, else we won't
release resources either, this seems fragile to me.

I can only think of three ways to address this:

1. Kill ->start() and force all users to defer
   state allocation to first ->dump() invocation, so existing
   ->done() can be used to release resources.

OR
2. add ->stop() and have core always pair it with ->start(),
   no matter if dump() got called or not, then convert all
   places that provide .start to use .stop, not .done.

OR
3. change meaning of ->done() so its always called once ->start()
   was invoked (and returned 0), this requires audit of all
   places that provide .done to make sure they won't trip.

3) seems to be what Tom intended when he added .start, so probably
best to investigate that first.
