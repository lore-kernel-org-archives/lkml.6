Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31725C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26A92241B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDLowsIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26A92241B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbeKLIWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbeKLIWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8567223CA;
        Sun, 11 Nov 2018 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975542;
        bh=iCNvr2g36cKBJpD73YpTFrp1KEDtms4FeFyPRDcJxmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDLowsIjyD5lpzZ5XGKzDgedK/80hBA9p7pH8ApRHvVLI9R1Ha+frltxaiUuAiIZU
         AFfZQAY6PNm7frBFTfKTXTsRQ4kqF3QRM7RHm2KPoKbdaWBK9/s4RGDImkXd0kXCJs
         /08cw8C+pugLBox9Aw70NyIZeeI067oji1ongefo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 024/222] ARM: dts: exynos: Disable pull control for MAX8997 interrupts on Origen
Date:   Sun, 11 Nov 2018 14:22:01 -0800
Message-Id: <20181111221650.380267425@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit f5e758b8358f6c27e8a351ddf0b441a64cdabb94 upstream.

PMIC_IRQB and PMIC_KEYINB lines on Exynos4210-based Origen board have
external pull-up resistors, so disable any pull control for those lines
in respective pin controller node. This fixes support for MAX8997
interrupts and enables operation of wakeup from MAX8997 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 17419726aaa1 ("ARM: dts: add max8997 device node for exynos4210-origen board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos4210-origen.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -152,6 +152,8 @@
 		reg = <0x66>;
 		interrupt-parent = <&gpx0>;
 		interrupts = <4 IRQ_TYPE_NONE>, <3 IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max8997_irq>;
 
 		max8997,pmic-buck1-dvs-voltage = <1350000>;
 		max8997,pmic-buck2-dvs-voltage = <1100000>;
@@ -289,6 +291,13 @@
 	};
 };
 
+&pinctrl_1 {
+	max8997_irq: max8997-irq {
+		samsung,pins = "gpx0-3", "gpx0-4";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
 &sdhci_0 {
 	bus-width = <4>;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;


