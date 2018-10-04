Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18F22084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="s0faqtGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18F22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJECf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:28 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:47762 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeJECf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id C6B3E1FBA4;
        Thu,  4 Oct 2018 21:34:43 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538681683; x=
        1541273684; bh=KKVyyBS4oW4DfmHiU/gqRxlOHearp/uEX7HgGQY69JU=; b=s
        0faqtGJ4xcflRg0rkHPkg3nk8NDHGGnjVuoeHOnHl6aJLCPfv2ExZ6T4Ak4/cVUE
        cSsOP3XCVTQxqv2C9pxjcrWk1GkBUhq3PE+gND3q1xh1QDjW22Ospg7XY5laF3+F
        T1+sPhY9mdkjwHJRSwPGvv5u8Rah+nGYUvHLC0LA9FT409gD6tx9mcypIcoitSG/
        VvLMRPxp4ryzVKP3gcHxxH/Q6bzIrzb2INn/d25BTSgLEtNrXDEEL8OrYx+P0wYK
        KU3CWT++yvj5dXYvdmaPbxnCgIWSels4axL57MFfa0bH28gqkM0GKRl30KLD4Ec0
        wk7MXQY5miEK3AaQ6/scGKlcnurJAKAqVOwrK3zZdpY+fIrfcq8tdTBe5znDI0+S
        SnWDkmvsSAjuLB6A7XAa3OVele31YRa/Vx8GaxiBQadxqNASyfafHf+5JA4WcxAD
        jc0iismFAATSHySWuePKg4Wfr9ycoLOErbRkC5B2d9RCkY49Ailg8BJtqAmNYfY5
        ooMTTqzAshfqT7qa66KmBe0aS09C4C/H5wKf4Itvbpx1TYNUioAnXzRopkHTq7uy
        PYg8eIB//Kv2q/7tfzrVmOxPTaQfSCYtjtDPtJvBrPPCNnZAjUzLxn5yXvAPtx6x
        mVJKn6hsiaDk3CP8rBlNR9R+RAIRkxJQCmvBxITGqM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id B_W0kFCemLKR; Thu,  4 Oct 2018 21:34:43 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 6B4531F99C;
        Thu,  4 Oct 2018 21:34:42 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dtsi: axp81x: add AC power supply subnode
Date:   Thu,  4 Oct 2018 22:34:08 +0300
Message-Id: <20181004193410.7265-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..67c17151b584 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -69,6 +69,11 @@
 		};
 	};
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp813-battery-power-supply";
 		status = "disabled";
-- 
2.17.1

