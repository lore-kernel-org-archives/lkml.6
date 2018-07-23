Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D3420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D3420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbeGWLwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:52:45 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35468 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387815AbeGWLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:52:45 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fhYRb-0008Ja-Tm; Mon, 23 Jul 2018 12:52:00 +0200
Date:   Mon, 23 Jul 2018 12:51:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>, cscnull@gmail.com,
        kadlec@blackhole.kfki.hu, johannes.berg@intel.com, Jason@zx2c4.com,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        xiyou.wangcong@gmail.com, dsahern@gmail.com,
        netfilter-devel@vger.kernel.org, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: fix memory leak of dump
Message-ID: <20180723105159.vpknxgam3fqeicvv@breakpoint.cc>
References: <20180722143354.23722-1-cscnull@gmail.com>
 <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
 <20180722.100755.19840167505550163.davem@davemloft.net>
 <20180722180910.wcwhantwpm2nfxet@breakpoint.cc>
 <20180723091551.mwhltw4ujm4bylvj@salvia>
 <20180723092818.ztsfsnqzxgzrauim@breakpoint.cc>
 <20180723093855.c4ncixsnkee6r34v@salvia>
 <20180723094228.mejwuvoyitolqktv@breakpoint.cc>
 <20180723094742.gg6e73l6aknghal7@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723094742.gg6e73l6aknghal7@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Jul 23, 2018 at 11:42:28AM +0200, Florian Westphal wrote:
> We can also add another scratchpad area, similar to the ->cb[x] area
> that can be initialized before netlink_dump_start()? So we don't need
> the data pointer.
> 
> By passing the array of attributes, we'll need to do attribute parsing
> over and over again from each netlink_dump() call.

Its still done once, parsing is only delayed/moved to ->start().

Now:

nla_parse
control->data = kmalloc() + init
netlink_dump_start()
  ->start() /* if it returns 0, done() will be called eventually
  netlink_dump()
->done()
  free(cb->data);

Proposed fix:
control->data = &on_stack;
netlink_dump_start()
  ->start()
     nla_parse
     cb->data = kmalloc() + init
  netlink_dump()
->done()
  free(cb->data);

I've submitted a patch for nf_tables, let me know if you have a better
idea or see a problem with it.
