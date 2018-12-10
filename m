Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D15EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19732082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOTdJMoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19732082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeLJRgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:36:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33078 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeLJRgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:36:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so5576854plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=OOTdJMoV28QZwKWig2beKcjaiyzW73Jrx6asTLjc3u2QteieCIsaKh6NfWFd62n5OH
         yqZiwkKmuZQImMFk4aJ1wCiwmGvUcl90vDFqhepLwmubv2sdJLrbpU8MmcF4NOgTzdre
         0XpAVEptPwRU4K+RO/n8lLKNjsmYAgxlvfs5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=jZEC1ZksUaqrqWFh5zK1h8hwEHdTDV4UJLbEk8Eg4rl4fLVNDpJsr1q2aIo+XeMcku
         p3MlR3N1xIELcnymmeOqszFJCtzcAp4dmnomYiO/ryXbtxzAxeolRknc/QVzqeUrRRI6
         We+Vtct47/CxTeTT1lpftbgpQ5UgiBzX1C2J0lUQ45GxFOGCbOJHwyDCI5Uu3e3pGMQ4
         zqEHk/UzJKBw6fn1saq/NAthdNeP+l9m8PcF8otirk7pnbSI0ZRQ+ReFIQ9RnxhW7FOH
         ezO2TNkVNGjFdr43S2p7YlbJgjP89RMeW6FNE3CI50g0qIu0fbG+OntyGUpdim36y/ZC
         1BzQ==
X-Gm-Message-State: AA+aEWa1UWBclhh+UjZNug/xA7Iyxmf0EQKGH8nPh3H6hKKMlPy2vKK6
        iZxmbBoAX3ar/8dr5lFFLmBB
X-Google-Smtp-Source: AFSGD/VlQQbhivcoy3gWxuETmz8E5m2MnAiSp/sBTcGGLnX7DhUXiIwhB7Xgrg7o88ZwLSXJH+Wb3Q==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4mr12922734plr.298.1544463372718;
        Mon, 10 Dec 2018 09:36:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:36:12 -0800 (PST)
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
Subject: [PATCH v4 01/15] dt-bindings: Add RDA Micro vendor prefix
Date:   Mon, 10 Dec 2018 23:05:36 +0530
Message-Id: <20181210173550.29643-2-manivannan.sadhasivam@linaro.org>
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

Add vendor prefix for RDA Micro which now merged into Unisoc
Communications Inc.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..37826fac7684 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -320,6 +320,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 raspberrypi	Raspberry Pi Foundation
 raydium	Raydium Semiconductor Corp.
+rda	Unisoc Communications, Inc.
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
 richtek	Richtek Technology Corporation
-- 
2.17.1

