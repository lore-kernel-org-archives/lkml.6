Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeERMT1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:19:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36627 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:19:24 -0400
X-Google-Smtp-Source: AB8JxZr+Hf5WvncioyjfAVAuacXNp7Pwa0NM33Begj16rIoghS8vJC/OAcNYmvdwMYW28FM+BKM897eXvOqQJojvSu4=
MIME-Version: 1.0
In-Reply-To: <20180517.163113.2110198960037727630.davem@davemloft.net>
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com> <20180517.163113.2110198960037727630.davem@davemloft.net>
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Date: Fri, 18 May 2018 14:18:41 +0200
Message-ID: <CAPoXtQJJ-Fv6dBWxFs+r+B-+jhQAF+AxdqDg9g55AwSyBJ0U6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
To: David Miller <davem@davemloft.net>
Cc: "Tobin C. Harding" <tobin@apporbit.com>,
        Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 10:31 PM, David Miller wrote:
> From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
> Date: Thu, 17 May 2018 15:05:29 +0200
>
>> + /* Will be set by userspace during if setup */
>> + dev->dev_addr[0] = 0;
>
> Hmmm... really?
>
> Also, every error path from this point forward will leak 'dev'.
>

In com20020.c found this:
/* FIXME: do this some other way! */
if (!dev->dev_addr[0])
dev->dev_addr[0] = arcnet_inb(ioaddr, 8);

NODE-ID, must be univoque, for all arcnet network.
My previews idea was take random value but, this could create a
collision over network.

A possible solution is:
In case of collision com20020 set a bit in status register.
Then peak a new NODE-ID and repeat this while correct NODE-ID is found.

Other ideas is pass it via DTS.
But suppose have 2 same product in same network, same address same problem.
For this reason i prefer left standard driver behavior.

Other ideas for solve this ?

Other question discussed with Tobin in RFC patch is:

At now a devm_ioremap is done by this driver.

Other version of this driver, PCI, PCMCIA, ISA do not remap memory.
Other implementation, use:inb outb for r/w operation.
I do a ugly #ifndef and redefine arcnet_inb in case is defined
CONFIG_ARCNET_COM20020_IO.

My proposal was:
Add relative callback arcnet_inb, arcnet_outb and friends hw struct in
arcdevice.h, then every driver set callback with required function.

Regards, Andrea
