Return-Path: <shakeelb@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525920459; cv=none;
        d=google.com; s=arc-20160816;
        b=cqee2GceDp0XgiwmxR+rAxPQghPnOc/6b7e/2M9NWUNq7uLZffZNbtYtLD8OF8D5TL
         2W+oCA6Nqx1LGl4fkL8e3tqrTberV5SlD6w170OfnWK5zy/cWX5gmle4AiE7/TCIaS9L
         iQlM8OMH82o0oa+M+B1iL9aLK69E1oKzH7dNm+QhOaqBEYW1MB4flQN7t+VxgEJ2bRi+
         ods6ZviO6sWJ/wCaXp+uUaWo6FFWDKsi16oNJooFEHJWqhKnWxpjgFYTix1oz+Kfjygy
         ZExIibMXgw53J6olnFCw7a6kyg3T9IFQ2A1qQmTRgPlOR8R2eZBSshfDbMQZiYG5Fsfq
         EpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bRJtQ488tiyhnEgZXadG8o1kC7N8MC/B0UoIS20lF9A=;
        b=bNp9QyMsJ3ZIk6eN60vLnucO9PWLmF3akUjornRc2YM383OMN4LtM83YpWicpNQG9W
         dubxDOB/VqNI7cfOrW2roSWj5gSb1PwSk1Ov2RhKrlN0BsDBiYiktvSjxbU7wI99QhY1
         jb2PWvVcizqxbD+Zal+G34y1Rrs4Sfcdr0GtLg+FLSNVZwgp/n83yw+R98jTzk+wUtUe
         YO8g1s6FVSFWTSf7VMJds86xYOsDW7Az0wA6QSrnE5jtGYVBHwMUb0f+hHmnXhLsUtcU
         o+wgY5Er/iZgeXAbECZLbafE0lPWNf8lTmiUmVLGaC8j4RAiZP9TfVSnSXS/Wu01sajh
         eLzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V1MALTpP;
       spf=pass (google.com: domain of shakeelb@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=shakeelb@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V1MALTpP;
       spf=pass (google.com: domain of shakeelb@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=shakeelb@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpNocn8WLYzZmPQvDwCLx6gfgdoc9K4JGLpbAH/o/Krjr/kwxFL4zQiDVcFGe4NzL+3/LmHw4nCnfOzYxZ4SLY=
MIME-Version: 1.0
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
 <152586701534.3048.9132875744525159636.stgit@localhost.localdomain> <20180509155511.9bb3de08b33d617559e5fb3a@linux-foundation.org>
In-Reply-To: <20180509155511.9bb3de08b33d617559e5fb3a@linux-foundation.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 10 May 2018 02:47:27 +0000
Message-ID: <CALvZod4QNfxkhg1x5NyfWjHe+OmK1kVeU-wepKdmDH46n7Ha0Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] mm: Assign id to every memcg-aware shrinker
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Vladimir Davydov <vdavydov.dev@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, Roman Gushchin <guro@fb.com>, mka@chromium.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, chris@chris-wilson.co.uk,
	longman@redhat.com, Minchan Kim <minchan@kernel.org>, Huang Ying <ying.huang@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com, linux@roeck-us.net,
	LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>, lirongqing@baidu.com,
	Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600043571652449783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 3:55 PM Andrew Morton <akpm@linux-foundation.org>
wrote:

> On Wed, 09 May 2018 14:56:55 +0300 Kirill Tkhai <ktkhai@virtuozzo.com>
wrote:

> > The patch introduces shrinker::id number, which is used to enumerate
> > memcg-aware shrinkers. The number start from 0, and the code tries
> > to maintain it as small as possible.
> >
> > This will be used as to represent a memcg-aware shrinkers in memcg
> > shrinkers map.
> >
> > ...
> >
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct
file_system_type *type, int flags,
> >       s->s_time_gran = 1000000000;
> >       s->cleancache_poolid = CLEANCACHE_NO_POOL;
> >
> > +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)

> It would be more conventional to do this logic in Kconfig - define a
> new MEMCG_SHRINKER which equals MEMCG && !SLOB.

> This ifdef occurs a distressing number of times in the patchset :( I
> wonder if there's something we can do about that.

> Also, why doesn't it work with slob?  Please describe the issue in the
> changelogs somewhere.

> It's a pretty big patchset.  I *could* merge it up in the hope that
> someone is planning do do a review soon.  But is there such a person?


Hi Andrew, couple of these patches are being reviewed by Vladimir and I
plan to review too by next week. I think we can merge them into mm tree for
more testing and I will also this patch series internally (though I have to
backport them to our kernel for more extensive testing).

thanks,
Shakeel
