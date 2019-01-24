Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95510C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C75221872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAXI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:57:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36628 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:57:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so3935621edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+Ga4HcAj4PEPantT0zK17Jzcxuvsr4InP65q9Oyi8o=;
        b=K0H5TvhQeAR+UO2Xo/B/D8BWgf2frQOCopu0YRjZVnOrf9umwMzTVWUpM1QOvSLjnE
         r/qU+65H0uaHTD3jug9kyeXEZm0v/F5ELIhNYd8ZXqMukW8OheSjFdYQ/2kr26LJvAjy
         3xTF6sFzZgPQbRIzawVShVwX4MezMDxoV88oLtnZ7TX+GYOogEpm6IuSlOg9VRggkO23
         TiRnOuzLcPW1phdr4iE3puN9/WbLDnmqMV3BcC+YxgI5NCIWhg1IjzzCak7azOM+rwWx
         khOrrgTJg/D+rKvrpWH8OtZQFC9EjjQ5c0EIrFhVGaXpgTAd74qEEQCsFpKrs3kob07s
         KAwA==
X-Gm-Message-State: AJcUukfBf0xL38q34/ks9AP8zJP6KzY+r08ZpWbtKh6NsKDJmZX/cvGc
        WQl9fK0vbEStuEU+Rq0l52RKWlVP6+c=
X-Google-Smtp-Source: ALg8bN7PvcLH8tzcGbMS1suO+kw0Yu1lvVP+v8vfUR9cJHVnal49JKHwmVanfx0rEDutEzcfSMEArQ==
X-Received: by 2002:a50:a5b8:: with SMTP id a53mr6004119edc.199.1548320226515;
        Thu, 24 Jan 2019 00:57:06 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id r8sm10372051edo.11.2019.01.24.00.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:57:06 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id y185so1805025wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:57:05 -0800 (PST)
X-Received: by 2002:a1c:578e:: with SMTP id l136mr1631590wmb.124.1548320225556;
 Thu, 24 Jan 2019 00:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20190110062207.18787-1-wens@csie.org> <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
In-Reply-To: <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 24 Jan 2019 16:56:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Message-ID: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is unavailable
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 5:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/01/2019 07:22, Chen-Yu Tsai wrote:
> > If the clock tree is not fully populated when the timer-sun5i init code
> > is called, attempts to get the clock rate for the timer would fail and
> > return 0.
> >
> > Make the init code for both clock events and clocksource check the
> > returned clock rate and fail gracefully if the result is 0, instead of
> > causing a divide by 0 exception later on.
> >
> > Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Applied thanks.

I'm not seeing this in linux-next, nor the patch

    arm64: arch_timer: Workaround for Allwinner A64 timer instability

Any idea where these ended up?


Thanks
ChenYu
