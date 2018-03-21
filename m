Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELvygg1QV8z8kEbBPDLr1Yaghw4uxn70eTPM+i54wUuHcNwdzv0MqFkIY1yOv4ImrMkklLhL
ARC-Seal: i=1; a=rsa-sha256; t=1521649251; cv=none;
        d=google.com; s=arc-20160816;
        b=fUdn/UIgVL9hGUjzfqypcADS3zEOzB+yL2EADq2RDqXTC+wXT1/4JFsFJYaKwHlxm1
         U2LsN3hKDWSIVfSOimDKbwnyYco81hiTAn5MX+G7kHlq5Am0slMysrdSRyYsFHpakAa3
         LRk8yuMPBwTqYPUxW7/qTbnu+jC6EBLXgDN7A22umsX2kxvv9YGrSDiDzK3bjFucUTHv
         veE8IZsUGXSMUS1eg2YFOLZpfdZGfgh3yJe7yphygmPl9ETZBco992T9KS78MNC9M6Z/
         FnDrI/iKS2bzW4FkBz8VNf8NRR0t/JBkevYoHpcmKm8UqrQYcIWnv/ihnKZGC7HXP7Z+
         Ko7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ILYf89dlw7eNxYt6xx/4ZEpX0Lp6XwPdundiPVMh200=;
        b=Xpo98oU3ZKHrRAJCHRwXc++qAePpX3u33TLcMbEQC04EdkSBtCKOMc5YbOjZciviSQ
         P8bxuR5sunUDAblbiERqas1Hzq3Ly2vFHRcCqCAg0m5EGfWZbI9AB5qKxqt8Y2uTC6I8
         bWsk2rxVldwrdzzd27iB2ncq/2LWTEZNYMZbzBJF5DAxcvjBcUz4CYx+q4e1Ez+QPSY+
         zqIeXZ0ZWWhzGfMRYsX1IlWDhKWjquX/1c90Mjllzjvy1ZnEqnOENb3rx79/oqBSSRFe
         7Kn1BqGtluFlPtjr76/YMLl2m7/ls90jtGWbY6jTD7ZUDo7YKnK/pcUou4HAomOODol/
         t9DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Nr9ohil3;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Nr9ohil3;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 21 Mar 2018 09:20:39 -0700
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
Message-ID: <20180321162039.GC4780@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180321145625.GA4780@bombadil.infradead.org>
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
 <20180321152647.GB4780@bombadil.infradead.org>
 <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595564885156708058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 06:43:01PM +0300, Kirill Tkhai wrote:
> On 21.03.2018 18:26, Matthew Wilcox wrote:
> > On Wed, Mar 21, 2018 at 06:12:17PM +0300, Kirill Tkhai wrote:
> >> On 21.03.2018 17:56, Matthew Wilcox wrote:
> >>> Why use your own bitmap here?  Why not use an IDA which can grow and
> >>> shrink automatically without you needing to play fun games with RCU?
> >>
> >> Bitmap allows to use unlocked set_bit()/clear_bit() to maintain the map
> >> of not empty shrinkers.
> >>
> >> So, the reason to use IDR here is to save bitmap memory? Does this mean
> >> IDA works fast with sparse identifiers? It seems they require per-memcg
> >> lock to call IDR primitives. I just don't have information about this.
> >>
> >> If so, which IDA primitive can be used to set particular id in bitmap?
> >> There is idr_alloc_cyclic(idr, NULL, id, id+1, GFP_KERNEL) only I see
> >> to do that.
> > 
> > You're confusing IDR and IDA in your email, which is unfortunate.
> > 
> > You can set a bit in an IDA by calling ida_simple_get(ida, n, n, GFP_FOO);
> > You clear it by calling ida_simple_remove(ida, n);
> 
> I moved to IDR in the message, since IDA uses global spinlock. It will be
> taken every time a first object is added to list_lru, or last is removed.
> These may be frequently called operations, and they may scale not good
> on big machines.

I'm fixing the global spinlock issue with the IDA.  Not going to be ready
for 4.17, but hopefully for 4.18.

> Using IDR will allow us to introduce memcg-related locks, but I'm still not
> sure it's easy to introduce them in scalable-way. Simple set_bit()/clear_bit()
> do not require locks at all.

They're locked operations ... they may not have an explicit spinlock
associated with them, but the locking still happens.

> > The identifiers aren't going to be all that sparse; after all you're
> > allocating them from a global IDA.  Up to 62 identifiers will allocate
> > no memory; 63-1024 identifiers will allocate a single 128 byte chunk.
> > Between 1025 and 65536 identifiers, you'll allocate a 576-byte chunk
> > and then 128-byte chunks for each block of 1024 identifiers (*).  One of
> > the big wins with the IDA is that it will shrink again after being used.
> > I didn't read all the way through your patchset to see if you bother to
> > shrink your bitmap after it's no longer used, but most resizing bitmaps
> > we have in the kernel don't bother with that part.
> > 
> > (*) Actually it's more complex than that... between 1025 and 1086,
> > you'll have a 576 byte chunk, a 128-byte chunk and then use 62 bits of
> > the next pointer before allocating a 128 byte chunk when reaching ID
> > 1087.  Similar things happen for the 62 bits after 2048, 3076 and so on.
> > The individual chunks aren't shrunk until they're empty so if you set ID
> > 1025 and then ID 1100, then clear ID 1100, the 128-byte chunk will remain
> > allocated until ID 1025 is cleared.  This probably doesn't matter to you.
> 
> Sound great, thanks for explaining this. The big problem I see is
> that IDA/IDR add primitives allocate memory, while they will be used
> in the places, where they mustn't fail. There is list_lru_add(), and
> it's called unconditionally in current kernel code. The patchset makes
> the bitmap be populated in this function. So, we can't use IDR there.

Maybe we can use GFP_NOFAIL here.  They're small allocations, so we're
only asking for single-page allocations to not fail, which shouldn't
put too much strain on the VM.
