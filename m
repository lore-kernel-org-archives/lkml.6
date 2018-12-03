Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13964C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45C214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P4REhBT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE45C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLCKQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38500 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so11483818wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wg4zCKkS5SfqlTRPj9JdiOkThqwhYO31sOTuFqJbv8g=;
        b=P4REhBT+SdcfxIfpb6eF0vbf+VMAT8ksV6a8YaOzCwDqLMOQx7fsYDoG6NREqfZsht
         csYkt25uMUuqcf6TSBQO7c57wNp4s7tlEiQ4rgmoQgjHeOnZM5bdEM7mE5sWhFbwd9/Y
         JzGC0CPNQfrCc8oHzKFL7G18BY+mWAJOdDpH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wg4zCKkS5SfqlTRPj9JdiOkThqwhYO31sOTuFqJbv8g=;
        b=h0PhHQc7OTWkc7s2bZuokfH+rBT8bOG5qR4+miEwPkmVrfuY7DMXXEVvBWiRpXpKlN
         0OIL3ajgtRDvqZ74avPXnL3Qf9jAIkeGLwgrNaQLL9lh1QFVLEtELBE2n2kL3fLVIaPS
         pr4F7+k6amgEVIZyZFB79L6t0BM/TI0CVihdPdy81OP5yQBLpmq7HX2xHgQcH8kCfc+v
         0TNMC3Q7el5ZTO03H3DkFG0ObZkb+149++6DWbqb2j5kSKSrCPz3/SSw0TWoXqgoX7Q0
         ijoat0fyZ2jof9UdKrahoJnBMlEzD2XmBAPXdLZXb5CDFfXGvOKbhIEfTZQmha3kBZ5z
         wUPA==
X-Gm-Message-State: AA+aEWYXbp/FdFLGl9CamZZLNZix8uHAMReW1UD4PgT/YkF37DB+FLd4
        YqeZDGmeZx2lZAmhhC1mPZFjkQ==
X-Google-Smtp-Source: AFSGD/UOV3gw0B7fO0cTvmV+8AhL+IERt/3Sh8OSHR90BdAk+ZC3xvxFiQia66+W1PEyVGFPnn8kjQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr13012473wrm.232.1543832159477;
        Mon, 03 Dec 2018 02:15:59 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:15:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/9] arm64: allwinner: dts: axp803: Set GPIO0/1 pinmux for LD0s
Date:   Mon,  3 Dec 2018 15:45:42 +0530
Message-Id: <20181203101547.16835-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO0, GPIO1 can be used as LDO like ldo_io0, ldo_io1 in
AXP803.

So, attach the LDO GPIO pins along with pinctrl properties.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index c6b95980d476..b0d6b3c3cf38 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -54,6 +54,16 @@
 			     "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
 	};
 
 	regulators {
@@ -137,12 +147,16 @@
 		};
 
 		reg_ldo_io0: ldo-io0 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio0_ldo>;
 			regulator-name = "ldo-io0";
 			status = "disabled";
 		};
 
 		reg_ldo_io1: ldo-io1 {
 			regulator-name = "ldo-io1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio1_ldo>;
 			status = "disabled";
 		};
 
-- 
2.18.0.321.gffc6fa0e3

