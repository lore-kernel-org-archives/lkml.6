Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C778ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C30E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJYFSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:18:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35505 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeJYFSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:18:35 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9OKmqiL025521;
        Wed, 24 Oct 2018 22:48:52 +0200
Date:   Wed, 24 Oct 2018 22:48:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Joe Perches <joe@perches.com>
Cc:     David Miller <davem@davemloft.net>, wanghaifine@gmail.com,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181024204852.GA25509@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024.101028.1211941922121897721.davem@davemloft.net>
 <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:28:11AM -0700, Joe Perches wrote:
> On Wed, 2018-10-24 at 10:10 -0700, David Miller wrote:
> > From: Wang Hai <wanghaifine@gmail.com>
> > Date: Wed, 24 Oct 2018 23:47:29 +0800
> > 
> > > To determine whether len is less than zero, it should be put before 
> > > the function min_t, because the return value of min_t is not likely 
> > > to be less than zero.
> []
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> []
> > > @@ -3301,11 +3301,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
> > >       struct net *net = sock_net(sk);
> > >       int val, len;
> > >  
> > > +     len = min_t(unsigned int, len, sizeof(int));
> > > +
> > >       if (get_user(len, optlen))
> > >               return -EFAULT;
> > 
> > You can't be serious?
> 
> I'm not personally taken aback by this but
> there is the new Code of
> Conduct to consider.
> 
> John McEnroe earned quite a bit of his
> reputation as an 'enfant terrible' via a
> similar statement.
> 
> https://www.youtube.com/watch?v=t0hK1wyrrAU
> 
> Perhaps a different word choice next time in
> reply to submitters of ill-considered and/or
> defective patches could be useful.

Maybe but on this one I think we're really out of the scope of the CoC.

When you read this patch from an apparent first-time contributor (no
trace in either LKML, netdev or even google), the level of assurance
in the commit message is pretty good, showing that he's not at all a
beginner, which doesn't match at all the type of error seen in the
code, which doesn't even need to be compiled to see that it will emit
a warning and not work as advertised. Moreover, the commit message is
vague enough to seem it tries to cover the patch, and doesn't even
match what's done in the patch.

When you factor in the fact that the code opens a big but very discrete
vulnerability, I tend to think that in fact we're not facing a newbie
at all but someone deliberately trying to inject a subtle backdoor into
the kernel and disguise it as a vague bug fix, possibly even hoping that
it would find its way to -stable. I would not be surprised if this e-mail
address is a throw-away anonymous address created just for this occasion.

I could totally be wrong of course, but the clues are quite heavy here
as I find it hard to argue for a series of beginner's mistakes. If this
person really exists and can explain how we ended up there, I will of
course happily retract my suspicion and apologize.

Willy
