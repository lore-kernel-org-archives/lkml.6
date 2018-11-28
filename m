Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2870020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d17O4Svg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2870020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeK2AxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:53:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbeK2AxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:53:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so9525550pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpKApkbZh5UuKp02YzW5T5e/e2xGXhow1EV1I9MOaJE=;
        b=d17O4SvgBbuCy21nNSEV0esnJ/ow37xiyVsnrnnQzO56ADysjAmfJTA/AyRVIr7vmx
         R9Er7RqFMcSP9NV4kAQop669EmO73RONEZjdEp/bWTHbQsmomyt6dt5kDvrCSShpw7Pf
         GWq9HWia/Ug6b+LoFcZMeUAjZGiT34Gxzvm3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpKApkbZh5UuKp02YzW5T5e/e2xGXhow1EV1I9MOaJE=;
        b=ZDdybpL+XFQbvLx1yci1BYAK6K9oKKXaui2M9bdhQaz2Fn+NUJ1pbf8aUOlq7UYUZD
         TH5iCU1e0FmJ34HoO8UK5m5fNOL8jU5gCXgKDtHSEikRll2OxilPN0a/aCoDScA79B9I
         AecOaBhgfgFNwJ4c94yyUl/SvpeC6oHFiFVBpKOKxE3RwmqskheLzurVJilu8smn+mh5
         1h/BhyzHs++CZ/pg2Dvr5rWE1wiN/pkgZ6ik9Kw1uz14hegQ2cx/+xCCf6REVOoeZNVq
         ZAf1ireXsn61F4qGv8FIzX4iKsbsD1CGnKbN2r+r6iwJL42AVremCz8JKAkwAAhCSznj
         ImjQ==
X-Gm-Message-State: AA+aEWbgi7I7efcklg/6+hOwRiwO2fQPudRaoAouIuv4vGlr1xEDgRcP
        RnIKSntMLmaKrbCecHDj1V1a
X-Google-Smtp-Source: AFSGD/UDrdJgNoGeCZwTdECtWiv2yPSfEukqx3EEnUHRdd5UlA7Oy+GHFHKYrAPtyf3VVtqKVILEZQ==
X-Received: by 2002:a63:1848:: with SMTP id 8mr32777558pgy.81.1543413097787;
        Wed, 28 Nov 2018 05:51:37 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:51:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 02/15] dt-bindings: arm: Document RDA8810PL and reference boards
Date:   Wed, 28 Nov 2018 19:20:53 +0530
Message-Id: <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add bindings for RDA Micro RDA8810PL SoC and below reference boards:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

Cc: overseas.sales@unisoc.com
Cc: zhao_steven@263.net
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt

diff --git a/Documentation/devicetree/bindings/arm/rda.txt b/Documentation/devicetree/bindings/arm/rda.txt
new file mode 100644
index 000000000000..43c80762c428
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rda.txt
@@ -0,0 +1,17 @@
+RDA Micro platforms device tree bindings
+----------------------------------------
+
+RDA8810PL SoC
+=============
+
+Required root node properties:
+
+ - compatible :  must contain "rda,8810pl"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Orange Pi 2G-IoT: "xunlong,orangepi-2g-iot"
+ - Orange Pi i96: "xunlong,orangepi-i96"
-- 
2.17.1

