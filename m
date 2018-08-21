Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A496C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3220C0F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3220C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHUQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:08:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37666 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbeHUQIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:08:25 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fs655-0005sf-Si; Tue, 21 Aug 2018 14:48:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@collabora.com, Lee Jones <lee.jones@linaro.org>,
        cl@rock-chips.com
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Date:   Tue, 21 Aug 2018 14:48:19 +0200
Message-ID: <1691066.Iypvixkm4y@phil>
In-Reply-To: <20180814165059.13219-1-enric.balletbo@collabora.com>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. August 2018, 18:50:59 CEST schrieb Enric Balletbo i Serra:
> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

On a Rockchip rk3399-scarlet tablet
Tested-by: Heiko Stuebner <heiko@sntech.de>

This patch also _fixes_ the kernel bug below.

Scarlet is not yet submitted upstream, but when I remove
the brightness-levels and default-brightness-level properties
in my wip devicetree files to rely on the newly introduced
automatic level calculation, I end up with the following:

[  136.723586] Internal error: ptrace BRK handler: f20003e8 [#1] PREEMPT SMP
[  136.735920] Modules linked in: drm_panel_orientation_quirks pwm_bl(+) ip_tables x_tables ipv6 smsc95xx smsc75xx ax88179_178a asix usbnet phy_rockchip_pcie i2c_hid
[  136.752227] CPU: 5 PID: 1547 Comm: systemd-udevd Tainted: G        W         4.18.0-12611-g04bcfe5fee2d-dirty #1033
[  136.763916] Hardware name: Google Scarlet (DT)
[  136.763923] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  136.763943] pc : pwm_backlight_probe+0x610/0x850 [pwm_bl]
[  136.763958] lr : pwm_backlight_probe+0x108/0x850 [pwm_bl]
[  136.786349] sp : ffff00000a33b930
[  136.794421] x29: ffff00000a33b930 x28: ffff00000a33bdf0 
[  136.800373] x27: 0000000000000100 x26: ffff000000ada110 
[  136.806327] x25: 0000000000000000 x24: ffff000000ad9348 
[  136.806343] x23: ffff8000f1a3e400 x22: ffff000008e29000 
[  136.818239] x21: ffff8000f1a3e410 x20: ffff8000f097a798 
[  136.824189] x19: ffff00000a33b9a0 x18: 0000000000000000 
[  136.830137] x17: 0000000000000000 x16: 0000000000000000 
[  136.836156] x15: 0000000000000400 x14: 0000000000000400 
[  136.842104] x13: 0000000000000000 x12: 0000000000000001 
[  136.848052] x11: 0000000000000003 x10: 0101010101010101 
[  136.855639] x9 : fffffffffffffffd x8 : 7f7f7f7f7f7f7f7f 
[  136.861588] x7 : 0000000000000000 x6 : 0000000000000005 
[  136.867727] x5 : ffff8000f150c900 x4 : ffff8000f1a3e610 
[  136.876571] x3 : ffff8000f097a880 x2 : 0000000000000000 
[  136.882519] x1 : ffff800016393500 x0 : 0000000000000000 
[  136.888481] Process systemd-udevd (pid: 1547, stack limit = 0x0000000095c9ae43)
[  136.888484] Call trace:
[  136.888498]  pwm_backlight_probe+0x610/0x850 [pwm_bl]
[  136.888523]  platform_drv_probe+0x50/0xa0
[  136.909550]  really_probe+0x1c8/0x2a0
[  136.914515]  driver_probe_device+0x58/0x108
[  136.919196]  __driver_attach+0xdc/0xe0
[  136.930103]  driver_attach+0x20/0x28
[  136.934286]  bus_add_driver+0x1b8/0x228
[  136.938580]  driver_register+0x60/0x110
[  136.942890]  __platform_driver_register+0x40/0x48
[  136.948172]  pwm_backlight_driver_init+0x1c/0x1000 [pwm_bl]
[  136.948187]  do_one_initcall+0x5c/0x180
[  136.958709]  do_init_module+0x58/0x1b0
[  136.962905]  load_module+0x1bfc/0x2200
[  136.967104]  __se_sys_finit_module+0xc0/0xd8
[  136.971967]  __arm64_sys_finit_module+0x14/0x20
[  136.977038]  el0_svc_common+0x60/0xe8
[  136.981136]  el0_svc_handler+0x24/0x88
[  136.985333]  el0_svc+0x8/0xc
[  136.988558] Code: 95eb49f6 17ffff25 9101c3b3 17fffe8d (d4207d00) 
[  136.995379] ---[ end trace 0f7902d334b84f12 ]---


