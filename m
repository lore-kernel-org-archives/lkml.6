Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97123ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC020856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAC020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJZOem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:34:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:44529 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJZOel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:34:41 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Oct 2018 14:59:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6AD8A180B67;
        Fri, 26 Oct 2018 14:59:02 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 26 Oct 2018 14:59:02 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E601E40394;
        Fri, 26 Oct 2018 14:59:01 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id AB952120144;
        Fri, 26 Oct 2018 14:59:01 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com
Subject: [PATCH v2 1/2] spi: uniphier: fix incorrect property items
Date:   Fri, 26 Oct 2018 14:58:44 +0900
Message-Id: <1540533525-1816-2-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes incorrect property because it was different
from the actual.
The parameters of '#address-cells' and '#size-cells' were removed,
and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.

Fixes: 4dcd5c2781f3 ("spi: add DT bindings for UniPhier SPI controller")
Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
index 504a4ec..b04e66a 100644
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -5,18 +5,20 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
 Required properties:
  - compatible: should be "socionext,uniphier-scssi"
  - reg: address and length of the spi master registers
- - #address-cells: must be <1>, see spi-bus.txt
- - #size-cells: must be <0>, see spi-bus.txt
- - clocks: A phandle to the clock for the device.
- - resets: A phandle to the reset control for the device.
+ - interrupts: a single interrupt specifier
+ - pinctrl-names: should be "default"
+ - pinctrl-0: pin control state for the default mode
+ - clocks: a phandle to the clock for the device
+ - resets: a phandle to the reset control for the device
 
 Example:
 
 spi0: spi@54006000 {
 	compatible = "socionext,uniphier-scssi";
 	reg = <0x54006000 0x100>;
-	#address-cells = <1>;
-	#size-cells = <0>;
+	interrupts = <0 39 4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0>;
 	clocks = <&peri_clk 11>;
 	resets = <&peri_rst 11>;
 };
-- 
2.7.4

