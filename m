Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24720989
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="VC56qkky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLHRiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:13 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49672 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeLHRiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 9832F20929;
        Sat,  8 Dec 2018 18:38:08 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544290687; x=
        1546882688; bh=jXIX8izX1CAuHrKZL/jrJD5rwgJGf7wij/BFmTD06Lw=; b=V
        C56qkkyMJYe69QQFeBiWzvF2PiU0dc96IN4LSCOAlbqH58x6mYyhUYJ3XVT5EIOI
        /pL22kDKb7h2+tGxcBbaMJB9PtroCRjus5rxAhTyTcddmR7zS0o32J9GapTDHQwY
        OygE4IhXnKZGANbVR7MrirgmA+mbxQC+MQJT8q39+ZGy9MfCTpqbazm3jTJeFEPp
        2+Q1mGvswMtrTMIDsjMfjT6na/VI5Q7XmvYfN5BPv2LEORGY7HcQSCWXzEacX9vp
        tQjH/KE4AbLVB4MUvKCLn+3NXhRNgeQ0ExJu5PFRXoGEXVowwyy9TpgsOaYhseCf
        gV5PTr+1dO+oBV75gWVI0z0cLWiuk4y/SPW04W6PpWqdtnBknEATMtXM3NAcLUv3
        umeYfqfh6MehdLtGaSAbAVA982f/HmR1+M7mI4RmKBTjFq9686II6wSHXeh3IpKy
        HaJ6QdWkJNcme4LMDWOpZEn8oSzbjMt2EYCMw+usgUP63iNtPY94wkHzyv3zRRms
        4xbV3sGpvehZ4IOkbZB4jjWN73L96Iip5t/AO+RaZM286PxWR6B9Wux/f4U3XQ+8
        dP+G3PJeymchEhuh69EzKtE/IFGZx21mu3sLMDTiGXKGrZVUbMwuts7shrAm6n17
        YS3IndTphn9aZwB3b/3fJfYvl0cjdrugz3z44pszrM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IR-2xEhYvnHh; Sat,  8 Dec 2018 18:38:07 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 42E4B1FB8E;
        Sat,  8 Dec 2018 18:38:07 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 2/9] ARM: dts: axp81x: add AC power supply subnode
Date:   Sat,  8 Dec 2018 19:36:11 +0200
Message-Id: <20181208173618.31395-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
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

