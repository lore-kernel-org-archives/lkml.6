Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72EA21A68
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/gQ4Hlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72EA21A68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934432AbeGCRsj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:48:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934151AbeGCRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=duh8DvsTwIGdNlTHwYtcWzMFUSLR4/Rfv93vsRrgpqg=; b=R/gQ4HlxmCQw76tjac3i63WXw
        5Gvz9DcHEC293AJjfJmPcVdAIHUyPj82/+aXfA0JDv87v+rFfWQxhWzcsqGJiYWjK+CdaYmth/ZYW
        loH5EP/G8EY1sDWX7RKHJN6ngPXIpBajfbDOcDE4wDgjLrWfXQ5xRfikrKdYmFwBwDe2LsG9kQa3m
        i/fNQcn+EkkmbP4nWRjcU9lmsx22PVj3TiDOvV1qSywDeSyAhAb83MSFZ07xQvL8NN8Co7wsVlvKK
        peXEKfSGOHvmC/icTEguJzhTUGPShWVGluZRwOJ7Qs7TnYNQab9gweUAVxuJ+FyxOlZMEQBWbcUiV
        OOWLy+VSw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPP1-0008E4-25; Tue, 03 Jul 2018 17:47:47 +0000
Date:   Tue, 3 Jul 2018 10:47:44 -0700
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
Message-ID: <20180703174744.GB4834@bombadil.infradead.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:46:28AM -0700, Shakeel Butt wrote:
> On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > This will actually reduce the size of each shrinker and be more
> > cache-efficient when calling the shrinkers.  I think we can also get
> > rid of the shrinker_rwsem eventually, but let's leave it for now.
> 
> Can you explain how you envision shrinker_rwsem can be removed? I am
> very much interested in doing that.

Sure.  Right now we have 3 uses of shrinker_rwsem -- two for adding and
removing shrinkers to the list and one for walking the list.  If we switch
to an IDR then we can use a spinlock for adding/removing shrinkers and
the RCU read lock for looking up an entry in the IDR each iteration of
the loop.

We'd need to stop the shrinker from disappearing underneath us while we
drop the RCU lock, so we'd need a refcount in the shrinker, and to free
the shrinkers using RCU.  We do similar things for other data structures,
so this is all pretty well understood.
