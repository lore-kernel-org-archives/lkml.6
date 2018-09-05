Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE73C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20320857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZFRcdQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIESQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbeIESQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:16:45 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8695020857;
        Wed,  5 Sep 2018 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536155186;
        bh=iSuzQyl/6gmEtEttbIVROOZFt5p3dtvgWKo4PFkt3/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZFRcdQyHREFhiKzMKxH4ny3SNKl1XYRX7VTrWdQMcrycBgUqZUHEC+0e2W0FueJO
         jh9JqXkD5XKS2F9UI5Y9tCd38a2nvj/Bi+pVgq0CNU4wTbG0mIIBI+4/dCVRneVg7d
         sMWSr8Vr8wVj5dvrSKAZ46TxsTsxNM0YdcJ6+Y6s=
Received: by mail-wm0-f45.google.com with SMTP id o18-v6so7851618wmc.0;
        Wed, 05 Sep 2018 06:46:26 -0700 (PDT)
X-Gm-Message-State: APzg51BOp1go6iduLB9sQwhxrrm1N2O+T3I5cm99jHRCIn4WSbjzqVdv
        2FGatwrAptOpI6MTrGn0HgbQZdYhnUp4rOcViJg=
X-Google-Smtp-Source: ANB0VdZXgiwOGRDLJ1aRziom77iKDWCWLGIi+koPUFTlFQTSFqRu7yMSDq1baiLR3Vl5gusdWI64xBxmNiZoCPi/lm0=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr264226wme.135.1536155185081;
 Wed, 05 Sep 2018 06:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180905123053eucas1p196633ed9d661f79ed1c2e06a14a2b964@eucas1p1.samsung.com>
 <20180905123043.22604-1-m.szyprowski@samsung.com>
In-Reply-To: <20180905123043.22604-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Sep 2018 15:46:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeQh1_36RnjpfByszi4V6t+GmKNUeWh0QFn+JLovVSfeg@mail.gmail.com>
Message-ID: <CAJKOXPeQh1_36RnjpfByszi4V6t+GmKNUeWh0QFn+JLovVSfeg@mail.gmail.com>
Subject: Re: [PATCH] mfd: max8997: Disable interrupt handling for
 suspend/resume cycle
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, myungjoo.ham@samsung.com,
        lee.jones@linaro.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 at 14:32, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Disable IRQs during suspend/resume cycle to ensure handling of wakeup
> interrupts (i.e. RTC wake alarm) after max8997_resume(). This way it can
> be properly handled when I2C bus is finally available. This pattern is
> also used in other MAX PMIC MFD drivers.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/max8997.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index d1495d76bf2c..5a50ea976c70 100644
> --- a/drivers/mfd/max8997.c
> +++ b/drivers/mfd/max8997.c
> @@ -464,6 +464,7 @@ static int max8997_suspend(struct device *dev)
>
>         if (device_may_wakeup(dev))
>                 irq_set_irq_wake(max8997->irq, 1);
> +       disable_irq(max8997->irq);
>         return 0;
>  }
>
> @@ -474,6 +475,7 @@ static int max8997_resume(struct device *dev)
>
>         if (device_may_wakeup(dev))
>                 irq_set_irq_wake(max8997->irq, 0);
> +       enable_irq(max8997->irq);
>         return max8997_irq_resume(max8997);

Looks good except that here and in some existing drivers we do not
resume in reverse order of suspend. How about making it like in
drivers/mfd/max77843.c? It should not differ from functional point of
view, just logically it makes sense.

Best regards,
Krzysztof
