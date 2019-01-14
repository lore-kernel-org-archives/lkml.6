Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4944FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1973420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5BNadTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfANKfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:35:08 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42514 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfANKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:35:07 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so13298551vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QcJx7KrAxopUw0FSGZKcSuUPEZlj8XNbB+CptmcnR8=;
        b=A5BNadTO4+0T+VByKY+4nZ9m90CevNZf9vJP15pOTD3YfmIpeQ+lBLKHbI+iESFh3g
         bRGAdtqk1d2xZQ9GazVaJfymRat3kHw7Ac9UzhGsiry4bZS2bQ1DO9EM2d3Y40QmbTK5
         Uce9AecwYgNz/wmyi6EEvGq+d3H1z36J6fnQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QcJx7KrAxopUw0FSGZKcSuUPEZlj8XNbB+CptmcnR8=;
        b=LtFHQXYDNqjL/xDIb4m+m2hvTukC1mNR8e0/RbanLz2ByWSDQJQ+CCd/6n7tOyd0MY
         MJOxj5Jj7D8XvGSyGHQijLHKeFVJVGxYurfFIMJ/1fDWOsrhnOID0SniHOU9eanOITlL
         mB0PNOQYHL8e82ZSklTBaoKm6wlT86JyQiF+6zBwcEvwZ/v1ukjaOo6cCg6eGk/GxgAv
         +/vfUTF0A7tAzVDOM/bBYNNeqUA6I7x0M68wUsUXliCwBytQAUvALK6Ig95mcp6ejiKS
         Z/y8blkckgVNVd49XWuQs1P0ZiKEsBY2ejDueqKisaH18ACI1MLdkNeUhpXNwEuxwkbe
         rwzQ==
X-Gm-Message-State: AJcUukdKT+4Q4eLGWyYPl+XEqifGyu40HSNgSmQqysGr6A5KzG3LDRC7
        XrwMXt0e+cWoiu+tNbRg17JmmWOHRFXoOam6qxIC/A==
X-Google-Smtp-Source: ALg8bN5WJVEj3/uFYjJ5H8B1W5giv9Oj7Fxn2EcSduwi4BxNEr2XrggEKEWTr+vBmOzj0Y75R6wrnJbJ5yEc8LANZQA=
X-Received: by 2002:a05:6102:193:: with SMTP id r19mr10180990vsq.9.1547462106695;
 Mon, 14 Jan 2019 02:35:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org> <CAJZ5v0h+m6sR=nFFXSMv_FKy=y0W4mSd3W34qW48-BpnGBPcZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+m6sR=nFFXSMv_FKy=y0W4mSd3W34qW48-BpnGBPcZQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Jan 2019 16:04:55 +0530
Message-ID: <CAHLCerM+bbXbUzoqm_5oPw_o-zEFCN4FjXRGVVqYkGYzC5upDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Thermal throttling for SDM845
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 3:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 14, 2019 at 11:22 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Add support for thermal throttling on SDM845.
> >
> > We introduce a generic flag to be used by cpufreq drivers to tell the
> > cpufreq core to auto-register a thermal cooling device.
> >
> > There are a few miscellaneous fixes to keep checkpatch happy.
> >
> > If this approach is acceptable I can send a series converting other cpufreq
> > drivers to use this flag and get rid of driver code.
> >
> > Amit Kucheria (9):
> >   [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
> >   drivers: thermal: of-thermal: Print name of device node with error
> >   drivers: cpufreq: Add thermal_cooling_device pointer to struct
> >     cpufreq_policy
> >   cpufreq: Add a flag to auto-register a cooling device
> >   cpufreq: Replace open-coded << with BIT()
> >   cpufreq: qcom-hw: Register as a cpufreq cooling device
> >   arm64: dts: sdm845: Increase alert trip point to 95 degrees
> >   arm64: dts: sdm845: wireup the thermal trip points to cpufreq
> >   thermal: cpu_cooling: Clarify error message
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
> >  drivers/cpufreq/cpufreq.c            |  13 ++
> >  drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
> >  drivers/thermal/cpu_cooling.c        |   2 +-
> >  drivers/thermal/of-thermal.c         |   4 +-
> >  include/linux/cpufreq.h              |  34 +++--
> >  6 files changed, 210 insertions(+), 41 deletions(-)
>
> Would it be possible to split this series so as to put the cpufreq
> patches separately?

Sure, will send out another version.
