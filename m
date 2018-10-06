Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC029ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62E208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="bQkeMIOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B62E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJGEY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:24:59 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:53288 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeJGEY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id D279A1F99A;
        Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538860807; x=
        1541452808; bh=KKVyyBS4oW4DfmHiU/gqRxlOHearp/uEX7HgGQY69JU=; b=b
        QkeMIOE+q5nfrVnH5EH7pS/hS39coFr30nf9FxwzWIqoWbp/jSgBecix+F5JrkdT
        xjXLq2Hy+CkS2C9mglX5MTsMHN2JAin277J6aPWCRq4NnHLUpBXXOvVPML0vQeK1
        wDjSfX8WdbAdj9BxmxvgWOayfh3fqWQzgkEFUlrWINVemIg0AiuJeeOSbrJhE605
        qEieFdj8vyl+X3zDuP6qTNaBz2JBadtA2j5nvYqcybKgomNq7IbQM5BJNEx7DLHT
        4ckEX/EPr7ed3MKFwpqNR1cNCDqgPkDNnBtpZks8ymiNY+H+QKcj0LTOV26vRmaX
        ATCws1CbmYnFs7DvYcJONFLhTgSYuJfJTGxD6fOMKraxXHkYKfDB52Me49gzuHt/
        bmtbU5vVvmTlgBSIPV0UXKnhOe6KFg+Gmi5foZDV0cVZwmOWMDyFG2OOUDKl6q38
        6PZyxdpFT6u1l+ggZSpovu+0WsXBM7jS3L2jpdUSpMAQtT1VF0KYeng4NQhNFOfk
        YiZYzu5NB78eplaPUAJt+V6Ohy3dlefnl1yOKYO/FT3NO0bQdxGhpLzfbJ+PLfC4
        NKsEYdYAoD3MnQWE65zwu8HMILGVFf8sAwUjD/FneOsursxJV+R8E/srrd0H2ms6
        OBlaKCwPfuDHEECVJrLypExvBEghsahioBXgNgS6Ek=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id v4DppIMPGo09; Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id B185F1FBEE;
        Sat,  6 Oct 2018 23:20:06 +0200 (CEST)
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
Subject: [PATCH v2 2/6] ARM: dts: axp81x: add AC power supply subnode
Date:   Sun,  7 Oct 2018 00:18:32 +0300
Message-Id: <20181006211836.28253-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
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

