Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521916812; cv=none;
        d=google.com; s=arc-20160816;
        b=ynFDrnschsFMswKUKnuymczhY8qtIj2VG4jTDAVYU4eeFjAttA2VQa5g5nxn8MlZFp
         lU5FICggY1FFUCz8IIBbnAIZtF/BEtBN9NiBG3Xwh3RMAIYM3WLNTq1x7mund6pJrdeL
         nMUyJkZXHAAJJ7SGK5ubFvKJSs1czdRbcVLbmJAgkazRNfyfOBhDNEonZpIci3FoOhHl
         NGP3HvBeAY7n1kGClw3vwkf1lokZCQKZSMEUOeLr8ARQapZE+se7qMenGXcAlHIjQ5M6
         MFl+OLVCmqyXKGSHAuDux1oCroeqtRh6vXSxXFjOzYzT4YxEaIK01j3PtKKZ9H2AxfBZ
         F9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=1x/XcgpwXhpYN+nX00iNI7leEvm3H4wtDC1RsvD4uf8=;
        b=nyuGdqogVMIULq38qrPRGI0ABNGzt49PNncK9OaDf5whnqSjt2ifGlDPnLMZ0Lr44O
         Z3OmVOymiCNjMrXsVyhLNgU3SCIxHo0RoDFtA+sdT+qVhfB1WRhKwK6ngJQQmIx9gkXK
         gZSElX5Y1IakV30/fAJLRG5EW3ZH+IVkw6z7R+uK6E5H4MsEcAs1ZPiLsCCrDHba7p79
         DlXCoHtMXsZsRGPRqJdjpvrKBwVd/j59haMytzxO1oGAvUJwoYImFOsVJ8YHG07CI2Vi
         ws+Lvim5MYVMO8orKVGmt7QJdxf4BjUtu/PBbX4PGPHro1PqCLZUFml/7HVjndKp8fJy
         vStg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vJk5QqCq;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vJk5QqCq;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvsS6P8dlKy2VP1TG6VsEWLOjNtKjvTCmx4PqyvKESTchTkWRLwQHJu8CmVzHiykLvjTu7PCg==
Date: Sat, 24 Mar 2018 21:40:09 +0300
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
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1595845443393992189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Kirill,

I don't have any objections to the idea behind this patch set.
Well, at least I don't know how to better tackle the problem you
describe in the cover letter. Please, see below for my comments
regarding implementation details.

On Wed, Mar 21, 2018 at 04:21:17PM +0300, Kirill Tkhai wrote:
> The patch introduces shrinker::id number, which is used to enumerate
> memcg-aware shrinkers. The number start from 0, and the code tries
> to maintain it as small as possible.
> 
> This will be used as to represent a memcg-aware shrinkers in memcg
> shrinkers map.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/shrinker.h |    1 +
>  mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index a3894918a436..738de8ef5246 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -66,6 +66,7 @@ struct shrinker {
>  
>  	/* These are for internal use */
>  	struct list_head list;
> +	int id;

This definition could definitely use a comment.

BTW shouldn't we ifdef it?

>  	/* objs pending delete, per node */
>  	atomic_long_t *nr_deferred;
>  };
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8fcd9f8d7390..91b5120b924f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> +static DEFINE_IDA(bitmap_id_ida);
> +static DECLARE_RWSEM(bitmap_rwsem);

Can't we reuse shrinker_rwsem for protecting the ida?

> +static int bitmap_id_start;
> +
> +static int alloc_shrinker_id(struct shrinker *shrinker)
> +{
> +	int id, ret;
> +
> +	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		return 0;
> +retry:
> +	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
> +	down_write(&bitmap_rwsem);
> +	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);

AFAIK ida always allocates the smallest available id so you don't need
to keep track of bitmap_id_start.

> +	if (!ret) {
> +		shrinker->id = id;
> +		bitmap_id_start = shrinker->id + 1;
> +	}
> +	up_write(&bitmap_rwsem);
> +	if (ret == -EAGAIN)
> +		goto retry;
> +
> +	return ret;
> +}
