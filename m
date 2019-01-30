Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A1C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E1520870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="bFc7A360"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfA3JHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:07:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38133 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:07:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so10781793plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9ngn2EqMUIjUg8AoZAqTwCdyghXJc0dAyju25U+WQ7k=;
        b=bFc7A3602YA+Ipg6j4d9E0QpN8Vncl18Gw6v/h3wmXVJ3omjz6pJYJ1c1Jb2rHuuus
         gB9BDwOAewvTqFSrCUfJD4SPOatZZu8Bgho3SXKLarIjqR4fDqyBMijppttoFI7S4inM
         QgaiYDOJwDs1S5n340swgCqbV8FeFyq+Ro1LVnukFQJMDFbKwJOTHeCA0nxS6ILuAR+y
         Pulhh4a9c0VR1qYj83ed8pTyWX2VMBnUYwTfn0b6YTIECxLh6+MK5XoBbdoF3OJpQE1p
         kPf0N6iaSf4c/W2xYsZNzos4271UBW/br0qUL7KkvN8+37O3ant9wk9FSjPY2rapaKEP
         CftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9ngn2EqMUIjUg8AoZAqTwCdyghXJc0dAyju25U+WQ7k=;
        b=cgzocCXqStbAi6eEUF0OY/MGjF3QTGXlvM0a2DAl5fC9nL/fYJk4FzZn0yndvIt4Zz
         wRyYypr+AFNwAQuJ0KTNgjmOlsHnnPT08U49qG1wd2rZ1OV8SFR8PijQHXgmBBkDzgKf
         +3WVX9zVbDvmgpmtzMltht3NrDxyi3TiNVdPwsiu15TdQRfoPJ8mNoxmdZbHo+Qho1H1
         4eeahOVPcJOwHYu6rs8NqaiA5haZg4vYyfxwAHf/MeToWZYuLU34AjN/VhmznlPwCmpc
         EskalkyNXk6Wv7ys6I8e/J4iskZN6K8Z0tPAl3Mtt7fdVbQJFnLsODif2Kvd4PUhPDTq
         dnsA==
X-Gm-Message-State: AJcUukcuKALb6XF8m0QJ/wiBcjj+kfcxkjcTTDV6esj5HdrHQlbdDOpH
        yE97kx3fSMkw5phAYli5wqXFIAk5Fi0=
X-Google-Smtp-Source: ALg8bN6oFUc4ZOK3NMNAdU5s2cp23/r89BIaQEsgyyDDMDrMxc8Sb2gjLuiYA505QH9R6db3m/8Lkg==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr29072590plq.117.1548839254794;
        Wed, 30 Jan 2019 01:07:34 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id k14sm4486805pgs.52.2019.01.30.01.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:07:34 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: max77650: Fix include files
Date:   Wed, 30 Jan 2019 17:07:21 +0800
Message-Id: <20190130090722.24134-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a platform driver, no need to include linux/i2c.h.
Include linux/of.h for of_match_ptr.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 474f2c02f2d5..5afb91400832 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -5,7 +5,7 @@
 //
 // Regulator driver for MAXIM 77650/77651 charger/power-supply.
 
-#include <linux/i2c.h>
+#include <linux/of.h>
 #include <linux/mfd/max77650.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.17.1

