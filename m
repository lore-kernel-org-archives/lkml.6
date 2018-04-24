Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524568116; cv=none;
        d=google.com; s=arc-20160816;
        b=T1iR7R8rBaDCbtuSEu4CgJbLj4IDRXvRFnQLaJn1K8dd0mNz2UP2XCgWLemaRCQD0j
         CARn/DreHWLb4Vy3ULxMDzJohIulLYCN1Gugy/iUFT8H+sG5qcNPTx/pS3vUhpG3eWcI
         fzLMVoqhCudAZTC/oDZ5N/rELt4pUA2f6S1G9+yRoew7a1/4+wju3Esj2Z6qRmSDP60k
         hrSNk1dXSRot/MzU+nz1KEOtNYjMnyKAd2pucVn73+1CUqY7Wii/8BmoQjsxTmSVG8WT
         O1iG/C0uT9PC/Ijc0qA9hu8leFIvpT6UNp5qSB5qYcdS+Hxia1WHIWh8l52Oq5y+9O0p
         6hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=rwUNgrx3uKnV1/3bPUoFA1as6HycomeltALnNmFiT4w=;
        b=mjzlTu8nnvvK4WfE+7W4Of/6Pa/b+EqkXptXeMbV0C9NXOkWyQbAb7PPYHvHFLVO86
         q9/sGxnlDrmFdlbUbqAtTJAqs1h/fXL+zW/XVQknSCVXG5LdmwAqcQZeLsV0Nck6G/uJ
         si10NDmznnhs6yjn7AmZXaiQqAvysbVC3s+PoB/7tdK1ezlOokPSmElFPJEkcsK376Qu
         gGmCQ1fbVTYztP6l1uuCXapMz13hbhu/jI/PIEp3OQWr2um05ifIZXPyU/fpuwsg5eGr
         H/MkoPq8eXN9NPJedoJFGrw/w0B5SxBBkxchk3cWkphI8AQ3bUFbqpGAuqvUTedlNoDF
         FvXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XWnMa7v7;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XWnMa7v7;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpB4Qd1cvIRW3XQUE92BndRb86aLkADkzsmFDgrIyJdxrozD4j/LS1jRczGbrGdNQypLcwy/w==
Date: Tue, 24 Apr 2018 14:08:32 +0300
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
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180424110832.barhpnnm5u2shmcu@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <552aba74-c208-e959-0b4f-4784e68c6109@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552aba74-c208-e959-0b4f-4784e68c6109@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598625536961475463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 02:06:31PM +0300, Kirill Tkhai wrote:
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 4f02fe83537e..f63eb5596c35 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -172,6 +172,22 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >>  #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> >>  static DEFINE_IDR(shrinkers_id_idr);
> >>  
> >> +static int expand_shrinker_id(int id)
> >> +{
> >> +	if (likely(id < shrinkers_max_nr))
> >> +		return 0;
> >> +
> >> +	id = shrinkers_max_nr * 2;
> >> +	if (id == 0)
> >> +		id = BITS_PER_BYTE;
> >> +
> >> +	if (expand_shrinker_maps(shrinkers_max_nr, id))
> >> +		return -ENOMEM;
> >> +
> >> +	shrinkers_max_nr = id;
> >> +	return 0;
> >> +}
> >> +
> > 
> > I think this function should live in memcontrol.c and shrinkers_max_nr
> > should be private to memcontrol.c.
> 
> It can't be private as shrink_slab_memcg() uses this value to get the last bit of bitmap.

Yeah, you're right, sorry I haven't noticed that.

What about moving id allocation to this function as well? IMHO it would
make the code flow a little bit more straightforward. I mean,

alloc_shrinker_id()
{
	int id = idr_alloc(...)
	if (id >= memcg_nr_shrinker_ids)
		memcg_grow_shrinker_map(...)
	return id;
}

> 
> >>  static int add_memcg_shrinker(struct shrinker *shrinker)
> >>  {
> >>  	int id, ret;
> >> @@ -180,6 +196,11 @@ static int add_memcg_shrinker(struct shrinker *shrinker)
> >>  	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
> >>  	if (ret < 0)
> >>  		goto unlock;
> >> +	ret = expand_shrinker_id(id);
> >> +	if (ret < 0) {
> >> +		idr_remove(&shrinkers_id_idr, id);
> >> +		goto unlock;
> >> +	}
> >>  	shrinker->id = id;
> >>  	ret = 0;
> >>  unlock:
> >>
