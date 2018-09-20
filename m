Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F02ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7A921546
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKzwDL6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7A921546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeIUCdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33110 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id m26-v6so9612876lfb.0;
        Thu, 20 Sep 2018 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3SsFeK73BDBaVaH0gbzC0wuehUzjUhBg5plqI7ONe0=;
        b=WKzwDL6+m9pMfMNvByXKOUQbXBux9676tzWYCPMTCxxV/wzUthDWb9FUp9l/m3vGRw
         38dTl4+aZZmXzJYDdSAvBV9rFGoWoIlO8EuD8rG4c20EqZFcSzFK6paPTA81z7FFKpxx
         zr31732fYaq+U99hG1dgCaH8cCvQoI1TrMABZ1wwyyHaaVZBWLCWWmylKc+cBtABKFLE
         eTQRcqIYOpF+iOuJOWy4weQizSjfqOWyEwZ+44mWlQyz3totMLz4ykQvFQEubeqakq6o
         IW85bPTTDdfqjIZfBgUgN0uPuuBjvdxhbgxCtSPLML2sR0MXM5LuybfNwnAsDS7rXVDf
         p00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d3SsFeK73BDBaVaH0gbzC0wuehUzjUhBg5plqI7ONe0=;
        b=l5z0OoyupQNEaUtvq9PTdTw5Jwae9BJfP4AL37ha/mkm/QEdZ7ZZLRAn0FMCl2l+yH
         /ozEO2kbfuC/yKOQ88EyURGcfqYZVZHXm+MKHsZ+n18jhs+x2Q3PBeMWxRR7DpO3iPHB
         RPW9Ly2VW6kwl0dRxfUgrB7HDz/goztua3nLa4df522+NWnVwOEcI6VpF1nBKPSl2Fkt
         6gPzvdzuWxSutYAztjEsJDXCrUlW3u7HQUxG8+xSaK0jupH58jENSZnLrff++7EiseIf
         vofcY2IpX0drMwjYJ0fDL1nL/c+z8zBoc1gkdykTh1ApIS8ksqPaKpjio8l4s1bdxOmn
         w9OA==
X-Gm-Message-State: APzg51AFAMVxURO/H+GqtCRNMBvwdqwVYsaZnNZECNGX/cdH+9QJFWAf
        iwZuR+KXTHM/+MuJr+nwRGQ=
X-Google-Smtp-Source: ANB0VdZn9Sb0dRwCka++PsO7gW1C9wHujdFl2UsyR+j6Ox9uyCH8ifo9p0LmCVYZ/0zLzcArtUVsKw==
X-Received: by 2002:a19:c016:: with SMTP id q22-v6mr26676104lff.8.1537476481288;
        Thu, 20 Sep 2018 13:48:01 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:48:00 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 5/7] [media] ad5820: Add support for acpi autoload
Date:   Thu, 20 Sep 2018 22:47:49 +0200
Message-Id: <20180920204751.29117-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow module autoloading of ad5820 ACPI devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index e461d36201a4..5d1185e7f78d 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -22,6 +22,7 @@
  * General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
@@ -380,6 +381,15 @@ static const struct of_device_id ad5820_of_table[] = {
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ad5820_acpi_ids[] = {
+	{ "AD5820" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, ad5820_acpi_ids);
+#endif
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
@@ -387,6 +397,7 @@ static struct i2c_driver ad5820_i2c_driver = {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
 		.of_match_table = of_match_ptr(ad5820_of_table),
+		.acpi_match_table = ACPI_PTR(ad5820_acpi_ids),
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

