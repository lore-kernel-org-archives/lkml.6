Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE7EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3872086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3872086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeGVJI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:08:59 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:60988 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbeGVJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:08:59 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fh9Ty-0000kI-F0; Sun, 22 Jul 2018 10:12:46 +0200
Date:   Sun, 22 Jul 2018 10:12:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     cscnull@gmail.com, Pablo Neira Ayuso <pablo@netfilter.org>,
        kadlec@blackhole.kfki.hu, Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        kstewart@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dsahern@gmail.com, lucien.xin@gmail.com, ktkhai@virtuozzo.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] netlink: fix memory leak
Message-ID: <20180722081246.udphfijsnfnshrsc@breakpoint.cc>
References: <20180722024925.3176-1-cscnull@gmail.com>
 <CAHmME9pLNd5GeR4kq_KHcarPKh3mkS5Cv-2s-tiQsPG6GcZ6sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pLNd5GeR4kq_KHcarPKh3mkS5Cv-2s-tiQsPG6GcZ6sw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Sun, Jul 22, 2018 at 4:51 AM Shaochun Chen <cscnull@gmail.com> wrote:
> But even if you moved it somehow to the if(ret), I'm still not sure
> it'd be correct; start cbs should either succeed, or they should error
> out and cleanup entirely after themselves.

I agree, ->done() should not be called if cb->dump() was never invoked.

All ctnetlink and nf_tables spots need to cleanup after themselves.
