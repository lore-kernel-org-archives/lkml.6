Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47252C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53D920833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIZLFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:05:05 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:44680 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbeIZLFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:05:05 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id E14575FAF3; Wed, 26 Sep 2018 12:53:58 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
Date:   Wed, 26 Sep 2018 12:53:57 +0800
Message-Id: <20180926045357.20722-1-wens@csie.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
that supports the JEDEC read-ID command.

This patch enables the SPI controller and adds a device node
for the flash chip using the generic "jedec,spi-nor" comaptible.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This was working on linux-next 20180910, but now fails on linux-next
20180925, with the following error messages:

    m25p80 spi0.0: error -22 reading 9f
    m25p80: probe of spi0.0 failed with error -2

Reverting the spi/for-next branch makes it work again:

    m25p80 spi0.0: gd25q128 (16384 Kbytes)

Not sure what's up.

---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 9ee4f57557f3..2170cf63845e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -290,6 +290,18 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+
+	spiflash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		/* maximum speed for Rockchip SPI */
+		spi-max-frequency = <50000000>;
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.19.0

