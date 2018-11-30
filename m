Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3C32146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tvfaxah5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3C32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeLAFQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:16:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeLAFQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hopdeM218p6zL6llhqlc1laXYCeDdooFPkSuhlPpOo0=; b=Tvfaxah5b6crNnqDYjDQdOlFW
        u1+LpvMolHuuJo/olY9lhl+ynoXnkukaci8ZBcjB9NWSXuO8IvXylDVE8vkEZdImHwZY1tiTUNJ2e
        VxYhXCLzpDvN+0jIdRipWfStBDyL8TqYb2fSF98DjifTrustj9QpWJrGOEqFERL7PBVgoJmKJolpc
        HXDAGn3TmCR2jTVe/mJjplhZM1WX0x90PacOo7NjpyWax5b2oaWDTM3Dr5REi1/JLvBYVKFP0w8GI
        WKVDSGMfLMCSLSLBTrkltvf9nkXxM9ilm49WXgV81oCEIDGbdGkWOkwbwLfHcRlEjD6Xf4OOaW1ER
        hwy0/j2Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSnBF-0001nX-Eh; Fri, 30 Nov 2018 18:06:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B90AD2029F87F; Fri, 30 Nov 2018 19:06:19 +0100 (CET)
Date:   Fri, 30 Nov 2018 19:06:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181130180619.GC11614@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <20181130153128.GB11650@hirez.programming.kicks-ass.net>
 <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
 <20181130174804.GA11573@hirez.programming.kicks-ass.net>
 <5c79d914-96d3-1dcc-0a61-7f8f4db4fd06@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c79d914-96d3-1dcc-0a61-7f8f4db4fd06@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:49:34PM +0000, StDenis, Tom wrote:
> On 2018-11-30 12:48 p.m., Peter Zijlstra wrote:
> > On Fri, Nov 30, 2018 at 04:19:46PM +0000, StDenis, Tom wrote:
> >> On 2018-11-30 10:31 a.m., Peter Zijlstra wrote:
> > 
> >>> I pushed them out to:
> >>>
> >>>     git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/mm
> >>>
> >>> I hope that works; I'm out for a few hours, but should check on email
> >>> again tonight.
> >>>
> >>
> >> NAK I get a failure in TTM on init with your x86/mm branch (see attached
> >> dmesg).
> > 
> > *sigh*, it's been one of those days. Ok, I'll go write some cpa
> > selftests or something so that I have code that uses this stuff.
> > 
> 
> Well the ttm crash could be completely unrelated the problem is your 
> x86/mm branch is not up to date with master and doesn't include drm fixes.

Well, it crashes right in the middle of the CPA code, and I'm having a
horrible day, so I'm thinking I screwed up rather than anything else.

Also, some level of selftests would be good to have in any case I
figure.
