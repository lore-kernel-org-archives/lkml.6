Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C5A21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oLCCX8fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfA2NhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:37:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfA2Nf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so22075998wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3xH7Xzpc5cMZ4ARmqUIntN8kN6TvLlxWbp8jPTSrPE=;
        b=oLCCX8fxGTshQfV4X37oMOk5SwkE9oRSb3XmS8kNr4WLsaX3Qin3vcAalqxlSGyx0J
         IuYPDZlMkNyF50h5g3KFOGnibG3S5gYj7jQgIUg8CM2iMVcsYEDvu+00BQlj+4FGpqzE
         PFSxVsnFlnjKVqWb6uhF8IkEotSRX+qDKPp6VBAAjg6wbAXS0r7u8HkL+OkXHxOJ4Dgv
         GtZuAspq9XpjdCcvXQ7D1WLSr63E7Yk3aG7WXJgCSb/zpog90Zd302gtp0GKK74EhawJ
         ghwCQdItZeLfMZEDibaaBSh+qx120aTh/wfqV/O+AT1RbDLh4GnkS+uZfXvCLPOORiQm
         3RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3xH7Xzpc5cMZ4ARmqUIntN8kN6TvLlxWbp8jPTSrPE=;
        b=Q05UFz0MfgbhkpdyYZDvSE2qDH/AcxKFMqkyk4RC/Y/dM8sFmDXc2OA695a0F156Tx
         vlC9v5Moj0bQr4lrqvYZNLfzr9bJ315hNwtj2dXYpkK+3Ovm4xrvs+b1YqO4WqCCP9Nh
         hMRcLpjgIEgQTFnDSEKR0J7DoRwImcfvihPUyFUvjJDo3VvcszRSIO4H7bVXjOWaRLiO
         uB6L2BL5I6TfnEmBXHmTfiNzKFVYlxi4KesXPCnD+4Ql7aFV0p17rdPC2Dkeu8/dAB0K
         Gic7tbxBVteghXsnb2+BrzTo6BCJZOmiXEg+0I5StSd6RBlwWO3SmHMIKVPrLnhpxYNW
         076Q==
X-Gm-Message-State: AJcUukezPxhczkVGnVkyy5t/j8/QYdqHZg811WKGKzQv2TC/1miAA6kp
        7QGOZAAOiqV7PhtGd4WXooZzrb0wOP22pg==
X-Google-Smtp-Source: ALg8bN4DSE7OgWJTXwxy8hmIrvuogq9Wd+AW8Uy3mMrtXUZPhITGQOcjjnke0bUZPcq3G8O8Z+quHA==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr26422494wrj.118.1548768955159;
        Tue, 29 Jan 2019 05:35:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 02/13] dt-bindings: regulator: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:34 +0100
Message-Id: <20190129133545.1931-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for max77650 regulators.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
new file mode 100644
index 000000000000..f1cbe813c30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -0,0 +1,41 @@
+Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The regulator controller is represented as a sub-node of the PMIC node
+on the device tree.
+
+The device has a single LDO regulator and a SIMO buck-boost regulator with
+three independent power rails.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-regulator"
+
+Each rail must be instantiated under the regulators subnode of the top PMIC
+node. Up to four regulators can be defined. For standard regulator properties
+refer to Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
+
+Example:
+--------
+
+	regulators {
+		compatible = "maxim,max77650-regulator";
+
+		max77650_ldo: regulator@0 {
+			regulator-compatible = "ldo";
+			regulator-name = "max77650-ldo";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <2937500>;
+		};
+
+		max77650_sbb0: regulator@1 {
+			regulator-compatible = "sbb0";
+			regulator-name = "max77650-sbb0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1587500>;
+		};
+	};
-- 
2.20.1

