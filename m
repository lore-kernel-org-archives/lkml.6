Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524420219; cv=none;
        d=google.com; s=arc-20160816;
        b=zYUbiz32r4PA8mAEb/bBHk0BDnhf9PFZhzdtbfn6PlGQ3089UEJurJYyGWJwUhpvUX
         w8taRkp9z0sap+KBciwh6YtvdTmrpI/7asblJumXQ53U8bETZJc161knIUQpwqS/rCLV
         Nn1eIsMHgZR2gZQ85PakuA3wNwZZdmi7oSrYhmeGSzelikJxfFdFyR4LphEJP3eWeKkD
         9xWC4jmZSvhWus0H3erwaxDCf6Jtx01Ze36LVDo6P4A3Cf2dW8n5UyFE8fkASL8FR1Ot
         wJwWxnbEcV1qiVPXg0rfwdjqwWjMQ9buf7Mv/HHibPwF0zG9J27a2mwH2VB5ZpfIep61
         ZVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=FYT9lcUDTby6vLfiGHBBBGwklUq0J+iA6+7pUzbTFoQ=;
        b=EjIN7XTT1FR5Y5o2/19iBxFqb9V5X5N8eAs5IzrfdErgskxWODgFJdRFVwQYqXQdrf
         avYrsyoP5Qw7nSeTfIqp77iGb/IkHd6Fhcoqjtmqlcqn5U0EQ06CFBc2qFZi7KbUyRW9
         pNbEBdoZw/3WQ2RXoqQtBfp4qE9kbPWb5PQ6RYcI2qYV6GtbZ9i7K+7hhXcjbPHnaFOp
         VOGzFIOrFyfwNIK9v7vwaUCKXunbFhloc3S9nETqh8wcVblKFPVjrM4at0O+hu9ZY5lG
         kgjTyY49dOHoy/9OorQtikTM0py/TGNhjhDTROWJIH/DXOPGfTSCFro3Qh670dakUIDA
         77sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ohwQ5gpK;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ohwQ5gpK;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqeYHi0/xX3Y9XFK0FQtMAwo+Z/LeKGxWgy3EJH5oef9HNDmShCZlSoRSqivHPHykGAOTZ0GA==
Date: Sun, 22 Apr 2018 21:03:36 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v2 05/12] fs: Propagate shrinker::id to list_lru
Message-ID: <20180422180336.n6ahbpwmpedjga5n@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399122780.3456.1111065927024895559.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152399122780.3456.1111065927024895559.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009315192285775?=
X-GMAIL-MSGID: =?utf-8?q?1598470456031685396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 09:53:47PM +0300, Kirill Tkhai wrote:
> The patch adds list_lru::shrinker_id field, and populates
> it by registered shrinker id.
> 
> This will be used to set correct bit in memcg shrinkers
> map by lru code in next patches, after there appeared
> the first related to memcg element in list_lru.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/super.c               |    4 +++-
>  include/linux/list_lru.h |    1 +
>  include/linux/shrinker.h |    8 +++++++-
>  mm/list_lru.c            |    6 ++++++
>  mm/vmscan.c              |   15 ++++++++++-----
>  mm/workingset.c          |    3 ++-
>  6 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5fa9a8d8d865..9bc5698c8c3c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -518,7 +518,9 @@ struct super_block *sget_userns(struct file_system_type *type,
>  	hlist_add_head(&s->s_instances, &type->fs_supers);
>  	spin_unlock(&sb_lock);
>  	get_filesystem(type);
> -	err = register_shrinker(&s->s_shrink);
> +	err = register_shrinker_args(&s->s_shrink, 2,
> +				     &s->s_dentry_lru.shrinker_id,
> +				     &s->s_inode_lru.shrinker_id);

This looks ugly. May be, we could allocate an id in prealloc_shrinker
then simply pass it to list_lru_init in arguments?
