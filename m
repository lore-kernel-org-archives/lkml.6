Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeDKIhE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:37:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34179 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeDKIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:36:59 -0400
X-Google-Smtp-Source: AIpwx48KmQpwWRS18EDsp4ECQnP/38LA17x3yci3qVgyrqnYv6bnhaRzE6KSt/OE9W5ZHXu6T7uoLpDTK2Co9Vrxg5o=
MIME-Version: 1.0
In-Reply-To: <CA+Ln22Eabq0HH6YmCSFwLd68w3DU4xTX2BiNAeLe_tnG6282Xg@mail.gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com> <CA+Ln22Eabq0HH6YmCSFwLd68w3DU4xTX2BiNAeLe_tnG6282Xg@mail.gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Wed, 11 Apr 2018 17:36:57 +0900
Message-ID: <CA+Ln22FAmBHrxEvQpBPV1p=Kg2g+XCHn=HQJCNSUhFv+Jtf6xA@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B8bAUn001903

2018-04-10 17:38 GMT+09:00 Tomasz Figa <tomasz.figa@gmail.com>:
> 2018-04-10 16:06 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>> On Sun, Apr 8, 2018 at 8:07 PM, Paweł Chmiel
>> <pawel.mikolaj.chmiel@gmail.com> wrote:
>>> All banks with GPIO interrupts should be at beginning
>>> of bank array and without any other types of banks between them.
>>> This order is expected by exynos_eint_gpio_irq, when doing
>>> interrupt group to bank translation.
>>> Otherwise, kernel NULL pointer dereference would happen
>>> when trying to handle interrupt, due to wrong bank being looked up.
>>> Observed on s5pv210, when trying to handle gpj0 interrupt,
>>> where kernel was mapping it to gpi bank.
>>
>> Thanks for the patch. The issue looks real although one thing was
>> missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
>> Marek Szyprowski):
>>
>> 0x0 - EINT_23 - gpk0
>> 0x1 - EINT_24 - gpk1
>> 0x2 - EINT_25 - gpk2
>> 0x4 - EINT_27 - gpl0
>> 0x7 - EINT_8 - gpm0
>>
>> Maybe this should be done differently - to remove such hidden
>> requirement entirely in favor of another parameter of
>> EXYNOS_PIN_BANK_EINTG argument?
>
> Perhaps let's limit this patch to s5pv210 and Exynos5410 alone, where
> a simple swap of bank order in the arrays should be okay.
>
> We might also need to have some fixes on 4x12, because I noticed that
> in exynos4x12_pin_banks0[] there is a hole in eint_offsets between
> gpd1 and gpf0 and exynos4x12_pin_banks1[] starts with gpk0 that has
> eint_offset equal to 0x08 (not 0).

To close the loop, after talking offline and checking the
documentation, Exynos4x12 is fine, because the group numbers in SVC
register actually match what is defined in bank arrays.

Best regards,
Tomasz
