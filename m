Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A89C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393A2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393A2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeH0FpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:45:19 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:21061
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbeH0FpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:45:19 -0400
X-IronPort-AV: E=Sophos;i="5.53,293,1531778400"; 
   d="scan'208";a="276809348"
Received: from unknown (HELO hadrien) ([208.181.63.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 04:00:48 +0200
Date:   Sun, 26 Aug 2018 22:00:46 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Al Viro <viro@ZenIV.linux.org.uk>
cc:     Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
In-Reply-To: <20180826224322.GX6515@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1808262159430.2528@hadrien>
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk> <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com> <20180826173236.GU6515@ZenIV.linux.org.uk> <d31fe59160e0b7d40e09536a3c74619ebb1f3b13.camel@perches.com>
 <20180826212421.GW6515@ZenIV.linux.org.uk> <eca48539a3dede3bfaed9ab9a6c06794cf8160e0.camel@perches.com> <20180826224322.GX6515@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Aug 2018, Al Viro wrote:

> On Sun, Aug 26, 2018 at 03:26:54PM -0700, Joe Perches wrote:
> > On Sun, 2018-08-26 at 22:24 +0100, Al Viro wrote:
> > > On Sun, Aug 26, 2018 at 11:57:57AM -0700, Joe Perches wrote:
> > >
> > > > > That, BTW, is why I hate the use of sizeof(*p) in kmalloc, etc.
> > > > > arguments.  typeof is even worse in that respect.
> > > >
> > > > True.  Semantic searches via tools like coccinelle could help here
> > > > but those searches are quite a bit slower than straightforward greps.
> > >
> > > Those searches are .config-sensitive as well, which can be much more
> > > unpleasant than being slow...
> >
> > Are they?  Julia?
>
> They work pretty much on preprocessor output level; if something it ifdef'ed
> out on given config, it won't be seen...

Coccinelle doesn't care what is ifdef'd out.  It only misses the things it
can't parse.  Very strange ifdefs could indeed cause that, but it should
be a minor problem.

julia
