Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeEKLhk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:37:40 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:38733 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeEKLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:37:39 -0400
X-Google-Smtp-Source: AB8JxZor9at2T+M27SZAVwv6+iioDtf8XQZgvrnHzNwPsNia/NBshB6sEJo5+lCGxWj4QrIjIPiWlAwTBLBO76dAebk=
MIME-Version: 1.0
In-Reply-To: <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
References: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
 <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com> <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 11 May 2018 17:07:37 +0530
Message-ID: <CAOuPNLgbT59h=Jm5YiOCbrqFkDokJ8xutQ_OkpsFYzKazKhTHg@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To: open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need one help.
I am using i.MX7 Sabre board with kernel version 4.1.15

Let's say I am interested in GPIO number: 21
I wanted to set CPU affinity for particular GPIO->IRQ number, so I
tried the below steps:
root@10:~# echo 21 > /sys/class/gpio/export
root@10:~# echo "rising" > /sys/class/gpio/gpio21/edge
root@10:~# cat /proc/interrupts | grep 21
  47: 0 0 gpio-mxc 21 Edge gpiolib
root@10:~# cat /sys/class/gpio/gpio21/direction
in
root@10:~# cat /proc/irq/47/smp_affinity
3
root@10:~# echo 2 > /proc/irq/47/smp_affinity
-bash: echo: write error: Input/output error

But I get input/output error.
When I debug further, found that irq_can_set_affinity is returning 0:
[    0.000000] genirq: irq_can_set_affinity (0): balance: 1,
irq_data.chip: a81b7e48, irq_set_affinity:   (null)
[    0.000000] write_irq_affinity: FAIL

I also tried first setting /proc/irq/default_smp_affinity to 2 (from 3).
This change is working, but the smp_affinity setting for the new IRQ
is not working.

When I try to set smp_affinity for mmc0, then it works.
# cat /proc/interrupts | grep mmc
295:         55          0     GPCV2  22 Edge      mmc0
296:          0          0     GPCV2  23 Edge      mmc1
297:         52          0     GPCV2  24 Edge      mmc2

root@10:~# echo 2 > /proc/irq/295/smp_affinity
root@10:~#


So, I wanted to know what are the conditions for which setting
smp_affinity for an IRQ will work ?

Is there any way by which I can set CPU affinity to a GPIO -> IRQ ?
Whether, irq_set_affinity_hint() will work in this case ?


Thanks,
Pintu
