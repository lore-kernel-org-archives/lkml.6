Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0AEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A43521736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874862;
	bh=zivmjRJeqY7jYqs9u4inzJ0Gz6WHby5gz1++O+RQWrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wU54kH+3lb6FMqst902bo9EOQiZg2lio/UxIVcNGUPg1grwOVl3OqepPzeNq2PT4n
	 hITafPSMOPPgnAcjSlYyl9IHovm5THTS+YZtKUlvUgzoS3un/UBrS+ib9xdW4hohs0
	 FG/N3scjwmyOt/bukENdfcHPQq7M8nBiEkT2ZPs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfBKIrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKIrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:47:41 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4902176F;
        Mon, 11 Feb 2019 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549874860;
        bh=zivmjRJeqY7jYqs9u4inzJ0Gz6WHby5gz1++O+RQWrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=owks95T2YWjgSufmMAOQbpJ9QKYe0RV0d+FUmOSBNz+KrwCo4LRWDUd2m87D7oMVs
         EjQLL3NKYe/308PGAu/NnQK7ZKjwyX1sbNPgC389AYYNCz0hJC1eqc0XCxB5Zu+xOM
         Nwt4SEeuPCbT3GxWUw4V/u7u6ZAJ3wJTa76rmfJE=
Received: by mail-lf1-f49.google.com with SMTP id e27so7053941lfj.8;
        Mon, 11 Feb 2019 00:47:39 -0800 (PST)
X-Gm-Message-State: AHQUAubgL37g/4zCCiZMMDlbNs6HUbz1nWu7mKCoGPaM6z+b0wCWlZba
        w5m+A2aLagFQlCU1V7J6USlc8GdXwgAt9b2fgq0=
X-Google-Smtp-Source: AHgI3IbTz8HP3Eg7bv12FIUNhMJ0rqouVwIoGeFgtCcEBNN5rnfW7lFYNkeSvMATpHhxBiE1qsp2MsnwKI5ePzpSkps=
X-Received: by 2002:a19:f013:: with SMTP id p19mr2761837lfc.154.1549874857895;
 Mon, 11 Feb 2019 00:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com> <20190210225114.20110-2-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-2-stuart.menefy@mathembedded.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 09:47:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdNLd5MeFXa9bht4hzN8u+dMq=0GiWhhOShpUArS6RLtA@mail.gmail.com>
Message-ID: <CAJKOXPdNLd5MeFXa9bht4hzN8u+dMq=0GiWhhOShpUArS6RLtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: exynos_mct: Move one-shot check from
 tick clear to ISR
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When a timer tick occurs and the clock is in one-shot mode, the timer
> needs to be stopped to prevent it triggering subsequent interrupts.
> Currently this code is in exynos4_mct_tick_clear(), but as it is
> only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
> leaving exynos4_mct_tick_clear() just doing what its name suggests it
> should.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/clocksource/exynos_mct.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
