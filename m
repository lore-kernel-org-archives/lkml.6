Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6F020A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWaDg2wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6F020A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeHUQ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:56:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHUQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Ik70fkhtA+i4KltCtBN9SUSTfc5ejDaxPea9qStIbA=; b=ZWaDg2wC+LxkW9laImhhzP38y
        GkhPlMprhLtnQAQgLDJwC57adGPqSJn/u289YPwlhanM9RtLwrXwkQqZeVTEDVAcqiSxUr06Nojyk
        urQ4Vpvu6+O9c7rzYXPDxSj02KsRNQieEQewO0DNBm/U0bqU9OqJhtLbXCUH/6yg3Trj3Wsh6kqV/
        wV8pgm5NwbOGoy4jpBI7L14kkoxE8Rhuaq7E0O5TGhIBvJhrq7nYz0IgetaGophrserCWGuL+lDFW
        ztvig+5pt6Fd4I7q835OccQZBAQKvZd1xByQnTN9jvNDFn0kaRkDuS2YpwI3N6/p1gB3XoQqZmE/A
        3t1Il5wEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs6p3-0004Tf-Ad; Tue, 21 Aug 2018 13:35:49 +0000
Date:   Tue, 21 Aug 2018 06:35:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off
 error
Message-ID: <20180821133548.GA10602@bombadil.infradead.org>
References: <20180817231834.15959-1-guro@fb.com>
 <20180818012213.GA14115@bombadil.infradead.org>
 <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:11:44AM +0300, Konstantin Khlebnikov wrote:
> On Sat, Aug 18, 2018 at 4:22 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
> >> -                     scan = div64_u64(scan * fraction[file],
> >> -                                      denominator);
> >> +                     if (scan > 1)
> >> +                             scan = div64_u64(scan * fraction[file],
> >> +                                              denominator);
> >
> > Wouldn't we be better off doing a div_round_up?  ie:
> >
> >         scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
> >
> > although i'd rather hide that in a new macro in math64.h than opencode it
> > here.
> 
> All numbers here should be up to nr_pages * 200 and fit into unsigned long.
> I see no reason for u64. If they overflow then u64 wouldn't help either.

Shaohua added the div64 usage initially, adding him to the cc.

> There is macro DIV_ROUND_UP in kernel.h

Indeed there is.
