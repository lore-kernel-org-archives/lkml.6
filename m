Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6E2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RD67On7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC6E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbeGLMKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:10:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeGLMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:10:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id c4-v6so8761861wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DrjMqM9DfRkdPO3b8AbZcqKJWVhEEiaN5vW1Y5jijMs=;
        b=RD67On7RKWDz3Pm3K08Leq+4W0QPR4923OI+J0xeWXKv22NmY8CaIzrcSi91LPT7J7
         ryKP/NtE2xFgkOEqgSAEmigsGiDGI6wH2K4dqEpuWf96LaA60r/oJLEFwn5M+qMtFuPs
         aEEdPZaFh6dXHwOOxoEqCIEyPZ80ZVXb06Jjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrjMqM9DfRkdPO3b8AbZcqKJWVhEEiaN5vW1Y5jijMs=;
        b=Q0peGgDXpIhHVna5izIZ+0XbmurBLVRi699zBkALc5N+u9KA+jzuIrApkiZti/a9Po
         smhKOHQAnc8eK9+RyMFZC1UE7NdHVmXl6XyE3PmE3ra+ifBsi+O7+oCEx1yDS3WWaZED
         +lzZ2iZ7DkJbfF6f+D/270DU7p8kBrYOL7fGKugvYTUdXD4LaJYGLtoY1yiUqMczjJCY
         xA2q9lQYzCmEVd9Ex51R/eg9omuRe4Zli6nn6VuoAk7xiZkwklOsPYIcWGSeFej/Gmpg
         Oc1P17zO5AGE5XLwu2ePR0G0uEpSSX+9Ceep06EsH1YOUXFxRb3OOJ4AC7F0j0SctiE4
         Atag==
X-Gm-Message-State: AOUpUlEWujuIj+5FYpQfkquHBNFvihz23aB7ym/0RDa/mNCPXMCoIQD6
        4OGZYAdOcR/+Sh7HofckpRrncw==
X-Google-Smtp-Source: AAOMgpe25VqiDOruM6/v9RrYpsN0wr4vvijsO5FmLJbPuCHYiWKxyv+1FOAjTHRf60JrDELNOg+/FQ==
X-Received: by 2002:adf:ae51:: with SMTP id u17-v6mr1465690wrd.201.1531396867368;
        Thu, 12 Jul 2018 05:01:07 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id k13-v6sm17022485wrr.14.2018.07.12.05.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 05:01:06 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:01:00 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712120100.GA7404@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180712074040.GA4920@worktop.programming.kicks-ass.net>
 <20180712115249.GA6201@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712115249.GA6201@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:52:49PM +0200, Andrea Parri wrote:
> On Thu, Jul 12, 2018 at 09:40:40AM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 11, 2018 at 02:34:21PM +0200, Andrea Parri wrote:
> > > Simplicity is the eye of the beholder.  From my POV (LKMM maintainer), the
> > > simplest solution would be to get rid of rfi-rel-acq and unlock-rf-lock-po
> > > (or its analogous in v3) all together:
> > 
> > <snip>
> > 
> > > Among other things, this would immediately:
> > > 
> > >   1) Enable RISC-V to use their .aq/.rl annotations _without_ having to
> > >      "worry" about tso or release/acquire fences; IOW, this will permit
> > >      a partial revert of:
> > > 
> > >        0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with fences")
> > >        5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > 
> > But I feel this goes in the wrong direction. This weakens the effective
> > memory model, where I feel we should strengthen it.
> > 
> > Currently PowerPC is the weakest here, and the above RISC-V changes
> > (reverts) would make RISC-V weaker still.
> > 
> > Any any effective weakening makes me very uncomfortable -- who knows
> > what will come apart this time. This memory ordering stuff causes
> > horrible subtle bugs at best.
> 
> Indeed, what I was suggesting above is a weaking of the current model
> (and I agree: I wouldn't say that bugs in this context are nice  ;-).
> 
> These changes would affect a specific area: (IMO,) the examples we've
> been considering here aren't for the faint-hearted  ;-) and as Daniel
> already suggested, everything would again be "nice and neat", if this
> was all about locking/if every thread used lock-synchronization.
> 
> 
> > 
> > >   2) Resolve the above mentioned controversy (the inconsistency between
> > >      - locking operations and atomic RMWs on one side, and their actual
> > >      implementation in generic code on the other), thus enabling the use
> > >      of LKMM _and_ its tools for the analysis/reviewing of the latter.
> > 
> > This is a good point; so lets see if there is something we can do to
> > strengthen the model so it all works again.
> > 
> > And I think if we raise atomic*_acquire() to require TSO (but ideally
> > raise it to RCsc) we're there.
> > 
> > The TSO archs have RCpc load-acquire and store-release, but fully
> > ordered atomics. Most of the other archs have smp_mb() everything, with
> > the exception of PPC, ARM64 and now RISC-V.
> > 
> > PPC has the RCpc TSO fence LWSYNC, ARM64 has the RCsc
> > load-acquire/store-release. And RISC-V has a gazillion of options IIRC.
> > 
> > 
> > So ideally atomic*_acquire() + smp_store_release() will be RCsc, and is
> > with the notable exception of PPC, and ideally RISC-V would be RCsc
> > here. But at the very least it should not be weaker than PPC.
> > 
> > By increasing atomic*_acquire() to TSO we also immediately get the
> > proposed:
> > 
> >   P0()
> >   {
> > 	  WRITE_ONCE(X, 1);
> > 	  spin_unlock(&s);
> > 	  spin_lock(&s);
> > 	  WRITE_ONCE(Y, 1);
> >   }
> > 
> >   P1()
> >   {
> > 	  r1 = READ_ONCE(Y);
> > 	  smp_rmb();
> > 	  r2 = READ_ONCE(X);
> >   }
> > 
> > behaviour under discussion; because the spin_lock() will imply the TSO
> > ordering.
> 
> You mean: "when paired with a po-earlier release to the same memory
> location", right?  I am afraid that neither arm64 nor riscv current
> implementations would ensure "(r1 == 1 && r2 == 0) forbidden" if we
> removed the po-earlier spin_unlock()...
> 
> AFAICT, the current implementation would work with that release: as
> you remarked above, arm64 release->acquire is SC; riscv has an rw,w
> fence in its spin_unlock() (hence an w,w fence between the stores),
> or it could have a .tso fence ...
> 
> But again, these are stuble patterns, and my guess is that several/
> most kernel developers really won't care about such guarantees (and
> if some will do, they'll have the tools to figure out what they can
> actually rely on ...)
> 
> OTOH (as I pointed out earlier) the strengthening we're configuring
> will prevent some arch. (riscv being just the example of today!) to
> go "full RCsc", and this will inevitably "complicate" both the LKMM

"full RCpc"

  Andrea


> and the reviewing process of related changes (atomics, locking, ...;
> c.f., this debate), apparently, just because you  ;-) want to "care"
> about these guarantees.
> 
> Not yet convinced ...  :/
> 
>   Andrea
> 
> 
> > 
> > And note that this retains regular RCpc ACQUIRE for smp_load_acquire()
> > and associated primitives -- as they have had since their introduction
> > not too long ago.
