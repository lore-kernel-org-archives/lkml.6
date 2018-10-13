Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D49C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787BA2151C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="u+KohG31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787BA2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJMPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:45:52 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44428 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeJMPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id BF69F20FEB;
        Sat, 13 Oct 2018 10:09:37 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418172; x=
        1542010173; bh=yUoz/J22jZ3O8qivvjzvadJN4Zms13Ygz3EIGWpJgm0=; b=u
        +KohG31FEjv8GbVQwIGL3lnpw1mWVfXXBvfqkskS5YhzUBkohleqMrcM5AHLLLEQ
        TvPpt/7Np5/Lh82xPTzGSGsnQc2+edrLA/8LgMnYESe1w7EHmkH5GVWgU3p/60fv
        3ncGRmrFtbMcu7R35lT9x20YdRrJeV04RNsz8RQ2f2CP9FLRFQfd/1pBrKgYV/94
        3xNOjl8BBGR4/VrBOdBcBjGoR/4vCcA/zqTXXvMScfK4GrL1JxBv6AgzTmqKzrVu
        WZ+YpkGXOQIvo+szNR1jSNFbxe9C4vYICWl1luGq9w4kQsVvbhKOpd+Wv0dfL9by
        b708/7/1grq/TsA6Co4I1jtqTnSnbV5Zuw/kg9OYwI2xnCeSapWg3mSNosoCSm1+
        Ux8LPQhjnY8OmPti+Tmn0UsiI6DfXo8YfRioSW4hDGW/aoSoCFfatnXRG2VFKUju
        iUKGrvQbi4Wfxa7rwegcFvzOSmcjiRQSVErRdpLeWZAw8WaWWHLOpJlWMoXlG14y
        mGWv4LWGHyc9NcZyKHziaVJnNXZRE7MWFf2wfk71NL2etDyZThewJmviJt1RWhzm
        pC8lcjbL0k0izl24hZVJi2c9f081ZLEn6acXkSXFHYCVe6ANgD6Ik+jsgwQ4iERu
        AR/GkvA7mVPCsDrZpyJgtJvKayMpqLATY8uJcNsOCU=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WBYLi7M9y53V; Sat, 13 Oct 2018 10:09:32 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id BA0F11FBA4;
        Sat, 13 Oct 2018 10:09:31 +0200 (CEST)
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
Subject: [PATCH v4 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
Date:   Sat, 13 Oct 2018 11:08:42 +0300
Message-Id: <20181013080848.29894-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803/AXP813 AC power supply can limit input current and voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
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

