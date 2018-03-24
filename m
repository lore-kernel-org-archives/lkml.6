Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521917421; cv=none;
        d=google.com; s=arc-20160816;
        b=Nl/waY4+KcZcNTvxZFDvQQhHICsV0n+pQPO/hT75CaiOOiFaVbmy7RCiqCGDcmIwaK
         XB0W0+xmGQ5Oo/wfrrd4Zr6RupRTyFfGLDDgY/7XCzenWza+WGO7PeM9GSkEKElBCsRv
         T2I39zXmlucn4vfmU5ZU4O1AUZs2J8EKf+XdEA2ygqJjEnP9J1lolB+q74EWoWCI26vi
         qjLPXpy1nKHeEQ0apn5j/MCReG22HSmPK6LJ+f7o02CdtfViIGE480d/ya763AQvkrgc
         j+gpRtJYKQ5b0T41GNMRCJViy7wbkm1BAUm1410MNlR5o1yGiLcw1svslWOgGI00EkUU
         3WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=UnQ47EHbqK8CUBxRw3FVezd0+eOwSHbkFrlGm7jBpnQ=;
        b=RmYYTX+JuU9Rgq+54CWJgtGYUONrjyAsLzP3vN4pgkdVFWtNVm2DwP0WHk/cXd5EyX
         SRAG75QVwm0akpvXwq78PraToOJjd07INlGzhUCLyrsf4/+j/gnHmB+KKLjJzG271Fso
         hLmJmu1ei26x8CqG18BNQYgS3KFYJwFsP8zGJWz0VHZBuNFyNoqWn23Z/wMKJYfQWIYq
         lkxSZS7IM6kqotGD333RHxqg0tHsW0q8NvA3faKh5Ag9oG9Y+qrPeRQBBrLYIkCaX0Db
         QAFToJydrnVfGUmzlujLxsYGEA7Gt5GuDz91td+jKYOHOD1+dGrjKtfdcN4QPPpmsvk8
         CdzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OkzyGxKZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OkzyGxKZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/LeQ1W+z4ZaSvH1l+C/XFeUcivfcEnxNW6exRwjvt0IWJhJTkYxcVk3hyE7FdSqvvoQkNxLw==
Date: Sat, 24 Mar 2018 21:50:18 +0300
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
Subject: Re: [PATCH 04/10] fs: Propagate shrinker::id to list_lru
Message-ID: <20180324185018.iibbx3zjtzikjtlc@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163851112.21546.11559231484397320114.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163851112.21546.11559231484397320114.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553635124492604?=
X-GMAIL-MSGID: =?utf-8?q?1595846081297983271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:21:51PM +0300, Kirill Tkhai wrote:
> The patch adds list_lru::shrk_id field, and populates
> it by registered shrinker id.
> 
> This will be used to set correct bit in memcg shrinkers
> map by lru code in next patches, after there appeared
> the first related to memcg element in list_lru.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/super.c               |    5 +++++
>  include/linux/list_lru.h |    1 +
>  mm/list_lru.c            |    7 ++++++-
>  mm/workingset.c          |    3 +++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 0660083427fa..1f3dc4eab409 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -521,6 +521,11 @@ struct super_block *sget_userns(struct file_system_type *type,
>  	if (err) {
>  		deactivate_locked_super(s);
>  		s = ERR_PTR(err);
> +	} else {
> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> +		s->s_dentry_lru.shrk_id = s->s_shrink.id;
> +		s->s_inode_lru.shrk_id = s->s_shrink.id;
> +#endif

I don't really like the new member name. Let's call it shrink_id or
shrinker_id, shall we?

Also, I think we'd better pass shrink_id to list_lru_init rather than
setting it explicitly.
