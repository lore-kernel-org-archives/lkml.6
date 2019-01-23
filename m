Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D171020861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239983;
	bh=ATIy2YFQTZcBDMpG/L+ntduvRMKe2+98U7hes4tybXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ta/oZpPeH82FXkidk6cp78OW7sFNsu9cNuLzBmlTHyJ6i77fS1tPo7vsO9s8Gf64r
	 S6cdYCC+RB+Hfqkr5AZbxGuGLP0zcCcJrcA6mjEwAuF/vKWlvMNUtp2Erpkhf2EUlw
	 7iKK5XlJQWtmcn3YIXJBo3rxQyNH8mvlRhbZFcI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfAWKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:39:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44543 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfAWKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:39:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so1366880oig.11;
        Wed, 23 Jan 2019 02:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg0hX+CA34u3qPWrPjOGvXZCtdevBW0CLcPKrzIur2U=;
        b=oNubL5r2v1NHaX2swzYLQ5FQdQSAI6HgTe52ve3xMBejST0Vr3IrFEX8ch25H7IluO
         Bbb14DsRHErXkeI8jtnkoZbD/xnXaOL9mjxl5XbnpJkzShBBUi9r9gLnjYB+XNkaM7oT
         +HMGT3WtIOeXEGtY/pL59F/lK2/3Vg04Xuwn1Dby0O5AzlLVslPTZWm3JAz3kXAW9Zzd
         jqKe6Lw8bZHEU+bW2CB1k1k544M9A60404GC9RezmYYfJSRDv9gvPxrfd4G3wUM0aZeS
         JDOopqfDO6IqJHSERvwlxlVPoVaUwoJmt8CAqWTnknwwWeW4JwhbV/IBzUJZcSI/S7G5
         cQ7A==
X-Gm-Message-State: AJcUukf8iqQiYJThiVzt32pPiyGYE9rXCm+HvNUnEUJP+OUOIwA4khMn
        DNs9d3iZXfn1/w02QF0CXHuHtB0Jbx8eo3Yxa58=
X-Google-Smtp-Source: ALg8bN4OMvh9rmk40mLqZHHutmasWDl34DfUd4toWmTkysXdp7mQu25I4WtKjUDtDz1IPeogPNg9P9M+FN3eOAmUsZA=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr1006849oix.246.1548239981295;
 Wed, 23 Jan 2019 02:39:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
 <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
In-Reply-To: <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jan 2019 11:39:29 +0100
Message-ID: <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-01-19, 21:10, Amit Kucheria wrote:
> > @@ -151,6 +152,11 @@ struct cpufreq_policy {
> >
> >       /* For cpufreq driver's internal use */
> >       void                    *driver_data;
> > +
> > +#ifdef CONFIG_CPU_THERMAL
> > +     /* Pointer to the cooling device if used for thermal mitigation */
> > +     struct thermal_cooling_device *cdev;
> > +#endif
> >  };
> >
> >  /* Only for ACPI */
> > @@ -386,6 +392,12 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> >
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device.
> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > +
> >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> >
> > @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> >                       policy->cpuinfo.max_freq);
> >  }
> >
> > +#ifdef CONFIG_CPU_THERMAL
> > +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > +}
> > +
> > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> > +     cpufreq_cooling_unregister(policy->cdev);
> > +     policy->cdev = NULL;
> > +}
> > +#else
> > +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> > +#endif
>
> The whole ifdef hackery here saves space for a pointer per policy.
> Just get rid of it, it isn't worth it.

Is struct thermal_cooling_device defined if CONFIG_THERMAL is unset?
