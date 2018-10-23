Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF332075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="S4ZFqzUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF332075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeJXDSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:48 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45816 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbeJXDSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id A70221FB8E;
        Tue, 23 Oct 2018 20:54:05 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320844; x=
        1542912845; bh=k3hRch9kwYKaig1/554liSX6evfpQRGPH5Lx06DPVFc=; b=S
        4ZFqzUXVboMJEr1rfqPU3TbqncDyUcXGKB3T6EwLST9b/GjRy4eZCC7Xh3tloDDX
        SDNbwS7uldXqE54Vj2mGMoHF1B5WO6kiUMUx5Ij1NAKx86JZf/wqyuCkOLlsa/ZV
        GS0eAz8eFYyGhIKXLkJBk8bmkNNgrOvrMhOVbfX+BfT7QfNOjKIwZSRTGpsvpJF6
        LucyuDGXZieTKop0Q7j6i3rXSfx+i77isIoX7VtzTLrG2dverzeQ1fC3Lo6bGmy0
        p+Nv009hLRojMuGenZpB1FsXn0eeFe5M5thjeiDNxz0SxeeqI9lmGegQOaDYknNU
        /xKSdWzczsj4dhkzRXk6DQ44yMVqF2i2UD3D7eELX5e0BdWTXD985BC6D9fOhG3B
        wk8GmFZxwfFFxcg0EUCaDrISn0qwqHk+w2wGuiER6gk/5yFG/1n0ImHD6KaTkF65
        12D/ozsfXuaJnIgLbncwyQ0urOKp65nzio9rPULwgSH1HlohJsf3bLZtC+C0O4F7
        2Lm8NaSx+pYGBWAg579lXuiU7FzBjcHXxaC2DIYFNaRDJgizVES/am5RWATf7COG
        0eFO1vj3jjB/SJGR5LXm+W+B24xVjzJUKxkZpI94F/GHDCl6cRejuH9TPkb9Edcw
        mEQbCTUIPm7w7j3J1MDngC+Y2+lE7UyN8k+gAhfHbM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qAkoHgeLnzrL; Tue, 23 Oct 2018 20:54:04 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 2FCB41F984;
        Tue, 23 Oct 2018 20:54:04 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803 power bindings
Date:   Tue, 23 Oct 2018 21:53:21 +0300
Message-Id: <20181023185330.10472-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803 power supplies are compatible with AXP813, but
add specific compatibles for them.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
 .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 7a1fb532abe5..acdeb4b8f4cc 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp803-ac-power-supply"
 			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index 41916f69902c..780ebd7e3b84 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp803-battery-power-supply"
 			"x-powers,axp813-battery-power-supply"
 
 This node is a subnode of its respective PMIC DT node.
-- 
2.17.1

