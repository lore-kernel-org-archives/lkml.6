Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7EDBC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF902086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nzkg7UdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF902086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934303AbeFMGkJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:40:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35872 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933696AbeFMGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:40:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so860968pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GuFBaPGj5UtNr+isnApzAV6VlnxDQ4xF9RZHfZlSpGY=;
        b=Nzkg7UdKaDOiZr7llVkrDmZkc1mpAvXxOboyWzbWl//wEQ9QeRQWFeW9/ol7Znq9yU
         xfBjLj5cOaMZZJgDGW1m24XUBzNWONUIENIki5pyKOWydXBq+5nR4E31AHj2/98VhBRv
         a2jAVrZyE/5anWPn1WbxLZmgX7/iQLcmPwH5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GuFBaPGj5UtNr+isnApzAV6VlnxDQ4xF9RZHfZlSpGY=;
        b=PrXSt80UJxcBXROEny+JUC2AH6k+tgdszgEXfT7/7Q7I6UbmQj8X8gpJS20VcGqrit
         sOgZYOKC9vrsEIBMV6E3rNDe5+t51QTlkOKB/4Mlzcspugm56l2euTwJmXs92HuSegHV
         z3r7PSn0IXWQ/92Td8V+9l43EPSnjmk8P+UnMVoxf35TpQks8EImnRudCHm1/e7jvMfj
         ndoi7gYFL6jPrbdbQztHUbmf9IYMFCvXcLhMhkbfWiQjDln40U8uc/2wdnxRem7Pxmsk
         Yrpya2k6081MIpeJuyFYKkILp1rc8Q7/zayTCp3OBr3tY7B9yZb69IiVHaUsJTqjOJ5i
         EQEw==
X-Gm-Message-State: APt69E1TpGGghhwTKDrwyCinxcT1h5yDJDYepwKXlM1at9VJRvL+hWkf
        SR0+79OPL+iUs5NQfBJ+ksqqWA==
X-Google-Smtp-Source: ADUXVKLNecJ0SfjBqoqABQ4Ri2yrhXz9YlUQN/0+J+8d0EU0v399PIIr+Uus1vJ6+RA9whmvbC9REQ==
X-Received: by 2002:aa7:818b:: with SMTP id g11-v6mr3648159pfi.50.1528872006876;
        Tue, 12 Jun 2018 23:40:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q71-v6sm926738pfd.165.2018.06.12.23.40.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 23:40:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller documentation
Date:   Wed, 13 Jun 2018 14:39:47 +0800
Message-Id: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1528871668.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs ADC controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
new file mode 100644
index 0000000..8aad960
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -0,0 +1,36 @@
+Spreadtrum SC27XX series PMICs ADC binding
+
+Required properties:
+- compatible: Should be one of the following.
+	"sprd,sc2720-adc"
+	"sprd,sc2721-adc"
+	"sprd,sc2723-adc"
+	"sprd,sc2730-adc"
+	"sprd,sc2731-adc"
+- reg: The address offset of ADC controller.
+- interrupt-parent: The interrupt controller.
+- interrupts: The interrupt number for the ADC device.
+- #io-channel-cells: Number of cells in an IIO specifier.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+
+Example:
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic_adc: adc@480 {
+			compatible = "sprd,sc2731-adc";
+			reg = <0x480>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			hwlocks = <&hwlock 4>;
+		};
+	};
-- 
1.7.9.5

