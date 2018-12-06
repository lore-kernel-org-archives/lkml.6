Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D9B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCX96gWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D9B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeLFJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:16:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33037 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:16:00 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so13875739vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oplyraUjlzT1MdYD0jbSQna4BlEOoZ+ROrl7JO6ZcX4=;
        b=QCX96gWOCi1IvweM1uDEYuimkCOcRF7+ITWdMJ1/cX/tm7go7g7PjiOOT2DThXg68X
         oUJoeiHaC9AjOqB99Lc717nDsBjT9MAWCi/KsdCqStANCdXYNgUzqlm9kjXrE9vUwWg0
         dnBjBvLFgr43VIcrmgXIskRRE41DcczVCmHhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oplyraUjlzT1MdYD0jbSQna4BlEOoZ+ROrl7JO6ZcX4=;
        b=l2gvzWFsOICPh8v5wcHxh57Qo2hMajoFdUQKwrLxbRJRW7ydxdrSES6k2Jmao87uD6
         w93BzG7fTN7cZXn5oCzoAlOnNkpPEw3Dw2kRAth8Ntrn3jyx335GNJLheJekfVycze2b
         jYN9+3ANz5WY8P6DhwlcFR7gOi5gI5Dxf3fPYDwzaw6nl80ZtkdOLJLaqH1f2AxG5Pj5
         CLFavJ37vwyI0/woWmzwfPshTski77yGnyOIdoBfusLAfNWH1WjYx77Yuh6jmJXLQE4S
         dv+UanTMD55i4hkbLlsb+9bwNS0umgmPDOgsRJmYs1QhcdV2o3hodDRdXqZcnCbvNnLO
         fHWg==
X-Gm-Message-State: AA+aEWZ0lEuZ0RazlQQHwN0asOKU2fKhmamHwOljztBlbkIbrQiBCwmQ
        6h6fzDgaxYN5p28Dxe2qvenrPsJvkf/PHLE8X0tLsQ==
X-Google-Smtp-Source: AFSGD/UsZHvpC5TvTgT03vNBBhf3FX4VZq9uUDDdv07eTOp+J7Lffk6T8QhJKmOgHmIFPIqHa1bqWbsUwoPyi827vs0=
X-Received: by 2002:a67:b245:: with SMTP id s5mr12360073vsh.200.1544087759184;
 Thu, 06 Dec 2018 01:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-22-ulf.hansson@linaro.org> <20181204184553.GO18262@codeaurora.org>
In-Reply-To: <20181204184553.GO18262@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Dec 2018 10:15:23 +0100
Message-ID: <CAPDyKFqv+1R-hbSmgfrn8jtBXEB3S1-=bg+ArBkR4m-cxd2oQQ@mail.gmail.com>
Subject: Re: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to attach
 a CPU to its PM domain
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 19:45, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
> >Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
> >a CPU number as an in-parameter and attaches the CPU's struct device to its
> >corresponding PM domain. Additionally, the helper prepares the CPU to be
> >power managed via runtime PM, which is the last step needed to enable the
> >interaction with the PM domain through the runtime PM callbacks.
> >
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> >
> >Changes in v10:
> >       - New patch: Replaces "PM / Domains: Add helper functions to
> >         attach/detach CPUs to/from genpd".
> >
> >---
> > drivers/firmware/psci/psci.h           |  1 +
> > drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
> > 2 files changed, 20 insertions(+)
> >
> >diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> >index 05af462cc96e..fbc9980dee69 100644
> >--- a/drivers/firmware/psci/psci.h
> >+++ b/drivers/firmware/psci/psci.h
> >@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> > int psci_dt_init_pm_domains(struct device_node *np);
> > int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> >                       struct device_node *cpu_node, u32 *psci_states);
> >+int psci_dt_attach_cpu(int cpu);
> > #else
> > static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> > #endif
> >diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> >index 6c9d6a644c7f..b0fa7da8a0ce 100644
> >--- a/drivers/firmware/psci/psci_pm_domain.c
> >+++ b/drivers/firmware/psci/psci_pm_domain.c
> >@@ -12,8 +12,10 @@
> > #include <linux/device.h>
> > #include <linux/kernel.h>
> > #include <linux/pm_domain.h>
> >+#include <linux/pm_runtime.h>
> > #include <linux/slab.h>
> > #include <linux/string.h>
> >+#include <linux/cpu.h>
> > #include <linux/cpuidle.h>
> > #include <linux/cpu_pm.h>
> >
> >@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> >
> >       return 0;
> > }
> >+
> >+int psci_dt_attach_cpu(int cpu)
> >+{
> >+      struct device *dev = get_cpu_device(cpu);
> >+      int ret;
> >+
> >+      ret = dev_pm_domain_attach(dev, true);
> >+      if (ret)
> >+              return ret;
> >+
> >+      pm_runtime_irq_safe(dev);
> >+      pm_runtime_get_noresume(dev);
> >+      pm_runtime_set_active(dev);
> You would want to set this only if the CPU is online. Otherwise we will
> not power down the domain, if the CPU was never brought online.

Nice catch!

The platforms I tested this series on brings all their CPUs online
during boot, hence I haven't observed the problem.

I will post a new version soon to address the problem. Again, thanks
for your review!

[...]

Kind regards
Uffe
