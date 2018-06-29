Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4656224BF4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQttAyqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4656224BF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeF2H7I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:59:08 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51994 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933734AbeF2H7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:59:06 -0400
Received: by mail-it0-f67.google.com with SMTP id o5-v6so635474itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXCO7/yQD+VI9hL384NqMpogBCBFgFrMwMVukmefEG8=;
        b=bQttAyqbvmxpYBYcGdgpvNUWRiza0u2ncyhM0Y3USuqqfCEgTvv/HVNFPPeUnIGkDD
         F8HpW5nOjbJRY1ZjUceYBgHnRZf/6IPFQ/90PMwm+24kD2el9uTECBjWKPHKkNPFKfcU
         mgaR2abmlxVT4nCHO6Yazn/KVWB93ZDOwPyXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXCO7/yQD+VI9hL384NqMpogBCBFgFrMwMVukmefEG8=;
        b=t/OmLH7tvCxOijB5Xx6t+2WpwAIIKMPfHLO5UgmmbQgmR9HmqKXNFHbD6Hx/iUPCWT
         5o8O+Pz6enuT0WsA6q7Xg36Sg/Fm0NnBl04iwUeVe5+reljreacSQAepsToIAohEk1g6
         Zz4+eaPzVQIuC52LChKM0GS7HAcXz5hpEUiVwYwIvy9jAtSx54U2CLyRWzvLYJzFddEW
         ZKoVelS/Zgm7kGnwJTqIcajS3L2M5h4Fb5E4+JSJLamZxtQLYKiS2OF1tR6ATm7vHVli
         VwLnHflHvMPtRcAVKZtMn9nxVpI5FP3wAm76N9vdjzUiFGJyIrxrbn309SuyzW8WhvvU
         LqfQ==
X-Gm-Message-State: APt69E2AThGI9szBM3ZcRvR/QFJY1t2/MkYkJKJq8m6ie2HOVvXZ7H4Z
        AQ87lHYo++EWxaxhbkO808J1YOcKnHO1z9VV9Z3Zqw==
X-Google-Smtp-Source: AAOMgpdBB8sBaC5fklh0PBHG1Y7tfGAv+ladFStBz75NPjOneQZjCnOx9bGXAfoSUolOrH7mx0NstQxmbrU3aCUxDx4=
X-Received: by 2002:a24:5593:: with SMTP id e141-v6mr898705itb.135.1530259145696;
 Fri, 29 Jun 2018 00:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180619234349.166190-1-evgreen@chromium.org>
In-Reply-To: <20180619234349.166190-1-evgreen@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 09:58:54 +0200
Message-ID: <CACRpkdZCUnqLCP8Hr05_V_z+Tzw4Ke7c-DPbaLmhjzJJYGX-1w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
To:     evgreen@chromium.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 1:45 AM Evan Green <evgreen@chromium.org> wrote:

> The MSM pinctrl driver quietly swallows errors that occur
> when trying to call .irq_set_wake. It should instead pass
> those failures up the chain so the caller can react to them.
> Swallowing the error for instance causes gpio_keys to think that
> it was able to successfully set a wake IRQ, when in fact it may
> not have been, causing the following warning on resume:
>
> [   53.777819] Unbalanced IRQ 9 wake disable
> [   53.781979] WARNING: CPU: 0 PID: 1362 at kernel/irq/manage.c:623
> irq_set_irq_wake+0xac/0x12c
> [   53.794758] Modules linked in: spi_gpio spi_bitbang qcom_q6v5_pil
> qcom_common cfg80211 ip6table_filter smsc95xx usbnet mii
> [   54.016419] [<ffffff80081054b0>] irq_set_irq_wake+0xac/0x12c
> [   54.022252] [<ffffff80083c86a4>] msm_gpio_irq_set_wake+0x48/0x68
> [   54.028447] [<ffffff8008104d8c>] set_irq_wake_real+0x50/0x5c
> [   54.034275] [<ffffff80081054d0>] irq_set_irq_wake+0xcc/0x12c
> [   54.040104] [<ffffff800860fd00>] gpio_keys_resume+0x74/0xd8
> [   54.045846] [<ffffff800852018c>] platform_pm_resume+0x54/0x60
> [   54.051771] [<ffffff800852ceb4>] dpm_run_callback+0x104/0x210
> [   54.057694] [<ffffff800852d7cc>] device_resume+0x178/0x1b0
> [   54.063355] [<ffffff800852e938>] dpm_resume+0x1c4/0x38c
> [   54.068745] [<ffffff800852efac>] dpm_resume_end+0x20/0x34
> [   54.074315] [<ffffff80080fe700>] suspend_devices_and_enter+0x518/0x964
> [   54.081044] [<ffffff80080ff1dc>] pm_suspend+0x690/0x6e0
> [   54.086433] [<ffffff80080fd0f8>] state_store+0xd4/0xf8
> [   54.091733] [<ffffff80088a3af0>] kobj_attr_store+0x18/0x28
> [   54.097396] [<ffffff80082980a4>] sysfs_kf_write+0x5c/0x68
> [   54.102961] [<ffffff8008297050>] kernfs_fop_write+0x174/0x1b8
> [   54.108887] [<ffffff800821a9c0>] __vfs_write+0x58/0x160
> [   54.114276] [<ffffff800821acd4>] vfs_write+0xcc/0x184
> [   54.119487] [<ffffff800821af4c>] SyS_write+0x64/0xb4
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Bj=C3=B6rn is this patch OK with you? Seems fine to me.

Yours,
Linus Walleij
