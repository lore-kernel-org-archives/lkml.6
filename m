Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2058ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550F620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550F620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJYEjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:39:53 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35499 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYEjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:39:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9OK9kEP025492;
        Wed, 24 Oct 2018 22:09:46 +0200
Date:   Wed, 24 Oct 2018 22:09:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Eric Dumazet <edumazet@google.com>
Cc:     joe@perches.com, wanghaifine@gmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181024200946.GB25475@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024155739.GA25314@1wt.eu>
 <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
 <20181024163230.GA25382@1wt.eu>
 <bbc4eba31b89cb487962c0a5980a12c53b1aa58b.camel@perches.com>
 <CANn89iLH=VP1i=KS5QV1x41EpQM5-o1TJfDh01Y++bMpFpfBRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLH=VP1i=KS5QV1x41EpQM5-o1TJfDh01Y++bMpFpfBRg@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:03:08AM -0700, Eric Dumazet wrote:
> On Wed, Oct 24, 2018 at 9:54 AM Joe Perches <joe@perches.com> wrote:
> 
> > I think if the point is to test for negative numbers,
> > it's clearer to do that before using min_t.and it's
> > probably clearer not to use min_t at all.
> >
> 
> ...
> 
> >
> >         if (len > sizeof(int))
> >                 len = sizeof(int);
> 
> It is a matter of taste really, I know some people (like me) sometimes
> mixes min() and max()

I do mix them up a lot as well because I tend to read "x=min(y,4)" as
"take y with a minimum value of 4" which in fact would be "max(y,4)".

> I would  suggest that if someones wants to change the current code, a
> corresponding test
> would be added in tools/testing/selftests/net

In any case, what matters to me is that for now the only risk the existing
code represents is to overwrite up to one int of some userspace if the size
is negative, and we don't want that a wrong fix results in doing something
worse by accident like reading 2GB of kernel memory. I agree that Joe's
test with len<0 then len>sizeof(int) seems to work, but a test is probably
useful at least to ensure that the next person who passes there and wants
to turn this into min_t() again clearly catches all bad cases.

Regards,
Willy
