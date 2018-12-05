Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D656C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CB920892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g3NN9mOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CB920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeLEUtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:49:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37069 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:49:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so19646605lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chV5AMXa7wTX8GxqMhONGZ3HZuE3v6EMe6pHqOA45KM=;
        b=g3NN9mOUYwwsIgRo6hI3jVCwAjHlPRj0pGMnfXkdAmoMFw+gvRdHHNo4Cw9AqxBdgo
         uAJzrU3EjBCkGkYvl/sHbFqSH1eGvAAiKGLZ2k2AZyahVBsQfXlzwxjedyHxWnhKMPui
         EbvxNBUfQaXW+wbPhhT02f4nfywHoeMvQWmFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chV5AMXa7wTX8GxqMhONGZ3HZuE3v6EMe6pHqOA45KM=;
        b=bAUC0eYmUtGqY6aLc7HOA+u/dWsJqcOTUtnZ1CzAzbIvHn8rqjcIskIjdC/03oot2K
         FWhjYXgize1kauZngXjFDWLQYsv4gMCKiY/InKvi2o1hGeZSCbrO8HVMFk7VGRJGg+lG
         PUe95QVdykeQvmdb/xYYIbH/Rt5J7OhEslbxiflpnkXqVrvvIbhwVkXq2PpXqmRVfZEG
         0DEYfCXm1vHuWBkq26nN9jroKoX6dY/G5kAFTVSS4+OyEBGTqLo7DTIl6HzmAEb4L0aP
         b8vUIKiMAA9jgBvEJFQdXmCR6JI+FNkWnls9gL5FNwTD4ROZv8PRhbKaFOEawXZKLJza
         ZUUw==
X-Gm-Message-State: AA+aEWYL8Z0iaITZ59S4CadQT3+neqsElMelKVbE6C61TRsm+u3qEHxL
        0j3xOnGosEamMXqRVtKlwbWbcD/3yPA=
X-Google-Smtp-Source: AFSGD/U3Zjd15fOYXn0voc6M+ETXho7AJAIcjSBiw3xp4Ukf6NKGxfnNego/lbCl0rdt7DU4sT3cQQ==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr18076282ljt.107.1544042972218;
        Wed, 05 Dec 2018 12:49:32 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p138sm3791701lfp.22.2018.12.05.12.49.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:49:32 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l15-v6so19625949lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:49:32 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr18064501ljh.174.1544042532343;
 Wed, 05 Dec 2018 12:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 Dec 2018 12:41:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
Message-ID: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
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
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.

For what it's worth, we are ready to land this in Chrome OS. I think
this series has been very well discussed and reviewed, hasn't changed
much in the last few spins, and is in good enough shape to use as a
base for future patches. Georgi's also done a great job reaching out
to other SoC vendors, and there appears to be enough consensus that
this framework will be usable by more than just Qualcomm. There are
also several drivers out on the list trying to add patches to use this
framework, with more to come, so it made sense (to us) to get this
base framework nailed down. In my experiments this is an important
piece of the overall power management story, especially on systems
that are mostly idle.

I'll continue to track changes to this series and we will ultimately
reconcile with whatever happens upstream, but I thought it was worth
sending this note to express our "thumbs up" towards this framework.

-Evan
