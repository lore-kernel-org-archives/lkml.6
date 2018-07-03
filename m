Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726823F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esnnMnuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726823F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeGCWD4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:03:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46979 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933480AbeGCWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:03:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so2618286edo.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fbccId+exjACj9W6tge40iUVSzcZIDVV0bAtg5Y0oiA=;
        b=esnnMnuU25AIgTnBfg9OOzVHKi7XYb2raJelRWuEzGFgN2SVnfEcZ6eTlgSRDwnSHF
         a5rFIrrkxWbOXVZfc9mh88uCTkHAj16GLP/KyDg6nyUPAPJmynELkmnIg9LU9wZQhXWA
         WOX55e/i9WjyrCwpOYpd7suToIlU8c18oFbsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fbccId+exjACj9W6tge40iUVSzcZIDVV0bAtg5Y0oiA=;
        b=NERNZk0AVcWUQK8KOPw6rbNxdifhsA54/8uHglL4JnvDG8hVC/M4XcxSfp1OWoxNgG
         UI5IGpbfFmY+CLTFfYrPgHnClbLX8rv84vr+4EBwNOYhYlR3VxwT5oE++EmaIPRHvrU5
         6VWH5mCGQM3QvLPsDWS49kGTfFRF6Jd9+7K8Q/9LiksOcEiQJEIo745qCDL+1eWH7eqB
         1w6fx9CJSeIKTHSJLB4CfEGm/XjXgBWKpTAYa9zP87sTmi8M5Kq9IJEsfEAs2guDh7rm
         IZCj0tAtQD3XXyY5Po899dRj7eVkLS4mG5GquLzk/ziaVFWiL8kHWpEJm6o7Njqs9iFF
         JaiQ==
X-Gm-Message-State: APt69E3kWQtwa2h9ezQ83GUpFzxFbirulJal0ahOlS9OGaHvsielG6Nh
        gCs6Ta/RpoYPJNRpbAjY7Q2E1egN0LDUEtQ8fgZcLg==
X-Google-Smtp-Source: AAOMgpfzL7QOvbsO/xxALYVxOO87hI9X6zkQcotEH/gz0a0dc67u6wlQX3z83CXh+0s3pXcn2nCRebuV9Fv82dYBMFk=
X-Received: by 2002:a50:8a23:: with SMTP id i32-v6mr24677299edi.49.1530655422370;
 Tue, 03 Jul 2018 15:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org> <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
In-Reply-To: <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Jul 2018 16:03:31 -0600
Message-ID: <CANLsYkzrqYP7xDNSrmENeHuOHed0WQDT3PLyyFWN89HrNsR_RA@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 at 04:03, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
> > This patch follows what has been done for filters by adding an ioctl()
> > option to communicate to the kernel arbitrary PMU specific configuration
> > that don't fit in the conventional struct perf_event_attr to the kernel.
>
> Ok, so what *is* the PMU specific configuration that doesn't fit in the
> attribute and needs to be re-configured by the driver using the generation
> tracking?
>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  include/linux/perf_event.h |  54 ++++++++++++++++++++++
> >  kernel/events/core.c       | 110 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 164 insertions(+)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 4d9c8f30ca6c..6e06b63c262f 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -178,6 +178,12 @@ struct hw_perf_event {
> >       /* Last sync'ed generation of filters */
> >       unsigned long                   addr_filters_gen;
> >
> > +     /* PMU driver configuration */
> > +     void                            *drv_config;
> > +
> > +     /* Last sync'ed generation of driver config */
> > +     unsigned long                   drv_config_gen;
> > +
> >  /*
> >   * hw_perf_event::state flags; used to track the PERF_EF_* state.
> >   */
> > @@ -447,6 +453,26 @@ struct pmu {
> >        * Filter events for PMU-specific reasons.
> >        */
> >       int (*filter_match)             (struct perf_event *event); /* optional */
> > +
> > +     /*
> > +      * Valiate complex PMU configuration that don't fit in the
> > +      * perf_event_attr struct.  Returns a PMU specific pointer or an error
> > +      * value < 0.
> > +      *
> > +      * As with addr_filters_validate(), runs in the context of the ioctl()
> > +      * process and is not serialized with the rest of the PMU callbacks.
>
> Yes, but what is it? I get it that it's probably in one of the other
> patches, but we still need to mention it somewhere here.

I could write a more detailed description here, something about the
specification of sink and configuration of coresight specific features
(sequencers, counters, input/output) but I decided to keep things
generic.  Rather than doing that I thought it best to leave things
generic and let people look at the code for more details should they
want to.  Let me know what you think is best.

>
> > +      */
> > +     void *(*drv_config_validate)    (struct perf_event *event,
> > +                                      char *config_str);
> > +
> > +     /* Synchronize PMU driver configuration */
> > +     void (*drv_config_sync)         (struct perf_event *event);
> > +
> > +     /*
> > +      * Release PMU specific configuration acquired by
> > +      * drv_config_validate()
> > +      */
> > +     void (*drv_config_free)         (void *drv_data);
> >  };
> >
> >  enum perf_addr_filter_action_t {
> > @@ -489,6 +515,11 @@ struct perf_addr_filters_head {
> >       unsigned int            nr_file_filters;
> >  };
> >
> > +struct perf_drv_config {
> > +     void            *drv_config;
> > +     raw_spinlock_t  lock;
> > +};
> > +
> >  /**
> >   * enum perf_event_state - the states of a event
> >   */
> > @@ -668,6 +699,10 @@ struct perf_event {
> >       unsigned long                   *addr_filters_offs;
> >       unsigned long                   addr_filters_gen;
> >
> > +     /* PMU driver specific configuration */
> > +     struct perf_drv_config          drv_config;
> > +     unsigned long                   drv_config_gen;
> > +
> >       void (*destroy)(struct perf_event *);
> >       struct rcu_head                 rcu_head;
> >
> > @@ -1234,6 +1269,13 @@ static inline bool has_addr_filter(struct perf_event *event)
> >       return event->pmu->nr_addr_filters;
> >  }
> >
> > +static inline bool has_drv_config(struct perf_event *event)
> > +{
> > +     return event->pmu->drv_config_validate &&
> > +            event->pmu->drv_config_sync &&
> > +            event->pmu->drv_config_free;
> > +}
> > +
> >  /*
> >   * An inherited event uses parent's filters
> >   */
> > @@ -1248,7 +1290,19 @@ perf_event_addr_filters(struct perf_event *event)
> >       return ifh;
> >  }
> >
> > +static inline struct perf_drv_config *
> > +perf_event_get_drv_config(struct perf_event *event)
> > +{
> > +     struct perf_drv_config *cfg = &event->drv_config;
> > +
> > +     if (event->parent)
> > +             cfg = &event->parent->drv_config;
> > +
> > +     return cfg;
> > +}
> > +
> >  extern void perf_event_addr_filters_sync(struct perf_event *event);
> > +extern void perf_event_drv_config_sync(struct perf_event *event);
> >
> >  extern int perf_output_begin(struct perf_output_handle *handle,
> >                            struct perf_event *event, unsigned int size);
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f0434a9951a..701839866789 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2829,6 +2829,29 @@ void perf_event_addr_filters_sync(struct perf_event *event)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
> >
> > +/*
> > + * PMU driver configuration works the same way as filter management above,
> > + * but without the need to deal with memory mapping.  Driver configuration
> > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
> > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
> > + * bring the configuration information within reach of the PMU.
>
> Wait a second. The reason why we dance around with the generations of filters
> is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
> notified about mapping changes, we're called under the latter, and we'd need
> to grab the former to update the event configuration. In your case, the
> update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
> so you can just kick the PMU right there, via an event_function_call() or
> perf_event_stop(restart=1). In the latter case, your pmu::start() would just
> grab the new configuration. Should also be about 90% less code. :)
>
> Would this work for you or am I misunderstanding something about your
> requirements?
>
> > + */
> > +void perf_event_drv_config_sync(struct perf_event *event)
> > +{
> > +     struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
> > +
> > +     if (!has_drv_config(event))
> > +             return;
> > +
> > +     raw_spin_lock(&drv_config->lock);
> > +     if (event->drv_config_gen != event->hw.drv_config_gen) {
> > +             event->pmu->drv_config_sync(event);
> > +             event->hw.drv_config_gen = event->drv_config_gen;
> > +     }
> > +     raw_spin_unlock(&drv_config->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_event_drv_config_sync);
> > +
> >  static int _perf_event_refresh(struct perf_event *event, int refresh)
> >  {
> >       /*
> > @@ -4410,6 +4433,7 @@ static bool exclusive_event_installable(struct perf_event *event,
> >
> >  static void perf_addr_filters_splice(struct perf_event *event,
> >                                      struct list_head *head);
> > +static void perf_drv_config_splice(struct perf_event *event, void *drv_data);
> >
> >  static void _free_event(struct perf_event *event)
> >  {
> > @@ -4440,6 +4464,7 @@ static void _free_event(struct perf_event *event)
> >       perf_event_free_bpf_prog(event);
> >       perf_addr_filters_splice(event, NULL);
> >       kfree(event->addr_filters_offs);
> > +     perf_drv_config_splice(event, NULL);
> >
> >       if (event->destroy)
> >               event->destroy(event);
> > @@ -5002,6 +5027,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
> >  static int perf_event_set_output(struct perf_event *event,
> >                                struct perf_event *output_event);
> >  static int perf_event_set_filter(struct perf_event *event, void __user *arg);
> > +static int perf_event_set_drv_config(struct perf_event *event,
> > +                                  void __user *arg);
> >  static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
> >  static int perf_copy_attr(struct perf_event_attr __user *uattr,
> >                         struct perf_event_attr *attr);
> > @@ -5088,6 +5115,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
> >
> >               return perf_event_modify_attr(event,  &new_attr);
> >       }
> > +
> > +     case PERF_EVENT_IOC_SET_DRV_CONFIG:
> > +             return perf_event_set_drv_config(event, (void __user *)arg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > @@ -9086,6 +9117,85 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
> >       return ret;
> >  }
> >
> > +static void perf_drv_config_splice(struct perf_event *event, void *drv_data)
>
> I think the address filter counterpart is called "splice" because it takes
> a list_head as a parameter and splices that list into the list of filters.
> I'd suggest that this one is more like "replace", but up to you.

I was on the fence about the naming convention...  I wanted the
drv_config mechanism to be as close as possible to the filters, that
way if someone understands the filters they'll easily understand the
drv_config.  But it may be more confusing than anything else - I'll
change it.

>
> > +{
> > +     unsigned long flags;
> > +     void *old_drv_data;
> > +
> > +     if (!has_drv_config(event))
> > +             return;
> > +
> > +     /* Children take their configuration from their parent */
> > +     if (event->parent)
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&event->drv_config.lock, flags);
> > +
> > +     old_drv_data = event->drv_config.drv_config;
> > +     event->drv_config.drv_config = drv_data;
>
> Now I'm thinking: should we reset the generation here (and also in the
> address filters bit)? At least, it deserves a comment.

I thought your way of doing things was quite nice, hence doing the
same...  xyz_splice() does exactly that, it replaces the value but
downstream won't see it for as long as xyz_gen isn't updated - and
that is exactly what xyz_apply() does.  I can add a comment to clarify
how things work but I think we should keep the current scheme.

>
> > +
> > +     raw_spin_unlock_irqrestore(&event->drv_config.lock, flags);
> > +
> > +     event->pmu->drv_config_free(old_drv_data);
> > +}
> > +
> > +static void perf_event_drv_config_apply(struct perf_event *event)
> > +{
> > +     unsigned long flags;
> > +     struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
> > +
> > +     /* Notify event that a new configuration is available */
> > +     raw_spin_lock_irqsave(&drv_config->lock, flags);
> > +     event->drv_config_gen++;
> > +     raw_spin_unlock_irqrestore(&drv_config->lock, flags);
>
> Should we also mention how this new locks fits into the existing locking
> order?
>
> Regards,
> --
> Alex
