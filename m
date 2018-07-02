Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC05D244EE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0TzjZYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC05D244EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeGBRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:16:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37352 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbeGBRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:16:51 -0400
Received: by mail-lf0-f65.google.com with SMTP id j8-v6so2997458lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMmMC/TVNsudzMMeYrXGW5WdsIkwyF7HfSfaSjmlgNI=;
        b=d0TzjZYKPqOugIeDSTBovA2a76aR1eGiubmNfoGsVdDJEWvtloKk+8UypjwfwwUVFx
         y8GeL2hy7U3qt0PpCH+TJ8ZfTJuvO4YSxYsIo9oyRR8q3bOZaRigmZK8bJ5ljQ3jj8Ro
         Cq40B0yvqEB5LsrM3Gz4GqrYH31y/F9jrRsnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMmMC/TVNsudzMMeYrXGW5WdsIkwyF7HfSfaSjmlgNI=;
        b=l5g6Tdmrd9K5vmcEf1o8ub0HDtgIE8zqPJTSLWgFx0udcTZ25NjhWRqAfO3FDQvhgs
         sfDhr1Xntba1xvtzHsPKVY7sDMZpkwbpohqfG16wM3VJCv82NYznTSJN4LaBlACauurW
         A120uoeeDW+d1xErnR1EwnoRxOcR+t/nE55/vnUOaj5ikZorRNfJw8aWDu1RrrnIPt3I
         zzn6FBOiKxDOCwFEX+HoJRrfgngudmCb/lUZG6T38bzhqXBllmuojiBCdB/B/pPMTanP
         qkrWl2v8Q3v7/D31EK9qFxgUZ7WvIwj+bKYOUhpJmPP4Hue+1CU30uPoXuw1pWnZ0Xgo
         SuXA==
X-Gm-Message-State: APt69E22hKDwGIsie+nRvDZ5b0MThLYIO0jcWNCR7azzoHhaUQzh2KJ4
        XEnp6reyHr+1M1+IjzKa66tAjg3Oj8NXpQ==
X-Google-Smtp-Source: AAOMgpfGJIxdPYZOoQCdAp1Fj2wjRvSIH1CrkPS7a9UoMVJ+V8gnHtR/ca5XwhaGk+JanCjDAILWTA==
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr18101933lfv.51.1530551810186;
        Mon, 02 Jul 2018 10:16:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h140-v6sm2417124lfe.3.2018.07.02.10.16.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 10:16:50 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t21-v6so13100138lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:16:50 -0700 (PDT)
X-Received: by 2002:a2e:5c4:: with SMTP id 187-v6mr16756862ljf.28.1530551348932;
 Mon, 02 Jul 2018 10:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-7-georgi.djakov@linaro.org> <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
 <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
In-Reply-To: <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 2 Jul 2018 10:08:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft489LjMLp6YW1C_TywGDx0BPLAc8nSac1qCGiRDpAV9Ng@mail.gmail.com>
Message-ID: <CAE=gft489LjMLp6YW1C_TywGDx0BPLAc8nSac1qCGiRDpAV9Ng@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 5:12 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Evan,
>
> On 06/26/2018 11:48 PM, Evan Green wrote:
> > On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> >> +static int qcom_icc_init(struct icc_node *node)
> >> +{
> >> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> >> +       int ret;
> >> +
> >> +       /* TODO: init qos and priority */
> >> +
> >> +       clk_set_rate(qp->bus_clk, INT_MAX);
> >
> > Vroom! What's the rationale here? I wonder if it might be better to
> > avoid touching the clocks initially, and expect that the boot loader
> > sets up a decent initial set of bus frequencies for consumers that
> > never enable bus scaling? Otherwise, I worry that this driver becomes
> > basically an essential driver for the platform solely because of this
> > line and the one below, when really it might not be.
>
> The idea is to run the interconnects at max rate until consumers start
> sending requests, but i understand your worry and we can live without
> this for now. The better solution would be to set maximum bandwidth and
> remove it at late_init (after consumers are registered) or use this
> patchset: https://lkml.org/lkml/2018/3/21/897
> Actually I have some patches which add support for interconnects to keep
> the bandwidth constraints active until consumers are registered. The
> whole boot constraint thing adds complexity and introduces some
> overhead, but hopefully can be optimized.

Ah, that makes sense. This is a trickier issue than I was thinking
before. On one hand, you don't want to shut off bandwidth to a device
that was set up correctly by the boot environment and should keep
working until the driver comes up, like LCD. But on the other hand, if
a driver fails to come up, or fails to ask for bus bandwidth, you're
now burning at max. And then there's the issue of whether or not this
should be a required or optional driver for platforms that support it
(it would be nice if the system booted even without this driver, but
maybe for others that's a non-goal). I agree this is shouldn't hold up
this initial set of framework patches, we can solve this in a future
set.

-Evan
