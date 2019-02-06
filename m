Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA8CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28054218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549484075;
	bh=D/jyviaLgSda2+tt19m/3P0OWxLRwvwSZ0CI7AZU3po=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=HZpXFmF7bVe4YF8rMlUXILWIBJuq55CNHXXUwTvKcFOndwKXFKSOzEW+270uFZOQo
	 7GKNAWsWYo4rMp3OdrV4lIObUVcVS0gkynbARFfH03o6Dl94X/2sN6eUclRJWOf8Xv
	 kAza5j+zsQhfcFHzv8Bmn+F6g+eht5RactUZ2Hgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBFUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFUOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:14:32 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8821420823;
        Wed,  6 Feb 2019 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549484071;
        bh=D/jyviaLgSda2+tt19m/3P0OWxLRwvwSZ0CI7AZU3po=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LldSWTZgw7Qnu3m7DgpdJe/O3fRySBiF9x5ihc4fFM5ZNkcbnSpaDbuLf2s1gqalI
         qx8l6W8sFMXpe85Q3jYp97Uyk3pjmIsVbzX3siDZlFWRgLV//nQDRKQ9pH4fuDjDWe
         rqURUZjmRNNOXwspDe0A98cQHP3nME7OXYXak8Gc=
Date:   Wed, 6 Feb 2019 21:14:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH 3/3] mm/mincore: provide mapped status when cached status
 is not allowed
In-Reply-To: <e1478ab8-e009-9bdd-3866-f319bd7259a0@suse.cz>
Message-ID: <nycvar.YFH.7.76.1902062111120.11598@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-4-vbabka@suse.cz> <20190131100907.GS18811@dhcp22.suse.cz> <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz> <20190201091152.GG11599@dhcp22.suse.cz>
 <e1478ab8-e009-9bdd-3866-f319bd7259a0@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Vlastimil Babka wrote:

> > Well, but rss update will not tell you that the page has been faulted in
> > which is the most interesting part.
> 
> Sure, but the patch doesn't add back that capability neither. It allows
> to recognize page being reclaimed, and I argue you can infer that from
> rss change as well. That change is mentioned in the last paragraph in
> changelog, and I thought "add a hard to evaluate side channel" in your
> reply referred to that. It doesn't add back the "original" side channel
> to detect somebody else accessed a page.

On Fri, 1 Feb 2019, Vlastimil Babka wrote:

> > Is this really worth it? Do we know about any specific usecase that
> > would benefit from this change? TBH I would rather wait for the report
> > than add a hard to evaluate side channel.
> 
> Well it's not that complicated IMHO. Linus said it's worth trying, so
> let's see how he likes the result. The side channel exists anyway as
> long as process can e.g. check if its rss shrinked, and I doubt we are
> going to remove that possibility.

Linus, do you have any opinion here?

I have a hunch that mm maintainers are keeping this on a backburner 
because there might still open question(s) in the air.

Thanks,

-- 
Jiri Kosina
SUSE Labs

