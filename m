Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4937C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D57420896
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdgbTg/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAHIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:42:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32983 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfAHImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:42:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1567849plo.0;
        Tue, 08 Jan 2019 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zvlms/9Oh6c6viVVAzA5dTDzr6flDQdvl/myX+R22Es=;
        b=EdgbTg/BDZfiFIlYG4L0ZxnL24/LW3/vDFZ4CZzTtIpJhgds5XI2vcR+PiB5eqwtXw
         GQWi78TKypns6wHLQY5TNJGLVZ7aznuekWl2gIBMyfpvm78wyaV0HG7bcBzdzDLSFBUX
         Oou6FPlif2bTWxjLdU4vRSlnoqBOeQTgrKlqZ+dTpTzjr1tkrgYI0PpKEUAnVp/GtBG0
         hmQQ5AeRbMjLik4z3smpI0BmGXkgmN8k3btZpSbgbNCSQstMMSMAqRO+jBS1DJApDI/h
         2Natr7nzX/B40jdIZbGtBMM7fr22WYA1aOvbWDaqEfFm0YigDWGCmMKV7pwgkJ2OwNnw
         xKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zvlms/9Oh6c6viVVAzA5dTDzr6flDQdvl/myX+R22Es=;
        b=g2ODtuUmy4fjbHhJl33qneMwC//ugedGM4mqjOU0x8miEzgxRU6GcIoQQwaRNiMeJR
         jyTh8Gm3Fr3Swpfh1PlISxx2dCYzvVDS49TYY2JqQOTOzjF+HE/F1gurwChEDUStA52x
         Pt5vfu+k0MO0pMHoDjEHhsKxexxwiqBbEh96CVD7Qv0oC+Jh7vjmzkSUPZVG+bcygDyj
         XEszyLpr6ansOOik84LiRy4mQZQWmFk5byYR9yJVp8BMucHqQqpHzK4k3B10i8m4jLkE
         vdP7B7v3qiq/PSKevlh0JcozA4i6zhi7Tia1Pgc9kpxS0LatbSc45EYL9OH5zgd+MK5k
         qz/A==
X-Gm-Message-State: AJcUukez6dxqrESb1DqIyrtAYgPI0bodvfqmEUWRmE4Mi6x/WQ3wNZSk
        nMWle+eJi7erWMeNEAguYUY=
X-Google-Smtp-Source: ALg8bN5msPM1uGIQkeQtDjYmwb+KJAJRLfgYu8ip6tekhqNyJPYDMon7Wzqxe9XSVnstlZRxgYukoA==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr843823pls.293.1546936944596;
        Tue, 08 Jan 2019 00:42:24 -0800 (PST)
Received: from localhost.localdomain (i121-116-192-145.s41.a020.ap.plala.or.jp. [121.116.192.145])
        by smtp.gmail.com with ESMTPSA id l64sm86277445pge.73.2019.01.08.00.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 00:42:23 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-lpwan@lists.infradead.org, afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
Date:   Tue,  8 Jan 2019 17:41:31 +0900
Message-Id: <20190108084132.10214-3-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108084132.10214-1-ben.whitten@gmail.com>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx125x consumes a 32MHz clock and if it is coupled with a sx130x
concentrator may also provide a gated version of this 32MHz for the
concentrator.

In the example we connect to output 0 of "txco" clock source. The radio
also provides a single clock output, hence "#clock-cells = <0>", named
"clk32m" for consumption by the sx130x concentrator.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 .../{ => net}/lora/semtech,sx125x.yaml        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 rename Documentation/devicetree/bindings/{ => net}/lora/semtech,sx125x.yaml (67%)

diff --git a/Documentation/devicetree/bindings/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
similarity index 67%
rename from Documentation/devicetree/bindings/lora/semtech,sx125x.yaml
rename to Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
index 5eadec860b70..c2fb4ac06341 100644
--- a/Documentation/devicetree/bindings/lora/semtech,sx125x.yaml
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
@@ -33,13 +33,40 @@ properties:
     description: The frequency of the SPI communication to the radio,
       in Hz. Maximum SPI frequency is 10MHz.
 
+  clocks:
+    maxItems: 1
+    description: 32MHz clock provider
+
+  clock-names:
+    items:
+      - const: txco
+
+  clock-output-names:
+    items:
+      - const: clk32m
+    description: 32MHz output clock name
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
     radio0: lora@0 {
       compatible = "semtech,sx1257";
       reg = <0>;
+      clocks = <&tcxo 0>;
+      clock-names = "tcxo";
+      clock-output-names = "clk32m";
+      #clock-cells = <0>;
     };
-- 
2.17.1

