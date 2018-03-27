Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522165712; cv=none;
        d=google.com; s=arc-20160816;
        b=QAfz7jETykOur7YkpPeLJ5iu+NfZxs4GQEOQS0GfxydAB9oC4V4ilXsluWHZFsvRHM
         WEDpSDVzh25rAf1y7yuyHLMIpoarHpe644Iv5fnWjLKYm3u9tcvb4vPeZhHIny+xdS/k
         NBpgfslmiv18vmYDeAxZ23Yao8eo41lGFSZ0fn7AG5sI+HwjN5gm2AwaMT7035BchsQP
         3ftcrKqT+771aQpFKvIgMiK+wlKSs1cDAkqVBExu3IbqvAwHFxvJbv1Q33+y1IC7rTeC
         Ku9Vh4hSnuk1OBXHZQGPexYfTnI9cuFEOXaAAlpkhbTU2bUQ4mmHR/hZrCifVCmE95RT
         gt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=Tw0xQ8FRqT8mt68rEnCOm1ZdznUJ0tycw0HWjlTOlNA=;
        b=tk2SIrMmYvnWrW6/Kn7C8tfr/cKp+ZqXLxOC3g0fX7EXWE4+DCKP3XtHhSbgfG0KZi
         PAO70UypL41cXUQzKCXGH/YGRRmlKPk/tF8exXexx1OtYZSbeMA1W4MMHvWE3umDNYvk
         /V9H3c2K4UgXvncozyuUkUZTeuQ9bFhpewg+rjmiicAXqLyH6LHHVIbQS0coZNtFckkZ
         LvZvKYzrTdUXLNz2GFG2bg3/AdBaLziIBjHp2bpC/waDKHL8U3bxkifkOtV5OI/sxmQx
         q2dqxJ2f3227g0Rvr6RMhjGjSofCL0Zr4iBtKAah71rHtcOW4k+Bq56HuqxU6hg/C72h
         9KQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UznMGanZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UznMGanZ;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv7MHwUkX56LnNX0iNbU6l53YGZ11GVN6nvMFTF6Z4tOU0d31LWXXwzPZwlo/CrX0VgrtVmgg==
Date: Tue, 27 Mar 2018 18:48:28 +0300
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
Message-ID: <20180327154828.udezpkwkwzcftnqn@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
 <20180327091504.zcqvr3mkuznlgwux@esperanza>
 <5828e99c-74d2-6208-5ec2-3361899dd36a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5828e99c-74d2-6208-5ec2-3361899dd36a@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596106433652332299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 06:09:20PM +0300, Kirill Tkhai wrote:
> >>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>> index 8fcd9f8d7390..91b5120b924f 100644
> >>>> --- a/mm/vmscan.c
> >>>> +++ b/mm/vmscan.c
> >>>> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
> >>>>  static LIST_HEAD(shrinker_list);
> >>>>  static DECLARE_RWSEM(shrinker_rwsem);
> >>>>  
> >>>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> >>>> +static DEFINE_IDA(bitmap_id_ida);
> >>>> +static DECLARE_RWSEM(bitmap_rwsem);
> >>>
> >>> Can't we reuse shrinker_rwsem for protecting the ida?
> >>
> >> I think it won't be better, since we allocate memory under this semaphore.
> >> After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
> >> which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
> >> for a small time, just to assign already allocated memory to maps.
> > 
> > AFAIR it's OK to sleep under an rwsem so GFP_ATOMIC wouldn't be
> > necessary. Anyway, we only need to allocate memory when we extend
> > shrinker bitmaps, which is rare. In fact, there can only be a limited
> > number of such calls, as we never shrink these bitmaps (which is fine
> > by me).
> 
> We take bitmap_rwsem for writing to expand shrinkers maps. If we replace
> it with shrinker_rwsem and the memory allocation get into reclaim, there
> will be deadlock.

Hmm, AFAICS we use down_read_trylock() in shrink_slab() so no deadlock
would be possible. We wouldn't be able to reclaim slabs though, that's
true, but I don't think it would be a problem for small allocations.

That's how I see this. We use shrinker_rwsem to protect IDR mapping
shrink_id => shrinker (I still insist on IDR). It may allocate, but the
allocation size is going to be fairly small so it's OK that we don't
call shrinkers there. After we allocated a shrinker ID, we release
shrinker_rwsem and call mem_cgroup_grow_shrinker_map (or whatever it
will be called), which checks if per-memcg shrinker bitmaps need growing
and if they do it takes its own mutex used exclusively for protecting
the bitmaps and reallocates the bitmaps (we will need the mutex anyway
to synchronize css_online vs shrinker bitmap reallocation as the
shrinker_rwsem is private to vmscan.c and we don't want to export it
to memcontrol.c).
