Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522142333; cv=none;
        d=google.com; s=arc-20160816;
        b=SqgC5pbbLjOMNnPDXzAhWrn1Pgn8tXNl23ZgVyb7ml2K2TBpBDTkkrAHwUL310Vz7x
         76U6Rw3XV4dela1alRUfc3Owz2oD7OnR1c9dFlnk7+JwaIYtGC37lzTcU4OpSPc1Mnf3
         7u+Fo3wSVKVuBn6Lf19BeecfSM86nW+txPAALR7Qbm9qW0ousD6yuIHMRrPBURqNIxvQ
         F2c6RoJ1zL082NOEevmGvq48bML7X+mWOhITF40CiG1/tcuvAOuINZKcz7cDPz/gDo+J
         uaFGkJdvaVjJ0MwJ4RqKuR9ojuFtVl6IHLEvWxVM6GkgE340Tw5TinM7ykv5hhAbqCDO
         iqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=BpF04zaTlNbVRym7tLkTj8qkOruMPpVmqVX9zTgBMEs=;
        b=AbOQ5D4IBWvJdAv4U9AbE3k+bKDindIIUIyZjD5O7Zgmk+JOTw8X57mHJFPca70b3H
         ejVPH55iNipVK73kL9RkEv8gYrQawvdgkjfj/xZ5Z6JggrTMiTFCdxK9v6lVU+o58bGd
         V2Zdf7wNx85Qm21leFN/+oe69fksRd2EuImExatMFfK3EZK5fP76491hKyiqLLe/Tny9
         PfsW+fAqSGI7kqp3ta7IyU6rMfkeYIfh8Z+HS7RBBtTurBa80oqs/zslz1Ut2QBxTVfT
         HL6MEnh0rz3HIGj1SesG5rRt+5tQnDevaj7N3kKnrtNOluxiq3szu7h888HaU7pYxKr/
         vACw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lg8mh/bZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lg8mh/bZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuBR6czTkoFggbgqN8+r7mbHq6GfSbmJllvgUI5ZJPjIwM2AdbgQs4GRFOfUNY8agiX/G5GGw==
Date: Tue, 27 Mar 2018 12:18:50 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
	penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
	longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
	ying.huang@intel.com, mgorman@techsingularity.net,
	shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH 02/10] mm: Maintain memcg-aware shrinkers in
 mcg_shrinkers array
Message-ID: <20180327091850.ybql6l6gavhdieqg@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
 <20180324184516.rogvydnnupr7ah2l@esperanza>
 <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1596081919499256752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:20:55PM +0300, Kirill Tkhai wrote:
> On 24.03.2018 21:45, Vladimir Davydov wrote:
> > On Wed, Mar 21, 2018 at 04:21:29PM +0300, Kirill Tkhai wrote:
> >> The patch introduces mcg_shrinkers array to keep memcg-aware
> >> shrinkers in order of their shrinker::id.
> >>
> >> This allows to access the shrinkers dirrectly by the id,
> >> without iteration over shrinker_list list.
> > 
> > Why don't you simply use idr instead of ida? With idr you wouldn't need
> > the array mapping shrinker id to shrinker ptr. AFAIU you need this
> > mapping to look up the shrinker by id in shrink_slab. The latter doesn't
> > seem to be a hot path so using idr there should be acceptable. Since we
> > already have shrinker_rwsem, which is taken for reading by shrink_slab,
> > we wouldn't even need any additional locking for it.
> 
> The reason is ida may allocate memory, and since list_lru_add() can't fail,
> we can't do that there. If we allocate all the ida memory at the time of
> memcg creation (i.e., preallocate it), this is not different to the way
> the bitmap makes.
> 
> While bitmap has the agvantage, since it's simplest data structure (while
> ida has some radix tree overhead).
> 
> Also, bitmap does not require a lock, there is single atomic operation
> to set or clear a bit, and it scales better, when anything.

I didn't mean the per-memcg bitmaps - I think it's OK to use plain
arrays for them and reallocate them with the aid of RCU.

What I actually mean is the mapping shrink_id => shrinker. AFAIU it
isn't accessed from list_lru, it is only needed to look up a shrinker
by id from shrink_slab(). The latter is rather a slow path so I think
we can use an IDR for this mapping instead of IDA + plain array.
