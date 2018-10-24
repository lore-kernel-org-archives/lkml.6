Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B54ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283F1207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F1207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJYBXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:23:06 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:33825 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727535AbeJYBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:23:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4E7758368EF0;
        Wed, 24 Oct 2018 16:54:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ducks88_7f5d1b57e64e
X-Filterd-Recvd-Size: 2956
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 16:54:14 +0000 (UTC)
Message-ID: <bbc4eba31b89cb487962c0a5980a12c53b1aa58b.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Wang Hai <wanghaifine@gmail.com>, edumazet@google.com,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 09:54:13 -0700
In-Reply-To: <20181024163230.GA25382@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
         <20181024155739.GA25314@1wt.eu>
         <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
         <20181024163230.GA25382@1wt.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 18:32 +0200, Willy Tarreau wrote:
> On Wed, Oct 24, 2018 at 09:23:19AM -0700, Joe Perches wrote:
> > On Wed, 2018-10-24 at 17:57 +0200, Willy Tarreau wrote:
> > > On Wed, Oct 24, 2018 at 11:47:29PM +0800, Wang Hai wrote:
> > > > To determine whether len is less than zero, it should be put before 
> > > > the function min_t, because the return value of min_t is not likely 
> > > > to be less than zero.
> > > 
> > > Huh? First, the <0 test is made on "len", not "min_t", so it still
> > > is signed. Second, you're in fact completely removing the test here,
> > > look :
> > > 
> > > >  	struct net *net = sock_net(sk);
> > > >  	int val, len;
> > > >  
> > > > +	len = min_t(unsigned int, len, sizeof(int));
> > > > +
> > > 
> > > len is used uninitialized here, so the result is undefined.
> > > 
> > > >  	if (get_user(len, optlen))
> > > >  		return -EFAULT;
> > > 
> > > Then it gets overridden by get_user()
> > > 
> > > > -	len = min_t(unsigned int, len, sizeof(int));
> > > > -
> > > 
> > > Then its positive values are not bounded anymore since you moved the test.
> > 
> > Not quite.
> > 
> > Problem here is negative values are tested as
> > large positive values and limited to 4
> > 
> > ie:
> > 	ien len = -1,
> > 	len = min_t(unsigned int, len, sizeof(int));
> > 
> > len is now 4
> > 	
> > > >  	if (len < 0)
> > > >  		return -EINVAL;
> > 
> > So this test len < 0 could be moved up above min_t
> 
> It could indeed, or we could also have min_t() done on an int instead
> of an unsigned int and this would avoid the need to shuffle the code
> around and open a huge hole like this one.

I think if the point is to test for negative numbers,
it's clearer to do that before using min_t.and it's
probably clearer not to use min_t at all.

	if (get_user(len, optlen))
		return -EFAULT;

	if (len < 0)
		return -EINVAL;

	if (len > sizeof(int))
		len = sizeof(int);



