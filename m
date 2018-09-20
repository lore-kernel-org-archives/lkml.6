Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5720673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aP0tj7d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeITHPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:15:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40328 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeITHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:15:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so3543026pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=trZJ47sKl7zzy9mvAu/sLM9nxonqdZ/FOpmuB7APB5k=;
        b=aP0tj7d4Ny63TeBTUXskF2GxWQZGEbr4bxMs6LH6QJXhuD5nnaStLf+MQ3aRJtP3OX
         W2Ieivht35q6og6qHiM2SxXpzZWsw5SKWL90fxIGZACwaluDn4chb5nl00Ete+syf84F
         rxdwMQySvzEIXOcPDqfI6HSJMtVpERRs/iWtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=trZJ47sKl7zzy9mvAu/sLM9nxonqdZ/FOpmuB7APB5k=;
        b=Da0JzEnrnF3E1zhVz+z7p0YMHhtka93AWR2NqAGJrGpw03ZgjtLAyz1qdo3ZDNO6kB
         4TzP8L3LEpMlAPD0wO0N//kHMDdmmLBBySVYRHzXKJHlQdqaeYIMX0a3pz2bXZFeAW4Y
         +9CM2d/9/UvaVW9mEQXMwTsoMxn5C/Vox1JB8F4mDtJZXd/WJF3TfFEjZH6S1vjSCsQ3
         gacD1glCoytjh7hZSSlf3jWeug+uUJQQ7OnOg7V/xg+2HSqc5647tko0CqSmcLUXLbxy
         uhakVENytYrkYjc1UEddnhMJVZeD1WlYFDFrrObplnBtdnTaojbohavNjzzwYJ7y48gb
         SWog==
X-Gm-Message-State: APzg51A98vK+wbpghAUswJJON+GlH/YG28u1p+NzknTmyG6IiMesk75m
        IyCCQSqEA2FWO04O30lR1qQoUrN2Tj/4vt1X
X-Google-Smtp-Source: ANB0VdbC5VhLTqI+xtlvELJawmgiwYXRXb2gOoo+kUUClNY4JqIfpQCzbk6FwCUhNwQye2R8snkxvA==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr35183552pgq.382.1537407299639;
        Wed, 19 Sep 2018 18:34:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l127-v6sm38753943pfc.55.2018.09.19.18.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:34:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding
Date:   Wed, 19 Sep 2018 18:37:11 -0700
Message-Id: <20180920013712.2361-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920013712.2361-1-bjorn.andersson@linaro.org>
References: <20180920013712.2361-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for the TLMM pinctrl block found in the QCS404 platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
new file mode 100644
index 000000000000..ed169adaacce
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
@@ -0,0 +1,200 @@
+Qualcomm QCS404 TLMM block
+
+This binding describes the Top Level Mode Multiplexer block found in the
+QCS404 platform.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,qcs404-pinctrl"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the base address and size of the north, south and east TLMM
+		    tiles.
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Defintiion: names for the cells of reg, must contain "north", "south"
+		    and "east".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the TLMM summary IRQ.
+
+- interrupt-controller:
+	Usage: required
+	Value type: <none>
+	Definition: identifies this node as an interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 2. Specifying the pin number and flags, as defined
+		    in <dt-bindings/interrupt-controller/irq.h>
+
+- gpio-controller:
+	Usage: required
+	Value type: <none>
+	Definition: identifies this node as a gpio controller
+
+- #gpio-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 2. Specifying the pin number and flags, as defined
+		    in <dt-bindings/gpio/gpio.h>
+
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
+a general description of GPIO and interrupt bindings.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+The pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, drive strength, etc.
+
+
+PIN CONFIGURATION NODES:
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Each subnode only affects those parameters that are explicitly listed. In
+other words, a subnode that lists a mux function but no pin configuration
+parameters implies no information about any pin configuration parameters.
+Similarly, a pin subnode that describes a pullup parameter implies no
+information about e.g. the mux function.
+
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pin configuration subnode:
+
+- pins:
+	Usage: required
+	Value type: <string-array>
+	Definition: List of gpio pins affected by the properties specified in
+		    this subnode.
+
+		    Valid pins are:
+		      gpio0-gpio119
+		        Supports mux, bias and drive-strength
+
+		      sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
+		      sdc2_data
+		        Supports bias and drive-strength
+
+		      ufs_reset
+		        Supports bias and drive-strength
+
+- function:
+	Usage: required
+	Value type: <string>
+	Definition: Specify the alternative function to be configured for the
+		    specified pins. Functions are only valid for gpio pins.
+		    Valid values are:
+
+		    gpio, hdmi_tx, hdmi_ddc, blsp_uart_tx_a2, blsp_spi2, m_voc,
+		    qdss_cti_trig_in_a0, blsp_uart_rx_a2, qdss_tracectl_a,
+		    blsp_uart2, aud_cdc, blsp_i2c_sda_a2, qdss_tracedata_a,
+		    blsp_i2c_scl_a2, qdss_tracectl_b, qdss_cti_trig_in_b0,
+		    blsp_uart1, blsp_spi_mosi_a1, blsp_spi_miso_a1,
+		    qdss_tracedata_b, blsp_i2c1, blsp_spi_cs_n_a1, gcc_plltest,
+		    blsp_spi_clk_a1, rgb_data0, blsp_uart5, blsp_spi5,
+		    adsp_ext, rgb_data1, prng_rosc, rgb_data2, blsp_i2c5,
+		    gcc_gp1_clk_b, rgb_data3, gcc_gp2_clk_b, blsp_spi0,
+		    blsp_uart0, gcc_gp3_clk_b, blsp_i2c0, qdss_traceclk_b,
+		    pcie_clk, nfc_irq, blsp_spi4, nfc_dwl, audio_ts, rgb_data4,
+		    spi_lcd, blsp_uart_tx_b2, gcc_gp3_clk_a, rgb_data5,
+		    blsp_uart_rx_b2, blsp_i2c_sda_b2, blsp_i2c_scl_b2,
+		    pwm_led11, i2s_3_data0_a, ebi2_lcd, i2s_3_data1_a,
+		    i2s_3_data2_a, atest_char, pwm_led3, i2s_3_data3_a,
+		    pwm_led4, i2s_4, ebi2_a, dsd_clk_b, pwm_led5, pwm_led6,
+		    pwm_led7, pwm_led8, pwm_led24, spkr_dac0, blsp_i2c4,
+		    pwm_led9, pwm_led10, spdifrx_opt, pwm_led12, pwm_led13,
+		    pwm_led14, wlan1_adc1, rgb_data_b0, pwm_led15,
+		    blsp_spi_mosi_b1, wlan1_adc0, rgb_data_b1, pwm_led16,
+		    blsp_spi_miso_b1, qdss_cti_trig_out_b0, wlan2_adc1,
+		    rgb_data_b2, pwm_led17, blsp_spi_cs_n_b1, wlan2_adc0,
+		    rgb_data_b3, pwm_led18, blsp_spi_clk_b1, rgb_data_b4,
+		    pwm_led19, ext_mclk1_b, qdss_traceclk_a, rgb_data_b5,
+		    pwm_led20, atest_char3, i2s_3_sck_b, ldo_update, bimc_dte0,
+		    rgb_hsync, pwm_led21, i2s_3_ws_b, dbg_out, rgb_vsync,
+		    i2s_3_data0_b, ldo_en, hdmi_dtest, rgb_de, i2s_3_data1_b,
+		    hdmi_lbk9, rgb_clk, atest_char1, i2s_3_data2_b, ebi_cdc,
+		    hdmi_lbk8, rgb_mdp, atest_char0, i2s_3_data3_b, hdmi_lbk7,
+		    rgb_data_b6, rgb_data_b7, hdmi_lbk6, rgmii_int, cri_trng1,
+		    rgmii_wol, cri_trng0, gcc_tlmm, rgmii_ck, rgmii_tx,
+		    hdmi_lbk5, hdmi_pixel, hdmi_rcv, hdmi_lbk4, rgmii_ctl,
+		    ext_lpass, rgmii_rx, cri_trng, hdmi_lbk3, hdmi_lbk2,
+		    qdss_cti_trig_out_b1, rgmii_mdio, hdmi_lbk1, rgmii_mdc,
+		    hdmi_lbk0, ir_in, wsa_en, rgb_data6, rgb_data7,
+		    atest_char2, ebi_ch0, blsp_uart3, blsp_spi3, sd_write,
+		    blsp_i2c3, gcc_gp1_clk_a, qdss_cti_trig_in_b1,
+		    gcc_gp2_clk_a, ext_mclk0, mclk_in1, i2s_1, dsd_clk_a,
+		    qdss_cti_trig_in_a1, rgmi_dll1, pwm_led22, pwm_led23,
+		    qdss_cti_trig_out_a0, rgmi_dll2, pwm_led1,
+		    qdss_cti_trig_out_a1, pwm_led2, i2s_2, pll_bist,
+		    ext_mclk1_a, mclk_in2, bimc_dte1, i2s_3_sck_a, i2s_3_ws_a
+
+- bias-disable:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as no pull.
+
+- bias-pull-down:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as pull down.
+
+- bias-pull-up:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as pull up.
+
+- output-high:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins are configured in output mode, driven
+		    high.
+		    Not valid for sdc pins.
+
+- output-low:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins are configured in output mode, driven
+		    low.
+		    Not valid for sdc pins.
+
+- drive-strength:
+	Usage: optional
+	Value type: <u32>
+	Definition: Selects the drive strength for the specified pins, in mA.
+		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
+
+Example:
+
+	tlmm: pinctrl@01000000 {
+		compatible = "qcom,qcs404-pinctrl";
+		reg = <0x01000000 0x200000>,
+		      <0x01300000 0x200000>,
+		      <0x07b00000 0x200000>;
+		reg-names = "south", "north", "east";
+		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 120>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
-- 
2.18.0

