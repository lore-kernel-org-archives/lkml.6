Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522142107; cv=none;
        d=google.com; s=arc-20160816;
        b=QUBK10VedfRTJFJaL4mkcEsG4o3vZN34Nl5KOSk14IbK+mqP0bQKADW752TdDSSJ49
         7LPf/a1Ny8aZR4Xwz+5nbBozw1ARUAEwL3yGvJbFyiWmRF4GFr/yMw4CzbNkJ4B6NOYL
         zPAX58LCJcSPlAF8/hv8JDD0bxAOjD6Cu7DXwJTZl7DqJMjGq1cHFZJ5qi2Yzlg0WX+3
         nofsJswgURbMraGfV81rKLPJ7CuwYx1EIh7u5N9ThLOomHLL6uGbIrBBeKJTn4W50soI
         5Iaw/O1k1+LgaWBiJt/kv/yDJF7atCC40Sh/BLlX+jF0remSyn681DdsXKEHZNZ7WwOZ
         73KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=IP/5640eGTm+lrGD5tbDl1YAcA61UWl2gH7Q5QFclp4=;
        b=TVOnuFgZ7AERMVQVEUlFD2KRgJJVxB/hnbSl675sZI80EhEH4ijF8L9rr2alKhkY68
         ZbBOK3gdezaAjD9y3I+pQ0/4Ml9QSGo346lxgC2RgtgcEGmCSsgQH3cqdiEwdroPkoxg
         89xzBRiUi81fUun646co1IT+nNWD6v4gzvmZ0sWiN2ea5vSKgPCssqOAYyApi0P51XHf
         Q1lDiT9eudOqT3+SGxSF2y+VuPasDnlWsvh/4IPbBtDXrw81x2E36VVYwuBQ9dsDR7WC
         hcw0EDZul+ts10tze7NBww1udI8notW0gCTitJnObd+WsBqoM72FJ4UsZPHNLV8GO9vn
         yZEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BGbmCrXw;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BGbmCrXw;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuFeJZZN5ZLnbG/P+FkBwjbf56bi+LPmkHgYluqYGQDEP9ZGgRdVBP0HKEqlxuoa7znBhStyg==
Date: Tue, 27 Mar 2018 12:15:04 +0300
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
Message-ID: <20180327091504.zcqvr3mkuznlgwux@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596081682915121119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:09:35PM +0300, Kirill Tkhai wrote:
> Hi, Vladimir,
> 
> thanks for your review!
> 
> On 24.03.2018 21:40, Vladimir Davydov wrote:
> > Hello Kirill,
> > 
> > I don't have any objections to the idea behind this patch set.
> > Well, at least I don't know how to better tackle the problem you
> > describe in the cover letter. Please, see below for my comments
> > regarding implementation details.
> > 
> > On Wed, Mar 21, 2018 at 04:21:17PM +0300, Kirill Tkhai wrote:
> >> The patch introduces shrinker::id number, which is used to enumerate
> >> memcg-aware shrinkers. The number start from 0, and the code tries
> >> to maintain it as small as possible.
> >>
> >> This will be used as to represent a memcg-aware shrinkers in memcg
> >> shrinkers map.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> ---
> >>  include/linux/shrinker.h |    1 +
> >>  mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 60 insertions(+)
> >>
> >> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> >> index a3894918a436..738de8ef5246 100644
> >> --- a/include/linux/shrinker.h
> >> +++ b/include/linux/shrinker.h
> >> @@ -66,6 +66,7 @@ struct shrinker {
> >>  
> >>  	/* These are for internal use */
> >>  	struct list_head list;
> >> +	int id;
> > 
> > This definition could definitely use a comment.
> > 
> > BTW shouldn't we ifdef it?
> 
> Ok
> 
> >>  	/* objs pending delete, per node */
> >>  	atomic_long_t *nr_deferred;
> >>  };
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 8fcd9f8d7390..91b5120b924f 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
> >>  static LIST_HEAD(shrinker_list);
> >>  static DECLARE_RWSEM(shrinker_rwsem);
> >>  
> >> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> >> +static DEFINE_IDA(bitmap_id_ida);
> >> +static DECLARE_RWSEM(bitmap_rwsem);
> > 
> > Can't we reuse shrinker_rwsem for protecting the ida?
> 
> I think it won't be better, since we allocate memory under this semaphore.
> After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
> which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
> for a small time, just to assign already allocated memory to maps.

AFAIR it's OK to sleep under an rwsem so GFP_ATOMIC wouldn't be
necessary. Anyway, we only need to allocate memory when we extend
shrinker bitmaps, which is rare. In fact, there can only be a limited
number of such calls, as we never shrink these bitmaps (which is fine
by me).

> 
> >> +static int bitmap_id_start;
> >> +
> >> +static int alloc_shrinker_id(struct shrinker *shrinker)
> >> +{
> >> +	int id, ret;
> >> +
> >> +	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> >> +		return 0;
> >> +retry:
> >> +	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
> >> +	down_write(&bitmap_rwsem);
> >> +	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);
> > 
> > AFAIK ida always allocates the smallest available id so you don't need
> > to keep track of bitmap_id_start.
> 
> I saw mnt_alloc_group_id() does the same, so this was the reason, the additional
> variable was used. Doesn't this gives a good advise to ida and makes it find
> a free id faster?

As Matthew pointed out, this is rather pointless.
