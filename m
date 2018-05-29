Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935404AbeE2Ob3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:31:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39538 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeE2ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:31:21 -0400
X-Google-Smtp-Source: ADUXVKJYWaIDV32X+3CkXIvjA9BNFBNSoqBxH2x+epGuAKvhEIjIlq2kV4zA4UvKUYhl3JLe9lWpoeKzPnxbPMoc4Lo=
MIME-Version: 1.0
In-Reply-To: <3b99eb56-f303-98b8-cb1e-7ff134769c43@ti.com>
References: <20180528155059.2736080-1-arnd@arndb.de> <3b99eb56-f303-98b8-cb1e-7ff134769c43@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 16:31:19 +0200
X-Google-Sender-Auth: CDATOi89P7vd4QylhKTmPkTiqIw
Message-ID: <CAK8P3a2-421Y3Hwcu0SG0rORhO-wF06ULTJSAMrNypivS1PJjQ@mail.gmail.com>
Subject: Re: [PATCH] net: davinci: fix building davinci mdio code without CONFIG_OF
To: Sekhar Nori <nsekhar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 3:25 PM, Sekhar Nori <nsekhar@ti.com> wrote:

>> @@ -374,7 +372,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
>>               return -ENOMEM;
>>       }
>>
>> -     if (dev->of_node) {
>> +     if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>>               const struct of_device_id       *of_id;
>>
>>               ret = davinci_mdio_probe_dt(&data->pdata, pdev);
>
> I was expecting this one change to fix the issue since the if() block
> should be compiled away removing references to davinci_mdio_probe_dt().
>
> The code does get compiled out and there are no references to
> davinci_mdio_probe_dt() in the final object when !CONFIG_OF.
>
> But the compile error remains if the #ifdefs you removed above are
> installed back. Not sure why.

The way that "if (IS_ENABLED())" works, everything gets compiled at
first, but then the compiler uses dead code elimination to remove it
from the output after verifying that everything builds.

       Arnd
