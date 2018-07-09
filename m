Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF826C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EB120852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="UR5a0bRH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPYVp/9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EB120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeGIGdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:33:02 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38233 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbeGIGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:32:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so33845386oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oG92cabxWfz1myYpAA/uP5HPknzNKUEPxtaDo3ZrgEg=;
        b=UR5a0bRH9KkrrRNZBl9jFQJgsYkY95DBP1B+MB8qpIQM6h5aevBC6ht9v1BrlGIds1
         3tXgV5UZhD0vXMOH6K3PknRXfeaS3DawqU0gQo9TfVbhNGOwbeopdjg7IPQG92IKN3qI
         CHID1Dcn766lA5qT/IydsCfPPuE+SSQBirhBmOxkJUkVKiFB8Y2DrTNJbttPzOGMGWd2
         BLIdHJlPOXwTEoOBWoLfAPPY6KBQYKOi+ng8VL8fqbFq66gdp9z6CcYkrka+DHnGotEA
         o7hY+qEZPdETdUYw5kybDvSDjdxAbY0L8ffZ0xCy5K5NvIOHJKpJRFhumb3BsKfHm/Gk
         Kjyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oG92cabxWfz1myYpAA/uP5HPknzNKUEPxtaDo3ZrgEg=;
        b=MPYVp/9qxABBzuMogbjsWRv6sop4vonHgiXSn0YaqSSXNDaSQ/o0svMKzLV68GAj7N
         lV/bYFuZ2kthJVUaG8RLeEaRH5h+Eu1qBxfQINJdlpOg7G1VPDW9EK2VEXtBe2rOIG1Z
         lNUlHYSpe7Ea2zXOWeB020hZyK8uJztENNPf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oG92cabxWfz1myYpAA/uP5HPknzNKUEPxtaDo3ZrgEg=;
        b=ALTP20dcO5KSKimEpuqAHJs7sKEflRkOZBCq7l7f0WGh8Y8AZWNVWBkFG8+qp2TNCg
         FXpJ0GZ07wadxl2udOTh5V4ueAYJLUvvPcjsdoR6iYZAKagYa95lFRGFEOgDgGFmdxTy
         vnHhjRJ+mA5d+2MaBS7DRmnyxmxVbY3taDzp4VKG0/SSYZT3KxVmqnsEJj/PV8X38CmI
         y+ESHVuZez4M3YqEbrJL+DnpkJEn5MPX3bDfKzeYzX4jH5II9/RWOMS2YJDKnYjtTkaw
         /WsaZPDi14YSIodFlmOrLVyET5VZcS5bhli3o/Dsz4y7xJdo/iiEqGa50Yow7JNhAqtG
         LumQ==
X-Gm-Message-State: APt69E3Mh6XllwxTcHDB1cCn396Jiela12OemSJcbVwmbf20CcWsA1CB
        +N9SOr/Fw70jqti/4GgfnWZiUTbzDjRhITMsq4NTxQ==
X-Google-Smtp-Source: AAOMgpdZyn4lvlA9ZBTOwh6z21hTuIItRj1WwuJfeoTW2ZcGcai4hBfrEKkY4zmLBw5KffwhKECdji7KKAW8+8dqIBE=
X-Received: by 2002:aca:48b:: with SMTP id 133-v6mr22089102oie.275.1531117978433;
 Sun, 08 Jul 2018 23:32:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 23:32:57 -0700 (PDT)
In-Reply-To: <20180418134601.8502-2-manivannan.sadhasivam@linaro.org>
References: <20180418134601.8502-1-manivannan.sadhasivam@linaro.org> <20180418134601.8502-2-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 12:02:57 +0530
X-Google-Sender-Auth: hE_GhuI5G5mLNyy1qwCltGat50s
Message-ID: <CAHLCerMcXCXMEHz6jSmAo9uVjqJgrmY7oxck+fqm3yA=95z1yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dts: qcom: db820c: Add gpio-line-names property
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linus.walleij@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will.deacon@arm.com>, nicolas.dechesne@linaro.org,
        todor.tomov@linaro.org, dragonboard@lists.96boards.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 7:16 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio-line-names property for Dragonboard820c based on APQ8096 SoC.
> There are 4 gpio-controllers present on this board, including the
> APQ8096 SoC, PM8994 (GPIO and MPP) and PMI8994 (GPIO).
>
> Lines names are derived from 96Boards CE Specification 1.0, Appendix
> "Expansion Connector Signal Description". Line names for PMI8994 MPP
> pins are not added due to the absence of the gpio-controller support.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

FWIW,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 239 +++++++++++++++++++++++++++
>  1 file changed, 239 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 1c8f1b86472d..473530527e27 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -19,6 +19,33 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>
> +/*
> + * GPIO name legend: proper name = the GPIO line is used as GPIO
> + *         NC      = not connected (pin out but not routed from the chip to
> + *                   anything the board)
> + *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
> + *         LSEC    = Low Speed External Connector
> + *         P HSEC  = Primary High Speed External Connector
> + *         S HSEC  = Secondary High Speed External Connector
> + *         J14     = Camera Connector
> + *         TP      = Test Points
> + *
> + * Line names are taken from the schematic "DragonBoard 820c",
> + * drawing no: LM25-P2751-1
> + *
> + * For the lines routed to the external connectors the
> + * lines are named after the 96Boards CE Specification 1.0,
> + * Appendix "Expansion Connector Signal Description".
> + *
> + * When the 96Board naming of a line and the schematic name of
> + * the same line are in conflict, the 96Board specification
> + * takes precedence, which means that the external UART on the
> + * LSEC is named UART0 while the schematic and SoC names this
> + * UART3. This is only for the informational lines i.e. "[FOO]",
> + * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
> + * ones actually used for GPIO.
> + */
> +
>  / {
>         aliases {
>                 serial0 = &blsp2_uart1;
> @@ -90,6 +117,218 @@
>                         status = "okay";
>                 };
>
> +               pinctrl@1010000 {
> +                       gpio-line-names =
> +                               "[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
> +                               "[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
> +                               "[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
> +                               "[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
> +                               "[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
> +                               "[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
> +                               "[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
> +                               "[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
> +                               "GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
> +                               "TP93", /* GPIO_9 */
> +                               "GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
> +                               "[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
> +                               "NC", /* GPIO_12 */
> +                               "[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
> +                               "[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
> +                               "[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
> +                               "TP99", /* GPIO_16 */
> +                               "[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
> +                               "[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
> +                               "[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
> +                               "[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
> +                               "FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
> +                               "FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
> +                               "GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
> +                               "GPIO-D", /* GPIO_24, LSEC pin 26 */
> +                               "GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
> +                               "GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
> +                               "BLSP6_I2C_SDA", /* GPIO_27 */
> +                               "BLSP6_I2C_SCL", /* GPIO_28 */
> +                               "GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
> +                               "GPIO30", /* GPIO_30, S HSEC pin 4 */
> +                               "HDMI_CEC", /* GPIO_31 */
> +                               "HDMI_DDC_CLOCK", /* GPIO_32 */
> +                               "HDMI_DDC_DATA", /* GPIO_33 */
> +                               "HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
> +                               "PCIE0_RST_N", /* GPIO_35 */
> +                               "PCIE0_CLKREQ_N", /* GPIO_36 */
> +                               "PCIE0_WAKE", /* GPIO_37 */
> +                               "SD_CARD_DET_N", /* GPIO_38 */
> +                               "TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
> +                               "W_DISABLE_N", /* GPIO_40 */
> +                               "[BLSP9_UART_TX]", /* GPIO_41 */
> +                               "[BLSP9_UART_RX]", /* GPIO_42 */
> +                               "[BLSP2_UART_CTS_N]", /* GPIO_43 */
> +                               "[BLSP2_UART_RFR_N]", /* GPIO_44 */
> +                               "[BLSP3_UART_TX]", /* GPIO_45 */
> +                               "[BLSP3_UART_RX]", /* GPIO_46 */
> +                               "[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
> +                               "[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
> +                               "[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
> +                               "[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
> +                               "[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
> +                               "[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
> +                               "[CODEC_INT1_N]", /* GPIO_53 */
> +                               "[CODEC_INT2_N]", /* GPIO_54 */
> +                               "[BLSP7_I2C_SDA]", /* GPIO_55 */
> +                               "[BLSP7_I2C_SCL]", /* GPIO_56 */
> +                               "MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
> +                               "[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
> +                               "[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
> +                               "[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
> +                               "[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
> +                               "GPIO-E", /* GPIO_62, LSEC pin 27 */
> +                               "TP87", /* GPIO_63 */
> +                               "[CODEC_RST_N]", /* GPIO_64 */
> +                               "[PCM1_CLK]", /* GPIO_65 */
> +                               "[PCM1_SYNC]", /* GPIO_66 */
> +                               "[PCM1_DIN]", /* GPIO_67 */
> +                               "[PCM1_DOUT]", /* GPIO_68 */
> +                               "AUDIO_REF_CLK", /* GPIO_69 */
> +                               "SLIMBUS_CLK", /* GPIO_70 */
> +                               "SLIMBUS_DATA0", /* GPIO_71 */
> +                               "SLIMBUS_DATA1", /* GPIO_72 */
> +                               "NC", /* GPIO_73 */
> +                               "NC", /* GPIO_74 */
> +                               "NC", /* GPIO_75 */
> +                               "NC", /* GPIO_76 */
> +                               "TP94", /* GPIO_77 */
> +                               "NC", /* GPIO_78 */
> +                               "TP95", /* GPIO_79 */
> +                               "GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
> +                               "TP88", /* GPIO_81 */
> +                               "TP89", /* GPIO_82 */
> +                               "TP90", /* GPIO_83 */
> +                               "TP91", /* GPIO_84 */
> +                               "[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
> +                               "[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
> +                               "[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
> +                               "[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
> +                               "TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
> +                               "TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
> +                               "TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
> +                               "NC", /* GPIO_92 */
> +                               "TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
> +                               "TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
> +                               "TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
> +                               "TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
> +                               "NC", /* GPIO_97 */
> +                               "CAM1_STANDBY_N", /* GPIO_98 */
> +                               "NC", /* GPIO_99 */
> +                               "NC", /* GPIO_100 */
> +                               "[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
> +                               "BOOT_CONFIG1", /* GPIO_102 */
> +                               "USB_HUB_RESET", /* GPIO_103 */
> +                               "CAM1_RST_N", /* GPIO_104 */
> +                               "NC", /* GPIO_105 */
> +                               "NC", /* GPIO_106 */
> +                               "NC", /* GPIO_107 */
> +                               "NC", /* GPIO_108 */
> +                               "NC", /* GPIO_109 */
> +                               "NC", /* GPIO_110 */
> +                               "NC", /* GPIO_111 */
> +                               "NC", /* GPIO_112 */
> +                               "PMI8994_BUA", /* GPIO_113 */
> +                               "PCIE2_RST_N", /* GPIO_114 */
> +                               "PCIE2_CLKREQ_N", /* GPIO_115 */
> +                               "PCIE2_WAKE", /* GPIO_116 */
> +                               "SSC_IRQ_0", /* GPIO_117 */
> +                               "SSC_IRQ_1", /* GPIO_118 */
> +                               "SSC_IRQ_2", /* GPIO_119 */
> +                               "NC", /* GPIO_120 */
> +                               "GPIO121", /* GPIO_121, S HSEC pin 2 */
> +                               "NC", /* GPIO_122 */
> +                               "SSC_IRQ_6", /* GPIO_123 */
> +                               "SSC_IRQ_7", /* GPIO_124 */
> +                               "GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
> +                               "BOOT_CONFIG5", /* GPIO_126 */
> +                               "NC", /* GPIO_127 */
> +                               "NC", /* GPIO_128 */
> +                               "BOOT_CONFIG7", /* GPIO_129 */
> +                               "PCIE1_RST_N", /* GPIO_130 */
> +                               "PCIE1_CLKREQ_N", /* GPIO_131 */
> +                               "PCIE1_WAKE", /* GPIO_132 */
> +                               "GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
> +                               "NC", /* GPIO_134 */
> +                               "NC", /* GPIO_135 */
> +                               "BOOT_CONFIG8", /* GPIO_136 */
> +                               "NC", /* GPIO_137 */
> +                               "NC", /* GPIO_138 */
> +                               "GPS_SSBI2", /* GPIO_139 */
> +                               "GPS_SSBI1", /* GPIO_140 */
> +                               "NC", /* GPIO_141 */
> +                               "NC", /* GPIO_142 */
> +                               "NC", /* GPIO_143 */
> +                               "BOOT_CONFIG6", /* GPIO_144 */
> +                               "NC", /* GPIO_145 */
> +                               "NC", /* GPIO_146 */
> +                               "NC", /* GPIO_147 */
> +                               "NC", /* GPIO_148 */
> +                               "NC"; /* GPIO_149 */
> +               };
> +
> +               qcom,spmi@400f000 {
> +                       pmic@0 {
> +                               gpios@c000 {
> +                                       gpio-line-names =
> +                                               "NC",
> +                                               "KEY_VOLP_N",
> +                                               "NC",
> +                                               "BL1_PWM",
> +                                               "GPIO-F", /* BL0_PWM, LSEC pin 28 */
> +                                               "BL1_EN",
> +                                               "NC",
> +                                               "WLAN_EN",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC",
> +                                               "DIVCLK1",
> +                                               "DIVCLK2",
> +                                               "DIVCLK3",
> +                                               "DIVCLK4",
> +                                               "BT_EN",
> +                                               "PMIC_SLB",
> +                                               "PMIC_BUA",
> +                                               "USB_VBUS_DET";
> +                               };
> +
> +                               mpps@a000 {
> +                                       gpio-line-names =
> +                                               "VDDPX_BIAS",
> +                                               "WIFI_LED",
> +                                               "NC",
> +                                               "BT_LED",
> +                                               "PM_MPP05",
> +                                               "PM_MPP06",
> +                                               "PM_MPP07",
> +                                               "NC";
> +                               };
> +                       };
> +
> +                       pmic@2 {
> +                               gpios@c000 {
> +                                       gpio-line-names =
> +                                               "NC",
> +                                               "SPKR_AMP_EN1",
> +                                               "SPKR_AMP_EN2",
> +                                               "TP61",
> +                                               "NC",
> +                                               "USB2_VBUS_DET",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC",
> +                                               "NC";
> +                               };
> +                       };
> +               };
> +
>                 phy@34000 {
>                         status = "okay";
>                 };
> --
> 2.14.1
>
