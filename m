Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002CAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7D62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz9728MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7D62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLKJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:32:40 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42448 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLKJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:32:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so8461843vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFTRYNH/uemX7W+T0FFPzR+3gEy7EW+TmKaAd7Nbgcg=;
        b=iz9728MIWNkugNQZajnrF2W/SJtUSODYXl+fw2R555Pk7ePU6OTF+tOofSV43AMHEa
         5oF0bBpT6hA+hcgT2ZltvM36/Y82EB2WpCmiPEtziC3A6FI3SAV1RRgHGVj/ADiVH0bj
         sfL9GHFac7NxCOnUbAUstOddyfb0ew9GnRE/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFTRYNH/uemX7W+T0FFPzR+3gEy7EW+TmKaAd7Nbgcg=;
        b=VkYVvjZj3rq61buU08eGJN8wIbtR5pFS2dMb0Sk83z6eMRybKqqwzllVBod2OSLIaz
         TAhaFk8vJel/FDxHv65j3CbWWpku0V9+pFW0BzAQecLJIvLZXR4ICSHG73LVhESLxwow
         hHTOE9VVQ7/OowgikhOqbr8iwAHcTsyIMt/DsmHmJIIx/8dMu8qX6zv+h7hI/KTR0uLF
         YneD004nPjxAyFCtd1zFf411dzdrsUIsluYHKoYrFnXPfyJux1AIU9PCbtOkiKb6/xAN
         gF/njoOwyV45aEVyof/Kdvdn/V1aVZBZUhjrhHobnwGqlW5isdUFQFOoOy031fD29Asd
         jf0Q==
X-Gm-Message-State: AA+aEWay1yEXGY7wz8ls4yv3ldKaO2tDlo3bfCBUmigRm7mz9Nnz8Hkd
        MD5oyVt8JNHhME9Pbbu6PfzopFGWiibwTk0wuKdgIw==
X-Google-Smtp-Source: AFSGD/VBbWfmjWQHPO2N2ypvxVD2cFOYDRMvPU5QSem1xKcDDccdcvtCRovUvOVA9zR1K1Ndnf4J+HAKJSHsmj9qhkk=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr6848245vsa.165.1544520758884;
 Tue, 11 Dec 2018 01:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20181206151828.24417-1-jbrunet@baylibre.com>
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:32:03 +0100
Message-ID: <CAPDyKFp8H6jW-d8b51F2CZvr04setP443YbjbJX7dDLbbAtfVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and improvements
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 16:18, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The goal of the patchset was mainly to address the following warning:
>
> WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
> Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
> Hardware name: Some A113 Board (DT)
> pstate: 40000085 (nZcv daIf -PAN -UAO)
> pc : meson_mmc_irq+0xc0/0x1e0
> lr : __handle_irq_event_percpu+0x70/0x180
> sp : ffff000008003980
> x29: ffff000008003980 x28: 0000000000000000
> [...]
> x1 : ffff80001a71bd40 x0 : 0000000000000000
> Call trace:
>  meson_mmc_irq+0xc0/0x1e0
>  __handle_irq_event_percpu+0x70/0x180
>  handle_irq_event_percpu+0x34/0x88
>  handle_irq_event+0x48/0x78
>  handle_fasteoi_irq+0xa0/0x180
>  generic_handle_irq+0x24/0x38
>  __handle_domain_irq+0x5c/0xb8
>  gic_handle_irq+0x58/0xa8
>
> This happens when using the chained descriptor mode. If there is an
> error, we call mmc_request_done(), loosing any reference to the cmd. It
> turns out that the chained descriptor does really stops when we do so, at
> least not completly. Most of the time, it can be seen with this harmless
> warning because the descriptor will raise another unexpected IRQ. On rare
> occasion, it will completly break the MMC.
>
> This is mostly adressed by patch #1.
> With this fixed, I took (yet) another look at the ultra-high speed modes
> and the tuning.
>
> I came up with new settings in patch 3 and 4. I've tested them on eMMC,
> sdcard and sdio on the following platforms:
>  * gxbb p200
>  * gxl p230, libretech (eMMC only), kvim.
>  * axg s400
>
> So far, these new settings seems to be working great but I think it
> would be nice if others could test this and provide their feedback.
> This why  patch 3 and 4 are RFT tagged.
>
> Jerome Brunet (4):
>   mmc: meson-gx: make sure the descriptor is stopped on errors
>   mmc: meson-gx: remove useless lock
>   mmc: meson-gx: align default phase on soc vendor tree
>   mmc: meson-gx: add signal resampling
>
>  drivers/mmc/host/meson-gx-mmc.c | 100 ++++++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 25 deletions(-)
>

Following Kevin's approach, applied for next to get this tested, thanks!

Kind regards
Uffe
