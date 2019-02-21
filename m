Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB198C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68220880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/NQnAZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfBUItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:49:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfBUItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:49:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so13823545plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kyP+RDjUaCs6JazO4rZ6jGdzsafANy/ynWxrK/hLmE=;
        b=m/NQnAZjTvl/nw74qS5P4EpeP/e6WuvOGpT1PqqdE9X6USwrUX1XNwK/aO0aJRwcBK
         lIS73Ur2lMol9MIZi/1z8Mfn6XIHB0aq0pe1inh+7YMzBLWHdugKo9Zsa2imklCU5rWi
         cnaW2Jr1XuzlMEjrf9OaSJ2LniwRIJbq5Qc6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kyP+RDjUaCs6JazO4rZ6jGdzsafANy/ynWxrK/hLmE=;
        b=i/P2R5r4JLMyKJr8dgGBQjRofAjxDv27xbG35+kl0hx8WA2cA385kAaH7H8ZXk9N5R
         K6MWQMISnJvN+kMj94Pvkp41jjYERihfk/ZOo9sedo0koSmGH96i2mAZoJVpUlR5K5fg
         XQNSgFltVlZ7u6itOENsMkqPo5OnkX+gIz1K0GiY990yTGbyefTTRXly5YZpJuesOAO3
         PWI8nUNBL1VY5+CPsNift2oD52xftETDcMLZ0VFuXhIEcexnjFhPWjvE9tZ3b4DpjaFb
         19Mpej74X1eLukiZEunYZtSJa6jzbNumB5/VUVucrrqiyKtPWPZWkeF20S2zAxJbdZ/p
         eblw==
X-Gm-Message-State: AHQUAubapdf11IvkOhwu+dn3fKoZ4TuHFrp2LAYX/+jG/X+BsefxfH3I
        Chm4sQrok1UPuzE95uq4MSkLdQ==
X-Google-Smtp-Source: AHgI3IYO1Rp4CnjLSKDsTswDFogJ3+S+XZQNOVsSX3oE8iwO2P/ZjLBdeif0ZWJrvvjlRu+szsucDA==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr19879028pln.151.1550738943682;
        Thu, 21 Feb 2019 00:49:03 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 00:49:03 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 6/6] cros_ec: differentiate SCP from EC by feature bit.
Date:   Thu, 21 Feb 2019 16:47:29 +0800
Message-Id: <20190221084729.101784-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221084729.101784-1-pihsun@chromium.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a SCP and EC would both exist on a system, and use the cros_ec_dev
driver, we need to differentiate between them for the userspace, or they
would both be registered at /dev/cros_ec, causing a conflict.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v4:
 - No change.

Changes from v3:
 - No change.

Changes from v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c            | 9 +++++++++
 include/linux/mfd/cros_ec.h          | 1 +
 include/linux/mfd/cros_ec_commands.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb1254..7fb81b11791f55 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -418,6 +418,15 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "SCP detected.\n");
+		/*
+		 * Help userspace differentiating ECs from SCP,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 8f2a8918bfa33c..a971399bad82ee 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c357b..3e5da6e93b2f42 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU exposes a SCP */
+	EC_FEATURE_SCP = 39,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
2.21.0.rc0.258.g878e2cd30e-goog

