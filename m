Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F7ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D620824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7D620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJYBr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:47:28 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:42593 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbeJYBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:47:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8A945181D341A;
        Wed, 24 Oct 2018 17:18:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frog90_4aa1ccc66364d
X-Filterd-Recvd-Size: 2341
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 17:18:32 +0000 (UTC)
Message-ID: <375561cf08343abbcd4118da2272507c30311788.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Willy Tarreau <w@1wt.eu>, wanghaifine@gmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Oct 2018 10:18:31 -0700
In-Reply-To: <CANn89iLH=VP1i=KS5QV1x41EpQM5-o1TJfDh01Y++bMpFpfBRg@mail.gmail.com>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
         <20181024155739.GA25314@1wt.eu>
         <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
         <20181024163230.GA25382@1wt.eu>
         <bbc4eba31b89cb487962c0a5980a12c53b1aa58b.camel@perches.com>
         <CANn89iLH=VP1i=KS5QV1x41EpQM5-o1TJfDh01Y++bMpFpfBRg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 10:03 -0700, Eric Dumazet wrote:
> On Wed, Oct 24, 2018 at 9:54 AM Joe Perches <joe@perches.com> wrote:
> 
> > I think if the point is to test for negative numbers,
> > it's clearer to do that before using min_t.and it's
> > probably clearer not to use min_t at all.
> > 
> 
> ...
> 
> >         if (len > sizeof(int))
> >                 len = sizeof(int);
> 
> It is a matter of taste really,

Agree and hence my use of 'I think' above.

> I know some people (like me) sometimes
> mixes min() and max()

Not quite sure what you mean here by mixes.
mix up?  If so, the < > inversions probably
have about the same error rate.

And I suppose there are cases where the
always set of len in uses like

	len = min(len, 4);

are more costly (len being in a slow write
speed area of memory or some such) than the
other style of

	if (len < 4)
		len = 4;

I think that min() is easier to read in most
cases.

> I would suggest that if someones wants to change the current code, a
> corresponding test would be added in tools/testing/selftests/net?

