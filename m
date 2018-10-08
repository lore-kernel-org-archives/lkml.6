Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30A72054F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4NgBOHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30A72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIEil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:38:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:38:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so8395207pgv.3;
        Mon, 08 Oct 2018 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DB4mJC99RCSb06yHhTFT6Rx07Rhf2NMq1wxxXxOGDAo=;
        b=A4NgBOHkD8DKyb+DaAmu7gYwHGK+wgk3gSOoDObfilp6C9KePBALj3OqcO9dKBV8wj
         bNDCyZgX7Z2Ol4kXlYHDInRj3EuOB/qpR/NGug1Cho7mcExhplH+ku0k5tl7OqxTk95z
         CSRTdJO4Tv5ZObR/x9iYythCGmsnNTpYdrzA9wlkVOlbKlCkHx6uU5BIfnizMO1sY2nJ
         yGpU4Xr9P7Geb/XpHyR1putzU8+1UWkt22n5NVptu1idKJSXMhJGEUiQ6B6D9+8SfL56
         StfKFYGh3ou7NDLxQB77Kq+laFH/HNrwQKwXSEQkPCoSaoU6DYmHrFndX0gm5XOtIetY
         2krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DB4mJC99RCSb06yHhTFT6Rx07Rhf2NMq1wxxXxOGDAo=;
        b=rVcSfFT7ALnmCX+tE8dRHAOM3AjgV9EOvgWs5GTR8fBbzD2Gk8sq7xGzPpvb+DbIhN
         XKI+G5v38UbF7sYya13Jd1T8nHTxIjR7LUlEtPBdaV2ws2jwmbCOzC0C2jxBqRNBLcl7
         Bq0izxy+Df9GYWBNm4Ou74IAtcj1RsiQ9a01M4E2Nri1EDjc1VxRpY2J71iJpQ37NmHe
         YQGE7bOKfgwmgmOQMsTAwOm5/o9bdw6oq7mIZ23lAb6R4X0doUU4DVPrOFl7cyXyaYmC
         AlbRoSI4IBkLwI9BnGTQMetpmxE5ZqjqOno53KdljdYr2LtSGKLWtMf38HBFbrWHVLMM
         dy4A==
X-Gm-Message-State: ABuFfogVQ4fNDS2wqf3PpUBOl+1nvwrbG3zz8qEcScHEWL9C/TSnndIW
        nd8yZqrNcb8korVcvz643oob0+aC
X-Google-Smtp-Source: ACcGV60KkRWTJQFK8RNd92Fy7o8ocCx2vDVFR9Jll7rj1AxS/NncDPMJeF5qSQqFC6GA/IKW7jn1QA==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr26927995pfl.67.1539033897455;
        Mon, 08 Oct 2018 14:24:57 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j187-v6sm30530413pfc.39.2018.10.08.14.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 14:24:56 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (ina3221) Validate shunt resistor value from DT
Date:   Mon,  8 Oct 2018 14:24:51 -0700
Message-Id: <20181008212451.18637-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input->shunt_resistor is int type while the value from DT is
unsigned int. Meanwhile, a divide-by-zero error would happen if
the value is 0. So this patch just simply validates the value.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Validate the value and error out

 drivers/hwmon/ina3221.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index c3a497aed345..4f3ed24efe8e 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -536,8 +536,14 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 	of_property_read_string(child, "label", &input->label);
 
 	/* Overwrite default shunt resistor value optionally */
-	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
+	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
+		if (val < 1 || val > INT_MAX) {
+			dev_err(dev, "invalid shunt resistor value %u of %s\n",
+				val, child->name);
+			return -EINVAL;
+		}
 		input->shunt_resistor = val;
+	}
 
 	return 0;
 }
-- 
2.17.1

