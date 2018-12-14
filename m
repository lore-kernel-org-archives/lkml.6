Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72551C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5335208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YKi32Jtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5335208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeLNMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:42:14 -0500
Received: from vps.xff.cz ([195.181.215.36]:46428 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbeLNMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1544791329; bh=okS3jNr43q2CRdJZ7mqQmQXOMY7AppBVBNBrFJwFg0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKi32Jtc/Zo4UWtOubshbFIihFEQLbAZ0bf+7ajXehamZ1K5OEwGR7wfU6phL0ztT
         pJsuCywi1+lxMOqW57gUd45RbmLy/B+o+NdMQ+wbP4cXZumU1QnTI1XU0h1/63Vkw3
         g+pmYmif7dbAAY/IExvY9eANzcoUnpgOEGTnIX0A=
Date:   Fri, 14 Dec 2018 13:42:08 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
Message-ID: <20181214124208.e72glckgcgbfyc4f@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 05:35:48PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v2 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> based SBCs series.
> 
> Changes since v1:
> 
>   - Collected tags
>   - Re-organize dt binding clocks and clock-names properties
>   - Simplify check for deferred probe when getting clocks
>   - Add explanation of Cubietruck's clk_out_a pinmux setting placement
>     to commit message.
>   - Add missing "uart-has-rtscts" property to Cubietruck device tree
>
> [snip]

Hello,

I've tested your patch series on TBS A711 / BCM20702A1 with the following DTS:


 /* There's the BT part of the AP6210 connected to that UART */
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm20702a1";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vbat>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		max-speed = <1500000>;
+	};
 };


And it works. :)

Tested-by: Ondrej Jirman <megous@megous.com>


Thank you and regards,
  o.
