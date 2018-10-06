Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D9ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2E208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Z+QbnGZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF2E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJGEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:25:02 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:53360 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbeJGEZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:25:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id CED9720790;
        Sat,  6 Oct 2018 23:20:09 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538860809; x=
        1541452810; bh=ruX3wZR0GTvecoOmNyFlvQ1sc+zejmHze/zVBbMEiUA=; b=Z
        +QbnGZyfyBMPI3gsGxPPDQL0+T8kdMYNwDE1mWjnDDD0PS4kJ8CVJxbNHSQtlTQd
        yXZ3qx06Z36tWOTHKMO76N0CAuzCQGRainReSSucpatylm1vazRgub8BdvEV39ja
        REL8y0+E0LpCa53/Iiqf4QfA8OW/KBzgE5/l8pTo2UQ02W1igpYLqDu4p7HPP3Ll
        6+0ghn4XYxjnzgHjiyddseFqHYRu6GvFgOJlWxRNdT0BKyfJhS0tpzN/8fMw+sLg
        MlFAFDg8VZSXEXHmPc2dzrwe9f/1riNXWlRPmIIRmLwoIR5+aQxhyA0B/uzSNq22
        bD53JMzuQM95pf9kN+KbFVvxyDJIN/8CwnqsHxfzuOU+8z0YxqoLtGWukg/hMcw3
        y11L5TNTecGeoxPs9dhfVcGb+KLQaYo8ICSwjhvscSUQt18hhIgBh7m02+5FqPsQ
        diWTXqjRcsDeNm5AD/i+4sEfvPx8ct4sGvkdmZPL0JaX9/Mv40OO4b+hZhQ/yFGe
        GOs+d+9xehfcaGYBiHmNufz64N768MPVHqzSG+i0cjKgFAZcuKzidAMyZVt8COw7
        BQ2zmi+6MuX3ofoF0vJOoYymHSUyLAJ99+4v/9M0NP+1BCMNgqUaQ2nv3aracH/V
        eBVY58KGRTlOE2ywRaMLIfH3I/84nOFEcMPkOrLrao=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T9ymSrKY-3T3; Sat,  6 Oct 2018 23:20:09 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 729211FBEE;
        Sat,  6 Oct 2018 23:20:08 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] mfd: axp20x: add support AXP803 AC and battery power supplies
Date:   Sun,  7 Oct 2018 00:18:35 +0300
Message-Id: <20181006211836.28253-6-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 is compatible with AXP813.
Adding needed cells for AC and battery power supplies.

AXP813 AC power supply cell added.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c       | 22 +++++++++++++++++++++-
 include/linux/mfd/axp20x.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..215f0b009728 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator"
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp813-gpio",
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name           = "axp20x-ac-power-supply",
+		.of_compatible  = "x-powers,axp813-ac-power-supply",
+		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources      = axp20x_ac_power_supply_resources,
 	},
-	{	.name			= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
@@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name           = "axp20x-ac-power-supply",
+		.of_compatible  = "x-powers,axp813-ac-power-supply",
+		.num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources      = axp20x_ac_power_supply_resources,
 	},
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60eecbcb..2302b620d238 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -266,6 +266,7 @@ enum axp20x_variants {
 #define AXP288_RT_BATT_V_H		0xa0
 #define AXP288_RT_BATT_V_L		0xa1
 
+#define AXP813_ACIN_PATH_CTRL		0x3a
 #define AXP813_ADC_RATE			0x85
 
 /* Fuel Gauge */
-- 
2.17.1

