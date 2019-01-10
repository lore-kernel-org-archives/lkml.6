Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E731820660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TbmC6P61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfAJOu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:50:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfAJOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yf2o7Qr2A0EynpqG9ISnaaUomBOS5WiwMGXUM9f9/Bw=; b=TbmC6P61VuVcfg3sapG+k2XPN
        OF6DMx4XacypBaKDCKS33Q8595To2868TqaRLjTKv/pzW1Gq6eypAYxhMD9EEetDuNkXc7OLhFjir
        QjBO4s6tyeA9XXO81ZhVgzxO9hryOl+DSCnB29aRRkAIYolcGa2fL5EkgP+ExRh4IL/Gje/F6jQVy
        afw+5WoVzQTxsxxU4eyZJKevZaC3f6NANGCj6xwrhDlLh6m/nEWUQDNh0Xagzd+G+zwHy1r+iXzQR
        +xmsZISm4i4rTgOQ6P4NhXGaUpEgw6h4Wrfi/8ZWC8gWWz/gWsEUREM2+ZDlENv73pUZYUE0oNWW5
        ohPSoU3cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghbf3-0000D7-06; Thu, 10 Jan 2019 14:50:21 +0000
Date:   Thu, 10 Jan 2019 06:50:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190110145020.GW6310@bombadil.infradead.org>
References: <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard>
 <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard>
 <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110004424.GH27534@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:44:24AM +1100, Dave Chinner wrote:
> And, really, this would be just another band-aid over a symptom of
> the information leak - it doesn't prevent users from being able to
> control page cache invalidation. It just removes one method, just
> like hacking mincore only removes one method of observing the page
> cache.  And, like mincore(), there's every chance it impacts on
> userspace in a negative manner and so we need to be very careful
> here.

Putting the mincore() / cache timing information leak aside though,
the current behaviour of XFS means that an attacker can screw up the
performance of random applications just by repeatedly doing O_DIRECT
reads of libc.so.

Maybe O_DIRECT reads should be forbidden from files on XFS unless you
also have write access to them?  (eg owner).

