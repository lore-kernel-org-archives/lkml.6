Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0576C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824FB24A6C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824FB24A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965129AbeGAQ6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:58:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031419AbeGAQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CAA9B92B;
        Sun,  1 Jul 2018 16:44:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.17 149/220] rtc: sun6i: Fix bit_idx value for clk_register_gate
Date:   Sun,  1 Jul 2018 18:22:53 +0200
Message-Id: <20180701160914.530061737@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Trimarchi <michael@amarulasolutions.com>

commit 09018d4bd7994c2c9f775029bc24589bc85f76fa upstream.

clk-gate core will take bit_idx through clk_register_gate
and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
which is wrong and eventually external gate clock is not enabling.

This patch fixed by passing bit index and the original change
introduced from below commit.
"rtc: sun6i: Add support for the external oscillator gate"
(sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Fixes: 17ecd246414b ("rtc: sun6i: Add support for the external oscillator gate")
Cc: stable@vger.kernel.org
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-sun6i.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -74,7 +74,7 @@
 #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
 
 #define SUN6I_LOSC_OUT_GATING			0x0060
-#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
+#define SUN6I_LOSC_OUT_GATING_EN_OFFSET		0
 
 /*
  * Get date values
@@ -255,7 +255,7 @@ static void __init sun6i_rtc_clk_init(st
 				      &clkout_name);
 	rtc->ext_losc = clk_register_gate(NULL, clkout_name, rtc->hw.init->name,
 					  0, rtc->base + SUN6I_LOSC_OUT_GATING,
-					  SUN6I_LOSC_OUT_GATING_EN, 0,
+					  SUN6I_LOSC_OUT_GATING_EN_OFFSET, 0,
 					  &rtc->lock);
 	if (IS_ERR(rtc->ext_losc)) {
 		pr_crit("Couldn't register the LOSC external gate\n");


