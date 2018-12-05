Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B95208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544026596;
	bh=+gwzwDnPJNvLtZKEcJq1sOD+YlIQ9jtCtlNxDquqasA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u3I3/tdC6Aj8ZXWjNwYj2sXmMuJlexSgHSFio3KpRdTeD2gGLbbLnDrCOkHfpMb6s
	 Co7UaV1qHU+YWsz4+FCv4MfFLXi2G9oYAI3zsfu+ykQX34cmNyKJaO+A1+exV9/8Yw
	 2eZv1ikbka65+bEUyNlyif00Qc5uJHA8RV6eg6FE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B95208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeLEQQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeLEQQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:16:35 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68195214E0;
        Wed,  5 Dec 2018 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544026593;
        bh=+gwzwDnPJNvLtZKEcJq1sOD+YlIQ9jtCtlNxDquqasA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgKVnjHdkCcyggeq7BjdbCl7BxcHvgPf7S/DHpWyahmTZ4lLqTK5pZFLBIiUO9OcU
         NRMpTnap7OOMroC5aC+ikTZ9aOsLb3hDUZktI5SL1HNqXFX6A6GF1mxAtwfQ+tLxrc
         U+KcYKEEF9B9CCrd+RqhQQ/7RzYVyHMHt2OEk5pI=
Received: by mail-qt1-f171.google.com with SMTP id k12so22845746qtf.7;
        Wed, 05 Dec 2018 08:16:33 -0800 (PST)
X-Gm-Message-State: AA+aEWaura9G5+NXGidyNAWPOazdvFcE5ke8E4FEyaDh61YP0oItMIaI
        s521FzAez3+ER+zoOboc4QMDbgwy6gI/Yxs4/A==
X-Google-Smtp-Source: AFSGD/VShLBbgbwIJla3YZAI37uxkZHbIfEdulh/nkj92GC+EcdvCUwd6cqZQ+wGNlis0HADZyDVJlIYj4NIdiZfQ0I=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr24356925qts.144.1544026592489;
 Wed, 05 Dec 2018 08:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-2-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 5 Dec 2018 10:16:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyPH9WVw2VqGTjUvhxoq3+KGpfqtAMf9iH07N7m3P4yw@mail.gmail.com>
Message-ID: <CAL_JsqJyPH9WVw2VqGTjUvhxoq3+KGpfqtAMf9iH07N7m3P4yw@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:03 PM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
> Reviewed-by: Evan Green <evgreen@chromium.org>

[...]

> +struct icc_path *icc_get(struct device *dev, const int src_id,
> +                        const int dst_id);
> +void icc_put(struct icc_path *path);
> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);

icc_set() is very generic, but this function isn't easily extended to
other parameters than bandwidth. Perhaps icc_set_bandwidth() instead.
Then when you add some other setting, you just add a new function. Of
course, if you wind up with a bunch of different parameters, then
you'll probably need an atomic type interface where you test all the
settings together and then commit them separately in one call. But
from a DT perspective, I certainly hope there are not lots of new
settings folks want to add. :)

Rob
