Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E14C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA8F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA8F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeIMTX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:23:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbeIMSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 619F1D19;
        Thu, 13 Sep 2018 13:46:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/115] clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399
Date:   Thu, 13 Sep 2018 15:31:37 +0200
Message-Id: <20180913131828.358565784@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Levin Du <djw@t-chip.com.cn>

[ Upstream commit 640332d1a089909df08bc9f3e42888a2019c66e2 ]

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
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-rk3399.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1522,6 +1522,7 @@ static const char *const rk3399_pmucru_c
 	"pclk_pmu_src",
 	"fclk_cm0s_src_pmu",
 	"clk_timer_src_pmu",
+	"pclk_rkpwm_pmu",
 };
 
 static void __init rk3399_clk_init(struct device_node *np)


