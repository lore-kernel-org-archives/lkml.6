Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELuFrzD6wOncSl8C3fPegWOmu0JejbHmRYC5Qd6+gVgiQq4d1gO1EofMj6EYNmPThk6EQmh0
ARC-Seal: i=1; a=rsa-sha256; t=1521644197; cv=none;
        d=google.com; s=arc-20160816;
        b=LTVQS287Di0R83rr3XOz9ye8mubt1B3z3XMgxraIpq+26D7iGpsEbpBFazEdy7QyAv
         RX2WfjqKItkZWSq9bjzvLKlAoZQabfzRSDlbt3HajQw0c2GstgOxdW2Bt0HDToUUgeje
         vKy4d7sce+bdgfgVLfjWVR2RFK/1s1KrhwREDOtMByy+4eCmB/hiBjvr1JrYptE1zd46
         bu3LmT6Rc/AiN0GiNjnwChhFcmwvBn6hfJfn3almucSTVpbS8KqTjhLXJl9yYKSQDeO0
         gPsK+VfLWWOcGXvin2AiSR5OOM85zspa28o+ZDj/dw1/kFFUa+nAzZKBxmTLwAbXMaJ3
         bP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=x78mglObPLPEW7Yxwk7KGlSHs+OxJMUXPZy/9POnDx8=;
        b=fFZcdK2tgD2WNqdXMShvOesCC31Jmx4kfI6mNygAJ1H29W3fSh7Xjo0Qk/T8nrn2/G
         4QrmjuCxkZSqO5J/x5ydmrB/ImUlvqzZy89/0qWuPviSiNATjcZkmi6Azq3R9rtx/O7r
         IDwM0mhR1dkDpRtmQNRwBuCAMD1QGOax/Rk04VIpO0Sx2zbAui53iU0BgQ4OYw4QCDQ/
         kluuoHM2KWNecFYmuxDLrG9RBtjB+WYaziUGnx1n5fUginrKxpMaWZgpFTolNMobjt/S
         qOYFXPuV/bK4AKu34wCeuNNBagE6vgEreGgHkmmepLYJJCVZ9Vfc726kneOrdxkhBntt
         SUVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fYiH8fNi;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fYiH8fNi;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 21 Mar 2018 07:56:25 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	vdavydov.dev@gmail.com, akpm@linux-foundation.org,
	tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, shakeelb@google.com, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180321145625.GA4780@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595559585983782521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:21:40PM +0300, Kirill Tkhai wrote:
> +++ b/include/linux/memcontrol.h
> @@ -151,6 +151,11 @@ struct mem_cgroup_thresholds {
>  	struct mem_cgroup_threshold_ary *spare;
>  };
>  
> +struct shrinkers_map {
> +	struct rcu_head rcu;
> +	unsigned long *map[0];
> +};
> +
>  enum memcg_kmem_state {
>  	KMEM_NONE,
>  	KMEM_ALLOCATED,
> @@ -182,6 +187,9 @@ struct mem_cgroup {
>  	unsigned long low;
>  	unsigned long high;
>  
> +	/* Bitmap of shrinker ids suitable to call for this memcg */
> +	struct shrinkers_map __rcu *shrinkers_map;
> +
>  	/* Range enforcement for interrupt charges */
>  	struct work_struct high_work;
>  

Why use your own bitmap here?  Why not use an IDA which can grow and
shrink automatically without you needing to play fun games with RCU?
