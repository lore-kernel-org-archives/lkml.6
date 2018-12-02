Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDCC65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD2E208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c86y217+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD2E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLBUYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39845 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLBUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so10059696wra.6;
        Sun, 02 Dec 2018 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
        b=c86y217+EssT553fPEG7MQk86eyrX1V0dx+1thpVElww3Eq9XhMrWqUUftlMnaQMU7
         cyl/SAf/SCDJW/6GZsw8tY45EQBKY39LJNbzuB683A0vYdXF4/HvVZd7Kjuaq1wJbP02
         MNwUU8ioNr88gS8Pjaxq2LBtrAgRnUiHyYajpi6sQH/2kESVb9xtBIdPUwNW8OfhlYu/
         Vz7I4KRYyRTB1bWrHpjGaOo/T+t18EGm9p7AAdMQ8y8R9aFX93vM/axlAZpkRd+EtDS5
         iAAHuCl/k1abRlRFQ7/i2niHjhJCk+n/bcD7yF9mslZAKr1E7Ej7+0Sf8GUxuYLM4B55
         mnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
        b=kEy9LocqWQgFqncrWAFyIMa6+50hhQmrepCErs1umlBVz5smpWfn+cvgUD/QMFoW3p
         wJ35gnhvaLSLCeVagL4DLSUU7H3JiUwJfi5TfwS2U5N97lltmwhprr/7e0z/h27Y6XTz
         r5m7VBtrJVgRWyq7M60Re8GfNs5kVBPG4n1537vwhbj4ix5El2jqfOfUGuzhokI+cP3L
         f6seD8tLoG7Q8e48vaDN+/UsXtN0g8yTxONDM2VLNWLgEpwCwOH/H+tS+5/3r43jxT33
         lissA/+aOdPscpSTxhGmHXL7CerC3lDwLbayXpXaNKt6WkoxbimPOEbpWWVC9M0Knn9T
         n7ug==
X-Gm-Message-State: AA+aEWYgrWLfSh8UfpImvGmGJSLp8IVqeKCht74BjAYqgix01a/Gkus0
        BtAXaP47MjYDbxTvzFI/jb+qr15hs00=
X-Google-Smtp-Source: AFSGD/VPOOrnSKr8mzkgmLIdvSF++Z35odAHG4iAbEXTnXRN6wJoOxIskM6YjD5v5O+I7amaREuxQg==
X-Received: by 2002:adf:b201:: with SMTP id u1mr11711337wra.165.1543782277021;
        Sun, 02 Dec 2018 12:24:37 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:36 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 15/17] dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
Date:   Sun,  2 Dec 2018 23:23:49 +0300
Message-Id: <fb0c64319cbb5c2b062844ff38aba7b7323eefcb.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add definition for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index ed11ce0..4605525 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.7.4

