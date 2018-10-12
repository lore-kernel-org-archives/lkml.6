Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D782BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DDA2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DDA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJLPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:14:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44916 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJLPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:14:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so9165596oia.11;
        Fri, 12 Oct 2018 00:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2N6LmD7zHSnSP1dXyQSLFqpAnslerYQmmZyfMbCCiAc=;
        b=rv1cHYyFv+mVfQY8MioRciQ3Yldw2J87222CqGhg8Q6RRJY0XudxFnaijerznTgJEZ
         m2IGzC9bOdSuBcJQe2nThNDSQQ9dq21N1iVsRgAM8gJDp3Ou0wsQ1oyYqUmeYT2SEgPK
         f9s7mNXpWxWPFI1va6OMBO8wsAPmlTg4bjK4RI8awWNxDMb9V49VJXbfXBNirfFeuknj
         5oAthryUBX3vIbn2Qa+YlnPsel254+P5i57en4pVxwoCHMSUePalweTbK4QMsC9yqHzf
         P4Nxa981/1XF7D7SDnnJhMxmRRhFs1OJpewxgTao5e1xT4dmV0RDQnr0ljxC/EfSlVJA
         wfBQ==
X-Gm-Message-State: ABuFfohfgv8YvXSe6+1FO5x6ayncZz+Rm8Im+QcXQwOSoADZGhn7mGxr
        ytm3IJkq/8twIIrgW1WAx5ht3Zji5HzWR0TcJcg=
X-Google-Smtp-Source: ACcGV621R6uz96N39kIL90uBy/rTcL8hwTmieUsbaXqBulJbfurbi26vSGu/TkqQ5DbIZoQRPylT8ZRqfEyJ6tMyBPo=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr2509982oif.195.1539330224708;
 Fri, 12 Oct 2018 00:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
 <8161939.SRDo8Qx48D@aspire.rjw.lan> <20181011220842.GE2371@codeaurora.org>
In-Reply-To: <20181011220842.GE2371@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Oct 2018 09:43:31 +0200
Message-ID: <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, rplsssn@codeaurora.org,
        Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:08 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Oct 11 2018 at 14:56 -0600, Rafael J. Wysocki wrote:
> >On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
> >> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> To allow CPUs being power managed by PM domains, let's deploy support for
> >> runtime PM for the CPU's corresponding struct device.
> >>
> >> More precisely, at the point when the CPU is about to enter an idle state,
> >> decrease the runtime PM usage count for its corresponding struct device,
> >> via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
> >> resumes from idle, let's increase the runtime PM usage count, via calling
> >> pm_runtime_get_sync().
> >>
> >> Cc: Lina Iyer <ilina@codeaurora.org>
> >> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> >> (am from https://patchwork.kernel.org/patch/10478153/)
> >> ---
> >>  kernel/cpu_pm.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> >> index 67b02e1..492d4a8 100644
> >> --- a/kernel/cpu_pm.c
> >> +++ b/kernel/cpu_pm.c
> >> @@ -16,9 +16,11 @@
> >>   */
> >>
> >>  #include <linux/kernel.h>
> >> +#include <linux/cpu.h>
> >>  #include <linux/cpu_pm.h>
> >>  #include <linux/module.h>
> >>  #include <linux/notifier.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/spinlock.h>
> >>  #include <linux/syscore_ops.h>
> >>
> >> @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
> >>  {
> >>      int nr_calls;
> >>      int ret = 0;
> >> +    struct device *dev = get_cpu_device(smp_processor_id());
> >>
> >>      ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
> >>      if (ret)
> >> @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
> >>               */
> >>              cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
> >>
> >> +    if (!ret && dev && dev->pm_domain)
> >> +            pm_runtime_put_sync_suspend(dev);
> >
> >This may cause a power domain to go off, but if it goes off, then the idle
> >governor has already selected idle states for all of the CPUs in that domain.
> >
> >Is there any way to ensure that turning the domain off (and later on) will
> >no cause the target residency and exit latency expectations for those idle
> >states to be exceeded?
> >
> Good point.
>
> The cluster states should account for that additional latency.

But even then, you need to be sure that the idle governor selected
"cluster" states for all of the CPUs in the cluster.  It might select
WFI for one of them for reasons unrelated to the distance to the next
timer (so to speak), for example.

> Just the CPU's power down states need not care about that.

The meaning of this sentence isn't particularly clear to me. :-)

> But, it would be nice if the PM domain governor could be cognizant of
> the idle state chosen for each CPU, that way we dont configure the
> domain to be powered off when the CPUs have just chosen to power down
> (not chosen a cluster state). I think that is a whole different topic to
> discuss.

This needs to be sorted out before the approach becomes viable, though.

Basically, the domain governor needs to track what the idle governor
did for all of the CPUs in the domain and only let the domain go off
if the latency matches all of the states selected by the idle
governor.  Otherwise the idle governor's assumptions would be violated
and it would become essentially useless overhead.

Thanks,
Rafael
