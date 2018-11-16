Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBD0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B890F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B890F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeKQIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:20:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41637 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:20:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so22417414otk.8;
        Fri, 16 Nov 2018 14:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drXqcYQ5TQ0Ts4r0rdK1f6vDai11PvwH1mXapm9Fd2E=;
        b=QR0my5HjD1cwonHEHR7bHyygMbHhWlz78XD00LuXXgi+tuf2I/91BRwbRP+MyRaN/o
         dD79GVKaHbsGYDCxNiZM7cxDFc7ce0FUVUu5oMs3DX4Inyt5b+u7VAnqtIrJhEl5feIJ
         1bqiqUCUbXSIUaXzz7B5DVubuY0ECfOCgdFYR4IpxnjkdxgWyKV62qEQAgI5WpikjVVj
         dzAieB0GsmRaiCcLmPY5Qzwwo9z8ve4GyOuQ3E7JifMU6gGbR4hEipOMGXOY/G4Y7u20
         orBeEnUc0ipuIvc6tVNNrZeZbQSOeEqFRZvs9scNJMYMIpWPfSdvae641hR7/uDncpro
         m/Cg==
X-Gm-Message-State: AGRZ1gLCz2xx6JOmNOuxWnK0YNqOURUnov8jACJo5sQ0730SwTmwA6z4
        6NT7onN52ujF5ByGmUn4zslEeXlPAw==
X-Google-Smtp-Source: AJdET5c7+IgqL2sFuJUVRxTAtUVQfIvxetI/NZny7VWPXpCjZvMXOMLrfzxY1phNIEjo1gv1BIYgiQ==
X-Received: by 2002:a9d:39f7:: with SMTP id y110mr6966738otb.240.1542405954716;
        Fri, 16 Nov 2018 14:05:54 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id w5sm2316587oif.48.2018.11.16.14.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:05:54 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: ina3221: Convert to using %pOFn instead of device_node.name
Date:   Fri, 16 Nov 2018 16:05:38 -0600
Message-Id: <20181116220540.17222-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116220540.17222-1-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ina3221.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..27abbc5b9d46 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -469,10 +469,10 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 
 	ret = of_property_read_u32(child, "reg", &val);
 	if (ret) {
-		dev_err(dev, "missing reg property of %s\n", child->name);
+		dev_err(dev, "missing reg property of %pOFn\n", child);
 		return ret;
 	} else if (val > INA3221_CHANNEL3) {
-		dev_err(dev, "invalid reg %d of %s\n", val, child->name);
+		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
 		return ret;
 	}
 
@@ -490,8 +490,8 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 	/* Overwrite default shunt resistor value optionally */
 	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
 		if (val < 1 || val > INT_MAX) {
-			dev_err(dev, "invalid shunt resistor value %u of %s\n",
-				val, child->name);
+			dev_err(dev, "invalid shunt resistor value %u of %pOFn\n",
+				val, child);
 			return -EINVAL;
 		}
 		input->shunt_resistor = val;
-- 
2.19.1

