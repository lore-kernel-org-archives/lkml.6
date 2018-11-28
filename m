Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66978C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B76921104
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPjsVxwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeK2AxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:53:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeK2AxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:53:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so17406383ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8Lbn+76YG2fKXAD/HPwpqXf74NU6wV67oW/8QgA2DA=;
        b=fPjsVxwn9WnVWIEfFqDeVfgxw7pY/n148o+kHVAznpN17Qnob/l75D05wS0bMoze4s
         +mq/Qc03B+AiwiufcguMJXaLYxN55sUpP1nU87oiLmpbWfxWrD9PftclqIPIGphVQaz0
         D22iW2I36EUGyzFew4nlMA7ZL9jowFBgjdtYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8Lbn+76YG2fKXAD/HPwpqXf74NU6wV67oW/8QgA2DA=;
        b=iuRygJGQo5ViF2WuLL5VQKqMvVvQlok5Mia3sfyL2Q9A9Nlt5XYabvQJKRYH8AHPnd
         Qar0c5w1AVFxQHKT9hhbDOP2CkM2/9FWILpKO+SHB8PcrwEzqUFoGCfV7ezkXoWHi9g2
         cgYx0m4zjRVDnHu30WHJ6MUZCxNRwbiiGJrMIkL4L6mdJeb3rdbuJv1Y/mmb573/fJK8
         p0f+pPl4iQ2YOysKKjqSMfBy8Ks6AvdShoLxmgI0hI9ryDh5ah67i6eF5cm9h0LFzxvI
         dYpMXVTTxFoPR6eMqIFUbwD5dAApVWGhF4Y7BCgaf8CxxEECUCCA60HLYnZ5rawepvKu
         rxfA==
X-Gm-Message-State: AA+aEWa/Kg2/YMxBO6X+90A4F3li/dAsmvWvV0ih/c61lo1SLQNc2zqu
        03JPiB3h9FXKZvFv1S435zXC
X-Google-Smtp-Source: AFSGD/U1sjGeyQR1QPUecVxmvWDFqCWWhOPnIMGMY/MZXumQXSSwzvUesCnEi3THHep7ut67JItRVg==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr35798091plr.245.1543413088519;
        Wed, 28 Nov 2018 05:51:28 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:51:28 -0800 (PST)
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
Subject: [PATCH v3 01/15] dt-bindings: Add RDA Micro vendor prefix
Date:   Wed, 28 Nov 2018 19:20:52 +0530
Message-Id: <20181128135106.9255-2-manivannan.sadhasivam@linaro.org>
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

Add vendor prefix for RDA Micro which now merged into Unisoc
Communications Inc.

Cc: overseas.sales@unisoc.com
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

