Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3832AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346462084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZyT8Wu9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346462084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbeGKM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:59:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51328 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:59:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so2358851wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gTfgHFR8lUEaHgDCiT6JkBRtuNeOtjU7c2LhorFNddo=;
        b=ZyT8Wu9WiRz2L3tpt/MsJhQVRSja9Y6iopiwReWp52FyRRMa9TomJEc5zRPKZFrXDf
         udAR1I1ZJv4OEm6N/fwzyQh2l4aNaoYKUgFe6aF2wjFuyFZWpQDcpcF4+VSwuzi/rJCn
         MJp4djLc2qUPsTymuRdsN3y5GKXQQWQTdIYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTfgHFR8lUEaHgDCiT6JkBRtuNeOtjU7c2LhorFNddo=;
        b=JWxu49NcdAVQlx5z1PBzUqo0SWQyWrC/Y5iGBu26ozoYuda78/iKITVOl8mrAbN1OV
         B0nCJ61+k2CtPodcUIMph1l2FXzalYxLVBF22s3QLLehemp2AsItriEdauOmZuOMRGlJ
         IU1g+efDNOCXq9eEV0/hXIbG7uR838WiXU37pErbTFwcx5XGyXwmsZevl4a4gwz2UXzW
         CxB9Rz+aoZSDjRiHjBN9giQjVNQIniEdqZcioaMmciBZNCvTszJ9ZXpP3jxDeSzHZ1Oy
         rvPWGUWorByjL5sRfPjeZSV6xBBAYWz4vuP5caVoc8LyQBcUfRIo3vtwwUb8D7oCohdG
         PifQ==
X-Gm-Message-State: AOUpUlECBDtZdAdp/1wQ6+SDIhAV/sUKPWQZlWRnaPCScLpfIsFNeuxV
        4jqJyVbSE030IiKmoI7XkwkCpg==
X-Google-Smtp-Source: AAOMgpe3GfPpRrvMwa1SsgBt1P7YLCJ6Bi7/XWN838aaCHkhxzposQhuNLH4LMLSxTkaGMGEPEEl6A==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr5221761wmo.84.1531313705225;
        Wed, 11 Jul 2018 05:55:05 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 38-v6sm12132322wrm.15.2018.07.11.05.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:55:04 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:54:58 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711125458.GA10452@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711123421.GA9673@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:34:21PM +0200, Andrea Parri wrote:
> On Wed, Jul 11, 2018 at 10:43:11AM +0100, Will Deacon wrote:
> > On Tue, Jul 10, 2018 at 11:38:21AM +0200, Andrea Parri wrote:
> > > On Mon, Jul 09, 2018 at 04:01:57PM -0400, Alan Stern wrote:
> > > > More than one kernel developer has expressed the opinion that the LKMM
> > > > should enforce ordering of writes by locking.  In other words, given
> > > 
> > > I'd like to step back on this point: I still don't have a strong opinion
> > > on this, but all this debating made me curious about others' opinion ;-)
> > > I'd like to see the above argument expanded: what's the rationale behind
> > > that opinion? can we maybe add references to actual code relying on that
> > > ordering? other that I've been missing?
> > > 
> > > I'd extend these same questions to the "ordering of reads" snippet below
> > > (and discussed since so long...).
> > > 
> > > 
> > > > the following code:
> > > > 
> > > > 	WRITE_ONCE(x, 1);
> > > > 	spin_unlock(&s):
> > > > 	spin_lock(&s);
> > > > 	WRITE_ONCE(y, 1);
> > > > 
> > > > the stores to x and y should be propagated in order to all other CPUs,
> > > > even though those other CPUs might not access the lock s.  In terms of
> > > > the memory model, this means expanding the cumul-fence relation.
> > > > 
> > > > Locks should also provide read-read (and read-write) ordering in a
> > > > similar way.  Given:
> > > > 
> > > > 	READ_ONCE(x);
> > > > 	spin_unlock(&s);
> > > > 	spin_lock(&s);
> > > > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > > > 
> > > > the load of x should be executed before the load of (or store to) y.
> > > > The LKMM already provides this ordering, but it provides it even in
> > > > the case where the two accesses are separated by a release/acquire
> > > > pair of fences rather than unlock/lock.  This would prevent
> > > > architectures from using weakly ordered implementations of release and
> > > > acquire, which seems like an unnecessary restriction.  The patch
> > > > therefore removes the ordering requirement from the LKMM for that
> > > > case.
> > > 
> > > IIUC, the same argument could be used to support the removal of the new
> > > unlock-rf-lock-po (we already discussed riscv .aq/.rl, it doesn't seem
> > > hard to imagine an arm64 LDAPR-exclusive, or the adoption of ctrl+isync
> > > on powerpc).  Why are we effectively preventing their adoption?  Again,
> > > I'd like to see more details about the underlying motivations...
> > > 
> > > 
> > > > 
> > > > All the architectures supported by the Linux kernel (including RISC-V)
> > > > do provide this ordering for locks, albeit for varying reasons.
> > > > Therefore this patch changes the model in accordance with the
> > > > developers' wishes.
> > > > 
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > 
> > > > ---
> > > > 
> > > > v.2: Restrict the ordering to lock operations, not general release
> > > > and acquire fences.
> > > 
> > > This is another controversial point, and one that makes me shivering ...
> > > 
> > > I have the impression that we're dismissing the suggestion "RMW-acquire
> > > at par with LKR" with a bit of rush.  So, this patch is implying that:
> > > 
> > > 	while (cmpxchg_acquire(&s, 0, 1) != 0)
> > > 		cpu_relax();
> > > 
> > > is _not_ a valid implementation of spin_lock()! or, at least, it is not
> > > when paired with an smp_store_release(). Will was anticipating inserting
> > > arch hooks into the (generic) qspinlock code,  when we know that similar
> > > patterns are spread all over in (q)rwlocks, mutexes, rwsem, ... (please
> > > also notice that the informal documentation is currently treating these
> > > synchronization mechanisms equally as far as "ordering" is concerned...).
> > > 
> > > This distinction between locking operations and "other acquires" appears
> > > to me not only unmotivated but also extremely _fragile (difficult to use
> > > /maintain) when considering the analysis of synchronization mechanisms
> > > such as those mentioned above or their porting for new arch.
> > 
> > The main reason for this is because developers use spinlocks all of the
> > time, including in drivers. It's less common to use explicit atomics and
> > extremely rare to use explicit acquire/release operations. So let's make
> > locks as easy to use as possible, by giving them the strongest semantics
> > that we can whilst remaining a good fit for the instructions that are
> > provided by the architectures we support.
> 
> Simplicity is the eye of the beholder.  From my POV (LKMM maintainer), the
> simplest solution would be to get rid of rfi-rel-acq and unlock-rf-lock-po
> (or its analogous in v3) all together:
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 59b5cbe6b6240..bc413a6839a2d 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,6 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
>  
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,7 +59,7 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
>  let ppo = to-r | to-w | fence
> 
> Among other things, this would immediately:
> 
>   1) Enable RISC-V to use their .aq/.rl annotations _without_ having to
>      "worry" about tso or release/acquire fences; IOW, this will permit
>      a partial revert of:
> 
>        0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with fences")
>        5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> 
>   2) Resolve the above mentioned controversy (the inconsistency between
>      - locking operations and atomic RMWs on one side, and their actual
>      implementation in generic code on the other), thus enabling the use
>      of LKMM _and_ its tools for the analysis/reviewing of the latter.

  3) Liberate me from the unwritten duty of having to explain what these
     rfi-rel-acq or unlock-rf-lock-po are (and imply!) _while_ reviewing
     the next:  ;-)

         arch/$NEW_ARCH/include/asm/{spinlock,atomic}.h

     (especially given that I could not point out a single use case in
      the kernel which could illustrate and justify such requirements).

  Andrea


> 
> 
> > 
> > If you want to extend this to atomic rmws, go for it, but I don't think
> > it's nearly as important and there will still be ways to implement locks
> > with insufficient ordering guarantees if you want to.
> 
> I don't want to "implement locks with insufficient ordering guarantees"
> (w.r.t. LKMM).  ;-)
> 
>   Andrea
> 
> 
> > 
> > Will
