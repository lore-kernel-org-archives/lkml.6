Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C97C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA55D20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oug2GetC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfAUPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:34:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42091 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730440AbfAUPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:34:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so16876361edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KlyrB5n5ya2HRdFoSG/ZicyJjS++CBBS44KKM+5uUG4=;
        b=oug2GetC1HER1Wuh3Dc28fvOQtTvAbMGpPHPCtqqe9lokfFVxRPh68RXS9qfvvj8ek
         kyhPUajIgaEAadEZBxOOOGPyTET4TIlzGxXmGOMXAQgPVZ9qO3SomuwcfJY9d0a5zGHb
         ZbjXMBcAmRIQSijOOA19ElKDEkgMpJ/m2v62g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KlyrB5n5ya2HRdFoSG/ZicyJjS++CBBS44KKM+5uUG4=;
        b=eajQfNDPCjkXJLFR/ThpzQeTSvD/1M5Mbhl1DreogSE9/DJRmhpDDvy+6F5ZhYV4j1
         tbfpjClVTRilfogqVEy7ZOLlLTEkzNVZjJ2IrrkTuIEbgaCURZRLH1CJ2HiBDGYANhHe
         Ido5ubm4IVm19ZNkXeSlid3cu8RfA11nauhlMSMUGyzciW5hJH5aEf8FR8Cb1DkicyE9
         s/brH1SgJ3wOYeTuZLcAbiPuFlxhdV5lY7vQCgVr+hX+WZ1JmRA/RC57TWSdewSDZTPl
         IWAb4v3dT0wMOIgNB7ka+BsghN7Ggq07dayfdmFH7oVehwyMS0137Ls7HQvIWUyVKQmk
         /VOA==
X-Gm-Message-State: AJcUukdbDloU4aFqrfYOMyr0k1+BMYGSfnV5jQw3ByJsTMMNCOP2IX+q
        KJvrYvhQLJ37zmNdIQ2Y5hvm/d6yA0cDPg==
X-Google-Smtp-Source: ALg8bN5v94yCkk5D/zG6BiZnkiNjGlpPkfemtMIIITebGnm1HUUjYIBtb1NKxWEwEAT2JS0IZ5cMAQ==
X-Received: by 2002:a50:afa3:: with SMTP id h32mr27223730edd.150.1548084885349;
        Mon, 21 Jan 2019 07:34:45 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a27sm9661964eda.65.2019.01.21.07.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:34:44 -0800 (PST)
Date:   Mon, 21 Jan 2019 16:34:39 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] sched: Use READ_ONCE()/WRITE_ONCE() in
 task_cpu()/__set_task_cpu()
Message-ID: <20190121153439.GA12623@andrea>
References: <20190116184218.13757-1-andrea.parri@amarulasolutions.com>
 <20190121104707.GA5883@andrea>
 <20190121122526.GA13777@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121122526.GA13777@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:25:26PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 21, 2019 at 11:51:21AM +0100, Andrea Parri wrote:
> > On Wed, Jan 16, 2019 at 07:42:18PM +0100, Andrea Parri wrote:
> > > The smp_wmb() in move_queued_task() (c.f., __set_task_cpu()) pairs with
> > > the composition of the dependency and the ACQUIRE in task_rq_lock():
> > > 
> > > 	move_queued_task()		task_rq_lock()
> > > 
> > > 	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
> > > 	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
> > > 	[S] ->cpu = new_cpu		[L] ->on_rq
> > > 
> > > where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
> > > address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
> > > "[L] ->on_rq" by the ACQUIRE itself.
> > > 
> > > Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honour
> > > this address dependency between loads; also, mark the store to ->cpu in
> > > __set_task_cpu() by using WRITE_ONCE() in order to tell the compiler to
> > > not mess/tear this (synchronizing) memory access.
> > 
> > In the light of the recent discussion about the integration of plain
> > accesses in the LKMM (c.f., e.g., [1] and discussion thereof), I was
> > considering even further changes to this in order to "reinforce" the
> > above smp_wmb().  Here's two approaches (one of):
> > 
> >  1) replace this smp_wmb()+WRITE_ONCE() with an smp_store_release();
> > 
> >  2) or keep this smp_wmb()+WRITE_ONCE(), but use {WRITE,READ}_ONCE()
> >     also for the accesses to ->on_rq.
> 
> That should be the least painful I think. Note that we never store a
> value larger than a single byte in that word, so tearing shouldn't be a
> problem, but yes, that makes it all neat and tidy.

Thank you for the suggestion; I'll send the revisited patch shortly.

  Andrea
