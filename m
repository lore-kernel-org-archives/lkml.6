Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDJIid (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:38:33 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:53897 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeDJIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:38:31 -0400
X-Google-Smtp-Source: AIpwx4/vZHwOZ3c7NnyRtkxlfyzeYFY6vltG+dwc1PrPXcNtr5MYtlC8Hz8f3QBAkST/vpiAKmFZoL+SjpcX/3B88sY=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Tue, 10 Apr 2018 17:38:29 +0900
Message-ID: <CA+Ln22Eabq0HH6YmCSFwLd68w3DU4xTX2BiNAeLe_tnG6282Xg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/samsung: Correct EINTG banks order
To: Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS"
        <linux-samsung-soc@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3A8cdbF005216

2018-04-10 16:06 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sun, Apr 8, 2018 at 8:07 PM, Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
>> All banks with GPIO interrupts should be at beginning
>> of bank array and without any other types of banks between them.
>> This order is expected by exynos_eint_gpio_irq, when doing
>> interrupt group to bank translation.
>> Otherwise, kernel NULL pointer dereference would happen
>> when trying to handle interrupt, due to wrong bank being looked up.
>> Observed on s5pv210, when trying to handle gpj0 interrupt,
>> where kernel was mapping it to gpi bank.
>
> Thanks for the patch. The issue looks real although one thing was
> missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
> Marek Szyprowski):
>
> 0x0 - EINT_23 - gpk0
> 0x1 - EINT_24 - gpk1
> 0x2 - EINT_25 - gpk2
> 0x4 - EINT_27 - gpl0
> 0x7 - EINT_8 - gpm0
>
> Maybe this should be done differently - to remove such hidden
> requirement entirely in favor of another parameter of
> EXYNOS_PIN_BANK_EINTG argument?

Perhaps let's limit this patch to s5pv210 and Exynos5410 alone, where
a simple swap of bank order in the arrays should be okay.

We might also need to have some fixes on 4x12, because I noticed that
in exynos4x12_pin_banks0[] there is a hole in eint_offsets between
gpd1 and gpf0 and exynos4x12_pin_banks1[] starts with gpk0 that has
eint_offset equal to 0x08 (not 0).

> Anyway if such hidden requirement
> stays, then please document it in the source code (it maybe next to
> PIN order... or next macro... or also in exynos_eint_gpio_irq()).
>
> Beside that please add cc-stable and appropriate fixes tag,

Agreed. Probably the only safe way of documenting this is to put it
inside each bank array, so that when someone creates a copy/paste for
new SoC, the comment is clearly visible... Perhaps something like:

/* Must start with EINTG banks, ordered by EINT group number. */

Best regards,
Tomasz
