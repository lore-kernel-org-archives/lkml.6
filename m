Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A216C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5210D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544530976;
	bh=FFeaETZdQBB2dSmZLr5IlKg5Jtpaxji9hPRY+RFFHXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kdDOPUtH617UoWTCzThbyh5PEyrrAHTnWvfD+DSzMGWk4VG6uDMPhgxVKQ4S2D01A
	 i1Rt4jOVFF57ZIJaY3QHAVxpoa/NUBfxIPp/74+jxjF6eplCqFMRHF42X+wE0F2nwn
	 mm1brmvdB/vFtyBg/KDqB7MtQtNtf2LmrazJ4VhE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5210D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLKMWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:22:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39029 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeLKMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:22:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so13799578otl.6;
        Tue, 11 Dec 2018 04:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4P8DK96RANt8wuy0n1vxyL3W3nAhJLK+D/rv8JL+wAs=;
        b=eKD+oLhgBhwoMS/CcDULsS7eLUt1gMS1jMuNeEiQem2VRmxWPVgASDkeixCikCh36t
         +ru9nyQH7q/snuSk9RLeSB/D6au8XGY9q6YRQxCvxE3bgPwbUhyDGMORil1grG3V94iq
         IJF6WfEPfjqeUSXG3lQyKVnlrq7x4qfvVfJh4/V1fYFOt41w6UBP6YYrvWdVViZcbKo2
         J4xsvAysgcccmbklZXYNGcgNqEtOz88xR7WgGkrS8v3PwknMG6lLS4EpyAORBvze8dpj
         jWtujHvw8pmSbHbZqYDAYJHo1Mo5mQBBvu/L3irJfk36Kb7HW4BBpBnS4icutiqeJqoU
         oDEw==
X-Gm-Message-State: AA+aEWZvIdesiwdJy762pKdao5+PhQdLaAQ4h4IEPuZpx4aQrJneMNZr
        Q1GQUy/5tHIYPiGf1pRrc5XoJWssmk1ZWaOJHR8=
X-Google-Smtp-Source: AFSGD/VvQnHDgpvCROY+SSR+Qk8sizZrJULY+4RRomDF18LG5gK+bFWlsV/5SYpeFotZD1sFb+yZbhP+9xzbUo5Sp1w=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr990207otg.139.1544530972386;
 Tue, 11 Dec 2018 04:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-3-quentin.perret@arm.com> <CAJZ5v0iygh1Kh4FnOE=2GzcUHW+FBV+9ZrotAfmXtgdk==6tNg@mail.gmail.com>
 <20181211121742.d6ujfyccwn7t63b3@queper01-lin>
In-Reply-To: <20181211121742.d6ujfyccwn7t63b3@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 13:22:41 +0100
Message-ID: <CAJZ5v0hP4iEQAFOA2AzcgVUzWS5FeQpCza4Ly-esw0qkYwqrLw@mail.gmail.com>
Subject: Re: [PATCH v10 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:17 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Rafael,
>
> On Tuesday 11 Dec 2018 at 13:01:24 (+0100), Rafael J. Wysocki wrote:
> > On Mon, Dec 3, 2018 at 10:56 AM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > [cut]
> >
> > >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > > +/**
> > > + * enum schedutil_type - CPU utilization type
> > > + * @FREQUENCY_UTIL:    Utilization used to select frequency
> > > + * @ENERGY_UTIL:       Utilization used during energy calculation
> > > + *
> > > + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> > > + * need to be aggregated differently depending on the usage made of them. This
> > > + * enum is used within schedutil_freq_util() to differentiate the types of
> > > + * utilization expected by the callers, and adjust the aggregation accordingly.
> > > + */
> > > +enum schedutil_type {
> > > +       FREQUENCY_UTIL,
> > > +       ENERGY_UTIL,
> > > +};
> >
> > Why not to use bool instead of this?  Do you expect to have more than
> > just two values in the future?  If so, what would be the third one?
>
> Indeed, the only reason is that an enum is easier to extend, if need be.
> I think you mentioned some time ago that CPUIdle could be, in principle,
> interested in having access to aggregated utilization signals of CPUs:
>
> https://lore.kernel.org/lkml/CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com/
>
> So yeah, I kept Peter's original enum and went for documenting the type,
> as you suggested on v7 :-)

OK, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.
