Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8217AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA7A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAbi7baQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA7A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGRWvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:51:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43463 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRWvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:51:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so5512206edt.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFk+ePabofdqJXNesplHfbZwzP61hbJbw5N75WIMrAc=;
        b=MAbi7baQCNFUG6Sqoa2kl/MSer4uEUZNCDiQf6b6orU5burYnv/oGc2I9Nq4fomv99
         Kahu/u7y6LArpBKnkH2H4WUkGflGIUB/W1nhnwYgvdYwt+6Gq12i99/HvO28EhTXVgLX
         c05Sxb/RJ78jWo/ic9Vw+GwR3R1b1EC5l4DSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFk+ePabofdqJXNesplHfbZwzP61hbJbw5N75WIMrAc=;
        b=j5NoKF6arrqhc6Bif7FCostWkvgsUsPK3jF5n6tSI782KeISaeTPzim/chDTeEsVW6
         t5bXPVDDyGBKgMcrugaT39B21uhXFibUmL7oA1M5hMQ0Kz0lmv3TZzPUcqzKNTIIzu3V
         9cpRoc5pQTY7AhvXbcvwumGDoNazBVTzeovxOz2Jju0VXoDFq9TZWQkPTrpN5BC0vlP0
         X+aQHJS9uCXEQDJlSLZ0+KZgsXffeETs5X5eeKDLFQEix0efvx3RSf+Tqp4KspX0nXWB
         MM5DHBbuYh39H8bZ7Hx6RsbAe3HqhSt2mFNd4y7szjQaQnedCzehGpu2pNK2j3d3LT5n
         1i0g==
X-Gm-Message-State: AOUpUlGnFhB3/+YEaPiQG8DJb1OZZFDDeqA8r++o5a/df1ozsh7reoJl
        ISeBdtaKOUfYtgVgV0CCC5bMfsVaXj1YG29OnKxW2A==
X-Google-Smtp-Source: AAOMgpd0usmJ9XXHYed7tGY0QEELXOHB8x6Y14ARC9xtfcocx/YMqvVbZfR18QgyPG/BFHJKZB56tdup3QVaPJO8VPs=
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr8353117edd.195.1531951887236;
 Wed, 18 Jul 2018 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1531942988-20901-1-git-send-email-mathieu.poirier@linaro.org> <d648155e-0486-7d7c-5e29-2bda6c536dba@arm.com>
In-Reply-To: <d648155e-0486-7d7c-5e29-2bda6c536dba@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 18 Jul 2018 16:11:16 -0600
Message-ID: <CANLsYkw5eXvVg+8QGBFsQ_kawL-Okuny-e4VPY=q6w3_27Dq_Q@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm_perf: Rework alloc/free methods to avoid
 lockep warning
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 at 15:31, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 07/18/2018 08:43 PM, Mathieu Poirier wrote:
> > When enabling the lockdep mechanic and working with CPU-wide scenarios we
> > get the following console output:
> >
>
> > This is fixed by working with the cpu_present_mask, avoinding at the same
> > the need to use get/put_online_cpus() that triggers lockdep.
>
> The patch looks correct to me. In fact I have a patch [1], which
> does the same thing and switches to using per-cpu variable for the
> paths.

Not only did you beat me to the punch but I think using a per-cpu
variable is cleaner, so let's go with yours.

Mathieu

>
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 39 +++++++++++++-----------
> >   1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 677695635211..16b9c87d9d00 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -108,26 +108,32 @@ static int etm_event_init(struct perf_event *event)
> >   static void free_event_data(struct work_struct *work)
> >   {
> >       int cpu;
> > +     void *snk_config;
> >       cpumask_t *mask;
> >       struct etm_event_data *event_data;
> >       struct coresight_device *sink;
> >
> >       event_data = container_of(work, struct etm_event_data, work);
> >       mask = &event_data->mask;
> > -     /*
> > -      * First deal with the sink configuration.  See comment in
> > -      * etm_setup_aux() about why we take the first available path.
> > -      */
> > -     if (event_data->snk_config) {
> > -             cpu = cpumask_first(mask);
> > -             sink = coresight_get_sink(event_data->path[cpu]);
> > -             if (sink_ops(sink)->free_buffer)
> > -                     sink_ops(sink)->free_buffer(event_data->snk_config);
> > -     }
> > +     snk_config = event_data->snk_config;
> >
> >       for_each_cpu(cpu, mask) {
> > -             if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
> > -                     coresight_release_path(event_data->path[cpu]);
> > +             if (IS_ERR_OR_NULL(event_data->path[cpu]))
> > +                     continue;
> > +
> > +             /*
> > +              * Free sink configuration - there can only be one sink
> > +              * per event.
> > +              */
> > +             if (snk_config) {
> > +                     sink = coresight_get_sink(event_data->path[cpu]);
> > +                     if (sink_ops(sink)->free_buffer) {
> > +                             sink_ops(sink)->free_buffer(snk_config);
> > +                             snk_config = NULL;
> > +                     }
> > +             }
> > +
> > +             coresight_release_path(event_data->path[cpu]);
> >       }
>
> >
> >       kfree(event_data->path);
> > @@ -145,16 +151,13 @@ static void *alloc_event_data(int cpu)
> >       if (!event_data)
> >               return NULL;
> >
> > -     /* Make sure nothing disappears under us */
> > -     get_online_cpus();
> > -     size = num_online_cpus();
> > -
> >       mask = &event_data->mask;
> > +     size = num_present_cpus();
> > +
> >       if (cpu != -1)
> >               cpumask_set_cpu(cpu, mask);
> >       else
> > -             cpumask_copy(mask, cpu_online_mask);
> > -     put_online_cpus();
> > +             cpumask_copy(mask, cpu_present_mask);
>
> I think it is safe to use cpu_online_mask outside the
> get/put_online_cpus(). Using present_mask may fail as
> we could fail to create a path for a CPU that is not online.
>
>
> Please could you check if [1] fixes the problem for you ?
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/591606.html
>
> Cheers
> Suzuki
