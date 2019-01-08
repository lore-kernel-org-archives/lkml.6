Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BD12070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR9uYBn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfAHIma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:42:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33867 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfAHIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:42:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1557564plz.1;
        Tue, 08 Jan 2019 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkpcXAJnt5ax4aCurBUzxVNE0WIBxUcBalSzzt77+/4=;
        b=pR9uYBn7EvMQ5Pp7um0Q9+Yjl6ZWfZ8WywUMJSLz6CsBJRjK5slP5t7SmVjtgZaClv
         rYFWlD0REHgDWvy5o/Skk7dNwGAR7y5gGgQ7bCwydChiH/ggtGAPwQaJrACWpmqAMXSC
         nFqLpaUasMQEdBP2wDwfW3E1mGkp0OCMxD5f//ISFz2yi19oHN7Cf5yncytMTjjoYImS
         sWV6bHN6clr+Lpt/m0lyf2UZd/oDyQjm0z0/ptxa9k1y34sFpBETQtiDTRsNFF6ogROy
         EwZJtcGVK0vB0eFAZHStkDPsFY6N+adAtcnDEUssaeV4vKm4gbvixuH/q1fYpIf/LR/a
         hz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vkpcXAJnt5ax4aCurBUzxVNE0WIBxUcBalSzzt77+/4=;
        b=Tk7xwqyqgsDq7pfXUy3zeicU0hODC8KuJHpVIVKM3jcnei4RvI67svTs4oSuZxR8M6
         r0/EolfIDDZVYOCuKj0t1a1GhgMulxnEGbCbKvjWdtkRtHAXV/bEZ68kwVyFzqfvrcnY
         QsXZjvKnggLkJbfQxEiSIKRSQTsDX/2TouUJLv/6VEx6iH+4z/7mRXXA8U45RHqHhnEH
         c30wrHFlLoAC7fHn0UbJmiGjIxS7FUcGky/PZ2rjwVUZZVXHa+TKgrwViFMe4z+cBPiV
         trurlT3p3o8d+Mz0HMqkl/dfpXiDoeKR5xhjYvX4W0I3RzjWzN0ODKY94F0A7ejHAYHr
         37Uw==
X-Gm-Message-State: AJcUukfxxvc8/rL3RUvuPfw14DUok8kmY4qGSoeMpDy++iAva2No9tTB
        Fy1LYBwY1idmBZ6UBriPP8M=
X-Google-Smtp-Source: ALg8bN6lAJvJzV4OXEErwxdDjXiWnNipx7aS9ErceYWL6lf30MS0W/Dwcc7t8/9q091waJmQjyvYsA==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr886728pls.90.1546936947815;
        Tue, 08 Jan 2019 00:42:27 -0800 (PST)
Received: from localhost.localdomain (i121-116-192-145.s41.a020.ap.plala.or.jp. [121.116.192.145])
        by smtp.gmail.com with ESMTPSA id l64sm86277445pge.73.2019.01.08.00.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 00:42:27 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-lpwan@lists.infradead.org, afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 4/4] dt-bindings: lora: sx130x: add clock bindings
Date:   Tue,  8 Jan 2019 17:41:32 +0900
Message-Id: <20190108084132.10214-4-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108084132.10214-1-ben.whitten@gmail.com>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx130x family consumes two clocks, a 32MHz clock provided by a
connected IQ transceiver, and a 133MHz high speed clock.

In the example we connect the concentrator to output 0 of a fixed clock
providing the 133MHz high speed clock, and we connect to output 0 of a
connected transceiver 32MHz clock.

The connected radios are both fed from output 0 of a fixed 32MHz clock,
with only one being the clock source back with one output to the
sx130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 .../{ => net}/lora/semtech,sx130x.yaml        | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{ => net}/lora/semtech,sx130x.yaml (62%)

diff --git a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
similarity index 62%
rename from Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
rename to Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
index ad263bc4e60d..23a096ca2912 100644
--- a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
@@ -15,7 +15,8 @@ description: |
   demodulating LoRa signals on 8 channels simultaneously.
 
   It is typically paired with two sx125x IQ radios controlled over an
-  SPI directly from the concentrator.
+  SPI directly from the concentrator. One of the radios will provide
+  a 32MHz clock back into the concentrator.
 
   The concentrator itself it controlled over SPI.
 
@@ -41,6 +42,20 @@ properties:
       in Hz. Maximum SPI frequency is 10MHz although 8MHz is typically used
       on a number of cards.
 
+  clocks:
+    maxItems: 2
+    items:
+      - description: 32MHz clock provider
+      - description: 133MHz high speed clock provider
+    description: The chip requires two clock inputs; A 32MHz clock at CMOS
+      level which is provided from a connected radio.
+      And a 133MHz high speed clock at CMOS level provided by an oscillator.
+
+  clock-names:
+    items:
+      - const: clk32m
+      - const: clkhs
+
   radio-spi:
     description: The concentrator has two radios connected which are contained
       within the following node.
@@ -64,11 +79,27 @@ required:
 
 examples:
   - |
+    tcxo: dummy32m {
+      compatible = "fixed-clock";
+      clock-frequency = <32000000>;
+      clock-output-names = "tcxo";
+      #clock-cells = <0>;
+    };
+
+    clkhs: dummy133m {
+      compatible = "fixed-clock";
+      clock-frequency = <133000000>;
+      clock-output-names = "clkhs";
+      #clock-cells = <0>;
+    };
+
     concentrator0: lora@0 {
       compatible = "semtech,sx1301";
       reg = <0>;
       reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
       spi-max-frequency = <8000000>;
+      clocks = <&radio1 0>, <&clkhs 0>;
+      clock-names = "clk32m", "clkhs";
 
       radio-spi {
         #address-cells = <1>;
@@ -77,11 +108,17 @@ examples:
         radio0: lora@0 {
           compatible = "semtech,sx1257";
           reg = <0>;
+          clocks = <&tcxo 0>;
+          clock-names = "tcxo";
         };
 
         radio1: lora@1 {
           compatible = "semtech,sx1257";
           reg = <1>;
+          clocks = <&tcxo 0>;
+          clock-names = "tcxo";
+          clock-output-names = "clk32m";
+          #clock-cells = <0>;
         };
       };
     };
-- 
2.17.1

