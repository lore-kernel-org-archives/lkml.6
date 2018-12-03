Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3793320851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jlRr82vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3793320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLCKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50828 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeLCKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so2658118wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rcmd27QWJ4xmppTvwllwY6JeAM/zSw/3F56Tx3gVCeQ=;
        b=jlRr82vuqkK0mmH/legr7UuT2SR17Izjlh427s+xfWa7DmENHl9PTVPMRQg+2yZaVu
         t61q4G+qv5aM+Yho3fsirfrh5a4+/c6/1eUWio8l1K6LoIMCJRu4ILsS+8pk983poCaF
         QIbIl9qeY5dAErs7Q4rfb9Wl9XjygP+uAHQRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rcmd27QWJ4xmppTvwllwY6JeAM/zSw/3F56Tx3gVCeQ=;
        b=L0SpRbi3bkcboigJBcw7JjQ2qMriwiZMuYLrFwyPIigmfP0ptbf0pN+l52CKqj5MZY
         NnricLdwF1X15qSG/wpCGvB6ylcTuzkqze56mrAUNmIRLA5MNKRhfZRDoxR8XQOfuRYw
         lzsKIrnOfJ3QIFIR0PbG5cn0vLQDMsNnwfK1ky7EGRPH8JQ/dEYD28SeJOw2UKo8hQjx
         If+yFt3/lFGcnl5L+69vMOXBE8yjvPGuCrSle58yz6rCCNhqPIbaFLllAtDoEDTSkn4/
         W4rjcjloLcl/TYn7ja35gyxueEn9HJbzF6jADcLUB2Py3KL4CAVNVfDoQB8gzfoVarSI
         nvVA==
X-Gm-Message-State: AA+aEWau0rD6K9dO7qtiQle3IxsZvY0S2+uptexaXsPoZ3L1A8e5dmAC
        Lni186FFkUfEbs52KlMKfEOYmQ==
X-Google-Smtp-Source: AFSGD/XtKq3es9+911MegfWg8xs36aHwaMEywK0bx9cUOLdLgmGC8tOga7v8E9RG6igPmIUh54Mt9g==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr7546256wmn.108.1543832165929;
        Mon, 03 Dec 2018 02:16:05 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:16:05 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 9/9] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
Date:   Mon,  3 Dec 2018 15:45:47 +0530
Message-Id: <20181203101547.16835-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Goodix GT5663 capacitive touch controller node on
Amarula A64-Relic board.

The CTP connected to board with,
- SDA, SCK from i2c1
- GPIO-LD0 as vcc supply
- PH4 gpio as interrupt pin
- PH8 gpio as reset pin
- X and Y axis are inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 9ac6d773188b..913fcdff828e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -88,6 +88,28 @@
 	status = "okay";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		vcc-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
+&i2c1_pins {
+	bias-pull-up;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
@@ -251,6 +273,13 @@
 	regulator-name = "vdd-cpus";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3

