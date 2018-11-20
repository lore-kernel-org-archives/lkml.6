Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327DC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EC2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="V3BoHLrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7EC2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbeKUEWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:51 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34408 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeKUEWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id D368E202F8;
        Tue, 20 Nov 2018 18:52:27 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736347; x=
        1545328348; bh=jXIX8izX1CAuHrKZL/jrJD5rwgJGf7wij/BFmTD06Lw=; b=V
        3BoHLrhaO+Px60Sli9GHuJAHr8FwKiaxe776bYN5iyqCvnjqtUaDQmPZwmia0LM+
        le5HupPmqJb9j5rPL0++8wYB6A7CtaUnys2CJBObntGLNqme4nZAm80rFYKmFJXt
        YikTAVdjmFJNMJt7espFodEM1v4NtRwJ9qfc+4fkLlKbwMqJYg9H/Wszww4RRPW9
        Vj22qpmzXkuzmYWBk3lamVsEu0bp63V0EjydRFNpV/ckMOEJ9PaimPb/X9pVBYDq
        gGhbcILcbMxkPU74zgqnkreCBuXLt0FrXCUbiz8NGtq6svvJM5HDGJfQXR9UIqZa
        RfQNfnjyc7ffiSOeWfBnfP0XBytIdZ29t8/fm9+zQRVnOMG8EDDoM9xrpQuxMAvl
        ee/6hc57pU9jLdX4Du/xAOeXRHD+p5oyYbfDM/XPhZGXQ6jAobgz7FsG1bxwQCUu
        ZcUJWHUE4mhPt4gsKZf6UVDthUgOzj8TxydF9fh56qB27LkrfOTtN++PSnzYaeAe
        wwWj3CXS05AF9UDc2me6yP1tZovs8nuXe1ztBE3S/vRjoRfMOGSzUagXAlAgadj7
        803E4fwKOCuU9dfbUqpro2f2Jy5/BhxkHkZzP4aeEI2awo3SS/FpHeRicXTfWOhz
        I6CpoZZS4wshA9k3sXjOFgswzKIfDObmiLlNR3tWDU=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zE5kbDa9qa9w; Tue, 20 Nov 2018 18:52:27 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 90CB81F943;
        Tue, 20 Nov 2018 18:52:26 +0100 (CET)
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
Subject: [PATCH v6 2/8] ARM: dts: axp81x: add AC power supply subnode
Date:   Tue, 20 Nov 2018 19:52:05 +0200
Message-Id: <20181120175211.3913-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..bd83962d3627 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	axp_adc: adc {
 		compatible = "x-powers,axp813-adc";
 		#io-channel-cells = <1>;
-- 
2.17.1

