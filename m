Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA33C21748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Snabtjg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33C21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbeHDA6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:58:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33065 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeHDA6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:58:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so6179895ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUzX5yJ6xxFO8ti1x4g/C903BlT8ZKkcHG9/H6dxHFU=;
        b=Snabtjg91FqdxRTUulbpZECBWIM034yyrFQtCwhBEsQzAkezVlRhxDMRgHd9JZupDt
         nPZT+pBysWVTDd/lYlf4uAqZLU4xfzWZAeg7tAMQrczC/6ry3//ubvo1l+99JUFsbDtG
         BqUpAWSemgwwIkAAGF/UdAzy+FeqCs9C2d+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUzX5yJ6xxFO8ti1x4g/C903BlT8ZKkcHG9/H6dxHFU=;
        b=cTuVxyUZxRh+7oBBS4f4kKAgxffCmtVSFM+BTvOpwLmUONJwJbxoj42xl2NF0ep2bo
         d4GL1WckjNdu28TGIfOaLLOuciYuqAwwwzZqgUWVlzEOr4iZaRf6+qi6rpXECk9rtgRP
         qJI0RlWG+yV7POcFhNTtDaXw3yLHtXbZsFCDHmbiFta1+QeyMNPxyoWw6fBVfWGT9oSF
         SwTKzxM9MBNttFL7fFOT9IfF9bvICQ03wiloJsUBfIatyVMhvfHldbJV5vbyg/V2eV/k
         b/IP82Jfb8N9jNZJvoh9iFE/Jn1aBFUQhxhBYxhXm0x6+vu9Nv9R2/UXNy6SftlQbc82
         Hjng==
X-Gm-Message-State: AOUpUlHDbH8QPn/FIwEXM5Xi8Pv/gJcwhdwaJfTNHOHRFmWPLmvC07ey
        4he9aGKtXAFXEGV5Je0We8L842MxC7Q=
X-Google-Smtp-Source: AAOMgpd16gM2YppIfSgY/HQKZBpWU5SsaIQ6nUVvb/VasZjDS3RiSujyd6AoDNqELm02ap8ULjmBjQ==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr6441698ljb.119.1533337195190;
        Fri, 03 Aug 2018 15:59:55 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 97-v6sm917883lfw.13.2018.08.03.15.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 15:59:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r13-v6so6136464ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 15:59:52 -0700 (PDT)
X-Received: by 2002:a2e:540d:: with SMTP id i13-v6mr6383987ljb.51.1533337192318;
 Fri, 03 Aug 2018 15:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-2-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 Aug 2018 15:59:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft5vxheWYyF2JODuGAKcfHfYOS6sg-vCar=dZG5tFm9SVw@mail.gmail.com>
Message-ID: <CAE=gft5vxheWYyF2JODuGAKcfHfYOS6sg-vCar=dZG5tFm9SVw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] interconnect: Add generic on-chip interconnect API
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  96 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   2 +
>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 125 +++++
>  include/linux/interconnect.h                |  42 ++
>  8 files changed, 847 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
>

Thanks Georgi. This looks great!

Reviewed-by: Evan Green <evgreen@chromium.org>
