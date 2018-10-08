Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B740C677E7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BD1214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="o1GqYlAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BD1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeJIBdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:05 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59494 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJIBdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 9B38A1F99B;
        Mon,  8 Oct 2018 20:20:04 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022803; x=
        1541614804; bh=y86LgGaC+PYu/TqO6XCmCJge6MTF+Ti6+RsXqNPgXjM=; b=o
        1GqYlAPyry7DQZXltzPs4x2HB4M9/oC0FW7kfkTc4oVQ2WJoKQb7+u/iJEuPl0E2
        QGqtTt5qP68ezU2HMK7cg2/PaX+kgYaiAb+H32zGAZxlSUGexXi42+xxf4Y12Hc9
        0JVrRFleFQuEedu3jwkBGlMlLlYfze/UhmcRALEh2MgiMlkKvkaXEUZ5bTQIDjLR
        Ef8+9sUgGIL11hv5Kf41sO1Xh1CpcYbpOrnzxkdNYmfoRPQQZzniar0NHhDmgo2T
        BYf5TVFyrUXZqjxODuZ/l+vKvkNnIQSbUn07DnSzC/ZFZ6vfq6eZh9t4f/WdRM2I
        Nzg0z/ZDW33JUisOQdfC2cgLVDecbJVk+wmj2jPqcEaoehEptVpR4mfCoE7T/QCs
        xoFePlqqiJQCgsT/Ia1pJNGDRTBwHtjQMdVTWnHZ7ycVklptx0tkAvHjAd5NuKNi
        YGz39CywdG4w24z55NuGDvKMA7U8LkTvrJSyxtLukicVE7TjTCQZmxi1L7xwCxka
        cJ2aRS37KSO8Us8FjtLFDDly17dyAnxnF2qbA1NnFrldOTzIlt7KbsEaHrFksW3Z
        OT5ZZ9CRliHmjdENgisja+HfexYAMXzsA1iOarDw8CkMh8hy4k2tvx0Ll/2WpMUu
        giDrM6cGFYfUjLhgj/omSRvWEegDm6DhjHFj6ig3n0=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BSZIzbgzQSl9; Mon,  8 Oct 2018 20:20:03 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 47A3720FEC;
        Mon,  8 Oct 2018 20:20:03 +0200 (CEST)
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
Subject: [PATCH v3 7/7] mfd: axp20x: Add supported cells for AXP803
Date:   Mon,  8 Oct 2018 21:19:08 +0300
Message-Id: <20181008181908.9456-8-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 is compatible with AXP813.
Adding cells for GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1508d9113126..4befe474b165 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
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
-- 
2.17.1

