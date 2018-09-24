Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB414C004D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC49208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dq09vVcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC49208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIYETv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:19:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbeIYETu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:19:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so2941090pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IlEA16ScxSwtOI1pIUhy7/t4qOCJcYpATX0BJZoBIOU=;
        b=dq09vVcHTkax2AFET7VSSuQfVczVVJWQL4amSpMWWIBecDi5mBPUUvCij/PXkXC0fM
         S9VGeZ14UgS1MqMfk1Zfec31PTtuOAeHKhzatigOB5goHfarX+B463d9fjaJpOcH/zTO
         p6BHRBD6bZjQGg0wieM30ZZ7NcXDCo3AftY10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IlEA16ScxSwtOI1pIUhy7/t4qOCJcYpATX0BJZoBIOU=;
        b=ksaUsGW8y4u1QG+gppi6fZcDoWoyglSKqCWbWJWD1q2cBBPDEyG2RVZyPRJhNFWghX
         cTj2CeXMMSm6u105nxodYQOA+I05DXAz7R8wzINfoWiYxl4+Q6QFP1jVJ2RnB3mxI75U
         1B0kxHEkku8ZwYT/166xJjhXhQNwCgX0vZ/qlolch+TNi9IWj7opUl+/t6rViTye7vDt
         ivMUIVD82PgUdCPn31EHkTiUMvn46A/2x/fEL4eBG+LSDgXSVCWG+j3WH2l0Dw/twkkp
         6H+ABZuoF2x/YGYGG0587iALuDzBtXnU5StGc0kzEpunmCmWGAOVfPJEA8uYAySpoysV
         23cQ==
X-Gm-Message-State: ABuFfohuIzRWP0sY/dFBuRuf+wxqyP7U9qompifE8lfh+b3mLTd3eNTI
        iPYZ4SAFFwRk38aTHMkOKI7teA==
X-Google-Smtp-Source: ACcGV611UbAFks6HMP6xQydao+YZEYMenaYs9KQFfLkmKicLPEQWkuTwohhQ7CVnJCNaz0eudrB7uw==
X-Received: by 2002:a62:6cc6:: with SMTP id h189-v6mr676496pfc.23.1537827327207;
        Mon, 24 Sep 2018 15:15:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w23-v6sm386260pgi.18.2018.09.24.15.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 15:15:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding
Date:   Mon, 24 Sep 2018 15:17:47 -0700
Message-Id: <20180924221748.21584-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924221748.21584-1-bjorn.andersson@linaro.org>
References: <20180924221748.21584-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for the TLMM pinctrl block found in the QCS404 platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped leading 0 in node address

 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
new file mode 100644
index 000000000000..74da0dfcd2c1
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
+	tlmm: pinctrl@1000000 {
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

