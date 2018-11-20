Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D9C46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Dasz/sL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A164A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeKUEW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:57 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34502 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbeKUEW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 794B32092C;
        Tue, 20 Nov 2018 18:52:32 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736351; x=
        1545328352; bh=pL7NHtztiwu1dc+uHme9yVhRXUCkKyzAdI+4FDYSySk=; b=D
        asz/sL71DL4WFNvSmxfSSmJSRLHoheUxvhjAvCuIHBB6ABAER5j+9wl9SjoFLDts
        2h288bdzOPZ+ZkrY2hKC+HCVcCcdoRsBV2A3ymclUf21K8HZoWWlPzuxMOYvtO2N
        UGPga3uspnJvkvmBBqIG0nNUkKxSlBFpLHNO7WT2TOOoVOft4W6OxXDXTcqOm17x
        sAUlV/FMWxlDaKfN/1tqPXletlgSUJno8RwjOoENopM5zLfuHcqPi9iOa8mq3bIL
        S+a9fRu5mA3/6OZPfOyqFw2y+njYJiDdJaI6LeMNXIe6Zrg75n7F5MoYlAYynFW3
        WrveiZ57PsUoKdP1uJDxBHiWCQFq4e35iW2XuN4Lc9U/+T1oTcXMqWdrotJAQP20
        7I+UooMZPKNtu8Cpm2V7CXCXV3nFbzTDWpfdiHdbpjgH5AqYHQU8iSBZIkTHFV19
        Nl8YAHquL3N8xoH5VVmnAHb1lXyU9Rzfsr6JdQY7PYqqe9Jkvmo1hlNsmJPtKDcQ
        mUjo+9hAW8tRPLJjkn5VzhfML/D0iQUZPOwrPnEXnJPx64VU/fR3gNjgTnKRoPEz
        VuGDQ7sVl0NxuosC3oh5TYML3xRSCOYo+S//dYigVWjqvHTCCtDOzh0kCf9yEpSg
        Z9iRAtixYH2TupWaoUDjROZhwo35eKm108qF9N8G0M=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XGCP2iq9fzti; Tue, 20 Nov 2018 18:52:31 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 7C9F02092A;
        Tue, 20 Nov 2018 18:52:30 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date:   Tue, 20 Nov 2018 19:52:11 +0200
Message-Id: <20181120175211.3913-9-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mfd/axp20x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dfc3cff1d08b..e415b967d38c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
 
 static const struct mfd_cell axp803_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
+	}, {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	},
 	{	.name			= "axp20x-regulator" },
+	{
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	},
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
-- 
2.17.1

