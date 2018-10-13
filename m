Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAD5C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1820835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="BFzLtwUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE1820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJMPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:46:34 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44318 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 6A1C120929;
        Sat, 13 Oct 2018 10:09:33 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418172; x=
        1542010173; bh=zCS+BIMBUR1lR0ncFh1yMgxvx+0n0f4MUIcP6T3qxcs=; b=B
        FzLtwUf8klMqUIdH3DLGrgCPTF44UgTGb5UdM1yOwu4ObCIcPFVHDHtA+Y4NapUd
        mLNY2GAIvkbcwRd58nurXoXluXmV2FUNTwmc0KiXTgKV9xR0al/I07pHkGLJBG+w
        vtLAiJvDX04C1JlmgiCBkCVH2lVC2JIvwHZy8wv5tH2kiMQo4x82A9BHcUYxsucq
        BkHuH1tM/8CEU0FKzdIt0P0w0J8b0QmFH7m/QJhkdINXzRLzg/tmi59TcFg5D5UM
        B6MYq10pKo6DflRSFyn22HYvPg0G0qD4Ln3LPMpw8EsbrIvCDyYb/+KiXjNqkl31
        I1o2XlNM3MbVWhgh/yeqtq5pjrWlbZelQq5bL5gVgA/XePdNN3msunHI8BlamxD/
        3WhDERLq3a+T1DECuEECT2B2eCrkKDCEYozwuFhMRMEOjYML8/O1QEzKcawgUhGb
        lS9msTWJyqVXewqwvmkv+U1LitRlG1Hf43cWR5dyYFjC2VvgaZxRVOurweiW0rBl
        47XldLGLN83ok7+s44lyPk1hbE/wjbzq9YgwJcPYfEjQdy9I7o0lGvN81jt8RnKp
        KSlzx7ICdkvooNiaFLzaG1bIysGtj691bcHLBstx4F57+bgdNFdypLI8CVH4CgAM
        sJ5F0QUHTcsyp5+I99Qup17Yx6d9ASQIT6EoTixulg=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WbFWjAgolOLk; Sat, 13 Oct 2018 10:09:32 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 59310202F8;
        Sat, 13 Oct 2018 10:09:32 +0200 (CEST)
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
Subject: [PATCH v4 2/7] ARM: dts: axp81x: add AC power supply subnode
Date:   Sat, 13 Oct 2018 11:08:43 +0300
Message-Id: <20181013080848.29894-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
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

