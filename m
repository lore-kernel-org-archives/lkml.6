Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5E6FDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADDF208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADDF208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbeFNI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:56:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754607AbeFNI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:56:02 -0400
X-UUID: d94c3662b54649cea555875d62548632-20180614
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2027145481; Thu, 14 Jun 2018 16:55:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 14 Jun 2018 16:55:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 14 Jun 2018 16:55:50 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>, <stable@vger.kernel.org>
Subject: [PATCH] pinctrl: mt7622: fix a kernel panic when pio don't work as EINT controller
Date:   Thu, 14 Jun 2018 16:55:49 +0800
Message-ID: <6615b85997509d659358d33eab2d280e235b8659.1528966092.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The function, external interrupt controller, is made as an optional to
mt7622 pinctrl. But if we don't want pio behaves as an external interrupt
controller, it would lead to hw->eint not be created properly and then
will cause 'kernel NULL pointer' issue when gpiochip try to call .to_irq
or .set_config. To fix it, check hw->eint before accessing the member.

[    1.339494] Unable to handle kernel NULL pointer dereference at virtual
	       address 00000010
[    1.347857] Mem abort info:
[    1.350742]   ESR = 0x96000005
[    1.353905]   Exception class = DABT (current EL), IL = 32 bits
[    1.360024]   SET = 0, FnV = 0
[    1.363185]   EA = 0, S1PTW = 0
[    1.366431] Data abort info:
[    1.369405]   ISV = 0, ISS = 0x00000005
[    1.373363]   CM = 0, WnR = 0
[    1.376437] [0000000000000010] user address but active_mm is swapper
[    1.383005] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    1.388748] Modules linked in:
[    1.391897] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1+ #344
[    1.398625] Hardware name: MediaTek MT7622 RFB1 board (DT)
[    1.404279] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.409221] pc : mtk_eint_find_irq+0x8/0x24
[    1.413532] lr : mtk_gpio_to_irq+0x20/0x28
[    1.417749] sp : ffffff800801baf0
[    1.421161] x29: ffffff800801baf0 x28: ffffff8008792f40
[    1.426637] x27: ffffff800886b000 x26: ffffff8008615620
[    1.432113] x25: ffffffc00e4dbdc8 x24: ffffff80087b8000
[    1.437589] x23: ffffffc00325a000 x22: ffffffc00325a010
[    1.443066] x21: ffffffc0033dec18 x20: 00000000ffffffea
[    1.448542] x19: ffffffc00e4db800 x18: 0000000000000130
[    1.454018] x17: 000000000000000e x16: 0000000000000007
[    1.459494] x15: ffffff80085ee000 x14: 0000000000000001
[    1.464970] x13: 0000000000000001 x12: 0000000000000010
[    1.470446] x11: 0101010101010101 x10: 0000000000000880
[    1.475922] x9 : ffffff800801b990 x8 : ffffffc0030688e0
[    1.481399] x7 : ffffff80080c0660 x6 : ffffffc00e4dbbb0
[    1.486875] x5 : 0000000000000000 x4 : 0000000000000000
[    1.492351] x3 : ffffff80082a92f4 x2 : 00000000fffffffa
[    1.497826] x1 : 0000000000000051 x0 : 0000000000000000
[    1.503305] Process swapper/0 (pid: 1, stack limit = 0x0000000054e053bd)
[    1.510210] Call trace:
[    1.512727]  mtk_eint_find_irq+0x8/0x24
[    1.516677]  mtk_gpio_to_irq+0x20/0x28
[    1.520539]  gpiod_to_irq+0x48/0x60
[    1.524135]  mmc_gpiod_request_cd_irq+0x3c/0xc4
[    1.528804]  mmc_start_host+0x6c/0x8c
[    1.532575]  mmc_add_host+0x58/0x7c
[    1.536168]  msdc_drv_probe+0x4fc/0x67c
[    1.540121]  platform_drv_probe+0x58/0xa4
[    1.544251]  driver_probe_device+0x204/0x44c
[    1.548649]  __driver_attach+0x84/0xf8
[    1.552512]  bus_for_each_dev+0x68/0xa0
[    1.556461]  driver_attach+0x20/0x28
[    1.560142]  bus_add_driver+0xec/0x240
[    1.564002]  driver_register+0x98/0xe4
[    1.567863]  __platform_driver_register+0x48/0x50
[    1.572711]  mt_msdc_driver_init+0x18/0x20
[    1.576932]  do_one_initcall+0x98/0x130
[    1.580886]  kernel_init_freeable+0x13c/0x1d4
[    1.585375]  kernel_init+0x10/0xf8
[    1.588879]  ret_from_fork+0x10/0x18
[    1.592564] Code: a8c67bfd d65f03c0 a9bf7bfd 910003fd (f9400800)
[    1.598849] ---[ end trace 4bbcb7bc30e98492 ]---
[    1.603677] Kernel panic - not syncing: Attempted to kill init!
	       exitcode=0x0000000b
[    1.603677]

cc: Kevin Hilman <khilman@baylibre.com>
Cc: stable@vger.kernel.org
Fixes: e6dabd38d8e7 ("pinctrl: mediatek: add EINT support to MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index ad6da11..e3f1ab2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1459,6 +1459,9 @@ static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
 	unsigned long eint_n;
 
+	if (!hw->eint)
+		return -ENOTSUPP;
+
 	eint_n = offset;
 
 	return mtk_eint_find_irq(hw->eint, eint_n);
@@ -1471,7 +1474,8 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	unsigned long eint_n;
 	u32 debounce;
 
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
+	if (!hw->eint ||
+	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
 		return -ENOTSUPP;
 
 	debounce = pinconf_to_config_argument(config);
-- 
2.7.4

