Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D54206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6Sq/fO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D54206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeK2FUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:20:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43614 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:20:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so27285072wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXT1Ek3AUSrLYZinC9FgwEb9RvtkWujW45EXwZvZiT0=;
        b=N6Sq/fO2ykC57XvOKfltg/lwoE/p4W9W7zWjhp54+NNLbfe8nMBykIoneodpdasvgZ
         AfHTNpV3kSiPd669+/U3RMqUJWybz3j0KOE1GqKc8yFnH1XfR+oK0EZSHRDsBaXF43LV
         lQmavk2k12Cw6X3hyzyAMCOX/9QTnUG7KD9qPIZcVxXTp6+Lx24fNJF0GY7b2LZaTTKs
         QjNRyknO9DT8ZBC/bXe5cFqxAZSZLyj9ZE/iIA8QY+Z08jCnMAU+lNrMFmXVS6cD4gg3
         SoiO9BasqnjbPqs3D88QWN3ZinMuGXjxr58hgxgz7zvo52lHGLtLmI8e1f6OykAtN15+
         /v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXT1Ek3AUSrLYZinC9FgwEb9RvtkWujW45EXwZvZiT0=;
        b=cvpJgKYqiLlpceef+cJcoNuwM+ZdthJrb8c/ZDgQHvppyyW6YqC9DSthHbPro/C4B8
         RUFSk6ualCdC4HMT6C6hwbU639GT8lolViTZV1QeWr5/L9C74Bd/noFcDkTvMp3z0QKy
         smnaXjNc5WtK6+rEmAb1Z24vSH+G6QxmZCJKsagA4cm47FYC3m/MejlwfsLkqNq5ci+X
         xG+cNFcyfVwPI+mvyk3LiecDckowaUtGaMZ0X4bAMzADhenir53raa48v2dLwe3+/SRC
         unHQOMpms3ya6UozHNoSEucXBZdCyq8HqfcUMsa4f5Ugyjek0TA6tZVWFX0ddOV4R2xP
         ffKQ==
X-Gm-Message-State: AA+aEWaJ13V4jLFeDOc9F2ElqB3mGQrRgNONQQQjT5g6RVyxiPJC4K+l
        FBNAo7L8f9Q849/yX2zHdJI=
X-Google-Smtp-Source: AFSGD/WbQYM+JJx3qZzFTKYvTpUCVzoBxLZpkd88IPC9dDBE4hjGFPEr89Jm4V2AgNRKs2WblUXZtA==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr32410561wru.300.1543429068936;
        Wed, 28 Nov 2018 10:17:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j8sm6204493wrt.40.2018.11.28.10.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:17:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     ajay.kathat@microchip.com, adham.abozaeid@microchip.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: wilc1000: correct inconsistent indenting
Date:   Wed, 28 Nov 2018 19:17:24 +0100
Message-Id: <20181128181724.25194-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct inconsistent indenting reported by smatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/wilc1000/wilc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
index 35ff432587fe..6d1eb82d1df8 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/wilc_spi.c
@@ -963,7 +963,7 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 			dev_err(&spi->dev,
 				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
 				j, tmp, unknown_mask);
-				happened = 1;
+			happened = 1;
 		}
 
 		j++;
-- 
2.19.2

