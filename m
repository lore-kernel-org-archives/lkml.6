Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5144120661
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9KkHMx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfBRU3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:29:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfBRU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:29:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25so7652491ljk.8;
        Mon, 18 Feb 2019 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuFYiNaIXu8bH/oXNgUI9qhc2E54tNm+yvLdDJiPEi8=;
        b=M9KkHMx2leZCJg8eO7cHgNlFXbvQNhEWxQcXHTmAniIt34K4bszjOmdBy3dMOpj0Ri
         E9kCeMPeC4p/n4Q9UM4aMUoize5UXIoWmWP1UadzeCcWWwbmMkE75ZMqJLEJy1uZvbA7
         dzXlkBGbqOL8aVD4My+ylIWASXk4CnHYm6uiO1XSQI2E473jSO3pY/CbWKhbYUSVzwb7
         s+XaLlmW1LKzVb8qgz2GeIr+Rym7p7H2+Rx/IgoytmujA5f2A5Td9BqJRIRRyoBZ4DIt
         QbemIx/FpSsncJC9wPf3ScjgQRgSFQ+nVKkXlOHgpb3tBCNWmWJUXCTM/gQ7+EQG5+g+
         F5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SuFYiNaIXu8bH/oXNgUI9qhc2E54tNm+yvLdDJiPEi8=;
        b=OfiaQKIhSTO2QK1L9gORE29Wtip2voyed33n8q0xSesfqEW0UnUWg2OhM/Skrd7WA7
         rJTq4gUh6i53bC1pN0IrOXyuL6r9MjoDh2CSyX0EEucIldIocansiRdtAnv28YZjfzGZ
         DiEhO04mQdftIgDy2Eos9lOVPIrOSKwBdj8X3jc3usU4AEt4f/S3tGD6FdtpuYBbT1xf
         l67+6tWiF1xfhNhzZqeBoDi2GCTtHELZE63k7O5/Q3W3nBMLWIAHGaTKRfKVqAXz4cAR
         k+oZBmK8AzW7ckGLqAv/CKLgjam0UqxxUNDNaJQ2KqrfZNflaxOMPScA+ogfZZ6vy44M
         EVKA==
X-Gm-Message-State: AHQUAuaVkYYIpVkKbC7L/pUjtzX5YLTN063xe6Oyf+XnaZh9kBkPofKz
        d/b0GZ6kDG++dC9ZnQ0dN/8=
X-Google-Smtp-Source: AHgI3IYxPYReIaWolL+qHvXGDduuuQLVOtidgHuIL+XTsR2qb20QdWXxYaJ97s0sNOd2lrwLiQ02mg==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr14798701ljj.89.1550521776046;
        Mon, 18 Feb 2019 12:29:36 -0800 (PST)
Received: from localhost.localdomain (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.googlemail.com with ESMTPSA id e72sm360895ljf.85.2019.02.18.12.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 12:29:35 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Artem Panfilov <panfilov.artyom@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: rtc: add ABEOZ9 support
Date:   Mon, 18 Feb 2019 23:29:29 +0300
Message-Id: <20190218202930.28140-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da6926095..0ac93f2dcedc 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -39,6 +39,7 @@ possibly an interrupt line.
 Compatible		Vendor / Chip
 ==========		=============
 abracon,abb5zes3	AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
+abracon,abeoz9		AB-RTCMC-32.768kHz-EOZ9: Real Time Clock/Calendar Module with I2C Interface
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1672		Dallas DS1672 Real-time Clock
 dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
-- 
2.19.1

