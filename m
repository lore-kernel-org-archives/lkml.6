Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A215224F7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mraLDIX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A215224F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934440AbeGCT0D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:26:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933196AbeGCT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=avtgIFaAPOdfeP7X3pYeyLrJPaeiHPelWWqFh0hmLSA=; b=mraLDIX5Hf+a2JIbF450DHnj6
        LihoDe9j6hLL3w19u1TL37xd1nr3kWcdOSxVNvl8rPwhsT3t4GFyNwX6rzY1Okx/Oi4bYHyiUuQU3
        WNR7w/Byh84agm2Cc6BTdPfW6ji98OekPKp/6hGwa8ZhKN8K8MNG1A5veW3avUoT2AVK+YyQ8ThHe
        xW9O4OHBwYyrAKX3SsJ3SBEo6rSGiWXrVpZbkFQ+xKUcRyb6k7Ln6Ds6x492ZdsbZ/ACtmzU58S/F
        3aPQzczPKuAIQ+Ujfz5aO/aFDfNe7De/V99y9k8Ol5YQ+C8nUqqFmy/FRwxEo/zQ1H0+I/bRS/U/4
        1U75qGe5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faQvN-0004Sw-8R; Tue, 03 Jul 2018 19:25:17 +0000
Date:   Tue, 3 Jul 2018 12:25:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180703192517.GA22738@bombadil.infradead.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
 <20180703175808.GC4834@bombadil.infradead.org>
 <94c282fd-1b5a-e959-b344-01a51fd5fc2e@virtuozzo.com>
 <CALvZod7v4n62PVvC50VSNV12ZV0WdsY4GOQt68EmY4u5fc9hfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7v4n62PVvC50VSNV12ZV0WdsY4GOQt68EmY4u5fc9hfQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:19:35PM -0700, Shakeel Butt wrote:
> On Tue, Jul 3, 2018 at 12:13 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > > Do we really have so very many !memcg-aware shrinkers?
> > >
> > > $ git grep -w register_shrinker |wc
> > >      32     119    2221
> > > $ git grep -w register_shrinker_prepared |wc
> > >       4      13     268
> > > (that's an overstatement; one of those is the declaration, one the definition,
> > > and one an internal call, so we actually only have one caller of _prepared).
> > >
> > > So it looks to me like your average system has one shrinker per
> > > filesystem, one per graphics card, one per raid5 device, and a few
> > > miscellaneous.  I'd be shocked if anybody had more than 100 shrinkers
> > > registered on their laptop.
> > >
> > > I think we should err on the side of simiplicity and just have one IDR for
> > > every shrinker instead of playing games to solve a theoretical problem.
> >
> > It just a standard situation for the systems with many containers. Every mount
> > introduce a new shrinker to the system, so it's easy to see a system with
> > 100 or ever 1000 shrinkers. AFAIR, Shakeel said he also has the similar
> > configurations.
> >
> 
> I can say on our production systems, a couple thousand shrinkers is normal.

But how many are !memcg aware?  It sounds to me like almost all of the
shrinkers come through the sget_userns() caller, so the other shrinkers
are almost irrelevant.
