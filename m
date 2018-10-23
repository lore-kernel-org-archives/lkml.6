Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B620C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D52075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="rnDGV2mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412D52075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeJXDSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:48 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45790 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeJXDSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 634881F905;
        Tue, 23 Oct 2018 20:54:05 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320844; x=
        1542912845; bh=j3Vl2TNmgvtTSUry15fj4Q/WOZ4rGD+1mEVBj65G2EA=; b=r
        nDGV2mKCRwEHJRvK0sc8FtP+Ns1Zt05hHAOdnszDRJ8rscqhwqGpX+z0kHHEB3OH
        0PHkGAeqydLSyVBc5PbogTZ1GVCilpuhbSd3RPrOh398uWgMSSx3eDaiL+ULolIE
        jsDHsxBYLS/2kXtUWGUaGAox/suBuAajoLl8dipe/UVBzFO3YqWCj4bU6j03fTyQ
        HHWzL3PggMoDY1quYdQHwh7yWrLEDxVW2qCdcMW+KLlZ17R7MN2RXEXUQuOdDt/h
        j1fzW7JG7gDzPUdWBQPxEfUvszPw+DDiOMmrEui8yvGxvEDADxiHRxF/gAbStjIq
        n+fQrBo3LEnHKS2z56a1IrfKKLZG2jCUxyhpve78013D1RpQ5bDR/jOwJqJZV+XV
        s5LZOKFLF5naqctj194A7o6NsCXu8z2pn20qZlCDV28O6c22JJpegmO0BhFrcZ4D
        SDl5B9ltCU3QrcriwJ8kcZ443R52BNe9RN3lvLTavlFt5U1GS6CNop4I7YJk5CTl
        vYcANS90/5S04P+jSBGaTRsMIB24G9Bpmn3WaJMWr9N+QPRpAajLMe5AzaOFJJgQ
        p0AO2NIO4ZNkafGAJU9OHHmRkNa5RED0TkKe9RWzgRE/k41tgxxH9qy5W3Cpd7RN
        kmUAMj0nPrfij9c7+yTufvM+cLxn9xAzhzlDUjmR5A=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qLiMwXuBKNHI; Tue, 23 Oct 2018 20:54:04 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 02D831F99A;
        Tue, 23 Oct 2018 20:54:02 +0200 (CEST)
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
Subject: [PATCH v5 01/11] dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
Date:   Tue, 23 Oct 2018 21:53:20 +0300
Message-Id: <20181023185330.10472-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
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

