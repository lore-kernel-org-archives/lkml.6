Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B9D223E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBHG/bkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B9D223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHJJlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:41:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40891 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:41:44 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so1405480ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YQ1mvc3fpLCYZ1k9LMumyPnyEEMxxI7a897RhpnxXLU=;
        b=jBHG/bkX3e6KHpGd6oXgTfbi6R2QBozPot5oBqgXMjnccn2SZmlKkvQ69xyRiRJsI2
         tdRgpF3DSw6Ct1rpuJSocQsqcafRDkyta+RGiNir8E9Zh2Jka08aMwU48D4NFhimUHnV
         Bnr8sKzxutA3cEVII4cRmomFhf3p2DBChOCzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YQ1mvc3fpLCYZ1k9LMumyPnyEEMxxI7a897RhpnxXLU=;
        b=SqVW7IA0RFS3sY100z9lQHpo3vEXCUiCRxrfcfMDYllq5S+2UcVA1YrhCtGoCg3bRx
         bTWsbp6AhybuoHN5EXMle3Nct4L2L0Wuz7bbegZ3MoV6ajX1F4rkSZ3rkJwF3X/LujPo
         njE9GxKed+wbvZCsuQL//A66ZI7V5X+ZtdrEE+xx5Ghwnns+MxqHfr8/a7dVfUt0uTcP
         jXGoYbevGuQde3lc+uBDI6Xm7SqhyStr0SPJ8FZ86TMioSHOMUXCfK/41k64A7KHeZ1z
         GUBOzdXx1h59c0O2duMrUZirKi1BqUxel8ZBjRSh1ENldc4K1AW7o3PN1ioVYj0yM9Jk
         jiSQ==
X-Gm-Message-State: AOUpUlGSiJ0Y7jT0CPjcmkl36q47mxRpDpLye2om6EWKLrGLRqBB74Rx
        s35GlrdTuUVY0QZwFcBWJckgCfB2QKMKsaFF3albYA==
X-Google-Smtp-Source: AA+uWPytdZ1hBEp03qLh1VYECiOKg4OHxWivy/F+iAoVHXUdp+NBoDmczDIlU6EQmJvJnLb5xD1fT1mv9IjDx/bX+GY=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr1141991itb.8.1533885190645;
 Fri, 10 Aug 2018 00:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com>
In-Reply-To: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Aug 2018 09:12:59 +0200
Message-ID: <CAKfTPtD_O9aDG=r7f2nCXteHsjNwxdD2Nrthv1TwkPw0O8NYtQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix compiling warring in smp=n case
To:     douly.fnst@cn.fujitsu.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dou,

On Fri, 10 Aug 2018 at 04:35, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
> When compiling kernel with SMP disabled, the build warns with:
>
> kernel/sched/core.c: In function =E2=80=98update_rq_clock_task=E2=80=99:
> kernel/sched/core.c:139:17: warning: unused variable =E2=80=98irq_delta=
=E2=80=99 [-Wunused-variable]
>   s64 steal =3D 0, irq_delta =3D 0;
>
> Fix this by revert the HAVE_SCHED_AVG_IRQ to
>
>   defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACC=
OUNTING)
>
> Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()=
")
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Acked-by: Vincent Guitttot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c45de46fdf10..ef954d96c80c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -177,7 +177,7 @@ static void update_rq_clock_task(struct rq *rq, s64 d=
elta)
>
>         rq->clock_task +=3D delta;
>
> -#ifdef HAVE_SCHED_AVG_IRQ
> +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_=
ACCOUNTING)
>         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>                 update_irq_load_avg(rq, irq_delta + steal);
>  #endif
> --
> 2.14.3
>
>
>
