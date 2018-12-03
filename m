Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF33C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BFC20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qC8oqrq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BFC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLCKQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeLCKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so11501381wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYIR92ZSRt6P2LabORDc+r2SZD6NGN2vTfFdELLfLf4=;
        b=qC8oqrq55XITG+IaBKgDlrqKba/eWXMICT8ZW/Rcc4w4V6RiseMUjyfrfmbtTpyUDd
         0mBjZRf+m3qaDu0DTvoS/QChJeSM09sBOq9ACkMw0YHJ6WxFEYFT8xBCcWPVTdkEU7AA
         dTa0Ib7KnK7tI8rzBqeja78V/ZEzDQy+/L0sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYIR92ZSRt6P2LabORDc+r2SZD6NGN2vTfFdELLfLf4=;
        b=o0oWRwl5G9FJ8ifiEdN4wK3NPvk+zsyAvHPiurSxD7ecZ150cvOi0ESNwzKiXiY3H6
         gPgVZCfQeKx9RZyCdpL6nQbsTrHok/tOosxK2/vNWI1t6kgxJHx2T7Hk/qbho53uyH7T
         55Kqzs82HxRjg7KcLSrSmMSLTgdNbww862RRunwRcalR5EGJn4yBRqQV7Zi3/okEUoWr
         UWCK91d5oM5SNJ/6lSOYh4kZiHXwnsbYkBUVlavXSOs7R/F/imYU5RogtqVpnSHhNH6O
         KSr4UxJZ0ty0whLMwCfj6taRd67/W++749idPb4n+hRMolNV+WOSlAXYz22/S/hiS8ZZ
         qeHg==
X-Gm-Message-State: AA+aEWbOhrbbrcK367QOVciE9/xSczCu4vIJIoXoZ5oDunAyq4G/pLgQ
        EWHvuV+ide09wwebUxSnYDLM5A==
X-Google-Smtp-Source: AFSGD/Vm4W738LcPT1s/CT/dGj4WK/IiXywz4IEpkGYPcV0L5ZaqAwwt1Y6p2GtyZ5p6627XpfOOdg==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr13550244wre.13.1543832163368;
        Mon, 03 Dec 2018 02:16:03 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:16:02 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 7/9] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Mon,  3 Dec 2018 15:45:45 +0530
Message-Id: <20181203101547.16835-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart wakeup gestures,
the existing goodix driver will work by phandle vcc-supply regulator.

So, document compatible and example node for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/input/touchscreen/goodix.txt           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 604766e347ce..1898d3dde8e1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
@@ -42,3 +43,15 @@ Example:
 
 		/* ... */
 	};
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		vcc-supply = <&reg_ldo_io0>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
-- 
2.18.0.321.gffc6fa0e3

