Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB90E23DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB90E23DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeGCUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:40:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43212 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeGCUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:40:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1faS4k-0008JF-53; Tue, 03 Jul 2018 20:39:02 +0000
Date:   Tue, 3 Jul 2018 21:39:02 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
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
Message-ID: <20180703203901.GV30522@ZenIV.linux.org.uk>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
 <20180703174744.GB4834@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703174744.GB4834@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:47:44AM -0700, Matthew Wilcox wrote:
> On Tue, Jul 03, 2018 at 08:46:28AM -0700, Shakeel Butt wrote:
> > On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > This will actually reduce the size of each shrinker and be more
> > > cache-efficient when calling the shrinkers.  I think we can also get
> > > rid of the shrinker_rwsem eventually, but let's leave it for now.
> > 
> > Can you explain how you envision shrinker_rwsem can be removed? I am
> > very much interested in doing that.
> 
> Sure.  Right now we have 3 uses of shrinker_rwsem -- two for adding and
> removing shrinkers to the list and one for walking the list.  If we switch
> to an IDR then we can use a spinlock for adding/removing shrinkers and
> the RCU read lock for looking up an entry in the IDR each iteration of
> the loop.
> 
> We'd need to stop the shrinker from disappearing underneath us while we
> drop the RCU lock, so we'd need a refcount in the shrinker, and to free
> the shrinkers using RCU.  We do similar things for other data structures,
> so this is all pretty well understood.

<censored>
struct super_block {
...
        struct shrinker s_shrink;       /* per-sb shrinker handle */
...
}
<censored>

What was that about refcount in the shrinker and taking over the lifetime
rules of the objects it might be embedded into, again?
