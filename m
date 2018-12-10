Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F98920851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAXuJ8+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F98920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeLJRgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:36:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeLJRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:36:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5579356plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
        b=YAXuJ8+RB2DXLXlJjsmBYxPGPKn8PUw3SYbKrETOx3OzVKs/4hNH2LDxhRL4bx/nAL
         I6Xeb0BnrvGPC+hEni1mM32Et0Yddd6GVEjV5hUcftlvTlQuf3cb3uOxl+8o8i9a17/G
         YWGO2AKH/r+d/60k6/pO5d7gsNDwZaRjiMoA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
        b=CKA5rzEAi5fOYobttJPJc4XalzCJPqJYTl9IzDhGl2uVHK62UvRhwLQ+n2yAm7AbRL
         fSdhRVEm6sW2WALKwQN7scEfwVCLm7y6XpP/MC/fyZHs5uM+bpJYWkSez3tvu/45fIlO
         sxhc8L/byyw4/HeT7L0CkWdoFSoi/jL3Sd02KBfZ0MZV5ZOWug5LPHi4r/vAaujvPz06
         oukM8bW8rOLUHFYUqKhM2M+UR7Z1fvlUNb86pbne2FyPgurTTs5qtljkc/zVV7h2W1FC
         3TECk6puiwTRyEmKh6lBwtrRrQ5aGG0Fe/dhsEk0FYI4jnqvuB/8iJkDU4rZlq+PXQcP
         zOag==
X-Gm-Message-State: AA+aEWYEp+dFKuB2ktPnWy0k5pbK0rcOv5Y6k44sJxFX+nSwaY+ZNAPz
        0cZnO3BYEVXkHAswppPS95mJ
X-Google-Smtp-Source: AFSGD/Wz2XxQXuAz0RTqoKVJzQmZWsvyXihZ51S8kKbW49zS79pqi/EGrLltCwFa5FSa2mfSR6VNxg==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr12863201plc.211.1544463381821;
        Mon, 10 Dec 2018 09:36:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:36:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 02/15] dt-bindings: arm: Document RDA8810PL and reference boards
Date:   Mon, 10 Dec 2018 23:05:37 +0530
Message-Id: <20181210173550.29643-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
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

Cc: zhao_steven@263.net
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

