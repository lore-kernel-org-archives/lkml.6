Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeBTR7A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:59:00 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36262 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBTR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:58:58 -0500
X-Google-Smtp-Source: AH8x224DsY4MBPJKcEuencdTiTn7QBDUWQ70JCXYmqqKIh2D+yseQf80eqKEjRjY7PA9hBvV7+CGUqlJzUDVLGj9EuQ=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vck_8G=zTD4ftYC7yd+q_6XiXWvs+kX_zqr6bUtMUf4wg@mail.gmail.com>
References: <20180220150318.138827-1-delroth@google.com> <CAHp75Vck_8G=zTD4ftYC7yd+q_6XiXWvs+kX_zqr6bUtMUf4wg@mail.gmail.com>
From: "Pierre Bourdon (delroth)" <delroth@google.com>
Date: Tue, 20 Feb 2018 18:58:56 +0100
Message-ID: <CANEr7oWE7Po4ReN8+oX4CEzrbjmnhSJpwmfgjyidB6dqP0m8Gg@mail.gmail.com>
Subject: Re: [PATCH] max17042: propagate of_node to power supply device
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andre Heider <a.heider@gmail.com>, Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 6:34 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 20, 2018 at 5:03 PM, Pierre Bourdon <delroth@google.com> wrote:
>> max17042_get_status uses the core power_supply_am_i_supplied. That
>> function relies on DT properties to figure out the power supply
>> topology, and will error out without DT.
>
>> +       psy_cfg.of_node = dev->of_node;
>
> Perhaps do this in general manner, see how GPIOLIB takes care of it:
>
> $ git grep -n -A4 -w CONFIG_OF_GPIO -- drivers/gpio/gpiolib.c
> drivers/gpio/gpiolib.c:1161:#ifdef CONFIG_OF_GPIO
> drivers/gpio/gpiolib.c-1162-    /* If the gpiochip has an assigned OF
> node this takes precedence */
> drivers/gpio/gpiolib.c-1163-    if (chip->of_node)
> drivers/gpio/gpiolib.c-1164-            gdev->dev.of_node = chip->of_node;
> drivers/gpio/gpiolib.c-1165-#endif
> ...

Makes sense. From a quick look in existing drivers, it looks like the
only values being used currently as psy_cfg.of_node are the nodes from
the parent device, so it seems like it could be made generic.

Are we aware of any driver that is not propagating the of_node on
purpose? Is this something that should be supported? If not, I guess
we could get rid of power_supply_config.of_node and always use the one
from the parent device in __power_supply_register.

(I'm very new to this codebase, sorry for the possibly dumb questions!)

-- 
Pierre Bourdon (delroth@)
