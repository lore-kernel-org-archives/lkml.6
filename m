Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeCUPoC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:44:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35105 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeCUPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:43:28 -0400
X-Google-Smtp-Source: AIpwx48Sw8svenO4+TdW98oksMvAnm+nTxfcXgym8vGH1NeE9iKrgsMFVdayL37ixgWgEKn52nMX5pWY6ZjlOlUs1dA=
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Mar 2018 16:43:26 +0100
X-Google-Sender-Auth: ywoXyP3sELnFZlb5sM9VgHq_lqk
Message-ID: <CAMuHMdW+OzGYK7zj+-jWmZwMcve7=C5gGamgH9jmdgqJ7NC7Vg@mail.gmail.com>
Subject: Use after free with pinctrl_enable() and devm_pinctrl_register_and_init()
To: Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Tony,

If claiming hogs failed, pinctrl_enable() frees the pctldev, and
destroys its mutex.

However, if the pin controller is registered using
devm_pinctrl_register_and_init(), device resource management will call
pinctrl_unregister() later.  This will access the destroyed pctldev,
which may crash the system.

With poisoning enabled (CONFIG_DEBUG_SLAB=y), the crash is imminent:

    sh-pfc e6050000.pin-controller: function 'foo' not supported
    sh-pfc e6050000.pin-controller: invalid function a in map table
    sh-pfc e6050000.pin-controller: error claiming hogs: -22
    sh-pfc e6050000.pin-controller: could not claim hogs: -22
    Unhandled fault: alignment exception (0x001) at 0x6b6b6c2f
    pgd = 581794e0
    [6b6b6c2f] *pgd=00000000
    Internal error: : 1 [#1] SMP ARM
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.16.0-rc5-kzm9g-00484-gb3469948b11d02a0-dirty #1043
    Hardware name: Generic SH73A0 (Flattened Device Tree)
    PC is at __lock_acquire+0xd8/0x1bf0
    LR is at lock_acquire+0x98/0xb8
    pc : [<c016fc84>]    lr : [<c0171f80>]    psr: 20000093
    sp : df441be8  ip : df441c80  fp : 00000000
    r10: 00000000  r9 : 00000001  r8 : 00000000
    r7 : 00000000  r6 : c1084170  r5 : df5586e8  r4 : df43e040
    r3 : 6b6b6c2f  r2 : 6b6b6b6b  r1 : 00000000  r0 : 6b6b6b6b
    Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5387d  Table: 4000404a  DAC: 00000051
    Process swapper/0 (pid: 1, stack limit = 0x2557051f)
    Stack: (0xdf441be8 to 0xdf442000)
    ...
    [<c016fc84>] (__lock_acquire) from [<c0171f80>] (lock_acquire+0x98/0xb8)
    [<c0171f80>] (lock_acquire) from [<c0598888>] (__mutex_lock+0x7c/0x9ec)
    [<c0598888>] (__mutex_lock) from [<c0599210>] (mutex_lock_nested+0x18/0x20)
    [<c0599210>] (mutex_lock_nested) from [<c034cd18>]
(pinctrl_unregister+0x48/0x158)
    [<c034cd18>] (pinctrl_unregister) from [<c03b3f30>]
(release_nodes+0x218/0x25c)
    [<c03b3f30>] (release_nodes) from [<c03b08ac>]
(driver_probe_device+0x200/0x318)
    [<c03b08ac>] (driver_probe_device) from [<c03aedd8>]
(bus_for_each_drv+0x90/0xb8)

My first idea was to add a !devres_find(pctldev->dev, devm_pinctrl_dev_release,
NULL, NULL) check to the error path of pinctrl_enable(), which seems
to work(TM).

However, that's still not 100% correct and sufficient:
  - pinctrl_unregister() will do some cleanup (pinctrldev_list and debugfs) that
    should not be done,
  - When using pinctrl_register() or devm_pinctrl_register(), and
    pinctrl_enable() fails, all other cleanup done in pinctrl_unregister()
    never happens.

Thoughts?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
