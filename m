Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB71C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C52086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215C52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeGVJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:58:47 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:32826 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbeGVJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:58:46 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fhAGA-0000tu-6X; Sun, 22 Jul 2018 11:02:34 +0200
Date:   Sun, 22 Jul 2018 11:02:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Shaochun Chen <cscnull@gmail.com>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, johannes.berg@intel.com, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        Jason@zx2c4.com, dsahern@gmail.com, lucien.xin@gmail.com,
        ktkhai@virtuozzo.com, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, tom@quantonium.net
Subject: Re: [PATCH] netlink: fix memory leak
Message-ID: <20180722090234.bttpk2xmwf4d7hfo@breakpoint.cc>
References: <20180722024925.3176-1-cscnull@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722024925.3176-1-cscnull@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaochun Chen <cscnull@gmail.com> wrote:

[ CC Tom Herbert ]

> and the memory which pointed by control->data will leak. so if netlink_dump
> start fail, call control->done to free the memory.

Tom, I was about to suggest moving extra allocations for dumps
into a ->start() callback whereever possible.

However, it looks like ->done() is not guaranteed to be called even if
->start() was invoked, but it seems at least ila assumes ->done always
cleans up after ->start.

I am looking at netlink_dump(); it calls ->done() only after the dump
callback was invoked.

In nf_tables_api.c case it might be possible to defer allocations until
->dump() is called for first time via cb_args but I don't think its
going to be any better than cleaning up manually after netlink_dump_start()
returned an error.

Any better ideas or advice on how to procceed?

Thanks!
