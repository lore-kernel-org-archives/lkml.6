Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D6FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1798C2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1798C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJJTto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:49:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38828 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJJTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:49:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so5519974wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9pvEU4RRbaSBa481fLZTmPJK27vcNhQVCFX3T6sXFc=;
        b=hk01WJn1d9aQnFFfKhX0RomOAPm5Ayb0hDEvha1MUCWqmrhdSoiIOGgGKXqzCoMQrP
         jFbhX4lBvyTSwHI36VkcFNNxDSKm344UPQIQDibUb3v6E55jxTtns2FQzYcx1CMckQ0b
         4AbqS/pbiK87+DGnCoNQHKhbXO7X+9cyvXUh6ccvJYTkcNRUWOQduZNC9aEst8XMV2NT
         sIkpCPUVwbHrddp79ZHMKMZOzKuwEy0n3ZwfvsNvazAXMjl7ibykIs+r45JFFU2CS73r
         doFPeUyLiVyO6KWiTC9YM94zJGn1j7s/c2Q+35ny7135p1/tLnlystZ83DITR554Sdb0
         CDCQ==
X-Gm-Message-State: ABuFfoj1q0D+Jy9IFsjyD/NcL7ZEfI64HtgRivOJxQEkesQnem/hNM+q
        /HhbTo3kleYcWKHUkpiwX89oPQ==
X-Google-Smtp-Source: ACcGV63u4ULhAVfiJXbjAWTGvelNMIdXj4a9yqHtkMe9a57RKjO+qs+4wtinaFlfdHh3GD8RXjQwFQ==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr706948wma.96.1539174466367;
        Wed, 10 Oct 2018 05:27:46 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id b71-v6sm20926361wma.13.2018.10.10.05.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:27:45 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:27:42 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010122742.GM9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010123417.26c682ef@luca64>
 <20181010105710.GP5728@hirez.programming.kicks-ass.net>
 <20181010131629.6623ddb4@luca64>
 <20181010112300.GQ5728@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010112300.GQ5728@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 13:23, Peter Zijlstra wrote:
> On Wed, Oct 10, 2018 at 01:16:29PM +0200, luca abeni wrote:
> > On Wed, 10 Oct 2018 12:57:10 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> > > > So, I would propose to make the proxy() function of patch more
> > > > generic, and not strictly bound to mutexes. Maybe a task structure
> > > > can contain a list of tasks for which the task can act as a proxy,
> > > > and we can have a function like "I want to act as a proxy for task
> > > > T" to be invoked when a task blocks?  
> > > 
> > > Certainly possible, but that's something I'd prefer to look at after
> > > it all 'works'.
> > 
> > Of course :)
> > I was mentioning this idea because maybe it can have some impact on the
> > design.
> > 
> > BTW, here is another "interesting" issue I had in the past with changes
> > like this one: how do we check if the patchset works as expected?
> > 
> > "No crashes" is surely a requirement, but I think we also need some
> > kind of testcase that fails if the inheritance mechanism is not working
> > properly, and is successful if the inheritance works.
> > 
> > Maybe we can develop some testcase based on rt-app (if noone has such a
> > testcase already)
> 
> Indeed; IIRC there is a test suite that mostly covers the FIFO-PI stuff,
> that should obviously still pass. Steve, do you know where that lives?
> 
> For the extended DL stuff, we'd need new tests.

This one, right?

https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/pi_tests/pi_stress.c?h=stable/v1.0

It looks like it supports DEADLINE as well.. although I'll have to check
again what it does for the DEADLINE case.
