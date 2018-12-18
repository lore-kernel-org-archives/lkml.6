Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF15C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRDtvfB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeLRDn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:43:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37797 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLRDn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:43:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so5630774pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luzeqSOhSz7LYRGlTw2LYlPWG9a6KoSdnr5RovVM/to=;
        b=ZRDtvfB3uhSv6h0cB9LFJGhrkynV4iY8BLNaMUu0bkctqgIhSLeizpJKXsy/I//wFe
         VfTlsgIxborkZpjV7uA7asoLYvWgS6Nco2Frn2WwmfTUkWnxx8sVirPez3cmQqKKB4qE
         isB3WpQDFc6/aLXEuc33fKb1SbtPz02N6UF9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luzeqSOhSz7LYRGlTw2LYlPWG9a6KoSdnr5RovVM/to=;
        b=kd6kTbsboR12Oped0WY3G2RmNue5pu/MiqczEONebzIWEhC4srKTcWbkuxJ7S3hIlA
         edfJMes09O+bTCfKjzEBKoSM/HBKgRWn8UI6yJb8kik21H3zMuPEtJqJExRDvT8pHBVu
         20Ezc6SdupJ3PGuR7cFzV8mkKIi0brMXKOF7YZTdswqkFvrFmlbj9gsfIHPHqpA+mjFI
         n/wCwTdtfp8WHuIo2RCYmtHKZiOyd1aBaVoj34OSw2U1Adezlvqc5TaWPwz79vVjyB4z
         KMicrccxkIMT26XuPwygDhSvvAwvVxgjWKQIE9RulsF5LPsXVPQmOa8lFCRLwoFqDG3J
         7moA==
X-Gm-Message-State: AA+aEWbJdT5PB5jbOGAysMeky6DYevkGZeUZ71rfSPmN7jTCQtPkm8dO
        Fc9gDhdZboTCP2ebsr3t8YWJ
X-Google-Smtp-Source: AFSGD/VR/eT+K8K8dsUFr/AOsZY1so87nVuE+POJjIu9WSSzGCQuIU8gNWIjEhXN2el2I6LdGv0TAQ==
X-Received: by 2002:a63:6604:: with SMTP id a4mr8658608pgc.118.1545104606620;
        Mon, 17 Dec 2018 19:43:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:43:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Tue, 18 Dec 2018 09:11:32 +0530
Message-Id: <20181218034132.5070-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for RDA Micro SoC architecture with myself
and Andreas Färber as the maintainers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..7f2ae2ed53f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,20 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/rda8810pl-*
+F:	drivers/clocksource/timer-rda.c
+F:	drivers/irqchip/irq-rda-intc.c
+F:	drivers/tty/serial/rda-uart.c
+F:	Documentation/devicetree/bindings/arm/rda.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+
 ARM/REALTEK ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

