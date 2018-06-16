Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1623A2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="fc8E551g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeFPLHb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 07:07:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:13904 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932513AbeFPLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 07:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529147243;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BMri6QwoPUoSJ8swsiEczDMflRcT+PJrVhvQ9D2OUnM=;
        b=fc8E551ghc0QPTGHPjACMkt8LU16VYJkoQdfxK/UWpT+id1lBMuzG1MhAVLA8I7lRK
        z9vUENSZF6J1SZcDAeZsGT/PnE8AvkeHybHwi8LYjv41Um2fSqwhyKsFIhdkZGTYCUUY
        peF12U/WOxoiqucuJo1PX9wW44Yb8hvRqh5MzS4TJ3uepKdMPgXtZGXyccc6aMXiz69j
        cMX0/jK4ZRG6U2PtqeNrzigAngYvH/PJ4B+froJFlEoD2viyXmzMP2mh/C4kkNHwscaN
        g0+0s50Jx28BOUlOu9EvMHCXezCb4xED9JfShUt609FB7ZFqgEF1hp6AwyB7iiLpMBMV
        +XFg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiuclqEj/wBQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5GB7D7gf
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 16 Jun 2018 13:07:13 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com>
Date:   Sat, 16 Jun 2018 13:07:12 +0200
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com> <20180614120157.GE112168@atomide.com> <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com> <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com> <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 15.06.2018 um 13:18 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Tony,
>=20
>> Am 15.06.2018 um 13:13 schrieb Tony Lindgren <tony@atomide.com>:
>>=20
>> * Tony Lindgren <tony@atomide.com> [180615 07:00]:
>>=20
>> OK I posted a series to fix these issues hopefully as thread
>> "[PATCH 0/5] pinctrl fixes for generic functions and groups".
>>=20
>> Can you please test and see if that is enough to fix the issues
>> you're seeing?
>=20
> Yes, I'll try asap.

Ok, I tried on OMAP3 (GTA04A5 board).

First boot was ok, but second did show again the strcmp(NULL) :(

Interestingly, adding my printk() to pinctrl_generic_add_group makes it =
disappear.
(I think the printk adds more delay to one of the code paths and avoids =
the race or
problematic concurrency).

There is also good news: the selectors are now assigned in strict =
sequence.
This is a big improvement:

root@letux:~# dmesg|fgrep generic_add
[    0.739501] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_hsusb2_pins selector=3D0
[    0.741638] pinctrl_generic_add_group: pctldev=3Dee481f80 =
name=3Dpinmux_hsusb2_2_pins selector=3D0
[    0.742401] pinctrl_generic_add_group: pctldev=3Dee481e00 =
name=3Dpinmux_mcbsp1_devconf0_pins selector=3D0
[    0.743072] pinctrl_generic_add_group: pctldev=3Dee481d00 =
name=3Dpinmux_tv_acbias_devconf1_pins selector=3D0
[    0.760437] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_uart1_pins selector=3D1
[    0.762268] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_uart2_pins selector=3D2
[    0.763610] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_uart3_pins selector=3D3
[    1.790527] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_twl4030_pins selector=3D4
[    1.799835] pinctrl_generic_add_group: pctldev=3Dee3cd000 =
name=3Dpinmux_twl4030_vpins selector=3D0
[    1.969635] pinctrl_generic_add_group: pctldev=3Dee481f80 =
name=3Dspi_gpio_pinmux selector=3D1
[    2.164093] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_mmc1_pins selector=3D5
[    2.198242] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_wlan_irq_pin selector=3D6
[    2.374328] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_gpmc_pins selector=3D7
[    2.769989] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_wlan_pins selector=3D8
[    2.785888] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_bt_pins selector=3D9
[    2.802154] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_wlan_irq_pin selector=3D10
[    5.415222] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_dss_dpi_pins selector=3D11
[    6.080566] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_mcbsp1_pins selector=3D12
[    6.182617] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_mcbsp2_pins selector=3D13
[    6.271240] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_mcbsp3_pins selector=3D14
[    6.330718] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_penirq_pins selector=3D15
[    6.368927] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_mcbsp4_pins selector=3D16
[    6.616546] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D17
[    6.835418] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D18
[    6.874694] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D19
[    6.900299] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dhdq_pins selector=3D20
[    6.937042] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D21
[    7.062744] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D22
[    7.108032] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D23
[    7.145080] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D24
[    7.197723] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dbacklight_pins_pinmux selector=3D25
[    7.427398] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dmodem_pins selector=3D26
[    7.476562] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D27
[    7.505981] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dbacklight_pins_pinmux selector=3D28
[    7.564910] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D29
[    7.894439] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D30
[    8.207489] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D31
[    8.311096] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_pps_pins selector=3D32
[    8.340667] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D33
[    8.414428] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D34
[    9.231445] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D35
[    9.446716] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D36
root@letux:~#=20

But it looks as if we still have duplicate assignments by deferred =
probing, i.e. some cleanup is
missing (or is this intended behaviour?).

Regarding the strcmp(NULL) faults, it seems as we still have the =
situation that there are
invalid selector numbers stored somewhere and used by generic driver =
probing code (i.e. before
the driver is modprobed):

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.17.0-letux+ (hns@iMac.fritz.box) (gcc =
version 4.9.2 (GCC)) #2453 SMP PREEMPT Fri Jun 15 20:34:03 CEST 2018
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), =
cr=3D10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing =
instruction cache
[    0.000000] OF: fdt: Machine model: Goldelico GTA04A5/Letux 2804

...

[    6.884918] pinctrl_generic_get_group_name: group>name is NULL
[    6.933441] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    6.947204] pinctrl_get_group_selector: strcmp: (null) modem_pins
[    6.980468]   get_group_name =3D =
pinctrl_generic_get_group_name+0x0/0x5c
[    7.009735]   pctldev =3D 0xee396180
[    7.013336] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000
[    7.099395] pgd =3D (ptrval)
[    7.102233] [00000000] *pgd=3Dbe11a831
[    7.106018] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[    7.111663] Modules linked in: pps_gpio(+) panel_tpo_td028ttec1 =
snd_soc_simple_card(+) snd_soc_simple_card_utils snd_soc_omap_twl4030(+) =
pps_core encoder_opa362 wwan_on_off(+) snd_soc_gtm601 pwm_omap_dmtimer =
connector_analog_tv generic_adc_battery pwm_bl bq27xxx_battery_hdq =
bq27xxx_battery wlcore_sdio bmp280_spi omap_hdq omap2430 ov9655 =
v4l2_fwnode v4l2_common snd_soc_omap_mcbsp snd_soc_omap =
snd_pcm_dmaengine bmp280_i2c bmp280 videodev at24 leds_tca6507 tsc2007 =
phy_twl4030_usb bmc150_accel_i2c bmc150_magn_i2c media bmc150_accel_core =
bmc150_magn industrialio_triggered_buffer kfifo_buf musb_hdrc =
gpio_twl4030 snd_soc_twl4030 twl4030_pwrbutton twl4030_charger =
twl4030_vibra twl4030_madc industrialio gnss_w2sg0004 ehci_omap =
w2cbw003_bluetooth gnss omapdss omapdss_base cec
[    7.182952] CPU: 0 PID: 1198 Comm: udevd Not tainted 4.17.0-letux+ =
#2453
[    7.189971] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    7.196563] PC is at strcmp+0x0/0x34
[    7.200317] LR is at pinctrl_get_group_selector+0x84/0xc8
[    7.205993] pc : [<c0758ec0>]    lr : [<c042d9bc>]    psr: 600f0013
[    7.212554] sp : ed019cf8  ip : 00000000  fp : 0000001d
[    7.218017] r10: 0000001c  r9 : 0000001d  r8 : 00000000
[    7.223480] r7 : c0799fac  r6 : ee396180  r5 : ef7c4b74  r4 : =
0000001a
[    7.230316] r3 : 00000000  r2 : 00000000  r1 : ef7c4b74  r0 : =
00000000
[    7.237182] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
[    7.244659] Control: 10c5387d  Table: ad01c019  DAC: 00000051
[    7.250671] Process udevd (pid: 1198, stack limit =3D 0x(ptrval))
[    7.256866] Stack: (0xed019cf8 to 0xed01a000)
[    7.261444] 9ce0:                                                     =
  ed019d1c ee396180
[    7.270019] 9d00: ef7c4b74 00000000 ed0fc810 00000000 ed20d740 =
c042e990 ed20d990 00000001
[    7.278594] 9d20: 00000002 ed20d9c0 ed20d780 ed20d7c0 ed0fc810 =
00000000 00000000 ed20d740
[    7.287139] 9d40: 00000000 c042d1a4 00000014 ee23aac0 c0b59e30 =
c08e9f64 ee23ca10 00000000
[    7.295715] 9d60: ed20dad0 ee23ca10 c0bd1df0 fffffdfb bf248020 =
00000030 00000000 c042d36c
[    7.304290] 9d80: 00000000 ee23ca10 ed20db50 c04f2e70 ee23ca10 =
00000000 c0bd1df4 c04d3e8c
[    7.312866] 9da0: ee23ca10 ee23ca44 bf248020 c0b666c8 bf248180 =
bf2481b0 00000000 c04d413c
[    7.321441] 9dc0: ee23ca10 bf248020 c04d40bc c04d2620 ee01be58 =
ee25e034 bf248020 00000000
[    7.330017] 9de0: ed0fc000 c04d34b8 bf247727 bf247728 00000000 =
bf248020 c0b98de0 bf24b000
[    7.338592] 9e00: 00000000 c04d4ce0 c04d5500 bf248080 c0b98de0 =
c0102d74 014000c0 c07502e0
[    7.347167] 9e20: bf2480c8 ed22e2c8 ed22e200 c08e85a2 ed1fb080 =
bf248080 00000001 ed22e2e4
[    7.355743] 9e40: ed1fb0c0 a0070113 ed1fb100 ed1fb080 ee000000 =
014000c0 bf248080 ed019f50
[    7.364318] 9e60: bf24808c bf248080 ed019f50 ed1fb100 00000000 =
c01a7174 bf248080 ed1fb100
[    7.372894] 9e80: bf248080 ed019f50 bf24808c c01a5fa4 ffff8000 =
00007fff bf248080 c01a32d4
[    7.381469] 9ea0: 00000075 c076a678 f0bb090c b6e119f8 00000000 =
00000003 ee76e780 0000295c
[    7.390045] 9ec0: 00000000 c024cf6c 00000003 00000000 00000000 =
00000000 00000000 00000000
[    7.398620] 9ee0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
[    7.407196] 9f00: 00000000 00000000 7fffffff 00000000 b6e119f8 =
00000006 0000017b c01011e4
[    7.415771] 9f20: ed018000 00000000 00058378 c01a6328 7fffffff =
00000000 00000003 c021707c
[    7.424316] 9f40: 00000002 f0bae000 0000295c 00000000 f0baebbe =
f0bae000 0000295c f0bb0394
[    7.432891] 9f60: f0baf1b7 f0bafa98 00003000 000031b0 00000000 =
00000000 00000000 00001c1c
[    7.441467] 9f80: 00000023 00000024 0000001b 00000000 00000017 =
00000000 b6e127d4 00051f70
[    7.450042] 9fa0: 17964f00 c0101000 b6e127d4 00051f70 00000006 =
b6e119f8 00000000 b6e1231c
[    7.458618] 9fc0: b6e127d4 00051f70 17964f00 0000017b 00020000 =
00037f78 00050048 00058378
[    7.467193] 9fe0: bee21ee0 bee21ed0 b6e0bc4b b6f16a42 60070030 =
00000006 00000000 00000000
[    7.475769] [<c0758ec0>] (strcmp) from [<c042d9bc>] =
(pinctrl_get_group_selector+0x84/0xc8)
[    7.484436] [<c042d9bc>] (pinctrl_get_group_selector) from =
[<c042e990>] (pinmux_map_to_setting+0x158/0x1a0)
[    7.494659] [<c042e990>] (pinmux_map_to_setting) from [<c042d1a4>] =
(create_pinctrl+0x1f0/0x2f8)
[    7.503784] [<c042d1a4>] (create_pinctrl) from [<c042d36c>] =
(devm_pinctrl_get+0x2c/0x6c)
[    7.512268] [<c042d36c>] (devm_pinctrl_get) from [<c04f2e70>] =
(pinctrl_bind_pins+0x3c/0x138)
[    7.521118] [<c04f2e70>] (pinctrl_bind_pins) from [<c04d3e8c>] =
(driver_probe_device+0xe8/0x318)
[    7.530242] [<c04d3e8c>] (driver_probe_device) from [<c04d413c>] =
(__driver_attach+0x80/0xa4)
[    7.539093] [<c04d413c>] (__driver_attach) from [<c04d2620>] =
(bus_for_each_dev+0x58/0x7c)
[    7.547668] [<c04d2620>] (bus_for_each_dev) from [<c04d34b8>] =
(bus_add_driver+0xcc/0x1e0)
[    7.556243] [<c04d34b8>] (bus_add_driver) from [<c04d4ce0>] =
(driver_register+0x9c/0xe0)
[    7.564636] [<c04d4ce0>] (driver_register) from [<c0102d74>] =
(do_one_initcall+0xb4/0x248)
[    7.573211] [<c0102d74>] (do_one_initcall) from [<c01a7174>] =
(do_init_module+0x58/0x1d0)
[    7.581695] [<c01a7174>] (do_init_module) from [<c01a5fa4>] =
(load_module+0xe04/0xfb0)
[    7.589904] [<c01a5fa4>] (load_module) from [<c01a6328>] =
(sys_finit_module+0x88/0x90)
[    7.598114] [<c01a6328>] (sys_finit_module) from [<c0101000>] =
(ret_fast_syscall+0x0/0x54)
[    7.606689] Exception stack(0xed019fa8 to 0xed019ff0)
[    7.611999] 9fa0:                   b6e127d4 00051f70 00000006 =
b6e119f8 00000000 b6e1231c
[    7.620574] 9fc0: b6e127d4 00051f70 17964f00 0000017b 00020000 =
00037f78 00050048 00058378
[    7.629119] 9fe0: bee21ee0 bee21ed0 b6e0bc4b b6f16a42
[    7.634429] Code: e3520000 e5e32001 1afffffb e12fff1e (e4d03001)=20
[    8.755401] cfg80211: Loading compiled-in X.509 certificates for =
regulatory database
[    8.764160] ---[ end trace e60e3511cff37b8a ]---

Can this be a side-effect of the duplicate selector assigments?

Let's assume a first probe attempt does:

[    6.616546] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D17

This fails and is probed again doing:

[    6.835418] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D18
[    6.874694] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dpinmux_camera_pins selector=3D19

Then, a different driver does

[    6.900299] pinctrl_generic_add_group: pctldev=3Dee3cd180 =
name=3Dhdq_pins selector=3D20

And calls pinctrl_get_group_selector() to find itself in the list by =
pinmux_map_to_setting().

For this the code in pinctrl_get_group_selector() loops over all 21 =
known selector numbers,
calling pctlops->get_group_name(pctldev, group_selector) for each one.

If slots 17 and 18 do not really exist (or are deleted after failed =
probing), there is
a NULL return. Which triggers the strcmp(NULL), because the strcmp is =
not guarded against
non-existing slots in the radix tree.

So a simple workaround could be:

		if (gname && !strcmp(gname, pin_group)) {

But I think the fundamental problem is that the same driver assigns =
multiple slots if
probing is deferred.

Therefore, I tried to find out more why this happens. Here are some more =
observations by
studying the code and adding a dump_stack() inside =
pinctrl_generic_add_group():

1.  the records stored in the radix tree are allocated through =
devm_kzalloc() within
    pinctrl_generic_add_group().
2.  I have not found a mechanism that removes them from the radix tree =
if they are
    devm freed which IMHO happens if the probe fails (and all devm =
objects are
    rewound).
3.  I could not observe calls to pinctrl_generic_remove_group()
4.  this means a stale pointer to the group_desc is still stored in the =
radix tree
    if driver probing fails
5.  scanning through the radix tree for a matching gname in =
pinctrl_get_group_selector()
    accesses this stale radix tree entry.
    It has either been overwritten by something else - or contains a =
dangling pointer for
    group->name. This explains the randomness of the problem but that it =
is also repeatable
    to some extent. For a pure race of some 100 instructions it happens =
IMHO too often.
6.  the pinctrl_generic_add_group() is called from create_pinctrl() =
through=20
    pinctrl_dt_to_map() and pcs_dt_node_to_map(), i.e. before the =
pinctrl_maps_mutex
    is locked in create_pinctrl(). This means that =
pinctrl_generic_add_group() is
    not locked in this case.

I hope this helps to pinpoint and solve the remaining bugs.

BR and thanks,
Nikolaus

