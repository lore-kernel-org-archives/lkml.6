Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25118C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15DD21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdVY0Nz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15DD21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHBViR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:38:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37474 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBViQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so1342537eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EmyceJsWlKJKj6s5+Zz3FdA8utFArWkVCik2jDUiN6E=;
        b=YdVY0Nz5fXStaE6uu1NNY12n+22kjsdewedximc7nF4PA8ckI6egqPdATfJugSeHlj
         BrcGwoZCi43gzwD2sxBDmENTP7Tw8KNL5PIr226mcI87GyNTsnPnN+w9OX4MrSxGNZSw
         i8HGxLpwq7vn+7IBUtAREDe+GH5B43pV5y2hTAxJphxJpVI31Ff0cIy5xKOzm91Gyasm
         /Yu39DhqFq3r8/l7NutKT3bEfpIHiFuDL/gaCR2HTcDYgcJhK1Pvfe5y28oovZNbn+PU
         k0kJ4WRB+LIiCXcUzZcfxGhcutUIZdsvg4ZgxaY3zNu1qgT80d6C44cfMUtQcGPj/spt
         6J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=EmyceJsWlKJKj6s5+Zz3FdA8utFArWkVCik2jDUiN6E=;
        b=HEYeI8mpHA9RkxqPiaJo+RMG3X1Sdg0VDfPPCcLhrWvMq2XVUqnUVqQAs7BbHEG4fo
         HgxLFxWAgNw9CzAy9BkldMulvVb2TgQymyI1ooSshBHdrOTJ25sq3YO9QRZUbYiTAJVh
         LvuLMrzwb4tZfJEQ3r5r/DnogPG9W9dUJooy4i+Svi/JY1DJCdDB0Uf0y0DGD7zfwdXY
         nkMkA1Nt7NcIkcaeAWbvz1VtN5FJ12Byzmxssc/iWKCgr0A2U4xX/KuRQBfp4uuaqxpN
         67OY0uhJo9BvEfX7xUEyBwR7mM9HWYSHEvR6t8S2HN3oj65TWVkrykRGf6EU7L10ph6K
         IBgA==
X-Gm-Message-State: AOUpUlHHVcdgpzeJLTqmpW3jucGiaLvNoGRuspHBeK4n9oVZblrsnRr7
        5zsQ5HrdoE8Ei/eUbhSDIso=
X-Google-Smtp-Source: AAOMgpdeOrDFpcLwNdkN/bA+C9nkk4jXDsqGWw1FZG5A3IVNe8Tbf1XiF9uUCcd2HRqKkFAQRCuGIw==
X-Received: by 2002:a50:c8c3:: with SMTP id k3-v6mr4532127edh.193.1533239141291;
        Thu, 02 Aug 2018 12:45:41 -0700 (PDT)
Received: from jupiter.lan (126.158-248-196.customer.lyse.net. [158.248.196.126])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1219655edn.28.2018.08.02.12.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:45:40 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 1/5] dt-bindings: add parallel data bus (pardata)
Date:   Thu,  2 Aug 2018 21:45:32 +0200
Message-Id: <20180802194536.10820-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180802193909.GA11443@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parallel data bus is a simple parallel bus
that may be used to drive displays.
It is mostly used in simple embedded systems
but is also used in some desings utilising Linux.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/pardata/parallel-data-bus.txt         | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pardata/parallel-data-bus.txt

diff --git a/Documentation/devicetree/bindings/pardata/parallel-data-bus.txt b/Documentation/devicetree/bindings/pardata/parallel-data-bus.txt
new file mode 100644
index 000000000000..fa33b5bb8302
--- /dev/null
+++ b/Documentation/devicetree/bindings/pardata/parallel-data-bus.txt
@@ -0,0 +1,60 @@
+DT binding for parallel data bus
+
+Required properties:
+- compatible: "parallel-data-bus"
+- data-gpios: array of 8 GPIO specifiers, referring to the GPIO pins
+  connected to the data signal lines DB0-DB7
+  (8-bit mode) of the LCD Controller's bus interface,
+- enable-gpios: GPIO specifier, referring to the GPIO pin connected to
+  the "E" (Enable) signal line of the controller's bus interface,
+- rs-gpios: GPIO specifier, referring to the GPIO pin
+  connected to the "RS" (Register Select) controller's bus interface,
+
+Required properties for 8080 interface:
+- readwrite-gpios: For chips with 8080 interface list the GPIO
+  pin connected to the controllers read/write pin
+
+Required properties for 6800 interface:
+- read-gpios: For chips with 6800 interface list the GPIO
+  pin connected to the controllers read pin
+- write-gpios: For chips with 6800 interface list the GPIO
+  pin connected to the controllers write pin
+
+Required property for child node(s):
+- reg: numeric identifier for the display
+
+Example:
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+	}
+
+	power: regulator@0 {
+	}
+
+	pardatabus {
+		compatible = "parallel-data-bus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pardata>;
+		data-gpios = <&pioe 0 GPIO_ACTIVE_HIGH
+			      &pioe 1 GPIO_ACTIVE_HIGH
+			      &pioe 2 GPIO_ACTIVE_HIGH
+			      &pioe 3 GPIO_ACTIVE_HIGH
+			      &pioe 4 GPIO_ACTIVE_HIGH
+			      &pioe 5 GPIO_ACTIVE_HIGH
+			      &pioe 6 GPIO_ACTIVE_HIGH
+			      &pioe 7 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pioe 8 GPIO_ACTIVE_HIGH>;
+		rs-gpios = <&pioe 12 GPIO_ACTIVE_HIGH>;
+		readdwrite-gpios = <&pioe 11 GPIO_ACTIVE_HIGH>;
+
+		wg160160@0 {
+			compatible = "winstar,wg160160";
+			reg = <1>;
+			reset-gpios = <&pioe 13 GPIO_ACTIVE_LOW>;
+			chipselect-gpios = <&pioe 9 GPIO_ACTIVE_LOW>;
+			backlight = &backlight;
+			power = &power;
+		}
+	}
+
-- 
2.12.0

