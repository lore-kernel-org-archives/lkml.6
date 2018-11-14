Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2256C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07CB2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVLVO0z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07CB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeKNNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 08:50:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43829 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeKNNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 08:50:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so7077985plb.10;
        Tue, 13 Nov 2018 19:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b8aow+zSDqMrekCi3xtusAn3i8TG5qzpDFdF9SjU/gQ=;
        b=cVLVO0z6QWIs+VImrZBRPrW3YJfXR+BEfmsAU9KPLDuW8W5GYPp2m1OOI0Tkdrct1T
         d2OPzUQEya8fN0CkiqivQjGJF1Ut1mEwhPcxIK40zJ3N+ib5ITtLF2tJPfj1NrjIW/VP
         vyy1PMQnv/vInhUbp3yCgrl+LeLmy0Ww14kuhEEskKaFN/L/fc6kHs5djkm4ww2I+2ly
         +fYjQx5wvW6boX498sHcIvOTIFtGBlsc/5e4+h2vXZQKL/r57GjLxtUTJ9uGYAPXN1sd
         mRYqHxqCdU6lJTOYZuEVuDizdQN7wXrqcnegPTnSs3mXAJAjbQPjkluvl2Rb8vDISOiB
         zP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b8aow+zSDqMrekCi3xtusAn3i8TG5qzpDFdF9SjU/gQ=;
        b=KlLllYKipXrJdvupyRFrDTvJgVMj/RljxvL/cVvsSGX81mblAwwc88v7jYnRihabqQ
         jeLLKQnqYwB4lRmvVcdP31E3sXWfrdaZ0ol6x1fca2zx6BHSdVO2dCLOQtgkqWDVr28H
         JmJDVa1MdGlpbLI2yfqTO37fqEFYeucU+Kl9BwS22a8KRwoHtTOV2klsLxb8QGw4dQHV
         h11dvkXMxLfCR3P9ZXAI0Ae+du3XqI8Vd+cAmvOStcCgTnBUWIDL7RELxlfNwyZT9B8I
         7HrFZ2g2gvAdh9Yp2bwf0je+njgDMBhiqwUilUcqdZ+1L/MEkHXjJ/2bSMIBKyU5nHQp
         EIGw==
X-Gm-Message-State: AGRZ1gKB2y4jUo2KPQojZ9c5ZI0XuRCTVLBicH37mXu+adjb1IUIA/jS
        Ir1cwXoBNcP9oNDZRfgvVzc=
X-Google-Smtp-Source: AJdET5fG+pShqKFhl5BsKutextvfIqC0jzbImRvja0sW2D3h5lx4x3MyO0wETmO2jnqzTkJhjqr34g==
X-Received: by 2002:a17:902:4281:: with SMTP id h1-v6mr316691pld.114.1542167339277;
        Tue, 13 Nov 2018 19:48:59 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v15sm425302pfn.94.2018.11.13.19.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 19:48:58 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (ina2xx) Fix current value calculation
Date:   Tue, 13 Nov 2018 19:48:54 -0800
Message-Id: <20181114034854.20035-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current register (04h) has a sign bit at MSB. The comments
for this calculation also mention that it's a signed register.

However, the regval is unsigned type so result of calculation
turns out to be an incorrect value when current is negative.

This patch simply fixes this by adding a casting to s16.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index c2252cf452f5..07ee19573b3f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -274,7 +274,7 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
 		break;
 	case INA2XX_CURRENT:
 		/* signed register, result in mA */
-		val = regval * data->current_lsb_uA;
+		val = (s16)regval * data->current_lsb_uA;
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-- 
2.17.1

