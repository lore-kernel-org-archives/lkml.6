Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E720857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5E720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIGIMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:12:37 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:44486 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIGIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:12:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fy7W7-00056k-W3; Fri, 07 Sep 2018 11:33:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fy7Vx-0000ev-Ae; Fri, 07 Sep 2018 11:32:57 +0800
Date:   Fri, 7 Sep 2018 11:32:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Olof Johansson <olof@lixom.net>,
        David Miller <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH] net/sock: move memory_allocated over to percpu_counter
 variables
Message-ID: <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au>
References: <20180906192034.8467-1-olof@lixom.net>
 <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:33:58PM -0700, Eric Dumazet wrote:
> On Thu, Sep 6, 2018 at 12:21 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Today these are all global shared variables per protocol, and in
> > particular tcp_memory_allocated can get hot on a system with
> > large number of CPUs and a substantial number of connections.
> >
> > Moving it over to a per-cpu variable makes it significantly cheaper,
> > and the added overhead when summing up the percpu copies is still smaller
> > than the cost of having a hot cacheline bouncing around.
> 
> I am curious. We never noticed contention on this variable, at least for TCP.

Yes these variables are heavily amortised so I'm surprised that
they would cause much contention.

> Please share some numbers with us.

Indeed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
