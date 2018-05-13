Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526230680; cv=none;
        d=google.com; s=arc-20160816;
        b=h2uflRhcfb2E+bk+QSeib6tmeLp4taNoCHoR7w5gPfFeitUOeLNgY0k3WXcBmtW4Dt
         4v1m4xmxkkAola+GU1JctYDrsCypVyrQqyHyVJxQnp4qu2wbLQ4cCYUh2K8Z50yb/1Jt
         XtJ1BNZIGXmm4097S1v6fHvOGTAtKh0ijg5yAwvikRM9wxhzZczlqDxqjJd6MLBJ4brz
         E66CNOKctlLI66hrhqWScI4OtVmXT3F6XwPw4iHptgGGI7j/0ovqq1RMN6rNOZEgMQKP
         rzltJcccPcdakJLXcPPRu2y0Do0c+AoYbfL6+SixQFs50d9bOw975jVG4DdKWBWy30IR
         5yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=bkbro8PbJe+1XM+xFdSPG6FOgCehkVNIBDorUTzgGXs=;
        b=oxnzt8MzMt1qc53g4xz9RvPoMq9d5JeB/AJS0KeC6d2OJKlJh1y5pHjigG59emAMgz
         0FgG1bd4RD5mW3Fit6L2kJfz4O5FNZ/iC7SYCXfZQWPi3Z6v43RNZcSsnyC278NREESi
         duXzuS/8nAhspKG9WO+jp2Y2ZlkuRQa2T1DvpQAMMmCmfiuApbm4a8MGztlKP39AD99N
         NuZWRNUZ8oyDTFe1FhEZC2P6VsIjEnb8wbu1YORVicnSaf/Kcngia5OrglRMX1AzehAT
         scRjJRlcaHs9DKiT6cywvRcbum+YtKKSBgtr2HSjYE8Je2pqamyjK/gqzXWV/xJuSnZD
         eQ5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BgjUGpan;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BgjUGpan;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrgV75oGSLCJs73ilCrBZRoybj8RlOdzhVVo4oWvg2UJ7j5SYsptVaVIuCY8dU2b/lL2pWhRg==
Date: Sun, 13 May 2018 19:57:56 +0300
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
Subject: Re: [PATCH v5 06/13] fs: Propagate shrinker::id to list_lru
Message-ID: <20180513165756.obsexfkvnyoylq6v@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594598693.22949.2394903594690437296.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152594598693.22949.2394903594690437296.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070346813073089?=
X-GMAIL-MSGID: =?utf-8?q?1600368862061201588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 12:53:06PM +0300, Kirill Tkhai wrote:
> The patch adds list_lru::shrinker_id field, and populates
> it by registered shrinker id.
> 
> This will be used to set correct bit in memcg shrinkers
> map by lru code in next patches, after there appeared
> the first related to memcg element in list_lru.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/super.c               |    4 ++++
>  include/linux/list_lru.h |    3 +++
>  mm/list_lru.c            |    6 ++++++
>  mm/workingset.c          |    3 +++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2ccacb78f91c..dfa85e725e45 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -258,6 +258,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  		goto fail;
>  	if (list_lru_init_memcg(&s->s_inode_lru))
>  		goto fail;
> +#ifdef CONFIG_MEMCG_SHRINKER
> +	s->s_dentry_lru.shrinker_id = s->s_shrink.id;
> +	s->s_inode_lru.shrinker_id = s->s_shrink.id;
> +#endif

I don't like this. Can't you simply pass struct shrinker to
list_lru_init_memcg() and let it extract the id?
