Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1EEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309E020875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbeGWMAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:00:04 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35512 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387864AbeGWMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:00:03 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fhYYd-0008LV-UY; Mon, 23 Jul 2018 12:59:16 +0200
Date:   Mon, 23 Jul 2018 12:59:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     shaochun chen <cscnull@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        David Miller <davem@davemloft.net>,
        kadlec <kadlec@blackhole.kfki.hu>,
        "johannes.berg" <johannes.berg@intel.com>, jason <Jason@zx2c4.com>,
        ktkhai <ktkhai@virtuozzo.com>,
        "lucien.xin" <lucien.xin@gmail.com>,
        "xiyou.wangcong" <xiyou.wangcong@gmail.com>,
        dsahern <dsahern@gmail.com>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        tom <tom@quantonium.net>, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netlink: fix memory leak of dump
Message-ID: <20180723105915.a6vx5t7htcclez3k@breakpoint.cc>
References: <20180722143354.23722-1-cscnull@gmail.com>
 <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
 <20180722.100755.19840167505550163.davem@davemloft.net>
 <20180722180910.wcwhantwpm2nfxet@breakpoint.cc>
 <20180723091551.mwhltw4ujm4bylvj@salvia>
 <20180723092818.ztsfsnqzxgzrauim@breakpoint.cc>
 <CAKDdixCx5za07R9KdyohsZjJqzdTpE3mR1+4TwY5xjeBGVeTjg@mail.gmail.com>
 <CAKDdixBBd08eKvk-hJtwPy46u2uzihRCh_KdEMF3xG1ZJ6oNsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKDdixBBd08eKvk-hJtwPy46u2uzihRCh_KdEMF3xG1ZJ6oNsg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shaochun chen <cscnull@gmail.com> wrote:
> I have a question: we will try_module_get in __netlink_dump_start(),

Thats too late, we release rcu read lock before this, so the module
implementing ->dump might have been removed already.

> but why we need to call try_module_get again in  nft_netlink_dump_start ??

Its the other way around.
This is the first try_module_get; at this point we still hold rcu read
lock.

If nf_tables module is being removed, try_module_get will fail and
we can error out.

If it succeeds, its safe to drop the rcu read lock.
