Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F59C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57DB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc7a9LGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57DB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKUOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:10:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40541 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeKUOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:10:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so3373171pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpKApkbZh5UuKp02YzW5T5e/e2xGXhow1EV1I9MOaJE=;
        b=kc7a9LGSNqYsoKpPIzgZxpIy4w4a8SyzrrFTsjBXScjm8Iz44cdrEDihEXchpcSwn7
         QKPrlOiUJtVPEF+JOhBEziOKAupcHA0MeNxLfAqm3b/IiOm6MKRfPjimW6/CyBDNjToN
         ocTXITWDXU31kTmgB0+Fc7RvtYlRpsbXjDYV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpKApkbZh5UuKp02YzW5T5e/e2xGXhow1EV1I9MOaJE=;
        b=fh+m7ZdrXsVhuyIDoNj8aq+ix26CfjZhRcrgMDdN1DdBRjfnF4EcdenuuPPX09U2Ph
         aBaw6IqFg3nZxeovbNlvhSzedTxUAH1GrnWavUj86oYAdZFRdxeGR78Ywva6FeWAx+LO
         pLGyMF47DPbKmDuyNlI2iue++Be6cChjGvYc4eZiy1vnAfYo1GSfVFxTbJGT1hChOQRX
         bqVK40ULunvrIkuDXM+zSw9kyMHSjR2zQkFDQekqbiDfO+CRmCA67KIarn+So5rLOwyC
         MH+2nQ3pJIxS6QCtBMqKgWqqzbCZIIqXR7RevKplhCwh2MwTPbUjO9yRMkEeFk+TTHyM
         HK0g==
X-Gm-Message-State: AA+aEWZFFiECNHakZdklL6faPW8VQ+cH8zL7YxaDNuQfCIoKpBhazmP5
        Wjn9WI8EGuASeCcIy37kbAip
X-Google-Smtp-Source: AFSGD/X2XVZBo7/BGjzh58x3wYIXiRhx8swvn+AqWmvf4XEUnVBkX92lBeojGPeHSTRJg6VYOYpBDw==
X-Received: by 2002:a63:5026:: with SMTP id e38mr4438141pgb.123.1542771454229;
        Tue, 20 Nov 2018 19:37:34 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:37:33 -0800 (PST)
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
Subject: [PATCH v2 02/15] dt-bindings: arm: Document RDA8810PL and reference boards
Date:   Wed, 21 Nov 2018 09:06:39 +0530
Message-Id: <20181121033652.12247-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
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

