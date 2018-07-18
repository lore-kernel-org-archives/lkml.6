Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DCD206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFVfuMSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DCD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGRNwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:52:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeGRNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yqKbWV/ssIQBJZDq+pXRRmaJfMPMF50h1x9aRo6+/Pw=; b=dFVfuMSrxcVBf2kxkpxDfUUrB
        kra7EgvNrAaRjzChOstX7DjZ9wzDkWP+CJcu9F6A8S2B0Ton66W6/e4D9gpV8B8xcp95RYXyyl1Y6
        /DOoSrYG+845JiG4nLUeXN3NHYmL7pZC/p2VarResTEJ4CA1QB5mpTcsScHJOn4UZexOmEUYxg6we
        Q7I4fz3LjpuqisiAQSWzJt1ectf69isrORB8OvfDNccVijOnO1cwy7mQrHcAEePwE/aV6r7CM2y0t
        q51KB+om22TeS4L5ujBuB8Y5D9qwLZnf8O/FGZQs+/2nk1iqBkA8l5H3AtVtxtJ5FfgQxIHw/O5+n
        eP2c3gQrQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffmI3-00037K-5M; Wed, 18 Jul 2018 13:14:47 +0000
Date:   Wed, 18 Jul 2018 06:14:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Varsha Rao <rvarsha016@gmail.com>
Subject: Re: linux-next: build failure after merge of the ida tree
Message-ID: <20180718131446.GC4949@bombadil.infradead.org>
References: <20180718165406.6f262266@canb.auug.org.au>
 <20180718092426.mxdti3jes5jsssta@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718092426.mxdti3jes5jsssta@salvia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:24:26AM +0200, Pablo Neira Ayuso wrote:
> > interacting with commit
> > 
> >   9679150a0bd5 ("netfilter: nf_tables: Use id allocation")
> > 
> > from the netfilter-next tree.
> 
> @Varsha, I'm very sorry, but I guess I have to toss your patch, I
> would prefer avoid dependencies with the IDA API by now.

I've had a chance to read this patch a bit more carefully.  It transforms
one anti-pattern into another, so I can't say I'm a fan.

The first is specific to the networking code; having a list of things
with IDs, and constructing a bitmap when we need to allocate a new ID.

The second is having both an IDA and a list of things.

The more effective way to do all of this is to use an IDR.  You can get
rid of the linked list *and* the IDA, and it's faster to iterate over.
The root of the IDR is the same size as the list_head, and then you need
only store the 4-byte ID in each element instead of the 16-byte list_head.

So Varsha, if you would like to take a look at transforming table->sets
from a LIST_HEAD to an IDR, I think that would be a great use of your
time.
