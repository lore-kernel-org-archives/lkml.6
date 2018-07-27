Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AB4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F0B208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcNh0xkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F0B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbeG0NmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35038 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbeG0NmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so5302898wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9G4YyZAdOqI9TSlqZYFLNXpTxS+xcOq3a9AfDevwbLs=;
        b=AcNh0xkCJdaWOKQg2nkJH4VD0qSGsfj/C+eIpZrnfsU+i/cqvDFU9qnzD2suY7K1DZ
         n/cjWj/QouEw6y0d+s5YuoMofzMHqu80oEJsOZaSyL+nUqBstZw2k7JtcBjH0XUhFPmd
         xIYlrT86rJlUW0FLFjHryFFmuy7RS4zWzRSek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9G4YyZAdOqI9TSlqZYFLNXpTxS+xcOq3a9AfDevwbLs=;
        b=Iim0rB9X5YLm+LgGOR+W28UPfpJ6LL4C9S1B7l92fm3epTMLRBI7dgUl4qSpaGGVMw
         zR3mN9r1U+PQSviRlVicuEyzBy4dfUiRcaLouwImRL44mprnXyR8U6K6HddnV2giWiYP
         dAFQlF61X8J5HI82evH5MxVj5cnuu52q8K5u8UgIA+jm2Hsvrr7f4uL9JOr1UZZptnhQ
         sEazMSFC9gEYXIquXJbPrOOR+EQkr3GZ4EDNC4sD2JaatfPC949AvVuCV3KMXzHkQ+Yg
         JQZkm3DeNTReeEnLF/Q/IT7jZ1ATPDlPDtqZ2dXq9Gy+1b8wwWngYQ/q3pP6CfhJfVhY
         9hvQ==
X-Gm-Message-State: AOUpUlG7i+R9Ty8V0qylyoJ5UxgpCF/XNQ27ITbEMVPqwCB4dMzDMJdx
        vQTXETGwIvsHf4h7VT53xa3BFA==
X-Google-Smtp-Source: AAOMgpcTuAobqLRxpINJ54CmJKxVnEkLQTYBqOkhBoN7/XB6Vfjfi9pll04XMEFQxN9Wa6IKGTvlCw==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr4379795wmb.27.1532694024706;
        Fri, 27 Jul 2018 05:20:24 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
Date:   Fri, 27 Jul 2018 13:17:57 +0100
Message-Id: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt     | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
new file mode 100644
index 000000000000..1d8d49e30af7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -0,0 +1,123 @@
+QCOM WCD9335 Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
+Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
+the MSM8996, MSM8976, and MSM8956 chipsets. It has in-built
+Soundwire controller, interrupt mux. It supports both I2S/I2C and
+SLIMbus audio interfaces.
+
+Required properties with SLIMbus Interface:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: For SLIMbus interface it should be "slimMID,PID",
+		    textual representation of Manufacturer ID, Product Code,
+		    shall be in lower case hexadecimal with leading zeroes
+		    suppressed.  Refer to slimbus/bus.txt for details.
+		    Should be:
+		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
+
+- reg
+	Usage: required
+	Value type: <u32 u32>
+	Definition: Should be ('Device index', 'Instance ID')
+
+- interrupts
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Interrupts via WCD INTR1 and INTR2 pins
+
+- interrupt-names:
+	Usage: required
+	Value type: <String array>
+	Definition: Interrupt names of WCD INTR1 and INTR2
+	Should be: "intr1", "intr2"
+
+- reset-gpio:
+	Usage: required
+	Value type: <String Array>
+	Definition: Reset gpio line
+
+- qcom,ifd:
+	Usage: required
+	Value type: <phandle>
+	Definition: SLIM interface device
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: See clock-bindings.txt section "consumers". List of
+                three clock specifiers for mclk, mclk2 and slimbus clock.
+
+- clock-names:
+	Usage: required
+	Value type: <string>
+	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
+
+- vdd-buck-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V buck supply
+
+- vdd-buck-sido-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V SIDO buck supply
+
+- vdd-rx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V rx supply
+
+- vdd-tx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V tx supply
+
+- vdd-vbat-supply:
+	Usage: Optional
+	Value type: <phandle>
+	Definition: Should contain a reference to the vbat supply
+
+- vdd-micbias-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the micbias supply
+
+- vdd-io-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V io supply
+
+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+
+#sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+codec@1{
+	compatible = "slim217,1a0";
+	reg  = <1 0>;
+	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr2"
+	reset-gpio = <&msmgpio 64 0>;
+	qcom,ifd  = <&wc9335_ifd>;
+	clock-names = "mclk", "native";
+	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
+	vdd-buck-supply = <&pm8994_s4>;
+	vdd-rx-supply = <&pm8994_s4>;
+	vdd-buck-sido-supply = <&pm8994_s4>;
+	vdd-tx-supply = <&pm8994_s4>;
+	vdd-io-supply = <&pm8994_s4>;
+	#sound-dai-cells = <1>;
+}
-- 
2.16.2

