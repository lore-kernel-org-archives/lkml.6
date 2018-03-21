Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELvIjQrD3C3huyIOprHmMubbSpK//cZjDm1qwwqpOfAcMGlnI66oxKttpMNJXkYakMXIzIKl
ARC-Seal: i=1; a=rsa-sha256; t=1521646016; cv=none;
        d=google.com; s=arc-20160816;
        b=ijjOYciFXAZusCPMwVNj/m8txjEijopF5J5fblLj+NdHBdh7XSNovz3mBVRElLm4jD
         vW3fNjtTmAuXoAdmgCprqdw5ou2QPC5GTaEecmq3RT1373K0xKMBhAF9u/7X5mUBs1uR
         JItcNbf/eAbGQgKVFyOO8eWhvr+qf6bCHRlw2Z+fFOVrq2WC9k7l0I8HDOWVSHppOG5F
         rUer3E1PhkhCCeiNmViyV9RHy04UF+nbhnusDA8FNqDI93BIi2are4vOz7OnJJ+f6WzN
         PqTrYJlTbsHDlTvuyP9iKucyU7kyMIbsivDkh/UwOrND0CPMdEDF2f6zTBxR4UmHwFYy
         dZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ppRD6rtH0CmZBt6xHwZhH593wUeDu2hs5MjRXyFfOvg=;
        b=uFwEfFrioVDyO7FwGUAW//RbrLqNw40yiICdsuGZUrsxENRLswUqIdmFDvSTZevGcW
         m3Y0zJRhstR7cg0Kr/cVx+5KZZ4hIHvIEDQ+kmkNvoPZ6pWLYiUrhiLZIfxGJJLc+N+S
         oW/2JcJ4P+jPIcUO546F7PB9+uvTUro568D7SnULujV/cj95E03eHy9NVP8umHfrM448
         VOeqRc0UUaUcnu7uwvSw+2Nm4MoWj8nkeah39DipGRC2GHuYEkD2e8BsTSonhPLZmUj4
         hgprzPywT4LZ+OnpC3al6Z0DdkUOj4UiTxPhtsyXH/ZzLUKfAeF2WlJAcndP0DzBFBRf
         sryA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lVsmUsik;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lVsmUsik;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 21 Mar 2018 08:26:47 -0700
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
Message-ID: <20180321152647.GB4780@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180321145625.GA4780@bombadil.infradead.org>
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595561493892151513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 06:12:17PM +0300, Kirill Tkhai wrote:
> On 21.03.2018 17:56, Matthew Wilcox wrote:
> > Why use your own bitmap here?  Why not use an IDA which can grow and
> > shrink automatically without you needing to play fun games with RCU?
> 
> Bitmap allows to use unlocked set_bit()/clear_bit() to maintain the map
> of not empty shrinkers.
> 
> So, the reason to use IDR here is to save bitmap memory? Does this mean
> IDA works fast with sparse identifiers? It seems they require per-memcg
> lock to call IDR primitives. I just don't have information about this.
> 
> If so, which IDA primitive can be used to set particular id in bitmap?
> There is idr_alloc_cyclic(idr, NULL, id, id+1, GFP_KERNEL) only I see
> to do that.

You're confusing IDR and IDA in your email, which is unfortunate.

You can set a bit in an IDA by calling ida_simple_get(ida, n, n, GFP_FOO);
You clear it by calling ida_simple_remove(ida, n);

The identifiers aren't going to be all that sparse; after all you're
allocating them from a global IDA.  Up to 62 identifiers will allocate
no memory; 63-1024 identifiers will allocate a single 128 byte chunk.
Between 1025 and 65536 identifiers, you'll allocate a 576-byte chunk
and then 128-byte chunks for each block of 1024 identifiers (*).  One of
the big wins with the IDA is that it will shrink again after being used.
I didn't read all the way through your patchset to see if you bother to
shrink your bitmap after it's no longer used, but most resizing bitmaps
we have in the kernel don't bother with that part.

(*) Actually it's more complex than that... between 1025 and 1086,
you'll have a 576 byte chunk, a 128-byte chunk and then use 62 bits of
the next pointer before allocating a 128 byte chunk when reaching ID
1087.  Similar things happen for the 62 bits after 2048, 3076 and so on.
The individual chunks aren't shrunk until they're empty so if you set ID
1025 and then ID 1100, then clear ID 1100, the 128-byte chunk will remain
allocated until ID 1025 is cleared.  This probably doesn't matter to you.
