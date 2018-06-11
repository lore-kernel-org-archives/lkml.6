Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 09422C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A2420869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBBjFFLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A2420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbeFKWxr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:53:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45204 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeFKWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:53:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so13166180plz.12;
        Mon, 11 Jun 2018 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O3/sDB5m1O0gbhdJDvI7oiQvS/wwV6wbO8Os91tmW00=;
        b=qBBjFFLV64WolwvSk/S9TrI5ou+UR9BzGoVQSqHTxg3pLfTQwkQ/KCylTW/yLTeErJ
         yOWEieEjVJ95Fh4vzW8UEB051siBl/a2Ee2qUi/2jC5fLvNWQgTyjaG++CgfwjFecxQI
         NwnhG2S6Qu2DjwKq/iGXoF0GoR01zhYxozozcm9cFqoF5KtUDv+Vr7i9W9ByPFtrOyOR
         DRmaJ1Xd0tEAIIFivFQ1JtCo9Iprq5XYWwubbu5x2ENmMLndcTM+R/J9jze6+sc9aakb
         IMXNf0B9kTGYV5GgDfmXOAmqjU+27uNY3UNTK0smdbz9Wma+Dj1wt/QBToqPMzHnihTI
         7R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O3/sDB5m1O0gbhdJDvI7oiQvS/wwV6wbO8Os91tmW00=;
        b=X7gefS3TZgdqWX6DmtMuaUq9NwMTN1IiVInBcWOD0t5qGLfcwcU/Tggu9zsoDjMbQq
         Vi3JvzGqt7Qx8k6+0UobWh/lqkNvSDDuSz2UQQnjXeLhGngs/xPMuikGF6tiSwct3uqz
         qVqU8KFFys3xUtsqLQqpibYVc59b2rsZoKnFcvu990WUjaP8mxO+up6JwRCsyNzyBTnN
         6LVzZeLnlip20OfPEIhTRGYJfZTvGE9putR/Sq4uTMh1g5mUZQ89krm4e1STfn8dRt1D
         aPoMZ0tX2goSOH8O7iP+oDgRInMSZ/yukWkrTlIKThGHu466L7ZPAVIdhx9HeA1aHXPg
         Z99A==
X-Gm-Message-State: APt69E00w2v39MDirPXfdFCzp74vJfJaFC4LkCskZSE1dAyLX+bihCWF
        XreBjMLk3qe9bPy+j1lKEIk=
X-Google-Smtp-Source: ADUXVKJ7Y9Ws0wsz6e+nD4ywVQZUsn2cZLIB171X+0GGR0VKzg5a8P/7vA0uMxyuAQBnBP2Z/LWLAQ==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1-v6mr1117835pld.29.1528757624676;
        Mon, 11 Jun 2018 15:53:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u14-v6sm13300228pfd.103.2018.06.11.15.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:53:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM5301X ARM
        ARCHITECTURE), Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (open list:BROADCOM BCM5301X ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301x: Fix i2c controller interrupt type
Date:   Mon, 11 Jun 2018 15:53:40 -0700
Message-Id: <20180611225340.12733-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c controller should be using IRQ_TYPE_LEVEL_HIGH, fix that.

Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9a076c409f4e..ef995e50ee12 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -365,7 +365,7 @@
 	i2c0: i2c@18009000 {
 		compatible = "brcm,iproc-i2c";
 		reg = <0x18009000 0x50>;
-		interrupts = <GIC_SPI 121 IRQ_TYPE_NONE>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-frequency = <100000>;
-- 
2.14.1

