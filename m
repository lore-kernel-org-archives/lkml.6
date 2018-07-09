Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE1920864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiDvvQ/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933821AbeGIQtR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:49:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37483 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933292AbeGIQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:49:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so14449615edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g15owgsWNr00Ee8DXImaI1hNwjBk6I9+iJkw60G5JVU=;
        b=MiDvvQ/RT0Dv0NKeivWaI/kgtcxCxsgQLKdJ5XgXkKaqD8fgPSavnqR1EexMgrpqBc
         1Q3e4BJfExbkDdTlkr4hCvC1udGf9OScvkafu/E/GI+rJie8LKOF8evbk/9CnzGezvEd
         42cGRp5Di4/4IDP+B8nWT8xGMwGTisFQVBdNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g15owgsWNr00Ee8DXImaI1hNwjBk6I9+iJkw60G5JVU=;
        b=BruXwgKEnR66zXlAUkFOQOHtVO7m0F6SkuG6E5u23KTZAt0jw9d7txBXBbUvjVWtvK
         cmFWbzZEycZ3yJFqSldJAbcFWqiRyPjZi0hM2rFZXkYSET/bV3CKEdHovMNFxwQMcXnO
         tFVAMkocf2G9SQ/K4TAD0bPXsb6DIwLid6YGzFk38PjGztNN+cCs3hbAcIcZd25SpnwF
         YTclKcZdfDbHRykHobwkmS5AYpAbIXf5pfdOJRXJbbjxycpeKwLwvrdE1C4aFILVIIL5
         JXQW9vsu8aZBCJeE1xxXTWMK8Vz7QPlO2gyhDU+UUIkCaCMlf51EWcr+MhGrHL90DMkr
         X3RA==
X-Gm-Message-State: APt69E23sp8iq43SkbI9ugTyBLMX5OQUkP0IcNpa2xm9oQlER5HPchDD
        hXBL87AHgExdSi1pe5gCL93LcD6+wtJjJINMomOAag==
X-Google-Smtp-Source: AAOMgpeayxJuzMhSVjuw3Sc4EghzhnTZp2a3HYdtRwZfg81UXfa1gbxaB4MexryLn89aS+H+FfnBMqGeEvqtqLeIBZE=
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr22674332edd.195.1531154953519;
 Mon, 09 Jul 2018 09:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
 <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org> <20180706182222.8af97a96d613c90415cb202f@arm.com>
In-Reply-To: <20180706182222.8af97a96d613c90415cb202f@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 9 Jul 2018 10:49:02 -0600
Message-ID: <CANLsYkxkhbB3i2NP-DCyPUo7sSUNPvEsPM5MLaJOJbd6ZwLYNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-s390@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, heiko.carstens@de.ibm.com,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, schwidefsky@de.ibm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 at 17:22, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Thu,  5 Jul 2018 16:13:42 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> Hi Mathieu,
>
> > This patch adds the mechanic needed for user space to send PMU specific
>                       ^^^^^^^^
> I think you meant 'mechanism' here:  mechanics fix cars :)

I really meant "mechanic", as in "functional details or procedure" [1]

[1]. https://www.merriam-webster.com/dictionary/mechanics

>
> > +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> > +{
> > +     unsigned long flags;
> > +     void *old_drv_data;
> > +     struct pmu_drv_config *drv_config = &event->hw.drv_config;
> > +
> > +     if (!has_drv_config(event))
> > +             return;
> > +
> > +     /* Children take their configuration from their parent */
> > +     if (event->parent)
> > +             return;
> > +
> > +     /* Make sure the PMU doesn't get a handle on the data */
> > +     raw_spin_lock_irqsave(&drv_config->lock, flags);
> > +
> > +     old_drv_data = drv_config->config;
> > +     drv_config->config = drv_data;
> > +
> > +     raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> > +
> > +     /* Free PMU private data allocated by pmu::drv_config_validate() */
> > +     event->pmu->drv_config_free(old_drv_data);
> > +}
>
> I got this stacktrace whilst testing a perf tool *without* this series
> applied, running on a kernel *with* this series applied:

That shouldn't matter as I kept the changes backward compatible
specifically to handle this situation.

>
> [  132.942054] INFO: trying to register non-static key.
> [  132.946964] the code is fine but needs lockdep annotation.
> [  132.952389] turning off the locking correctness validator.
> [  132.957818] CPU: 2 PID: 2835 Comm: perf64-sans Not tainted 4.18.0-rc3-00196-g5b5d957532a8-dirty #146
> [  132.966856] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
> [  132.977527] Call trace:
> [  132.979947]  dump_backtrace+0x0/0x1c0
> [  132.983567]  show_stack+0x24/0x30
> [  132.986845]  dump_stack+0x90/0xb4
> [  132.990122]  register_lock_class+0x57c/0x580
> [  132.994343]  __lock_acquire.isra.12+0x6c/0x980
> [  132.998736]  lock_acquire+0x100/0x1e8
> [  133.002357]  _raw_spin_lock_irqsave+0x58/0x78
> [  133.006667]  perf_drv_config_replace+0x4c/0x80
> [  133.011061]  _free_event+0xbc/0x460
> [  133.014507]  put_event+0x2c/0x38
> [  133.017697]  perf_event_release_kernel+0x1ac/0x300
> [  133.022434]  perf_release+0x10/0x20
> [  133.025883]  __fput+0xa8/0x1e0
> [  133.028901]  ____fput+0x20/0x30
> [  133.032006]  task_work_run+0xa0/0xd0
> [  133.035539]  do_notify_resume+0x118/0x120
> [  133.039503]  work_pending+0x8/0x10
>
> Is a raw_spin_lock_init missing perhaps?

Not that I can tell - I need to investigate.

>
> Thanks,
>
> Kim
