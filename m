Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57489C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37D72075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AQdi8gBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeICOJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:09:54 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:32858 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeICOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:09:54 -0400
Received: by mail-it0-f51.google.com with SMTP id j198-v6so10862994ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=FkaiaaIdNyJ0HAusN7Jo5A3b46lStii3gpF7cbK38gg=;
        b=AQdi8gBGROAVxAAstAWZ1Q+7p/NTY9SHU2xEokgsKh2Y9G71pcyfGDdksFFTcE5Pwv
         Be80sm6n6eUI2emwUrAvbV3D5GVxKKUnfAHCd2MjUeJptwD7JuWg+jIjWm1YY/q7X0mj
         FMvyXlRHAb+GAqoeYuVPmR1NYjzkj3SGw84Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=FkaiaaIdNyJ0HAusN7Jo5A3b46lStii3gpF7cbK38gg=;
        b=EmkycyzivqwJ+R4p78Qso5T8ow3laVu2+GpX3EXh8fOhspJer3xVqOzHKFoYQvC/V0
         zO6Qgu7KGslf88nIxdUtAb9YDjn6ZFuiAm9fYphTeo+O//i1MjJP7nlLe8nwOFM7wZjC
         ewMdrGiYtKMpLbr8QjjyOWHlzo+FaeSUxWp0irQ9apIvfJYiRHf/WgfT5UZ+LpcH6BHd
         xaxqYD7H3rwMqIPhKGPD3VHNecOz8vQ51IWHWp1HDPtj5kF1UduFuBidGxDKGDRenls6
         4w3hyFloiKdQd8WFSEFh4a2Mk6RPVu99DOlJ7eZgpfQSkgouwZWV0HcQbaayzwNX65Lc
         UJAA==
X-Gm-Message-State: APzg51CmRbh0NFGm/jEfr419BeIWIPiL3d7qkGetNqNsrOsSWokZl79+
        IUIPBQZyAco46C8pHmsVOQg4vXCBEkRvfvd6P553cQ==
X-Google-Smtp-Source: ANB0VdYdHgcTuPHB5QL4IWQFrxLW0P2s9G5iK52nGslU67xRntQboj0b4cIrF1ievwmrsvmYtu4kxU/K0IlKs9Ygnxg=
X-Received: by 2002:a24:45a4:: with SMTP id c36-v6mr4205708itd.145.1535968230988;
 Mon, 03 Sep 2018 02:50:30 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <20180903021332.GA5481@ming.t460p>
 <6e187fdf263c80e95cf627f6b363cf8d@mail.gmail.com> <20180903092048.GA14444@ming.t460p>
In-Reply-To: <20180903092048.GA14444@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBGBaHbgI3aj7TASMtyl0BdHjAtwKh7HY7oinjDDA=
Date:   Mon, 3 Sep 2018 15:20:29 +0530
Message-ID: <db9815f15bbbf4c3ca31bb340f3ce6e9@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On 72 logical cpu case, we will allocate 88 (72 + 16) reply queues
(msix
> > index). Only first 16 reply queue will be configured in interrupt
> > coalescing mode (This is special h/w feature.) and remaining 72 reply
are
> > without any interrupt coalescing.  72 reply queue are 1:1 cpu-msix map
and
> > 16 reply queue are mapped to local numa node.
> >
> > As explained above, per scsi device outstanding is a key factors to
route
> > io to queues with interrupt coalescing vs regular queue (without
interrupt
> > coalescing.)
> > Example -
> > If there are sync IO request per scsi device (one IO at a time),
driver
> > will keep posting those IO to the queues without any interrupt
coalescing.
> > If there are more than 8 outstanding io per scsi device, driver will
post
> > those io to reply queues with interrupt coalescing. This particular
group
>
> If the more than 8 outstanding io are from different CPU or different
NUMA
> node,
> which replay queue will be chosen in the io submission path?

We tried this combination as well. If IO is submitted from different NUMA
node, we anyways have penalty of cache invalidate issue.  We trust
rq_affinity = 2 settings to have actual io completion to go back to origin
cpu.   This approach (of io acceleration queue) is as good as using
irqbalancer policy "ignore", where we have all reply queue mapped to local
numa node.


>
> Under this situation, any one of 16 reply queues may not work as
> expected, I guess.

I tried this and it was same performance with or without this new feature
we are discussing.

>
> > of io will not have latency impact because coalescing depth are key
> > factors to flush the ios. There can be some corner cases of workload
which
> > can theoretically possible to have latency impact, but having more
scsi
> > devices doing active io submission will close that loop and we are not
> > suspecting those issue need any special treatment. In fact, this
solution
> > is to provide reasonable latency + higher iops for most of the cases
and
> > if there are some deployment which need tuning..it is still possible
to
> > disable this feature.  We really want to deal with those scenario on
case
> > by case bases (through firmware settings).
> >
> >
> > >
> > > > I posted RFC at
> > > > https://www.spinics.net/lists/linux-scsi/msg122874.html
> > > >
> > > > We have done extensive study and concluded to use interrupt
coalescing
> > is
> > > > better if h/w can manage two different modes (coalescing on/off).
> > >
> > > Could you explain a bit why coalescing is better?
> >
> > Actually we are doing hybrid coalescing. You are correct, we have no
> > single answer here, but there are pros and cons.
> > For such hybrid coalescing we need h/w support.
> >
> > >
> > > In theory, interrupt coalescing is just to move the implementation
into
> > > hardware. And the IO submitted from the same coalescing group is
usually
> > > irrelevant. The same problem you found in polling should have been
in
> > > coalescing too.
> >
> > Coalescing either in software or hardware is best attempt mechanism
and
> > there is no steady snapshot of submission and completion in both the
case.
> >
> > One of the problem with coalescing/polling in OS driver is - Irq-poll
> > works in interrupt context and waiting in polling consume more CPU
> because
> > driver should do some predictive loop. At the same time driver should
quit
>
> One similar way is to use the outstanding IO on this device to predicate
> the poll time.

We attempted this model as well. If outstanding is always available
(constant workload), driver will never quit. Most of the time interrupt
will be disabled and thread will be in polling work. Ideally, driver
should quit after some defined time. Right ? That is why *budget* of
irq-poll is for. If outstanding goes up and down (burst workload), we will
be doing frequent irq enable/disable and that will vary  the results.

Irq-poll is best option to do polling in OS (mainly because of budget and
interrupt context mechanism), but predicting poll helps for constant
workload and also at the same time it hogs host CPU because most of the
time driver keep polling without any work in interrupt context.
If we use h/w interrupt coalescing, we are not wasting host CPU since h/w
can manage coalescing without host consuming host cpu.

>
> > after some completion to give fairness to other devices.  Threaded
> > interrupt can resolve the cpu hogging issue, but we are moving our key
> > interrupt processing to threaded context so fairness will be
compromised.
> > In case of threaded interrupt polling we may be impacted if interrupt
of
> > other devices request the same cpu where threaded isr is running.  If
> > polling logic in driver does not work well on different systems, we
are
> > going to see extra penalty of doing disable/enable interrupt call.
This
> > particular problem is not a concern if h/w does interrupt coalescing.
>
> Thanks,
> Ming
