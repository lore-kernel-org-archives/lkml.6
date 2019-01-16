Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E03C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0780520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TURSJ7/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfAPXoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:44:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52202 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfAPXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:44:04 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so6029945ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LeQfLR0aZ0V3aKibD+ER/7h/1zMywFsIvcaHPMOuRs=;
        b=TURSJ7/5T30A77hz76EL1Fphs6ExfDko2dgvRQWUgOorFlBlnv9cz0rzVXuiDH92m4
         iokcpO9oWflK54XrOOZQkMX4XpQ9WMvmUVUiXhI80p36dN81mcYuAUxmQua5l8fSKf1B
         BV0oA311nif01ztQkvFMQBvSFxAaiutXeEIok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LeQfLR0aZ0V3aKibD+ER/7h/1zMywFsIvcaHPMOuRs=;
        b=QzWmPFexPZBRP/qFU+HBPV3QYtWuREr4wsc7vGLZc1mClF00lDnRKLET1d8MXmIf+s
         9znlUrIGiATl7oBqQh1JhyT04EYn0VFpqS9E/j+exodcf14Ca2uDNcWP8s9GJz2NBSZ4
         LcITqRXbY5C7heGi+VKVoCzPb8bJJnkq4453OPFXqvZpG2psTjXQhrAeSryUZmSMJAxq
         eY4F7YXBx54Q06VSJrFBQb15tdXfCWrrzJxbs0CDS59XCM+licjaKHaIec7+GqMXYVxP
         JDmvekbiV34nvCB4j1xNswJFOnp5CkLvj2t/8tfMN1pVBkUAEQxJO5aSNSECQOniUKIM
         uNcw==
X-Gm-Message-State: AJcUukdTjoeFY9TaU6lgQSmEOigoN1MIln8rKnGkB5I85t5gEDGm4eDW
        0n9MpHR1zNTG7xSZtSflwVd/iK29kQIgMZjCdL/nkA==
X-Google-Smtp-Source: ALg8bN4RDVyPfuuoGUidOG1Su0+Pfc7Ap3/6Oi70P4x3d4+8EOj9JSO2qx60u/voN5GbthFTZVxoaIW0BIgB4eau1x4=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr7405335itl.146.1547682242833;
 Wed, 16 Jan 2019 15:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org> <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
In-Reply-To: <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 16 Jan 2019 16:43:51 -0700
Message-ID: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Suzuki,

On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 15/01/2019 23:07, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> >   .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> >   drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> >   3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..292bd409a68c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/perf_event.h>
> >   #include <linux/percpu-defs.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/types.h>
> >   #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >   };
> >
> > +static struct attribute *etm_config_sinks_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_sinks_group = {
> > +     .name   = "sinks",
> > +     .attrs  = etm_config_sinks_attr,
> > +};
> > +
> >   static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >   };
> >
> > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >   }
> >
> > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > +                                    struct device_attribute *dattr,
> > +                                    char *buf)
> > +{
> > +     /* See function coresight_sink_by_id() to know where this is used */
> > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > +}
> > +
> > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device *pdev = csdev->dev.parent;
> > +     struct device_attribute *dev_attr;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (!etm_perf_up)
> > +             return -EPROBE_DEFER;
> > +
> > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > +     dev_attr->attr.mode = 0444;
> > +     dev_attr->show = etm_perf_sink_name_show;
>
> I would have  added the attribute to the csdev (say, sink_attr),
> and add that to the group, so that it is easier to remove the
> attribute when the sink device is removed from the system (when
> we get there). It would be good to have something in place to remove the
> attribute.

My hope was to avoid introducing a new field in the already bloated
coresight_device structure, and on top of things a component specific
field.  I think it would be worth it if we'd envision making the
coresight drivers removable in a not so distant future.  But doing
something like that is quite tricky (as Kim quickly found out) and
skirts the bottom of the list of priorities, if on it at all.

I'll change it if you're really keen on it but it would be code that
is never used.

Mathieu

>
> Otherwise, the overall approach looks fine to me.
>
> Suzuki
