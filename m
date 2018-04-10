Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeDJHGb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeDJHG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:06:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8812C217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx49Fbi8ZypWHSSB7HRW64NuqOvPXSzBkZ3J2rIStonqhV3YHw2w7Fk2xxbsnZ1RkMIe525l3eM2jXhO64Hx0+HI=
MIME-Version: 1.0
In-Reply-To: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 10 Apr 2018 09:06:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
Message-ID: <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/samsung: Correct EINTG banks order
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>, linus.walleij@linaro.org,
        kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 8:07 PM, Paweł Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
> All banks with GPIO interrupts should be at beginning
> of bank array and without any other types of banks between them.
> This order is expected by exynos_eint_gpio_irq, when doing
> interrupt group to bank translation.
> Otherwise, kernel NULL pointer dereference would happen
> when trying to handle interrupt, due to wrong bank being looked up.
> Observed on s5pv210, when trying to handle gpj0 interrupt,
> where kernel was mapping it to gpi bank.

Thanks for the patch. The issue looks real although one thing was
missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
Marek Szyprowski):

0x0 - EINT_23 - gpk0
0x1 - EINT_24 - gpk1
0x2 - EINT_25 - gpk2
0x4 - EINT_27 - gpl0
0x7 - EINT_8 - gpm0

Maybe this should be done differently - to remove such hidden
requirement entirely in favor of another parameter of
EXYNOS_PIN_BANK_EINTG argument? Anyway if such hidden requirement
stays, then please document it in the source code (it maybe next to
PIN order... or next macro... or also in exynos_eint_gpio_irq()).

Beside that please add cc-stable and appropriate fixes tag,

Best regards,
Krzysztof
