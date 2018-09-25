Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78212145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY+PuYzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78212145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeIYJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:22:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41130 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeIYJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:22:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so1484743pfi.8;
        Mon, 24 Sep 2018 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i27eoIRURIs0+vIDJ8A6Lr6wvThnfMnF5bV0qpvXErI=;
        b=fY+PuYzr0QVkslJvK9SYzQKulSX+6lx1U2NJtedypp7Ty/aNDlHoPWXNN8Mfk1TCtf
         49NO0R2uOTS5fyLJjXZaio6nMqg6KlRkCDFUnq1fgaAoVr8UFt0MaRNy5YltVPvB0uY4
         DT5qdzDuc5xhKpTSfDXtbiZSWTPvFFBpSh8P/FlfrEOlXf/PgmvH8FFNl7v+kCUTN2Di
         YCL6cXYsXUjMAJq3UNj/2sQ9ETcFmgCv8SvPFiybIVtrhfAGCpY7eQHLi7lPplzKIYYz
         Ql/wGcrvwC+sNn4wBVVfMSpeUsrcGtO4vDKGY+0YoZIKq9Ciz39u48bZt8V5btKtglwH
         m6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i27eoIRURIs0+vIDJ8A6Lr6wvThnfMnF5bV0qpvXErI=;
        b=VI/0c4k0mwAJl9t01eM6IY68E/3jO+u97d34JQC/LdWbufMoVTg9glmXGW8WaeXxM9
         P1YUg/YypWWzdn/Fo7+GIsX22lJa2J+6xHPGQ6G2LZtiAhqcxg2nByl3Q51HEW3nFrGR
         rKsabENPOh4dAKzAbfi0wUx6PLLyjZYqQzRlDXOE17DyWgIUPOOFu361hBU2C4ak5/lk
         8DHeoghFUWqnJnktJ7q/Nv3VzApaBM0csXQZrjZarkbH4iYShQdNhl9f/Eeml6lim1dG
         ansAt74MHCjuMBHyn2ABSlstmFYHN3hCG1vRDxhdidnPrMz6GTD3b2kjcpc3r4G2hL5K
         w1cQ==
X-Gm-Message-State: ABuFfogMEaWACafxf5ZGoP9zBRidNVOp4uhJCQsrVXR2Ks3uomem2o7i
        jxzXOwmsKTMK/akGT1nF7Z4=
X-Google-Smtp-Source: ACcGV62V/bRYJY+ng0QWONg2ezi8+yFWLAF18IpECnXYHu1PSGQ1XcJ+yp5U1zzZtVj0OU6gNNViuQ==
X-Received: by 2002:a17:902:7887:: with SMTP id q7-v6mr1425638pll.111.1537845451584;
        Mon, 24 Sep 2018 20:17:31 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id n9-v6sm967993pfg.21.2018.09.24.20.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 20:17:31 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     preid@electromag.com.au, rtresidd@electromag.com.au,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 1/2] iio: magnetometer: Add DT support for PNI RM3100
Date:   Tue, 25 Sep 2018 11:17:23 +0800
Message-Id: <20180925031724.21399-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PNI RM3100 is a high resolution, large signal immunity magnetometer,
composed of 3 single sensors and a processing chip with MagI2C Interface.
PNI is not in the vendors' list, so this patch is also adding it.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
Changes in v2:
        - Remove bus specific part in compatible string.

 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
new file mode 100644
index 000000000000..4677690fc5d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
@@ -0,0 +1,20 @@
+* PNI RM3100 3-axis magnetometer sensor
+
+Required properties:
+
+- compatible : should be "pni,rm3100"
+- reg : the I2C address or SPI chip select number of the sensor.
+
+Optional properties:
+
+- interrupts: data ready (DRDY) from the chip.
+  The interrupts can be triggered on rising edges.
+
+Example:
+
+rm3100: rm3100@20 {
+	compatible = "pni,rm3100";
+	reg = <0x20>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 41f0b97eb933..5bf3395fe9ae 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -288,6 +288,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+pni     PNI
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1

