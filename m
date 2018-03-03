Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeCCTH7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 14:07:59 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:37965 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeCCTH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 14:07:57 -0500
X-Google-Smtp-Source: AG47ELtmvJBaciTdiyUiMKG2xQz8BqGzw8EElR4LNzeQE+KV8Wr1QSdKmV256VjMSrul+NS/dsTi3g==
Subject: Re: lost interrupts when running sabrelite images (v4.15+) in qemu
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fugang Duan <fugang.duan@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180303163236.GA29514@roeck-us.net>
From: Troy Kisky <troy.kisky@boundarydevices.com>
Message-ID: <88917ab4-ade0-dcfc-e81a-eeaa8a4d15b8@boundarydevices.com>
Date: Sat, 3 Mar 2018 11:07:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303163236.GA29514@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/2018 8:32 AM, Guenter Roeck wrote:
> Hi,
> 
> since v4.15, I get the following runtime warning when running sabrelite images
> in qemu.
> 
> irq 65: nobody cared (try booting with the "irqpoll" option)
> ...
> handlers:
> [<26292474>] fec_pps_interrupt
> Disabling IRQ #65
> fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
> 
> Bisect points to commit 4ad1ceec05e491 ("net: fec: Let fec_ptp have its
> own interrupt routine"). Analysis shows that platform_irq_count()
> returns 2, which is reduced to 1 by fec_enet_get_irq_cnt().
> If I let fec_enet_get_irq_cnt() return 2, the problem is gone.
> Reverting commit 4ad1ceec05e491 also fixes the problem.
> 
> Bisect log is attached.
> 

Sounds like you found a bug with qemu. I just booted sabrelite over nfs fine.
My interrupts look like this.


 64:      98767          0          0          0     GIC-0 150 Level     2188000.ethernet
 65:          0          0          0          0     GIC-0 151 Level     2188000.ethernet
___________
Irq 65 is only for ptp interrrupts now. If qemu is signaling an tx/rx frame interrupt on 65,
then qemu is wrong. Of course, I've never used qemu so feel free to ignore me if I make no sense.


BR
Troy
