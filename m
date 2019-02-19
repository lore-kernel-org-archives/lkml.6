Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B950CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874C621738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550590836;
	bh=rAxdQaZtbKqLU4Cc11ZDquT7sjdym3NIpkZjW5UgdpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DoL/0/ngVeMjhHTdkTc2KF4paoBjDh9nb088GZL3NXAK+npkMCaK5yy409cbRPrKf
	 yPoUW79J2y3blsHzqUb9diBs9dWXRgfn9FFmxO0Bl7K1gf5QM6S13eZRgBvTY1XkBx
	 NfqcE5PVNfyrU2JTNB+qT2IHit1Bw7rKiIt7eo0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfBSPke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBSPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:40:34 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56450217D7;
        Tue, 19 Feb 2019 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550590833;
        bh=rAxdQaZtbKqLU4Cc11ZDquT7sjdym3NIpkZjW5UgdpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b3RpLfj681PGohzPt6vJjLGMwmFa1f+ob72jvtuOVIcHas3IBPUmoAvHSWQilPzQl
         RsFKRH5JKcb9GV0CEjX9FRB0WMi1Qbp2Ifif72TL4q3DjOEbmTAQ6iyaSU3KJn8Orp
         6DJHIB0itIjSyTutDRm1b1UyE9pmvtpjdEAS1U7s=
Received: by mail-lj1-f178.google.com with SMTP id a17so1509391ljd.4;
        Tue, 19 Feb 2019 07:40:33 -0800 (PST)
X-Gm-Message-State: AHQUAuajj0EKZD4HB3Hp8nKghK3Oh8LUyczlsGUJyTC7ZOcpCoOI2ByM
        cyGHfGkX6ZG3IhkZcmTZOB25fktaTpGRlEsJDmc=
X-Google-Smtp-Source: AHgI3IYAADpubYwuwMQUvStHSeRaOG2mRENJE1em1NGsIcbDNJIVm7FrqfxomcY68NSZjfbakzX+4pLzcwKulELo/qQ=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr15429725lja.19.1550590831422;
 Tue, 19 Feb 2019 07:40:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190219152012epcas1p4df1d6e4f6439ab05de95c089a4416e06@epcas1p4.samsung.com>
 <20190219151941.9795-1-s.nawrocki@samsung.com>
In-Reply-To: <20190219151941.9795-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 19 Feb 2019 16:40:20 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdZP1XjkT2GQpy1PS4ToYtz_H-2c2a04pErCwLKaJi1cQ@mail.gmail.com>
Message-ID: <CAJKOXPdZP1XjkT2GQpy1PS4ToYtz_H-2c2a04pErCwLKaJi1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: samsung: i2s: Fix secondary platform device unregistration
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 16:20, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This fixes unregistration of the secondary platform device so all
> resources are properly released.  Additionally the removal sequence
> is corrected so it is in reverse order comparing to probe sequence.
> The test against NULL priv->pdev_sec is removed as it is not necessary.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - corrected order of calls on error path in probe() and in remove().
>
>  sound/soc/samsung/i2s.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
