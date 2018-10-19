Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73703ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFB621479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kotYoO85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFB621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSPs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:48:25 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93EF21480;
        Fri, 19 Oct 2018 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539935012;
        bh=5Ikn6AowIbZkyZD53B/fwsXIGp9LUJG9oNN3UCbuYTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kotYoO85DMD55zi7mqX/G2d/rbeaQVQI9z8R+Pvux0RlCqIH8xHw3GUv1mxJ8Rr30
         2XZlKhWv8zvjLzU/6kh7rc+F67hOA8DtCWy7x3qqAQWVEWnq2BQgk0xzFVqHz/+I8v
         6rTgFeB5+s5YKo/5hpErU+z04ZLSKFGzqgcrY3UA=
Received: by mail-lf1-f52.google.com with SMTP id x24-v6so8767724lfe.5;
        Fri, 19 Oct 2018 00:43:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoiML+xK7J2AuMAFAeHFp20qIkTr4HSDqmXoQ+vHjWIK1EnqWl1g
        bK9FC2XC8MfwijreHo3w1MBws4G/L0SsaeKgIE4=
X-Google-Smtp-Source: ACcGV60LVVVEecbcRnEPXlABDUD3lvw8tQeuJaagznT8Ev4Yx1ghwvFVqubVWAx/6Y+l81rBefq/R+xwOnDwJ2o5g1Y=
X-Received: by 2002:a19:aa8b:: with SMTP id t133-v6mr2239901lfe.92.1539935009741;
 Fri, 19 Oct 2018 00:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181018095717eucas1p2c89f6e71642e6db62676e1af5514529f@eucas1p2.samsung.com>
 <20181018095708.1527-1-m.szyprowski@samsung.com> <20181018095708.1527-4-m.szyprowski@samsung.com>
In-Reply-To: <20181018095708.1527-4-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 19 Oct 2018 09:43:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc=eNjk+9F3TE5S_Ci2ztuSXGJxdahgWOGamz9rGJO0xg@mail.gmail.com>
Message-ID: <CAJKOXPc=eNjk+9F3TE5S_Ci2ztuSXGJxdahgWOGamz9rGJO0xg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] clocksource: exynos_mct: Refactor resources allocation
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 11:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Move interrupts allocation from exynos4_timer_resources() into separate
> function together with the interrupt number parsing code from
> mct_init_dt(), so the code for managing interrupts is kept together.
> While touching exynos4_timer_resources() function, move of_iomap() to it.
> No functional changes.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 50 +++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 20 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
