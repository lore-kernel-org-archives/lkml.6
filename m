Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492FE2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fWBXDapQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492FE2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbeJBU2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:28:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34693 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbeJBU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:28:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so2138891edr.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+83VfBoJsGiR1fsewm/m+OphJwiVS0xTAoKpZr8Wnl4=;
        b=fWBXDapQB5y+tmW9/z8A4XUEyH7agLn0VWKSMFomiRA1WfbtpLxDT7FJPFrBNiYhc6
         aTl73iHRpAcKWwR5cgcyTiJ55XevScP8tXp+EU/tyyR0tS6RwSUdmbpCK2fJtgGZsgno
         b4ZmsQrZP0k0yLB/Z7ye3Mdv3cLEJfLIEx7TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+83VfBoJsGiR1fsewm/m+OphJwiVS0xTAoKpZr8Wnl4=;
        b=LxJggTwc6EU+bi8PBrndGObsYGBMOgD+xi6f787g0Fpr/Siz0b3mKTKZOsnyljZcdF
         CCTv+yd05nxx2WjRIouvXs5uu7TnmY/DdAOlMVDn7YVbhRmLhZf3h6BTfcImTgEH4oVB
         8Cfa/QY0n8jt+J67jS1O3jFypWATyIoHW5MyWACvCdxtk41BtHoP7BNtNloJJ+gyEPUx
         O4srTdVcXyboThM4W7qf/WxJJfBQnS+H1aLbW7psu9jKDqTivg26LZJdjmWN4yKAHcCc
         I6bdpDTwnO2HSnHBI+FmOXR3Zx53Je78uMx+kqYWv6jn552EJ3sEVizS7wPUeiTyw49A
         qlEw==
X-Gm-Message-State: ABuFfogbtRMRbsViYTw4mPDOdF4DKU8HF8itKnmzYbJhPM5ZrS5QwEKZ
        8Mz4h4lBOzDGJmBcK8UMJjjUpA==
X-Google-Smtp-Source: ACcGV63cK0nR40FLFoXBGl5Nt6bvqJyeg2KidQxTG4qUsOww5JK6Xq1+1xNFmjCUEt/l/ubQj61GtA==
X-Received: by 2002:a17:906:5808:: with SMTP id m8-v6mr19478675ejq.20.1538487890185;
        Tue, 02 Oct 2018 06:44:50 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id y14-v6sm2732394ejq.21.2018.10.02.06.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 06:44:49 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:44:42 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181002134442.GA10754@andrea>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
 <20181002123152.GA10055@andrea>
 <20181002132208.GF16422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002132208.GF16422@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:22:09PM +0100, Will Deacon wrote:
> On Tue, Oct 02, 2018 at 02:31:52PM +0200, Andrea Parri wrote:
> > > consider this scenario with your patch:
> > > 
> > > 1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
> > >    pending.
> > > 
> > > 2. CPU1 comes in and sets pending, spins on locked
> > > 
> > > 3. CPU2 sees a pending and locked val, and is about to enter the head of
> > >    the waitqueue (i.e. it's right before xchg_tail()).
> > > 
> > > 4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
> > >    it, so pending and locked are now 0.
> > > 
> > > 5. CPU0 sets pending and reads back zeroes for the other fields
> > > 
> > > 6. CPU0 clears pending and sets locked -- it now has the lock
> > > 
> > > 7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
> > >    for locked and pending to go clear. However, it reads a stale value
> > >    from step (4) and attempts the atomic_try_cmpxchg() to take the lock.
> > > 
> > > 8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
> > >    point we're hosed, because both CPU2 and CPU0 have the lock.
> > 
> > Thanks for pointing this out.   I am wondering: can't we have a similar
> > scenario with the current code (i.e., w/o these patches): what prevents
> > the scenario reported below, following Peter's diagram, from happening?
> 
> The xchg_tail() in step (7) reads from the fetch_or_acquire() in step (5),
> so I don't think we can see a stale value in the subsequent (overlapping)
> acquire load.

I see, thanks for the clarification.

  Andrea


> 
> Will
> 
> >   CPU0		CPU1		CPU2		CPU3
> > 
> > 0)						lock
> > 						  trylock -> (0,0,1)
> > 1)lock
> >     trylock /* fail */
> > 
> > 2)		lock
> > 		  trylock /* fail */
> > 		  fetch_or_acquire -> (0,1,1)
> > 		  wait-locked
> > 
> > 3)				lock
> > 				  trylock /* fail */
> > 				  goto queue
> > 
> > 4)						unlock -> (0,1,0)
> > 		  clr_pnd_set_lck -> (0,0,1)
> > 		  unlock -> (0,0,0)
> > 
> > 5)  fetch_or_acquire -> (0,1,0)
> > 6)  clr_pnd_set_lck -> (0,0,1)
> > 7)				  xchg_tail -> (n,0,1)
> > 				  load_acquire <- (n,0,0) (from-4)
> > 8)				  cmpxchg /* fail */
> > 				  set_locked()
