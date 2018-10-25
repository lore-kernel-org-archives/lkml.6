Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ECFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF67A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2q6ajhmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF67A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeJYWwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbeJYWwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:14 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B9C20848;
        Thu, 25 Oct 2018 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477156;
        bh=E1gWchKPPcAHphcXM0Em3y2IjgizSvbqswKwOG8l9RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2q6ajhmHAgpujtC/uqZezEwvw8RLpm4pfxGP9xymZn6hhceps7x0zCgP8lv7VUWAq
         IWrk3W4mzEzZ0NPt0HdPNEWRpv/wO036Bdqe1C6X01bE9gW/iRqTk9QvekDOKxmE0j
         TyabtoszFllEUjJmoP9DVPqTLm4khXvdAmyKSrrU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Dueck <davidcdueck@googlemail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 12/98] pinctrl: at91: fix null pointer dereference
Date:   Thu, 25 Oct 2018 10:17:27 -0400
Message-Id: <20181025141853.214051-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dueck <davidcdueck@googlemail.com>

[ Upstream commit 1ab36387ea4face01aac3560b396b1e2ce07c4ff ]

Not all gpio banks are necessarily enabled, in the current code this can
lead to null pointer dereferences.

[   51.130000] Unable to handle kernel NULL pointer dereference at virtual address 00000058
[   51.130000] pgd = dee04000
[   51.130000] [00000058] *pgd=3f66d831, *pte=00000000, *ppte=00000000
[   51.140000] Internal error: Oops: 17 [#1] ARM
[   51.140000] Modules linked in:
[   51.140000] CPU: 0 PID: 1664 Comm: cat Not tainted 4.1.1+ #6
[   51.140000] Hardware name: Atmel SAMA5
[   51.140000] task: df6dd880 ti: dec60000 task.ti: dec60000
[   51.140000] PC is at at91_pinconf_get+0xb4/0x200
[   51.140000] LR is at at91_pinconf_get+0xb4/0x200
[   51.140000] pc : [<c01e71a0>]    lr : [<c01e71a0>]    psr: 600f0013
sp : dec61e48  ip : 600f0013  fp : df522538
[   51.140000] r10: df52250c  r9 : 00000058  r8 : 00000068
[   51.140000] r7 : 00000000  r6 : df53c910  r5 : 00000000  r4 : dec61e7c
[   51.140000] r3 : 00000000  r2 : c06746d4  r1 : 00000000  r0 : 00000003
[   51.140000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   51.140000] Control: 10c53c7d  Table: 3ee04059  DAC: 00000015
[   51.140000] Process cat (pid: 1664, stack limit = 0xdec60208)
[   51.140000] Stack: (0xdec61e48 to 0xdec62000)
[   51.140000] 1e40:                   00000358 00000000 df522500 ded15f80 c05a9d08 ded15f80
[   51.140000] 1e60: 0000048c 00000061 df522500 ded15f80 c05a9d08 c01e7304 ded15f80 00000000
[   51.140000] 1e80: c01e6008 00000060 0000048c c01e6034 c01e5f6c ded15f80 dec61ec0 00000000
[   51.140000] 1ea0: 00020000 ded6f280 dec61f80 00000001 00000001 c00ae0b8 b6e80000 ded15fb0
[   51.140000] 1ec0: 00000000 00000000 df4bc974 00000055 00000800 ded6f280 b6e80000 ded6f280
[   51.140000] 1ee0: ded6f280 00020000 b6e80000 00000000 00020000 c0090dec c0671e1c dec61fb0
[   51.140000] 1f00: b6f8b510 00000001 00004201 c000924c 00000000 00000003 00000003 00000000
[   51.140000] 1f20: df4bc940 00022000 00000022 c066e188 b6e7f000 c00836f4 000b6e7f ded6f280
[   51.140000] 1f40: ded6f280 b6e80000 dec61f80 ded6f280 00020000 c0091508 00000000 00000003
[   51.140000] 1f60: 00022000 00000000 00000000 ded6f280 ded6f280 00020000 b6e80000 c0091d9c
[   51.140000] 1f80: 00000000 00000000 ffffffff 00020000 00020000 b6e80000 00000003 c000f124
[   51.140000] 1fa0: dec60000 c000efa0 00020000 00020000 00000003 b6e80000 00020000 000271c4
[   51.140000] 1fc0: 00020000 00020000 b6e80000 00000003 7fffe000 00000000 00000000 00020000
[   51.140000] 1fe0: 00000000 bef50b64 00013835 b6f29c76 400f0030 00000003 00000000 00000000
[   51.140000] [<c01e71a0>] (at91_pinconf_get) from [<c01e7304>] (at91_pinconf_dbg_show+0x18/0x2c0)
[   51.140000] [<c01e7304>] (at91_pinconf_dbg_show) from [<c01e6034>] (pinconf_pins_show+0xc8/0xf8)
[   51.140000] [<c01e6034>] (pinconf_pins_show) from [<c00ae0b8>] (seq_read+0x1a0/0x464)
[   51.140000] [<c00ae0b8>] (seq_read) from [<c0090dec>] (__vfs_read+0x20/0xd0)
[   51.140000] [<c0090dec>] (__vfs_read) from [<c0091508>] (vfs_read+0x7c/0x108)
[   51.140000] [<c0091508>] (vfs_read) from [<c0091d9c>] (SyS_read+0x40/0x94)
[   51.140000] [<c0091d9c>] (SyS_read) from [<c000efa0>] (ret_fast_syscall+0x0/0x3c)
[   51.140000] Code: eb010ec2 e30a0d08 e34c005a eb0ae5a7 (e5993000)
[   51.150000] ---[ end trace fb3c370da3ea4794 ]---

Fixes: a0b957f306fa ("pinctrl: at91: allow to have disabled gpio bank")
Cc: stable@vger.kernel.org # 3.18
Signed-off-by: David Dueck <davidcdueck@googlemail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d6380c187db6..ceebe2e3882f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -322,6 +322,9 @@ static const struct pinctrl_ops at91_pctrl_ops = {
 static void __iomem *pin_to_controller(struct at91_pinctrl *info,
 				 unsigned int bank)
 {
+	if (!gpio_chips[bank])
+		return NULL;
+
 	return gpio_chips[bank]->regbase;
 }
 
@@ -731,6 +734,10 @@ static int at91_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 		pin = &pins_conf[i];
 		at91_pin_dbg(info->dev, pin);
 		pio = pin_to_controller(info, pin->bank);
+
+		if (!pio)
+			continue;
+
 		mask = pin_to_mask(pin->pin);
 		at91_mux_disable_interrupt(pio, mask);
 		switch (pin->mux) {
@@ -850,6 +857,10 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	*config = 0;
 	dev_dbg(info->dev, "%s:%d, pin_id=%d", __func__, __LINE__, pin_id);
 	pio = pin_to_controller(info, pin_to_bank(pin_id));
+
+	if (!pio)
+		return -EINVAL;
+
 	pin = pin_id % MAX_NB_GPIO_PER_BANK;
 
 	if (at91_mux_get_multidrive(pio, pin))
@@ -891,6 +902,10 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 			"%s:%d, pin_id=%d, config=0x%lx",
 			__func__, __LINE__, pin_id, config);
 		pio = pin_to_controller(info, pin_to_bank(pin_id));
+
+		if (!pio)
+			return -EINVAL;
+
 		pin = pin_id % MAX_NB_GPIO_PER_BANK;
 		mask = pin_to_mask(pin);
 
-- 
2.17.1

