Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC6921B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898576;
	bh=/xP+Ntx5P4d7nqleI3PqSgm1nmYTUUX1l6gOgdG5LRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ssh1EzgnRtDdYCWXLWX435uYPhR0ZWqfLZXlt0etAxmzZRfJylQiitr0aB3Qe2BhB
	 Gf7OglMSBoGOJYK0Dr2pXjc9ZkLaMd31bZyBvCgTt1JvdqXTfl0SuCv/y5+n7FSRp8
	 vv+80DNgtFLIj+KrCkNcTApy7pS8ZbhYBjFgK+xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfBKPWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390651AbfBKPDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:35 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2ED222A7;
        Mon, 11 Feb 2019 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897415;
        bh=/xP+Ntx5P4d7nqleI3PqSgm1nmYTUUX1l6gOgdG5LRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JjY2SKYKjDxVGDhoYJaQu1ZCanZrhnKXGAwpyNwBYN5V9/Un1incj8Elda5rHpMZl
         yZi8rBI7HahFe+RDwh7XUB4xZRC1VEyIXetQFFU1JanbOnlzvrncrP5mN6WpZmg2qy
         xI5Avo60jFia5bUPyKgoNuXe+KV/giLpzgxkCrPs=
Received: by mail-lj1-f175.google.com with SMTP id j13-v6so9048237ljc.2;
        Mon, 11 Feb 2019 07:03:34 -0800 (PST)
X-Gm-Message-State: AHQUAubpgjFLNzseLFq3GzrAHMYdbCdiJz8OSC4ed3ozDB+Gba6xTlIE
        RGox4nhrzUBEUhYTD5gFRVKIPs9ku40qI1bhLLw=
X-Google-Smtp-Source: AHgI3IZEgvhz62lw9sZjhRRhNnwEkZo9DOqUJpf2nBGYjnGQlLZFVRfflzEkrOpl8MV28bUTa2tRXccpBB0VoO/2ACI=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr22322354lji.112.1549897413026;
 Mon, 11 Feb 2019 07:03:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-5-s.nawrocki@samsung.com>
 <CAJKOXPdar1q8oz4KHEVoQ6_NbD+hUYfFE3u97VLGUV7azEnZwA@mail.gmail.com> <62ea88ed-6916-f7a5-6806-6b9c5ba08f13@samsung.com>
In-Reply-To: <62ea88ed-6916-f7a5-6806-6b9c5ba08f13@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 16:03:21 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfYxbAKCBOXTmsGnprksSGrZGyHGrtn75rO46QMLZDzrw@mail.gmail.com>
Message-ID: <CAJKOXPfYxbAKCBOXTmsGnprksSGrZGyHGrtn75rO46QMLZDzrw@mail.gmail.com>
Subject: Re: [PATCH 04/22] ASoC: samsung: i2s: Fix prescaler setting for the
 secondary DAI
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 15:32, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 2/11/19 14:37, Krzysztof Kozlowski wrote:
> >> @@ -784,6 +787,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
> >>         i2s->frmclk = params_rate(params);
> >>
> >>         rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
> >> +       if (!rclksrc || IS_ERR(rclksrc))
>
> > IS_ERR_OR_NULL
>
> Thanks for your review! That line will be removed by subsequent patch
> (7/22) so I'd say such a change wouldn't make a difference anyway.

Then let's skip it:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
