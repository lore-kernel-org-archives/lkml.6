Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5429823CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5429823CB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeFVDtc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:49:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934352AbeFVDt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:49:28 -0400
X-UUID: 14ff8e2a02144dcaa0c5b7f5602b8bdf-20180622
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1503066779; Fri, 22 Jun 2018 11:49:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 22 Jun 2018 11:49:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 11:49:15 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH 5/7] pinctrl: mt7622: fix a kernel panic when gpio-hog is being applied
Date:   Fri, 22 Jun 2018 11:49:08 +0800
Message-ID: <031d7dd666390aaf1b0566476c9661e6e674cae8.1529639050.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

When we are explicitly using GPIO hogging mechanism in the pinctrl node,
such as:

	&pio {
		line_input {
			gpio-hog;
			gpios = <95 0>, <96 0>, <97 0>;
			input;
		};
	};

A kernel panic happens at dereferencing a NULL pointer: In this case, the
drvdata is still not setup properly yet when it is being accessed.

A better solution for fixing up this issue should be we should obtain the
private data from struct gpio_chip using a specific gpiochip_get_data
instead of a generic dev_get_drvdata.

[    0.249424] Unable to handle kernel NULL pointer dereference at virtual
	       address 000000c8
[    0.257818] Mem abort info:
[    0.260704]   ESR = 0x96000005
[    0.263869]   Exception class = DABT (current EL), IL = 32 bits
[    0.270011]   SET = 0, FnV = 0
[    0.273167]   EA = 0, S1PTW = 0
[    0.276421] Data abort info:
[    0.279398]   ISV = 0, ISS = 0x00000005
[    0.283372]   CM = 0, WnR = 0
[    0.286440] [00000000000000c8] user address but active_mm is swapper
[    0.293027] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    0.298795] Modules linked in:
[    0.301958] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1+ #389
[    0.308716] Hardware name: MediaTek MT7622 RFB1 board (DT)
[    0.314396] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    0.319362] pc : mtk_hw_pin_field_get+0x28/0x118
[    0.324140] lr : mtk_hw_set_value+0x30/0x104
[    0.328557] sp : ffffff800801b6d0
[    0.331983] x29: ffffff800801b6d0 x28: ffffff80086b7970
[    0.337484] x27: 0000000000000000 x26: ffffff80087b8000
[    0.342986] x25: 0000000000000000 x24: ffffffc00324c230
[    0.348487] x23: 0000000000000003 x22: 0000000000000000
[    0.353988] x21: ffffff80087b8000 x20: 0000000000000000
[    0.359489] x19: 0000000000000054 x18: 00000000fffff7c0
[    0.364990] x17: 0000000000006300 x16: 000000000000003f
[    0.370492] x15: 000000000000000e x14: ffffffffffffffff
[    0.375993] x13: 0000000000000000 x12: 0000000000000020
[    0.381494] x11: 0000000000000006 x10: 0101010101010101
[    0.386995] x9 : fffffffffffffffa x8 : 0000000000000007
[    0.392496] x7 : ffffff80085d63f8 x6 : 0000000000000003
[    0.397997] x5 : 0000000000000054 x4 : ffffffc0031eb800
[    0.403499] x3 : ffffff800801b728 x2 : 0000000000000003
[    0.409000] x1 : 0000000000000054 x0 : 0000000000000000
[    0.414502] Process swapper/0 (pid: 1, stack limit = 0x000000002a913c1c)
[    0.421441] Call trace:
[    0.423968]  mtk_hw_pin_field_get+0x28/0x118
[    0.428387]  mtk_hw_set_value+0x30/0x104
[    0.432445]  mtk_gpio_set+0x20/0x28
[    0.436052]  mtk_gpio_direction_output+0x18/0x30
[    0.440833]  gpiod_direction_output_raw_commit+0x7c/0xa0
[    0.446333]  gpiod_direction_output+0x104/0x114
[    0.451022]  gpiod_configure_flags+0xbc/0xfc
[    0.455441]  gpiod_hog+0x8c/0x140
[    0.458869]  of_gpiochip_add+0x27c/0x2d4
[    0.462928]  gpiochip_add_data_with_key+0x338/0x5f0
[    0.467976]  mtk_pinctrl_probe+0x388/0x400
[    0.472217]  platform_drv_probe+0x58/0xa4
[    0.476365]  driver_probe_device+0x204/0x44c
[    0.480783]  __device_attach_driver+0xac/0x108
[    0.485384]  bus_for_each_drv+0x7c/0xac
[    0.489352]  __device_attach+0xa0/0x144
[    0.493320]  device_initial_probe+0x10/0x18
[    0.497647]  bus_probe_device+0x2c/0x8c
[    0.501616]  device_add+0x2f8/0x540
[    0.505226]  of_device_add+0x3c/0x44
[    0.508925]  of_platform_device_create_pdata+0x80/0xb8
[    0.514245]  of_platform_bus_create+0x290/0x3e8
[    0.518933]  of_platform_populate+0x78/0x100
[    0.523352]  of_platform_default_populate+0x24/0x2c
[    0.528403]  of_platform_default_populate_init+0x94/0xa4
[    0.533903]  do_one_initcall+0x98/0x130
[    0.537874]  kernel_init_freeable+0x13c/0x1d4
[    0.542385]  kernel_init+0x10/0xf8
[    0.545903]  ret_from_fork+0x10/0x18
[    0.549603] Code: 900020a1 f9400800 911dcc21 1400001f (f9406401)
[    0.555916] ---[ end trace de8c34787fdad3b3 ]---
[    0.560722] Kernel panic - not syncing: Attempted to kill init!
	       exitcode=0x0000000b
[    0.560722]
[    0.570188] SMP: stopping secondary CPUs
[    0.574253] ---[ end Kernel panic - not syncing: Attempted to kill
	       init! exitcode=0x0000000b
[    0.574253]

Cc: stable@vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 055074bb..4c4740f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1424,7 +1424,7 @@ static struct pinctrl_desc mtk_desc = {
 
 static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
 {
-	struct mtk_pinctrl *hw = dev_get_drvdata(chip->parent);
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
 	int value, err;
 
 	err = mtk_hw_get_value(hw, gpio, PINCTRL_PIN_REG_DI, &value);
@@ -1436,7 +1436,7 @@ static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
 
 static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 {
-	struct mtk_pinctrl *hw = dev_get_drvdata(chip->parent);
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
 
 	mtk_hw_set_value(hw, gpio, PINCTRL_PIN_REG_DO, !!value);
 }
-- 
2.7.4

