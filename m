Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12F7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB9B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LWXRqneI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392849AbfAPMky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:40:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392821AbfAPMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:40:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so6759154wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVs0Nbg/JAhKmVo9NPvM4dEM8xg5pTYJjP6q4kBu8To=;
        b=LWXRqneIHEn3vagEfIheY/sgCa2folY+5yVAgjQ/BSv7krw6Uvdj9MlyZWdR70RjFk
         ugHDUs/9WhZlpF8E4l1fx8bJ5Lk2qg/gdsd3MWZl2IbimJcep+h22DxKeGEeyCj+giq9
         7AzeCjNX7icg9s5/XcJf45kOtipQluNLoZ91sX6S4c+LIDnO1Qvbx4Xt6iI4QARNTQrN
         6c7kAgztheoEAUv/My6tk7izrhRaK6luZYP+bEH6VHTqHcoFsYDlbIOty6kYjDfSEuU2
         TX5x7qSJsqIZrWIU9zjRS0/JETcedbuz7hnz3IGcm/JcBoV4pvDhDtpAYR/m2KFj2TCx
         AKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVs0Nbg/JAhKmVo9NPvM4dEM8xg5pTYJjP6q4kBu8To=;
        b=rAXEEOjLYP6XE/5vXgaERHDkZR8o3n5M4KmGsxZfoam3X/26t1cVMys9aCJ51JqdYj
         JBIBPGE32X2ASPiOoGqwyRyCJAAR0V591s0wq4LCeW26PXmi+4lrnAssp77dP/l/sEb1
         Zs+8STrYWBIULBr338kcbTRFg5RgEltfga2u/u8LZQDU/XqW5MgZVEYCAmj/6si7ue4n
         rCU0SIQmXHFTWIwfYVxWBpABN7mF7ckO25RaxmDGf/N/zVvemwJkMH8JXc9/3G3wsSZi
         9OyRWrkLsFWkbXHJ7QtYA0khhTB3gkbgkOuMEF0pRjIL+5RfOJLsxq0PjgIVIoU70X6P
         psOA==
X-Gm-Message-State: AJcUukcu+NOjgHY55mTb2T6wJhlgJlv0nobgbbi2evo9wycVhLwq2c04
        AU9OIi7MB9FYHKusYzX7TbQLCg==
X-Google-Smtp-Source: ALg8bN6ZKAuWqrOQJP9AIpFjvad4/9NfanEv3nTCFZZVz9nZ1zMrWPCOEo83+0jPTXEvWUpwY0OkYA==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr7460441wrc.62.1547642450280;
        Wed, 16 Jan 2019 04:40:50 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 04:40:49 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: meson: add specific simplefb bindings
Date:   Wed, 16 Jan 2019 13:40:29 +0100
Message-Id: <20190116124030.16882-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/amlogic,simple-framebuffer.txt    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt

diff --git a/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt b/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
new file mode 100644
index 000000000000..aaa6c24c8e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer", "simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	simplefb_hdmi: framebuffer-hdmi {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.20.1

