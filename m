Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB65C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1098247C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A3DesBqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1098247C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbeGCR6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:58:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934392AbeGCR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fvBl5fClATPACrpp/5GjJra4Ok63KW4ikU+qS/sH8jQ=; b=A3DesBqHRD2hx5rj6QZeQ/RAv
        z+C1h2RIa75NV1/z+aDewH4yTdZEdwRh4i7TvCbNzxypge5PiPOmtZ1ueOEr60edvD/fjkVAuiCCe
        I9HMmewE0DLUofEAcwwquOmuNwy+wftkUc56pfEvKHn8q5CmPHs5iB0MYoaM3lHZTqYmOUCMLGjQM
        zIEP5BDE0vAfY9Dj2KaPlEW0NCsNZ1WhzDOSx8hnu9g5sMrYlJ/WOX1Ro28CB7TU6woDxPKtiGhiN
        ZRuvJoh8kYtJuxkyoWEqKgm7ie9AZLHmP7Zpvff6D3JFNPgwVA1PtuC18nIvzKJC8vASCSu5mFRl1
        H5e0V7EVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPZ2-0005Ou-SA; Tue, 03 Jul 2018 17:58:08 +0000
Date:   Tue, 3 Jul 2018 10:58:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lirongqing@baidu.com, aryabinin@virtuozzo.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180703175808.GC4834@bombadil.infradead.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:46:57PM +0300, Kirill Tkhai wrote:
> shrinker_idr now contains only memcg-aware shrinkers, so all bits from memcg map
> may be potentially populated. In case of memcg-aware shrinkers and !memcg-aware
> shrinkers share the same numbers like you suggest, this will lead to increasing
> size of memcg maps, which is bad for memory consumption. So, memcg-aware shrinkers
> should to have its own IDR and its own numbers. The tricks like allocation big
> IDs for !memcg-aware shrinkers seem bad for me, since they make the code more
> complicated.

Do we really have so very many !memcg-aware shrinkers?

$ git grep -w register_shrinker |wc
     32     119    2221
$ git grep -w register_shrinker_prepared |wc
      4      13     268
(that's an overstatement; one of those is the declaration, one the definition,
and one an internal call, so we actually only have one caller of _prepared).

So it looks to me like your average system has one shrinker per
filesystem, one per graphics card, one per raid5 device, and a few
miscellaneous.  I'd be shocked if anybody had more than 100 shrinkers
registered on their laptop.

I think we should err on the side of simiplicity and just have one IDR for
every shrinker instead of playing games to solve a theoretical problem.

> > This will actually reduce the size of each shrinker and be more
> > cache-efficient when calling the shrinkers.  I think we can also get
> > rid of the shrinker_rwsem eventually, but let's leave it for now.
> 
> This patchset does not make the cache-efficient bad, since without the patchset the situation
> is so bad, that it's just impossible to talk about the cache efficiently,
> so let's leave lockless iteration/etc for the future works.

The situation is that bad /for your use case/.  Not so much for others.
You're introducing additional complexity here, and it'd be nice if we
can remove some of the complexity that's already there.
