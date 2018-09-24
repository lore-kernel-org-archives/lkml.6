Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EA92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GzqnhH0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EA92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeIXQ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:57:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41588 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:57:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so15875064edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2whNj4RcdK8Wlpanm09DeQRJiaISFPiZtn8l2emuidg=;
        b=GzqnhH0bLxokhVrH116Y7n8jl2OltzG3f3YhurwUlIMl5c5TisJ7h4rd+jUuaPtwj0
         8m1O8yjBFH3cKyagMiAjPLWCN88QyNFAYjqEnFBWHP+fh2eIhvUKjM/FWn4ABdwDKZgJ
         NgzebZZqPBuj48oGR/QqLn1//U55lfkeSn+aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2whNj4RcdK8Wlpanm09DeQRJiaISFPiZtn8l2emuidg=;
        b=s05LGBGK+KbUtJHzIdKACetipR19H1ssao2g6BroHiNz/pTnNAOn5cpYc6l4HHgxW/
         HXG3AvUJU5ifO9F8f19stfpwWXfhFqox2OISDhLaWbrZZz0BnypZa9cN+RnSdNeH6g/l
         0NZsO029tm1zk/9TZZpiMdNZh3i5Kd+3PoGi8wA842TVaZrnofui12imog70lvSyPZyn
         Ae9nsxqQfNW+9rMK6hdRJjkbMO3NhXxruhF1lzRrKTR70UQfX2l+10h/eW+RmpP4lMUS
         HghkLT6tXgaEaklw3M7okxqCkKe2XYUeCAlWIP1WZRWl8IgTqzCebN8C9rNNWnldIWek
         SHVg==
X-Gm-Message-State: ABuFfojZFvp7xJOhasG1l3e0gedTZWOeM9KXeAHkv/zskoosE94OAJ7f
        smflQjJVyIxx4hiOvKAjUoTgkGThAxfMeA==
X-Google-Smtp-Source: ANB0VdacsXKzJsGoqEjdd4B4HJ7pZJm0mfxmyI9bfF5Sb0R0q1WdljUYy8PnuiLZqHZ8lvvS14oFCg==
X-Received: by 2002:a50:bf0d:: with SMTP id f13-v6mr15769424edk.157.1537786572173;
        Mon, 24 Sep 2018 03:56:12 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1855295eds.54.2018.09.24.03.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:56:11 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:56:05 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] tools/memory-model: Model smp_mb__after_unlock_lock()
Message-ID: <20180924105605.GA8466@andrea>
References: <20180924104449.8211-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924104449.8211-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:44:49PM +0200, Andrea Parri wrote:
> From the header comment for smp_mb__after_unlock_lock():
> 
>   "Place this after a lock-acquisition primitive to guarantee that
>    an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
>    if the UNLOCK and LOCK are executed by the same CPU or if the
>    UNLOCK and LOCK operate on the same lock variable."
> 
> This formalizes the above guarantee by defining (new) mb-links according
> to the law:
> 
>   ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> 	fencerel(After-unlock-lock) ; [M])
> 
> where the component ([UL] ; co ; [LKW]) identifies "UNLOCK+LOCK pairs on
> the same lock variable" and the component ([UL] ; po ; [LKW]) identifies
> "UNLOCK+LOCK pairs executed by the same CPU".
> 
> In particular, the LKMM forbids the following two behaviors (the second
> litmus test below is based on
> 
>   Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> 
> c.f., Section "Tree RCU Grace Period Memory Ordering Building Blocks"):
> 
> C after-unlock-lock-same-cpu
> 
> (*
>  * Result: Never
>  *)
> 
> {}
> 
> P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> {
> 	int r0;
> 
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	spin_unlock(s);
> 	spin_lock(t);
> 	smp_mb__after_unlock_lock();
> 	r0 = READ_ONCE(*y);
> 	spin_unlock(t);
> }
> 
> P1(int *x, int *y)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*y, 1);
> 	smp_mb();
> 	r0 = READ_ONCE(*x);
> }
> 
> exists (0:r0=0 /\ 1:r0=0)
> 
> C after-unlock-lock-same-lock-variable
> 
> (*
>  * Result: Never
>  *)
> 
> {}
> 
> P0(spinlock_t *s, int *x, int *y)
> {
> 	int r0;
> 
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	r0 = READ_ONCE(*y);
> 	spin_unlock(s);
> }
> 
> P1(spinlock_t *s, int *y, int *z)
> {
> 	int r0;
> 
> 	spin_lock(s);
> 	smp_mb__after_unlock_lock();
> 	WRITE_ONCE(*y, 1);
> 	r0 = READ_ONCE(*z);
> 	spin_unlock(s);
> }
> 
> P2(int *z, int *x)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*z, 1);
> 	smp_mb();
> 	r0 = READ_ONCE(*x);
> }
> 
> exists (0:r0=0 /\ 1:r0=0 /\ 2:r0=0)
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
> NOTES.
> 
> - A number of equivalent formalizations seems available; for example,
>   we could replace "co" in the law above with "coe" (by "coherence")
>   and we could limit "coe" to "singlestep(coe)" (by the "prop" term).
>   These changes did not show significant performance improvement and
>   they looked slightly less readable to me, hence...
> 
> - The mb-links order memory accesses po-_before_ the lock-release to
>   memory accesses po-_after_ the lock-acquire; in part., this forma-
>   lization does _not_ forbid the following behavior (after A. Stern):
> 
> C po-in-after-unlock-lock
> 
> {}
> 
> P0(spinlock_t *s, spinlock_t *t, int *y)
> {
> 	int r0;
> 
> 	spin_lock(s);
> 	spin_unlock(s);
> 
> 	spin_lock(t);
> 	smp_mb__after_unlock_lock();
> 	r0 = READ_ONCE(*y);
> 	spin_unlock(t);
> }
> 
> P1(spinlock_t *s, int *y)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*y, 1);
> 	smp_mb();
> 	r0 = spin_is_locked(s);
> }
> 
> exists (0:r0=0 /\ 1:r0=0)

This should have been "exists (0:r0=0 /\ 1:r0=1)".

  Andrea


> 
> - I'm not aware of currently supported architectures (implementations)
>   of smp_mb__after_unlock_lock() and spin_{lock,unlock}() which would
>   violate the guarantee formalized in this patch.  It is worth noting
>   that the same conclusion does _not_ extend to other locking primiti-
>   ves (e.g., write_{lock,unlock}()), AFAICT: c.f., e.g., riscv.  This
>   "works" considered the callsites for the barrier, but yeah...
> ---
>  tools/memory-model/linux-kernel.bell | 3 ++-
>  tools/memory-model/linux-kernel.cat  | 4 +++-
>  tools/memory-model/linux-kernel.def  | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index b84fb2f67109e..796513362c052 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -29,7 +29,8 @@ enum Barriers = 'wmb (*smp_wmb*) ||
>  		'sync-rcu (*synchronize_rcu*) ||
>  		'before-atomic (*smp_mb__before_atomic*) ||
>  		'after-atomic (*smp_mb__after_atomic*) ||
> -		'after-spinlock (*smp_mb__after_spinlock*)
> +		'after-spinlock (*smp_mb__after_spinlock*) ||
> +		'after-unlock-lock (*smp_mb__after_unlock_lock*)
>  instructions F[Barriers]
>  
>  (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 882fc33274ac3..8f23c74a96fdc 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -30,7 +30,9 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> +	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> +		fencerel(After-unlock-lock) ; [M])
>  let gp = po ; [Sync-rcu] ; po?
>  
>  let strong-fence = mb | gp
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 6fa3eb28d40b5..b27911cc087d4 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -23,6 +23,7 @@ smp_wmb() { __fence{wmb}; }
>  smp_mb__before_atomic() { __fence{before-atomic}; }
>  smp_mb__after_atomic() { __fence{after-atomic}; }
>  smp_mb__after_spinlock() { __fence{after-spinlock}; }
> +smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
>  
>  // Exchange
>  xchg(X,V)  __xchg{mb}(X,V)
> -- 
> 2.17.1
> 
