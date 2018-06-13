Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ABF8DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B646208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jw5KYGsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B646208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935507AbeFMMjb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:39:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:9645 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeFMMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528893563;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Cc:Message-Id:Date:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=IPz480qssYzBfcfajEirvUTuMkpCQfEbNm/Q50NtRBI=;
        b=jw5KYGsr14cSm0sc+iGBa/mib2D60/GiylMwGV63ZIAi3wr+QXW8+kwZ/l6SJCXXWn
        KPJM4rFRPSL5NyIUIbM4/mxphz9m/jD8yYl/jwMT81KRfHLAclk4Em9QmbfVawzaYwcY
        4Xpsqy8/Kv8QAJEpDjmR9AsLMWGmvJ2aTpBPrXmm1WZWOKlKH2XRqSNoZrZyID/MQCJA
        ftTxpFfIYZsWzNcTd7OWjEKubPOBDUd1WkJ4IzNqnGh8vQ60dZvpyu6PGr2Wex1+q9AO
        ly28htuPPwFz9KZhwEG9m4tZPhyihmb1LdRDWzmShqx5Waf/yMjl5Qcxd6xw3jbfSFbg
        +grw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN2ElM="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id 407f97u5DCdAMIJ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Jun 2018 14:39:10 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
Date:   Wed, 13 Jun 2018 14:39:10 +0200
Message-Id: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>,
        kernel@pyra-handheld.com
To:     Linus Walleij <linus.walleij@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
we have sporadically observed this bug on OMAP3 and OMAP5 machines =
during boot:

> [    5.988882] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000
> [    6.003089] pgd =3D (ptrval)
> [    6.011859] [00000000] *pgd=3Dad268003, *pmd=3D27f089003
> [    6.025112] ehci-omap 4a064c00.ehci: irq 146, io mem 0x4a064c00
> [    6.032874] omapdss: unknown parameter 'def_disp' ignored
> [    6.040373] bq24296_get_vsys_voltage(0)
> [    6.052902] Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> [    6.058661] Modules linked in: encoder_tpd12s015(+) =
pwm_omap_dmtimer(+) connector_hdmi(+) omapdss(+) generic_adc_battery =
pwm_bl(+) omapdss_base cec ehci_omap(+) wlcore_sdio dwc3_omap =
leds_is31fl319x crtouch_mt tsc2007 bmp280_spi bq2429x_charger(+) =
bq27xxx_battery_i2c bq27xxx_battery ina2xx tca8418_keypad as5013(+) =
gpio_twl6040 twl6040_vibra palmas_pwrbutton palmas_gpadc bmc150_magn_i2c =
bmc150_accel_i2c usb3503 bmp280_i2c bmc150_accel_core bmc150_magn bmp280 =
industrialio_triggered_buffer w2cbw003_bluetooth bno055 kfifo_buf =
industrialio snd_soc_omap_mcpdm snd_soc_omap_mcbsp snd_soc_omap =
snd_pcm_dmaengine
> [    6.114731] CPU: 0 PID: 1307 Comm: udevd Tainted: G        W        =
 4.17.0-letux-lpae+ #2406
> [    6.123661] Hardware name: Generic OMAP5 (Flattened Device Tree)
> [    6.129962] PC is at strcmp+0x0/0x34
> [    6.133716] LR is at pinctrl_get_group_selector+0x44/0x78
> [    6.139362] pc : [<c0849b98>]    lr : [<c0526260>]    psr: a00e0013
> [    6.145920] sp : ed26dd00  ip : ed3ff390  fp : 00000019
> [    6.151389] r10: 00000018  r9 : ed2dfb40  r8 : 00000019
> [    6.156866] r7 : c088aba8  r6 : ebfcdb84  r5 : ee55f880  r4 : =
00000017
> [    6.163703] r3 : c05244a4  r2 : 00000000  r1 : ebfcdb84  r0 : =
00000000
> [    6.170548] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment user
> [    6.178026] Control: 30c5387d  Table: ad245b80  DAC: fffffffd
> [    6.184053] Process udevd (pid: 1307, stack limit =3D 0x(ptrval))
> [    6.190258] Stack: (0xed26dd00 to 0xed26e000)
> [    6.194823] dd00: ee55f880 ebfcdb84 00000000 ed0e7810 00000000 =
c0527220 ed2dfd90 00000001
> [    6.203402] dd20: 00000002 ed2dfdc0 ed2dfb80 ed2dfbc0 ed0e7810 =
00000000 00000000 ed2dfb40
> [    6.211977] dd40: 00000000 c0525a88 00000014 ee263680 c0e4bdf0 =
c09d4e04 ee22b810 00000000
> [    6.220557] dd60: ed2dfe10 ee22b810 c0ec3aec fffffdfb bf20a014 =
0000002f 00000000 c0525c50
> [    6.229135] dd80: 00000000 ee22b810 ed2dfe50 c05ead24 ee22b810 =
00000000 c0ec3af0 c05cbd88
> [    6.237710] dda0: ee22b810 ee22b844 bf20a014 c0e57bf0 bf20a180 =
bf20a1b0 00000000 c05cc038
> [    6.246275] ddc0: ee22b810 bf20a014 c05cbfb8 c05ca51c ee0dde58 =
ee1f5434 bf20a014 00000000
> [    6.254856] dde0: ed15df80 c05cb3b4 bf2092de bf2092df 00000000 =
bf20a014 c0e8a360 bf20d000
> [    6.263432] de00: 00000000 c05ccbdc c05cd400 bf20a080 c0e8a360 =
c0202c74 014000c0 c0840fd4
> [    6.272006] de20: bf20a0c8 ed3ff688 ed3ff5c0 c09d32e4 ed313ec0 =
00000000 00000000 ed313e80
> [    6.280582] de40: ed313e80 a00f0113 ed313140 ed313ec0 ee000000 =
014000c0 bf20a080 ed26df50
> [    6.289157] de60: bf20a08c bf20a080 ed26df50 ed313140 00000000 =
c02a098c bf20a080 ed313140
> [    6.297739] de80: bf20a080 ed26df50 bf20a08c c029f7d4 ffff8000 =
00007fff bf20a080 c029cb04
> [    6.306309] dea0: 00000064 c085b2f4 f0b05460 b6dc49f8 00000000 =
00000003 ed1d8240 000024b0
> [    6.314875] dec0: 00000000 c0347e60 00000003 00000000 00000000 =
00000000 00000000 00000000
> [    6.323454] dee0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [    6.332028] df00: 00000000 00000000 7fffffff 00000000 b6dc49f8 =
00000006 0000017b c02011e4
> [    6.340601] df20: ed26c000 00000000 000545c0 c029fb40 7fffffff =
00000000 00000003 c03104bc
> [    6.349179] df40: 00000002 f0b03000 000024b0 00000000 f0b03c20 =
f0b03000 000024b0 f0b04fb0
> [    6.357754] df60: f0b04077 f0b04800 00003000 00003120 00000000 =
00000000 00000000 00001b08
> [    6.366323] df80: 0000001e 0000001f 00000016 00000000 00000012 =
00000000 00000000 bed4e004
> [    6.374899] dfa0: 00000000 c0201000 00000000 bed4e004 00000006 =
b6dc49f8 00000000 00000000
> [    6.383480] dfc0: 00000000 bed4e004 00000000 0000017b 00020000 =
00037f78 00050048 000545c0
> [    6.392056] dfe0: bed4dee0 bed4ded0 b6dbec4b b6ec9a42 800f0030 =
00000006 00000000 00000000
> [    6.400640] [<c0849b98>] (strcmp) from [<c0526260>] =
(pinctrl_get_group_selector+0x44/0x78)
> [    6.409317] [<c0526260>] (pinctrl_get_group_selector) from =
[<c0527220>] (pinmux_map_to_setting+0x158/0x1a0)
> [    6.419533] [<c0527220>] (pinmux_map_to_setting) from [<c0525a88>] =
(create_pinctrl+0x1f0/0x2f8)
> [    6.428664] [<c0525a88>] (create_pinctrl) from [<c0525c50>] =
(devm_pinctrl_get+0x2c/0x6c)
> [    6.437146] [<c0525c50>] (devm_pinctrl_get) from [<c05ead24>] =
(pinctrl_bind_pins+0x3c/0x138)
> [    6.446008] [<c05ead24>] (pinctrl_bind_pins) from [<c05cbd88>] =
(driver_probe_device+0xe8/0x318)
> [    6.455131] [<c05cbd88>] (driver_probe_device) from [<c05cc038>] =
(__driver_attach+0x80/0xa4)
> [    6.463983] [<c05cc038>] (__driver_attach) from [<c05ca51c>] =
(bus_for_each_dev+0x58/0x7c)
> [    6.472556] [<c05ca51c>] (bus_for_each_dev) from [<c05cb3b4>] =
(bus_add_driver+0xcc/0x1e0)
> [    6.481143] [<c05cb3b4>] (bus_add_driver) from [<c05ccbdc>] =
(driver_register+0x9c/0xe0)
> [    6.489545] [<c05ccbdc>] (driver_register) from [<c0202c74>] =
(do_one_initcall+0xb4/0x248)
> [    6.498136] [<c0202c74>] (do_one_initcall) from [<c02a098c>] =
(do_init_module+0x58/0x1d0)
> [    6.506614] [<c02a098c>] (do_init_module) from [<c029f7d4>] =
(load_module+0xe04/0xfb0)
> [    6.514821] [<c029f7d4>] (load_module) from [<c029fb40>] =
(sys_finit_module+0x88/0x90)
> [    6.523041] [<c029fb40>] (sys_finit_module) from [<c0201000>] =
(ret_fast_syscall+0x0/0x4c)
> [    6.531604] Exception stack(0xed26dfa8 to 0xed26dff0)
> [    6.536899] dfa0:                   00000000 bed4e004 00000006 =
b6dc49f8 00000000 00000000
> [    6.545472] dfc0: 00000000 bed4e004 00000000 0000017b 00020000 =
00037f78 00050048 000545c0
> [    6.554037] dfe0: bed4dee0 bed4ded0 b6dbec4b b6ec9a42
> [    6.559339] Code: e3520000 e5e32001 1afffffb e12fff1e (e4d03001)=20
> [    6.567709] ---[ end trace 1a9ebd5c1c7fe0e4 ]---

It is initially triggered by udev loading and probing a module.

Here is another bug trace:

> [   13.671844] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000
> [   13.693389] pgd =3D (ptrval)
> [   13.696380] [00000000] *pgd=3D00000000
> [   13.700134] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> [   13.705780] Modules linked in: snd_soc_gtm601 pwm_omap_dmtimer =
connector_analog_tv generic_adc_battery pwm_bl bq27xxx_battery_hdq =
bq27xxx_battery omap3_isp(+) videobuf2_dma_contig videobuf2_memops =
videobuf2_v4l2 videobuf2_common omap_hdq omap2430 snd_soc_omap_mcbsp(+) =
snd_soc_omap snd_pcm_dmaengine bmp280_i2c(+) bmp280 ov9655(+) =
v4l2_fwnode v4l2_common itg3200 at24 videodev phy_twl4030_usb tsc2007 =
hmc5843_i2c hmc5843_core bma180 musb_hdrc industrialio_triggered_buffer =
lis3lv02d_i2c media leds_tca6507 lis3lv02d kfifo_buf input_polldev =
gpio_twl4030 snd_soc_twl4030 twl4030_vibra twl4030_charger =
twl4030_pwrbutton twl4030_madc industrialio w2sg0004 gps_core =
w2cbw003_bluetooth ehci_omap omapdss omapdss_base cec
> [   13.771331] CPU: 0 PID: 937 Comm: kworker/0:2 Not tainted =
4.17.0-rc2-letux+ #2290
> [   13.779174] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [   13.785736] Workqueue: events deferred_probe_work_func
> [   13.791107] PC is at strcmp+0x0/0x34
> [   13.794860] LR is at pinctrl_get_group_selector+0x6c/0xa8
> [   13.800506] pc : [<c0705afc>]    lr : [<c0429840>]    psr: 600f0013
> [   13.807067] sp : dddf9e08  ip : 00000000  fp : 00000011
> [   13.812530] r10: 0000000f  r9 : 00000010  r8 : c0745b0c
> [   13.817993] r7 : 00000000  r6 : ddc41600  r5 : df9c5274  r4 : =
0000000e
> [   13.824829] r3 : 600f0013  r2 : 00000002  r1 : df9c5274  r0 : =
00000000
> [   13.831665] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
> [   13.839111] Control: 10c5387d  Table: 9c88c019  DAC: 00000051
> [   13.845123] Process kworker/0:2 (pid: 937, stack limit =3D =
0x(ptrval))
> [   13.851776] Stack: (0xdddf9e08 to 0xdddfa000)
> [   13.856323] 9e00:                   dddf9e2c ddc41600 df9c5274 =
00000000 dcc99f10 00000000
> [   13.864868] 9e20: dcc98b80 c042a808 dcc84110 00000001 00000002 =
dcc98e40 dcc5bd80 dcc85f40
> [   13.873413] 9e40: dcc99f10 00000000 00000000 dcc98b80 00000000 =
c0429040 00000014 dda424c0
> [   13.881988] 9e60: c0a58df0 c0876b8c dda47c10 00000000 dca09110 =
dda47c10 c0aca804 fffffdfb
> [   13.890563] 9e80: bf282014 0000002c c0a94390 c0429208 00000000 =
dda47c10 dca09150 c04bb85c
> [   13.899108] 9ea0: dda47c10 00000000 c0aca808 c049fb58 00000000 =
dddf9ee8 c049fe64 dda47c44
> [   13.907714] 9ec0: df9bbe00 c0a02d00 00000000 c049e3b8 dd81be6c =
dcc3d738 dda47c10 c0a63258
> [   13.916259] 9ee0: 00000001 c049f9d8 dda47c10 00000001 00000000 =
dda47c10 c0a63258 dda47c10
> [   13.924804] 9f00: c0a9dba0 c049ef94 dda47c10 c0a63044 c0a63060 =
c049f4a4 c049f3b8 dde97900
> [   13.933380] 9f20: c0a63078 df9b8c00 00000000 df9bbe00 c0a02d00 =
c0145dac dde97900 c0a63078
> [   13.941955] 9f40: ffff9023 dde97900 df9b8c00 df9b8c00 dddf8000 =
df9b8c18 c0a02d00 dde97918
> [   13.950500] 9f60: 00000008 c0146580 dda48240 dde09ec0 dde16640 =
00000000 dde97900 c01462c0
> [   13.959075] 9f80: dd8b1ef0 dde09edc 00000000 c014a598 dde16640 =
c014a464 00000000 00000000
> [   13.967620] 9fa0: 00000000 00000000 00000000 c01010e8 00000000 =
00000000 00000000 00000000
> [   13.976196] 9fc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [   13.984741] 9fe0: 00000000 00000000 00000000 00000000 00000013 =
00000000 00000000 00000000
> [   13.993316] [<c0705afc>] (strcmp) from [<c0429840>] =
(pinctrl_get_group_selector+0x6c/0xa8)
> [   14.001953] [<c0429840>] (pinctrl_get_group_selector) from =
[<c042a808>] (pinmux_map_to_setting+0x158/0x1a0)
> [   14.012145] [<c042a808>] (pinmux_map_to_setting) from [<c0429040>] =
(create_pinctrl+0x1f0/0x2f8)
> [   14.021240] [<c0429040>] (create_pinctrl) from [<c0429208>] =
(devm_pinctrl_get+0x2c/0x6c)
> [   14.029724] [<c0429208>] (devm_pinctrl_get) from [<c04bb85c>] =
(pinctrl_bind_pins+0x3c/0x138)
> [   14.038574] [<c04bb85c>] (pinctrl_bind_pins) from [<c049fb58>] =
(driver_probe_device+0xe8/0x318)
> [   14.047668] [<c049fb58>] (driver_probe_device) from [<c049e3b8>] =
(bus_for_each_drv+0x84/0x94)
> [   14.056610] [<c049e3b8>] (bus_for_each_drv) from [<c049f9d8>] =
(__device_attach+0x88/0xfc)
> [   14.065155] [<c049f9d8>] (__device_attach) from [<c049ef94>] =
(bus_probe_device+0x28/0x80)
> [   14.073730] [<c049ef94>] (bus_probe_device) from [<c049f4a4>] =
(deferred_probe_work_func+0xec/0x120)
> [   14.083221] [<c049f4a4>] (deferred_probe_work_func) from =
[<c0145dac>] (process_one_work+0x244/0x464)
> [   14.092803] [<c0145dac>] (process_one_work) from [<c0146580>] =
(worker_thread+0x2c0/0x3ec)
> [   14.101348] [<c0146580>] (worker_thread) from [<c014a598>] =
(kthread+0x134/0x150)
> [   14.109100] [<c014a598>] (kthread) from [<c01010e8>] =
(ret_from_fork+0x14/0x2c)
> [   14.116638] Exception stack(0xdddf9fb0 to 0xdddf9ff8)
> [   14.121917] 9fa0:                                     00000000 =
00000000 00000000 00000000
> [   14.130462] 9fc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> [   14.139038] 9fe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
> [   14.145935] Code: e3520000 e5e32001 1afffffb e12fff1e (e4d03001)=20
> [   14.299560] omap-mcbsp 49022000.mcbsp: ASoC: Failed to create =
component debugfs directory

This time it comes from the deferred_probe_work_func().

It does not happen always and depends on which drivers are auto-probed =
from device tree and
in which sequence (which depends a little on random hardware =
influences).

Now my theory, after inserting some printk and digging through the code, =
is:
* the pinctrl-group handling is not thread safe but udev module probing =
and deferred_probe_work_func
  can run cuncurrently
* the radix tree (pin_group_tree) gets garbled (and is maybe not even =
the correct data structure)

Here are some details of my thoughts:

First of all, there is a warning that radix trees do not do any locking =
internally:

https://lwn.net/Articles/175432/

"One should note that none of the radix tree functions perform any sort =
of locking internally.
It is up to the caller to ensure that multiple threads do not corrupt =
the tree or get into
other sorts of unpleasant race conditions."

Now if I look into pinctrl_generic_add_group() and =
pinctrl_generic_get_group_name(),
pctldev->num_groups++ is not protected if pinctrl_generic_add_group() =
may be called by
two threads in parallel for the same pctldev. Hence a second thread may =
try to insert
a different node into the radix tree at the same selector index. This =
fails but there
is no error check - and the second entry is completely missing (but =
probably assumed to
be there).

Even worse in practise (examples above) seems to be that a driver =
failing to probe
(-EPROBE_DEFER) should do a call to pinctrl_generic_remove_group() in =
addition to an initial
pinctrl_generic_add_group(). This may happen multiple times in =
succession until the
driver finally probes successfully. Each time, num_groups is =
incremented/decremented.
So if two threads are working on driver probing the pctldev->num_groups =
may go back
and forward at unexpected times changing the insertion point of the =
other thread.

[Note: I could not verify that pinctrl_generic_remove_group() is ever =
called].

Another observation is that the code seems to assume that the selector =
numbers are
always in sequence and only the last one added is deleted by =
pinctrl_generic_remove_group().

But if I assume that a deferred driver waits quite a while before =
deciding to -EPROBE_DEFER,
other drivers may have been probed successfully by the other thread and =
have incremented
num_groups by more than 1 . Therefore the driver calling =
pinctrl_generic_remove_group() is
no longer the last one added.

In other words, the assumption seems to be that a radix-tree is an array =
where deleting
one entry in the middle reduces the index of the following ones and the =
reduced counter
gives the index of the first free index. But it is a sparse array and =
indexes are not
modified by insert/remove.

The result is that if several drivers are concurrently being probed =
(deferred_probe_work_func
executed concurrently to udevd probing), the assignment of the selector =
(aka radix tree
slot) defined by pctldev->num_groups may become wrong.

So entries may get lost and return NULL for gname in =
pinctrl_get_group_selector()
and as a result we see the strcmp(NULL). This is my theory about these =
kernel oopses.

Unfortunately I have no good idea how a solution could look like. One =
thing is
to add locking but there is a note in the comments of the =
pinctrl_generic functions
and there is mutex_lock(&pinctrl_maps_mutex); So there is something, but =
I am not
sure if all call paths are locked.

The other is to get the index/selection assignment right (which may even =
fail with
proper locking of the radix tree), maybe by using a different data =
structure than
a radix-tree.

Another observation after adding a printk to pinctrl_generic_add_group() =
is:

root@letux:~# dmesg|fgrep pinctrl_generic_add_group
[    0.749481] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_hsusb2_pins selector=3D0
[    0.751464] pinctrl_generic_add_group: pctldev=3Dee33a000 =
name=3Dpinmux_hsusb2_2_pins selector=3D0
[    0.752380] pinctrl_generic_add_group: pctldev=3Dee3f1e80 =
name=3Dpinmux_mcbsp1_devconf0_pins selector=3D0
[    0.753143] pinctrl_generic_add_group: pctldev=3Dee3f1d80 =
name=3Dpinmux_tv_acbias_devconf1_pins selector=3D0
[    0.770294] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_uart1_pins selector=3D1
[    0.772094] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_uart2_pins selector=3D2
[    0.773254] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_uart3_pins selector=3D3
[    1.800659] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_twl4030_pins selector=3D4
[    1.809997] pinctrl_generic_add_group: pctldev=3Dee33a080 =
name=3Dpinmux_twl4030_vpins selector=3D0
[    1.972412] pinctrl_generic_add_group: pctldev=3Dee33a000 =
name=3Dspi_gpio_pinmux selector=3D1
[    2.167144] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_mmc1_pins selector=3D5
[    2.204040] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_wlan_irq_pin selector=3D6
[    2.379150] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_gpmc_pins selector=3D7
[    2.774627] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_wlan_pins selector=3D8
[    2.791015] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_bt_pins selector=3D9
[    2.806610] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_wlan_irq_pin selector=3D10
[    5.240020] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_dss_dpi_pins selector=3D11
[    5.874664] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_mcbsp1_pins selector=3D12
[    5.988159] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_mcbsp2_pins selector=3D13
[    5.997283] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_mcbsp3_pins selector=3D14
[    6.089141] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_penirq_pins selector=3D14
[    6.149841] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_mcbsp4_pins selector=3D15
[    6.205993] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dhdq_pins selector=3D17
[    6.390899] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D18
[    6.580169] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D19

^^^ pin group added twice

[    6.890899] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dbacklight_pins_pinmux selector=3D20
[    6.957489] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D20

^^^ same selector number allocated twice

[    6.985687] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D21
[    7.020538] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D22

^^^ 23 missing
[    7.123748] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D24
[    7.158721] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dbacklight_pins_pinmux selector=3D25

^^^ another pin group added twice

[    7.195953] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dmodem_pins selector=3D26
[    7.213104] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D26

^^^ same selector allocated twice, 27 is missing

[    7.239318] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dbacklight_pins_pinmux selector=3D28

^^^ repetition

[    7.287414] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D29
[    7.328491] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D30
[    7.663543] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D31
[    7.693725] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D32
[    7.999755] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D33
[    8.091491] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_pps_pins selector=3D34
[    8.100219] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D34

^^^ another duplicate

[    8.197174] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D36
[    8.928436] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D37
[    9.465606] pinctrl_generic_add_group: pctldev=3Dee33a200 =
name=3Dpinmux_camera_pins selector=3D38
root@letux:~#=20

Which means that some groups are added multiple times and cleanup on =
EPROBE_DEFER doesn't work.

Well, this is my theory - which may be wrong. The only fact is the =
problem with strcmp(NULL, ...)
sporadically occuring.

So I hope that someone can make sense out of these findings and propose =
a patch to fix the real
bug (which may exist for quite a while and became more visible in =
4.17-rc1 - but bisect attempts
failed due to the randomness).

BR and thanks,
Nikolaus



