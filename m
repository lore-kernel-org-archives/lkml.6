Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429ABC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCFE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="kSjTjqCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCFE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJIBdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:02 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59350 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbeJIBdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 583462092A;
        Mon,  8 Oct 2018 20:20:00 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1539022799; x=1541614800; bh=XwIR79O3FcL1OK
        3t6jAk+zFJUbfkP6n2gD5rPprP96g=; b=kSjTjqCE9627GtlE/Iqlx42IvnAGIa
        BPQLPyW2JILLV0sm8kSb936jXny/YBXM2rpziiUC+t71WXaUs+GsF1//wVR+Cwtc
        BKei9LgObRxEsmtVR3fRp/HRI86X2Z6sK83F5g+6r8e3UAGrCfQTex01yg5PP3+F
        aM7gDU12Od6yIHtjbU8mcDuR0wm1ThMuSGxWpf1sFTY1SiYHOGKjMiNvZ4FsgSG6
        EtbUhWnbN+/7z/1sdf19SI16kvX80TtIVIRh1Bh6RuY7WqSFt/k5PXeLYwKO+gSu
        00Fp1fQi61nB/dOwh7tCtkI98NeZsxMqMfbyWUksTDmCG/aKfQFnjEDadLNkykw8
        CLZdwfhjsb0IWKd0NuFPEpBlfwvYtfo+e3FE1obNqtoUftxwvlNL1uTtUBs18iT5
        UmSZysNu9rEn3ISPBeLAsFF0D5CVzbnr/E6pJ2aAE79Yubh80a8v3FMqQ9eDwprN
        2mzFTospbqfyBw65aqjjeU1XeIoZBTiT8Gcep8yv9h4fXbCzn/7KNFIpdY5jE0gl
        JIAagHGlK8Vkpo+i3nn41g2PagbmlX6bn0QJuEOqYLsDU9O1JLK8eZGP2qOM8oD1
        hlOrJuMTl8hK7/FaXyAvZYM+m5FzkamsLEaahz/SZ0ulu3yg7JCWrHhhdaZTkG7D
        TlVXJD7tiuSR4=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zv-w5eABDNVh; Mon,  8 Oct 2018 20:19:59 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 245981F99B;
        Mon,  8 Oct 2018 20:19:59 +0200 (CEST)
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
Subject: [PATCH v3 0/7] AXP8x3 AC and battery power supply support
Date:   Mon,  8 Oct 2018 21:19:01 +0300
Message-Id: <20181008181908.9456-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Oskari Lemmela (7):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

 .../bindings/power/supply/axp20x_ac_power.txt |  3 +
 arch/arm/boot/dts/axp81x.dtsi                 |  5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
 drivers/mfd/axp20x.c                          | 22 ++++-
 drivers/power/supply/axp20x_ac_power.c        | 92 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 7 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.17.1

