Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F2EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAA22075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAA22075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJYBBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:01:53 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35490 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYBBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:01:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9OGWUTi025385;
        Wed, 24 Oct 2018 18:32:30 +0200
Date:   Wed, 24 Oct 2018 18:32:30 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Joe Perches <joe@perches.com>
Cc:     Wang Hai <wanghaifine@gmail.com>, edumazet@google.com,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181024163230.GA25382@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024155739.GA25314@1wt.eu>
 <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:23:19AM -0700, Joe Perches wrote:
> On Wed, 2018-10-24 at 17:57 +0200, Willy Tarreau wrote:
> > On Wed, Oct 24, 2018 at 11:47:29PM +0800, Wang Hai wrote:
> > > To determine whether len is less than zero, it should be put before 
> > > the function min_t, because the return value of min_t is not likely 
> > > to be less than zero.
> > 
> > Huh? First, the <0 test is made on "len", not "min_t", so it still
> > is signed. Second, you're in fact completely removing the test here,
> > look :
> > 
> > >  	struct net *net = sock_net(sk);
> > >  	int val, len;
> > >  
> > > +	len = min_t(unsigned int, len, sizeof(int));
> > > +
> > 
> > len is used uninitialized here, so the result is undefined.
> > 
> > >  	if (get_user(len, optlen))
> > >  		return -EFAULT;
> > 
> > Then it gets overridden by get_user()
> > 
> > > -	len = min_t(unsigned int, len, sizeof(int));
> > > -
> > 
> > Then its positive values are not bounded anymore since you moved the test.
> 
> Not quite.
> 
> Problem here is negative values are tested as
> large positive values and limited to 4
> 
> ie:
> 	ien len = -1,
> 	len = min_t(unsigned int, len, sizeof(int));
> 
> len is now 4
> 	
> > >  	if (len < 0)
> > >  		return -EINVAL;
> 
> So this test len < 0 could be moved up above min_t

It could indeed, or we could also have min_t() done on an int instead
of an unsigned int and this would avoid the need to shuffle the code
around and open a huge hole like this one.

Willy
