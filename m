Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE28C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224A9206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="jQUshi1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224A9206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeKUEWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:52 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34382 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbeKUEWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 6B37B20790;
        Tue, 20 Nov 2018 18:52:27 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736346; x=
        1545328347; bh=j3Vl2TNmgvtTSUry15fj4Q/WOZ4rGD+1mEVBj65G2EA=; b=j
        QUshi1dTw7vd1JvLh7mvyKcPN4wCyG4Kkm0Ctl1vnb6G5OWIgaugN4GpS2oveJQZ
        VcB+KEsE5q6lrmfzTZ5XMVUFJHFy9evVG/hXsrJtLLXtYxZ0OYAJ0qn8A47OtJwT
        ghdgxpmJXdFzqOQnoKnxyK6tFwhkrKIx0jKfslhcB9CaqAUi2WwASbNTTrj0b0XO
        F5ay/m1aU/v/3/c0VxnMlrkOABZPYVmkzhZtMEzoiGTywUhk/dZcyembR0wEN7MZ
        m55IukQ+Ban8rQE6PXoerC1cIEcLpA32fElSSue7K9NDReo2vOdoJ/kF5lsVc7W7
        in7tF3JzJawW3ZkQLzTwDJ6BLtppIJmysf10Te32VXfR3fUpMp6si+eOg8YEdKYs
        /PtRj9t90/iz8sc1pE3M2xigJ9srzQD7+N2G1duagyhxWCIhQ+k/c1R+5JTzKXIv
        nJUIojCP2GeAI/wk7tYvJ+2zdruydAIXg0WIRFeiqKC9UkLHmSka1qpni6nPsJpC
        o3+KTyqdSPfmpFGOgOVn1cZPF6TlQObfScwyR0kt9bSXarS1c4liZGenkiC5VW5d
        GrswLZc8V62iy3TCLTPq4eZilEEpjJja+qMQmZadG++dKcBPf+kW2OGAxPaINgEZ
        YK10AAhoVW5baIctYFGKwxYEJfIYMGfhET2iBoVAtI=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4uSEDpi4Hvr3; Tue, 20 Nov 2018 18:52:26 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id DEECE1FBED;
        Tue, 20 Nov 2018 18:52:25 +0100 (CET)
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
Subject: [PATCH v6 1/8] dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
Date:   Tue, 20 Nov 2018 19:52:04 +0200
Message-Id: <20181120175211.3913-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803/AXP813 AC power supply can limit input current and voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 826e8a879121..7a1fb532abe5 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
@@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
 The AXP22X is only able to tell if an AC power supply is present and
 usable.
 
+AXP813/AXP803 are able to limit current and supply voltage
+
 Example:
 
 &axp209 {
-- 
2.17.1

