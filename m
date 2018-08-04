Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A6C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E584D217B9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E584D217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeHDJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:31:38 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:57014 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHDJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:31:38 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.160])
        by regular1.263xmail.com (Postfix) with ESMTP id 5A6D11EB;
        Sat,  4 Aug 2018 15:31:39 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 8804D387;
        Sat,  4 Aug 2018 15:31:36 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.108.240
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <c303d7e852f18bccf51a4d887bc5525c>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 7
Received: from localhost.localdomain (240.108.33.59.broad.zs.gd.dynamic.163data.com.cn [59.33.108.240])
        by smtp.263.net (Postfix) whith ESMTP id 13908AEOABI;
        Sat, 04 Aug 2018 15:31:37 +0800 (CST)
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v0] clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399
Date:   Sat,  4 Aug 2018 15:31:02 +0800
Message-Id: <1533367862-7212-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

PWM2 is commonly used to control voltage of PWM regulator of VDD_LOG in
RK3399. On the Firefly-RK3399 board, PWM2 outputs 40 KHz square wave
from power on and the VDD_LOG is about 0.9V. When the kernel boots
normally into the system, the PWM2 keeps outputing PWM signal.

But the kernel hangs randomly after "Starting kernel ..." line on that
board. When it happens, PWM2 outputs high level which causes VDD_LOG
drops to 0.4V below the normal operating voltage.

By adding "pclk_rkpwm_pmu" to the rk3399_pmucru_critical_clocks array,
PWM clock is ensured to be prepared at startup and the PWM2 output is
normal. After repeated tests, the early boot hang is gone.

This patch works on both Firefly-RK3399 and ROC-RK3399-PC boards.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 2a8634a..5a62814 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1523,6 +1523,7 @@ static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
 	"pclk_pmu_src",
 	"fclk_cm0s_src_pmu",
 	"clk_timer_src_pmu",
+	"pclk_rkpwm_pmu",
 };
 
 static void __init rk3399_clk_init(struct device_node *np)
-- 
2.7.4


