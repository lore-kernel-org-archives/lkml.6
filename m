Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B06FC6178
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F233A2173F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9ZpzvhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F233A2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeIMVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:54:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeIMVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iW/SHZTSr7gGv2AfhcLoYSYAlYTZnC4UlMyDA5tr40A=; b=B9ZpzvhHysnpv71M2UKyLfov7
        SmG5zzT9vT0od398PSrNnyU3gDJm+/6YV5gmcpvQs//JwnhatllKETM+gBtxKU3U0Kc6QZP5omfzU
        u2bPclM06MWmBUTHxvHfrO037fLmonqhIEC9ynhmObbvjTYcZvyKCsF0cz1/vpox5yMgk8t0ZzzRL
        5bjHMm8i0kkdlGK+GwqHKHq2mG845USlqm+xM5QzCreHCctVySMCGdAemGdsArm+uoXDIZuJ4KCix
        8SexCwqT08LbAyp9sNl134CpVQKd0XZZfIkxvjem6v5s0JmTBBwC9q+hRrjjk5iOULqYNmUMKwype
        8Ju31Jqmw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Uid-00006j-UE; Thu, 13 Sep 2018 16:43:51 +0000
Date:   Thu, 13 Sep 2018 09:43:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iov_iter: Add new iters and use with AFS
Message-ID: <20180913164351.GC11574@bombadil.infradead.org>
References: <20180913161054.GB11574@bombadil.infradead.org>
 <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
 <17352.1536855503@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17352.1536855503@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:18:23PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > >  (5) Add an ITER_DISCARD iterator type.  This provides an iterator that
> > >      simply discards anything written to it.  It cannot be used as a data
> > >      source.
> > 
> > May I suggest an ITER_ZERO iterator type instead?  It acts like /dev/zero;
> > writes are discarded (as you have here) and reads return zeroes.
> > I've wanted such a thing in the past, but got distracted away from
> > that project.
> 
> I thought about that, but the zero-filling is not as easy to implement as the
> discard side - plus I don't have any use case to test it with.
> 
> Do you have a use case in mind?

At the time I did it, it was useful in dax, but I don't know if it is
any more.  It might serve to replace iov_iter_zero().
