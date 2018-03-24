Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521917119; cv=none;
        d=google.com; s=arc-20160816;
        b=UdYvIW11n5OeMgMzS2+8vkGmxaRycblG3G68ObkjaqYL52SydT4W755cecdqoyITQO
         ZIvTEUqcRXe1eyhpCL6sSg923iH6lslJEAp0Q0DhGABrnoaT9aw7Fz0wNxJ4atDFj28R
         B+ygWi3S71vIUHn92h5/LbB6xkECpyeslvJTVUaaaLDpmdkMB4WCIy/8QfjZT4baffZ4
         q7ugHtuoJWOWBcIQ+CvojcouCltMA5ftpKnfXvT9LremjSbJ+UDJeF0okZz9b0eX8aj6
         b7VjDW74KOW5xaHWc9QX/QJEeWg1RMqYBI9+VY4r7ttP/ywwae5tVTwURuxmv6GFgbjX
         GBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=01eGxy/TyqSnibBdGyokv1RLpRm1TUHGWl/nqDSS0ck=;
        b=wGDBpYgem3DxTLCTBVzlnTEwzrM9DNfSMNnxSDNeirSdsLqm9YShhArS5PQ09jtTMV
         24pQ8erPXtjkj1hKe4ztFO3VIOZbGP3bdDJNZATloPrcPLQ3l/HhiHYJf+O97ptSynsg
         +VId6RKHJUUVD013+zveOMiyh6/bNvi8T0IRRWJjLE5+D3kXq5ejvHbZuYDdm7BXzVfu
         8VQwUi3mpES6CWRUSD02PdBUKFc8uqnd6u46wq3VX+nm19m7Y8OPg3RlZa9yKTOjvgYW
         KhqqsNSYOQ2d5q2xCst/vIByNF2QN5qP3uamZz4PhGwOLgX3yZlptiozsuCngGhsjsdT
         U12A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JbCOK8Bn;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JbCOK8Bn;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuKtRK4yowqP8HjMZEAxqEmTI3ISQhIuwL1gIcBl0lYXUPDJ1vmEaS02S9BkTuoetyj9fNJkQ==
Date: Sat, 24 Mar 2018 21:45:16 +0300
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
Message-ID: <20180324184516.rogvydnnupr7ah2l@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1595845765871959960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:21:29PM +0300, Kirill Tkhai wrote:
> The patch introduces mcg_shrinkers array to keep memcg-aware
> shrinkers in order of their shrinker::id.
> 
> This allows to access the shrinkers dirrectly by the id,
> without iteration over shrinker_list list.

Why don't you simply use idr instead of ida? With idr you wouldn't need
the array mapping shrinker id to shrinker ptr. AFAIU you need this
mapping to look up the shrinker by id in shrink_slab. The latter doesn't
seem to be a hot path so using idr there should be acceptable. Since we
already have shrinker_rwsem, which is taken for reading by shrink_slab,
we wouldn't even need any additional locking for it.
