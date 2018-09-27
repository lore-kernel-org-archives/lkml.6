Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2640B2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUMVCpEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeI1CJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:09:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41345 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1CJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:09:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3-v6so2690416pgv.8;
        Thu, 27 Sep 2018 12:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7AD0S7PM2qwtTJVEYgPRsvVVieRD9k75GvHvcxkbDdU=;
        b=FUMVCpEl5aPmIDYEcCdTcv3rRCzyrDh61nT+EegfQW1bVNiHEaIgeOgJoOxQAgVy+r
         YRSCOao56VCs987BDWolFt1ySd+tuFkw0Ovw9KNZrn2KP5tL0ec/QN9dwPL2rDipvT3N
         VgKhs4ELmMurVuAKPZezP0ad56rGlJkL+QDgwGsMi19CFAgeWXoSS5VNenNWFHxKs0KD
         wtDZuih0tsKB6Vo3LuJ8ZaY8UPH1pRP1P2DzkctlY02k4R+KBK1qoe0zTxtIh1SPDhOa
         padwLyiWit60iLxOCxn5ZfiW+eocAcEs5RYa/oz9s1jTssUP4UPDMtZapOS6+C7/AfLm
         AFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7AD0S7PM2qwtTJVEYgPRsvVVieRD9k75GvHvcxkbDdU=;
        b=aA4vjuCUQzsCj4Lqh0kdFJYKUWuvDrMioDeLn9Fz5cKTI0v/LRr6CWveGwOYOjgNUO
         Kyo8AwpKeZy46dPfkzpdnhDy0nxmCkf5p7jFHruqPqxp8aIO4+jgld1ALBs5EhWCge+i
         inOR3anoadUXAhfUO3OUe+KkEf9eIrD48wlAh1ayzulwV7bFuIhpIjJe5q99zxNl5Zny
         Y+GlPa5eE6nIb+OSOrQ+/1NPgreRdfxAtUZwat86TyYamPWXatSlIm/1OCbL0cM5fVIo
         /6lhcqZ/m+OmQANv3JjEIRDsQi1orXBVeCQxcmOxb9FDIuqP7ERYXOCS7pBImOsMuKzz
         bMqg==
X-Gm-Message-State: ABuFfoiI2SRQ5QqlPIq8EInwkpeipx8eBtqj2yUrsXTAJubCqRrQwg6T
        uy3ZpVje2OSd9+VHtiT3cgg=
X-Google-Smtp-Source: ACcGV61SJ7AtGsvqtIHir+Y8pAuejexOYoF/bT/r13YZLBbQJjSzDs0WW02C9Xdz7gxqrKKHKUVXDA==
X-Received: by 2002:a62:8d16:: with SMTP id z22-v6mr3582784pfd.185.1538077757094;
        Thu, 27 Sep 2018 12:49:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g65-v6sm1449850pfg.98.2018.09.27.12.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:49:16 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Thu, 27 Sep 2018 12:49:09 -0700
Message-Id: <20180927194910.18464-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927194910.18464-1-nicoleotsuka@gmail.com>
References: <20180927194910.18464-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v5->v6:
 * Removed status property as no need to explicitly list it.
 * Combined all examples into a complete one.
v4->v5:
 * Replaced "input-id" with "reg" and added address-cells and size-cells
 * Replaced "input-label" with "label"
 * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
v3->v4:
 * Removed the attempt of putting labels in the node names
 * Added a new optional label property in the child node
 * Updated examples accordingly
v2->v3:
 * Added a simple subject in the line 1
 * Fixed the shunt resistor value in the example
v1->v2:
 * Dropped channel name properties
 * Added child node definitions.
 * * Added shunt resistor property in the child node
 * * Added status property to indicate connection status
 * * Changed to use child node name as the label of input source

 .../devicetree/bindings/hwmon/ina3221.txt     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..f2dd3137bf1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,40 @@
+Texas Instruments INA3221 Device Tree Bindings
+
+1) ina3221 node
+  Required properties:
+  - compatible: Must be "ti,ina3221"
+  - reg: I2C address
+
+  Optional properties:
+  = The node contains optional child nodes for three channels =
+  = Each child node describes the information of input source =
+
+  - #address-cells: Required only if a child node is present. Must be 1.
+  - #size-cells: Required only if a child node is present. Must be 0.
+
+  Example:
+
+  ina3221@40 {
+          compatible = "ti,ina3221";
+          reg = <0x40>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          [ child node definitions... ]
+  };
+
+2) child nodes
+  Required properties:
+  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
+
+  Optional properties:
+  - label: Name of the input source
+  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
+
+  Example:
+
+  input@0 {
+          reg = <0x0>;
+          label = "VDD_5V";
+          shunt-resistor-micro-ohms = <5000>;
+  };
-- 
2.17.1

