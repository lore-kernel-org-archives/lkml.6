Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526354953; cv=none;
        d=google.com; s=arc-20160816;
        b=gS6BfxVbk46yhTlyBX+8Jj5brXveMqQzwkBcBq0RqhtjVN4C8GX5hrlI0Z3bv6H3SP
         LxWKQ+u+2HJ3mRU759pKf9cRUVo4crYczPuFs0TpINWNrwNCDynck5JUjHC1Z2sW+wcc
         /CQCeW+c2qFAEDFijB+TZPZN2cJfnQiH+GEeBwcF68U3BV13oDpFflK+hfNmf90mCeRh
         8TfMlmrBUczqlcFwVu5mpmk5XIeAGkagDp22Ltum2AlBY7u9E9MGAT0vI/Gg2QTomJQJ
         0D/08jXD/8MiybKRnK6qnDeQMYhnPpj0xKrBdH1wZVTl92hfcNj6v7x+zVTfeL2B7fw+
         d9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=2Lj4naZtZqt9irH9/MoqsnFeZIJXiLGfMZqBHu0zp2U=;
        b=o7dHe8qNNmXqxkP/k4zW9ESHv1sKhDZIqyUpgtxGo0o/4w8PyMwgLpUWdzE21TziNy
         8rMPZPP+wO7O437FyV7DRNxiM1nZaGhB4bSwLdFS0M7m2mlDOBCXJ1br5BykMfF6OSTp
         MFtu839WVMpqqWCT3GRQbxUf1SCRP1gtn9rQ5iPL+qMUKBY7j0Ae0ODrj/dSovvAyWDQ
         /HAWn0mRxCC/2jpJIzNqkI38O64IRnQsH037JWJORYDSalnNw47cO6cjxa2RjKMaskFD
         YC46aPvjUUQEzAV0eDEdch7rpPS2G1OI4exvW9VvkEofy3XPv8p5LrfI7sEUtsVEnBYH
         9ENw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sXepanG6;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sXepanG6;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrkDJpM96GqwB0EqMmDhqhMnaboJcU2ymHhRyIY9OqcbTFvqNm9ik1kSbeAAw+5ugF7TdF1wg==
Date: Tue, 15 May 2018 06:29:09 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
	aryabinin@virtuozzo.com
Subject: Re: [PATCH v5 01/13] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180515032909.kjbhxxg7463nnvwo@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594593798.22949.6730606876057040426.stgit@localhost.localdomain>
 <20180513051509.df2tcmbhxn3q2fp7@esperanza>
 <e4889603-c337-c389-a819-17f8d4fd03ad@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4889603-c337-c389-a819-17f8d4fd03ad@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600499170988223506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 12:03:38PM +0300, Kirill Tkhai wrote:
> On 13.05.2018 08:15, Vladimir Davydov wrote:
> > On Thu, May 10, 2018 at 12:52:18PM +0300, Kirill Tkhai wrote:
> >> The patch introduces shrinker::id number, which is used to enumerate
> >> memcg-aware shrinkers. The number start from 0, and the code tries
> >> to maintain it as small as possible.
> >>
> >> This will be used as to represent a memcg-aware shrinkers in memcg
> >> shrinkers map.
> >>
> >> Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
> >> in case of !SLOB only, the new functionality will be under MEMCG && !SLOB
> >> ifdef (symlinked to CONFIG_MEMCG_SHRINKER).
> > 
> > Using MEMCG && !SLOB instead of introducing a new config option was done
> > deliberately, see:
> > 
> >   http://lkml.kernel.org/r/20151210202244.GA4809@cmpxchg.org
> > 
> > I guess, this doesn't work well any more, as there are more and more
> > parts depending on kmem accounting, like shrinkers. If you really want
> > to introduce a new option, I think you should call it CONFIG_MEMCG_KMEM
> > and use it consistently throughout the code instead of MEMCG && !SLOB.
> > And this should be done in a separate patch.
> 
> What do you mean under "consistently throughout the code"? Should I replace
> all MEMCG && !SLOB with CONFIG_MEMCG_KMEM over existing code?

Yes, otherwise it looks messy - in some places we check !SLOB, in others
we use CONFIG_MEMCG_SHRINKER (or whatever it will be called).

> 
> >> diff --git a/fs/super.c b/fs/super.c
> >> index 122c402049a2..16c153d2f4f1 100644
> >> --- a/fs/super.c
> >> +++ b/fs/super.c
> >> @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
> >>  	s->s_time_gran = 1000000000;
> >>  	s->cleancache_poolid = CLEANCACHE_NO_POOL;
> >>  
> >> +#ifdef CONFIG_MEMCG_SHRINKER
> >> +	s->s_shrink.id = -1;
> >> +#endif
> > 
> > No point doing that - you are going to overwrite the id anyway in
> > prealloc_shrinker().
> 
> Not so, this is done deliberately. alloc_super() has the only "fail" label,
> and it handles all the allocation errors there. The patch just behaves in
> the same style. It sets "-1" to make destroy_unused_super() able to differ
> the cases, when shrinker is really initialized, and when it's not.
> If you don't like this, I can move "s->s_shrink.id = -1;" into
> prealloc_memcg_shrinker() instead of this.

Yes, please do so that we don't have MEMCG ifdefs in fs code.

Thanks.
