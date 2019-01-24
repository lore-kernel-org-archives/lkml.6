Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1316C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86212218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFDqun13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfAXOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:54:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36480 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfAXOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:54:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so6810358wrp.3;
        Thu, 24 Jan 2019 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NOFMpVcXHy+sVbkvQS5EEr4KI99ndjmL+sfcPLZ3kSI=;
        b=sFDqun13+x84hunpUYZxJXC9iviUuG2XXLafgGyCr268Dc8Jb5F22hqAcYHkUkS7PC
         B79glBOVb6H+wxj0Cx7dtRYScqOgl/yEmue/73oJkbNS+fytCwiVfxZfMPRaRJwk6P14
         s5BnYC9BhOL5+XlVBq7QM7RcazTehS1bakX09LQgwxrJzry7Y1LVM7J6HfjyJH8QFK32
         RBWZjL494yaRPW79Zy02o20ZKEDROMF8ntp+RfCIBdrLXcPQ4xgx6/KYsa0L0a0hdD1U
         yVEBNEx2n4XqoT6mz1ih11NZ3u7Jx0dSKrzcGyEG9QjFK+kBX2OcKUzYCHfxwv2ucAb6
         +aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NOFMpVcXHy+sVbkvQS5EEr4KI99ndjmL+sfcPLZ3kSI=;
        b=TWA2iF8RJBxDgih4DLisiwrKCW0Hgetm5EQmpendcMCKVQQt57APdINiarkVJ26h4z
         GSID20r+z1H4U8UGOXVyOMed5+mc2rr59YbTgKNs59tBrPJWJyZLKW40Y4FBPi/9f8fE
         +Np/xJB3H+3q3fS0yIq8rTl2Em7Tiy8eneJRByYi+SnZSpl2P+0Qb2K6eO4iNLT9+3tI
         Qs5dfGVLnEPyGvWvFj6/j7WWh63k2i2U2zwIOLsTPUlaGpFZRHLzJHl4e/xN0sMix3gG
         w6h7SxyBTHOs33p67fZEu/9PRHy/U4qh4SnU4xnqzvZSrt+W+25z5PoXQjjDbAP8puUS
         5S0A==
X-Gm-Message-State: AJcUukeqFQOofAsjuIgBAK4lp8TymSE+GFOVUTOHDtbqMfZSmk9ffYUM
        Dp7dJ64yN8ikpVRJzbY4Ja4=
X-Google-Smtp-Source: ALg8bN7joMFG22DYGsZpiw+iXL00K8ZTUdQzPZbG1EODrxRgoqMO7fRC1ydePZPcLmHVl+61qPDVaA==
X-Received: by 2002:adf:c711:: with SMTP id k17mr7299693wrg.197.1548341638677;
        Thu, 24 Jan 2019 06:53:58 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t63sm53611538wmt.8.2019.01.24.06.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:53:58 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>
Subject: [PATCH v3 lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
Date:   Thu, 24 Jan 2019 14:53:08 +0000
Message-Id: <20190124145309.21698-4-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124145309.21698-1-ben.whitten@lairdtech.com>
References: <20190124145309.21698-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The SX125x consumes a clock (FXOSC) ranging from 32 to 36 MHz as its main
XTAL. It may also consume a clock for the TX synthesizer or DAC input clock
(FCLK_IN).
If the radio is coupled with an SX130x the radio is therefor operating in
master mode and it may also provide a gated version of FXOSC clock for the
concentrator. In this case the concentrator is expecting a 32 MHz input
clock.

In the example we connect fxosc to the "txco" clock source, represented by a
fixed clock. The radio also provides a clock output "fclk_out" for
consumption by the SX130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v2 -> v3:
* Name clock inputs and outputs
* Add FCLK_IN
v1 -> v2:
* Fixed incorrect usage of clock cells
* Fixed wording in commit and descriptions
* Dropped enforced clock names
---
 .../bindings/net/lora/semtech,sx125x.yaml     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
index fe2d2a23c28b..be45bcfd97be 100644
--- a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
@@ -27,12 +27,41 @@ properties:
     description: The chip select on the SPI bus or radio number in concentrator
       , with radio A = 0 and radio B = 1.
 
+  clocks:
+    maxItems: 2
+    description: Input clock (FXOSC) provider with output ranging from 32 MHz
+      to 36 MHz. TX synthesizer or DAC input clock (FCLK_IN) provider with
+      output ranging from 32 MHz to 36 MHz.
+
+  clock-names:
+    items:
+      - const: fxosc
+      - const: fclk_in
+    description: Input clock (FXOSC), TX synthesizer or DAC input clock
+      (FCLK_IN)
+
+  clock-output-names:
+    items:
+      - const: fclk_out
+    description: Output clock (FCLK_OUT) name, clock is gated version of the
+      input (FXOSC). Used in master mode operation.
+
+  '#clock-cells':
+    const: 0
+
 required:
   - compatible
   - reg
 
 examples:
   - |
+    tcxo: dummy32m {
+      compatible = "fixed-clock";
+      clock-frequency = <32000000>;
+      clock-output-names = "tcxo";
+      #clock-cells = <0>;
+    };
+
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -40,5 +69,9 @@ examples:
       radio0: radio@0 {
         compatible = "semtech,sx1257";
         reg = <0>;
+        clocks = <&tcxo>;
+        clock-names = "fxosc";
+        clock-output-names = "fclk_out";
+        #clock-cells = <0>;
       };
     };
-- 
2.17.1

