Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D5C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1D214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI+M6TYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D1D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeIWKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 06:07:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36266 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIWKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 06:07:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so7746759pgo.3;
        Sat, 22 Sep 2018 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6LBOqJQe9QtC48YHVqBHRixay1Xy4YheIM/hzHkzDQ=;
        b=rI+M6TYYbIYEB487sIxqmUmU1XCLdqraVwZK0NwoRUkrMfEHUjvTSPolfszTdL8K/k
         Y2KwBJZ6lDAeWtsCQJ6qrdVU/vQ0MDznQYfbW8+uQdhODpTfx4Brxhlaf23EbPdVy8zu
         RD2N5WDwEr4DCpqVH3npBbEP74a2XICaKnDmAW1poCflHqvkICFrZQ2pyZaQzG5R+uB5
         CG3+eoytI/nLcNRfDJa/Lkq9ARAqsa03GsfHawVO1ccl/v0IhGI2kouGEbSamA6Pc9oR
         8Diaz8chU5DjnVZgHa0XymBR0Wqdt0tWXLtKVeMwvnbkdfUzoE/09Wbky8BqsG9XVLiI
         0gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6LBOqJQe9QtC48YHVqBHRixay1Xy4YheIM/hzHkzDQ=;
        b=r7CF4EZ+93p/NysooyD6N/S/hmwnLaw1IZv40/HeFlz0vLd4+FSHft7a+VeYPS22mY
         LZgJC9t8tQ8Xf54k9wJt4EVVQEL0lUTpef5KD3ISJOGOTwo3LPHOTvJrIwcfNp90WWB9
         euEpoINYiFQWlZO0qTxN3PNFYqtAGb8dB2dT1imtHq1Puzw/HkIHGEZogjsWaxBeJ+y/
         2NXWCMG2sPRvGOw7QACqZsmOl9F73R78Wf74Ef8yOCLayuzfJiDxHUCT1xb78oiW3ofJ
         28H+DP8+nc2ROzCxCTUvkJWtAMlWuYpLBK1JC/Is148Ixr4bjU664Q6edRR+Hhqg3N3T
         ei4Q==
X-Gm-Message-State: ABuFfogbWkfUySs+4OmXQ1LwC0z4lHMRCT0OhBOf2/1AlvmvJbWTojrg
        hIS1Gcmu1Q3U01L6jyUpf20=
X-Google-Smtp-Source: ACcGV60RGm4iavJOCQ/0bbugJBOyQBvGaO9DrUw+Ke5hS0e350n6z7XgcpwPjNclHlnLW/4XGpfnQw==
X-Received: by 2002:a65:50c9:: with SMTP id s9-v6mr4293240pgp.417.1537675889872;
        Sat, 22 Sep 2018 21:11:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l10-v6sm68942799pfj.179.2018.09.22.21.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 21:11:28 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Sat, 22 Sep 2018 21:11:17 -0700
Message-Id: <20180923041118.8743-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923041118.8743-1-nicoleotsuka@gmail.com>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
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

 .../devicetree/bindings/hwmon/ina3221.txt     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..7d90bfe34adb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,42 @@
+Texas Instruments INA3221 Device Tree Bindings
+
+1) ina3221 node
+  Required properties:
+  - compatible: Must be "ti,ina3221"
+  - reg: I2C address
+
+  = The node contains optional child nodes for three channels =
+  = Each child node describes the information of input source =
+
+  Example:
+
+  ina3221@40 {
+          compatible = "ti,ina3221";
+          reg = <0x40>;
+          [ child node definitions... ]
+  };
+
+2) child nodes
+  Required properties:
+  - input-id: Must be 1, 2 or 3
+
+  Optional properties:
+  - input-label: Name of the input source
+  - shunt-resistor: Shunt resistor value in micro-Ohm
+  - status: Should be "disabled" if no input source
+
+  Example:
+
+  input1 {
+          input-id = <0x1>;
+          status = "disabled";
+  };
+  input2 {
+          input-id = <0x2>;
+          shunt-resistor = <5000>;
+  };
+  input3 {
+          input-id = <0x3>;
+          input-label = "VDD_5V";
+          shunt-resistor = <5000>;
+  };
-- 
2.17.1

