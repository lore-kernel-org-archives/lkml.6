Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F3CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9911D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RvZno6/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9911D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLCKQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50813 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so2657418wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GE2KwXHdmFr5oCC22e/Lvz0b5SuqoPfxF8T36urY/E=;
        b=RvZno6/0JHq/8Xiol/Kt3VuPZ4p/5AvZzsoU6w+UUYJ2GkP/CNSz+D4aPaIaIbydM2
         Y2IK1Jmq3RW1WfissAlI9ayUVu1GXy0NN0a+CU1olE4c83QNfn3lztxrbLZdJ4cpr9iK
         YEmDQcjrIhkCt7rF/pEzpix0PFBTpNIYsa6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GE2KwXHdmFr5oCC22e/Lvz0b5SuqoPfxF8T36urY/E=;
        b=Xmq77C2C/LROm3OLM8VAddQJ0TOzKWZrREmqYtmp/tHd9coChXKoxM9kelsR5nnLs3
         eqfwpJyBGttuEqRa6mHV+Yfe0q1oaVBxpQX5sOjPEHSGzC42oJAS+LiTPkNlYdZlmo3m
         IOi0kx3E58CGoopJ+e03YLt8gDWh/0tBL4mw/IRZFhxJspWrOo/HijbQbGFmbYmM98XE
         UGSboyOzHeynxg7T4xIid9LhvzEpdsfdmDIbM2M1B/9ITZ4z3yei5eRhLch1MQYjC9fg
         YgbaVxibDZ47RRcjY9+81/+KEqtYlliD5RE9UqcA/Y+dt9H5h6Gl10Ha9qgG1sFu4ifo
         Vu1A==
X-Gm-Message-State: AA+aEWawTsG9qx97qTWfLD+WLDXGs/gjlZ8w1jXRBtEXIbfTm+GhdGnl
        6DqMZS2VzGrzP6X0eza8lLJShA==
X-Google-Smtp-Source: AFSGD/WOhsI5EdV6mfsBy0JoWQcCWF0qkVDxZsqN4qBQohApKBD6fQdYmq6QY1bCO0Zsk3Lry3/Wqg==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr1882465wme.75.1543832155599;
        Mon, 03 Dec 2018 02:15:55 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:15:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/9] dt-bindings: gpio-axp209: Add AXP803 GPIOs compatible (w/ AXP813 fallback)
Date:   Mon,  3 Dec 2018 15:45:39 +0530
Message-Id: <20181203101547.16835-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 PMIC has two GPIO's which is similar to the one in
AXP813 PMIC.

Add a compatible string for it with AXP813 fallback compatible string, in
this case the AXP813 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..c8c5d20856c9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -12,6 +12,7 @@ Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
 	- "x-powers,axp813-gpio"
+	- "x-powers,axp803-gpio", "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
 - gpio-controller: Marks the device node as a GPIO controller.
-- 
2.18.0.321.gffc6fa0e3

