Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC3FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860A62089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860A62089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeJCR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:57:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36692 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:57:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id c18-v6so5127223otm.3;
        Wed, 03 Oct 2018 04:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpL1FFNkcACSH8I9nnTUKUkv2NoTOe9U5x4/S51RwfE=;
        b=B29sMaxeIbnbEP81m5DbsylcDaEAtYpT0tbNfpmcL6G/EPVXFO4MhGUXwYCvy9+lGZ
         sGDopzme5k3QdIrKzvM926xbVEJwKIU6RbSqfJNZCmHOvoNJSZcYiZYhQhp/APeThFPO
         QAspxnrb0xokYRQmC93Q7S2bdlBPVNJdJCFILFvmmNpReHct1qKkpcB1W+m7IiYx3th6
         5qx7aO73KkNawX5JSQ4Xu24D+RJiT9/UZwWd8MJjlNAtkhFDsETv+zhQugpKqRUtYth9
         Ppqj8zlTulIN9kR6DBLT9CNZOyK8ptDkyN1hncbiimHuwRh8Cb8jSOACmmveg8wo0T6J
         lOeA==
X-Gm-Message-State: ABuFfoikz1FlcPmIE3jtyfEoj921oYlIhshFSIII2pILRHnzsGK5MJp5
        CnhQ6LVnLHlHALw9n4vdNrdYPMyQtNnRWoHch1M=
X-Google-Smtp-Source: ACcGV62fEjI3s5MDh86AZVzgm6dvaylNq2YiIF+kL0HC2NENkpgY1GAnSYo5KYjCm+6IvsQYUi51FB0hXSfKc/uf+vY=
X-Received: by 2002:a9d:34f:: with SMTP id 73mr539211otv.343.1538564957410;
 Wed, 03 Oct 2018 04:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
 <4200780.ZjVhNjpZ67@aspire.rjw.lan> <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
In-Reply-To: <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Oct 2018 13:09:05 +0200
Message-ID: <CAJZ5v0iRMvhZ1rW40syPRJfYBZ4=zE2-f4HcKaRQsvg18pnTcw@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 12:25 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 03/10/2018 10:58, Rafael J. Wysocki wrote:
> > On Tuesday, September 25, 2018 11:38:44 AM CEST Daniel Lezcano wrote:
> >> The function get_loadavg() returns almost always zero. To be more
> >> precise, statistically speaking for a total of 1023379 times passing
> >> to the function, the load is equal to zero 1020728 times, greater than
> >> 100, 610 times, the remaining is between 0 and 5.
> >>
> >> I'm putting in question this metric. Is it worth to keep it?
> >
> > The honest answer is that I'm not sure.
> >
> > Using the CPU load for driving idle state selection is questionable in general
> > (there need not be any connection between the two in principle) and this
> > particular function is questionable either.  If it really makes no difference
> > in addition to that, then yes it would be good to get rid of it.
> >
> > That said it looks like that may be quite workload-dependent, so maybe there
> > are workloads where it does make a difference?  Like networking or similar?
>
> Perhaps initially the load was not the same:
>
>
> commit 69d25870f20c4b2563304f2b79c5300dd60a067e
> Author: Arjan van de Ven <arjan@infradead.org>
> Date:   Mon Sep 21 17:04:08 2009 -0700
>
>     cpuidle: fix the menu governor to boost IO performance
>
>
> The function get_loadavg() was:
>
> static int get_loadavg(void)
> {
>        unsigned long this = this_cpu_load();
>
>        return LOAD_INT(this) * 10 + LOAD_FRAC(this) / 10;
> }
>
> With:
>
> unsigned long this_cpu_load(void)
> {
>         struct rq *this = this_rq();
>         return this->cpu_load[0];
> }
>
>
> Now we pass the load we got from get_iowait_load() which is:
>
> void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> {
>         struct rq *rq = this_rq();
>         *nr_waiters = atomic_read(&rq->nr_iowait);
>         *load = rq->load.weight;
> }

This would mean that commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
runqueues less) changed the behavior more than expected, though (CC
Mel).

In any case that change was made in 2014 which is after Android
stopped using get_loadavg().

> Colin Cross did some measurements a few years ago and concluded it is
> zero most of the time, otherwise the number is so high it has no
> meaning. The get_loadavg() call is removed from Android since 2011 [1].

This is a good indication that it doesn't really matter (any more perhaps).

> I can hack my server (bi Xeon - 6 cores), add statistics regarding this
> metric and let it run during several days, sure a lot of different
> workloads will happen on it (compilation, network, throughput computing,
> ...) in a real use case manner. That is what I did with an ARM64
> evaluation board.
>
> However I won't be able to do that right now and that will take a bit of
> time. If you think it is really useful, I can plan to do that in the
> next weeks.

Well, we may as well just make this change to follow Android and let
it go through all of the CI we have for one cycle.

> [1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17

If you send a non-RFC patch to drop get_loadavg() (but you can drop it
altogether then, there are no other callers of it AFAICS), I'll queue
it up after the 4.20 (or whatever it turns out to be in the end) merge
window so all of the CIs out there have a chance to report issues (if
any).

Thanks,
Rafael
