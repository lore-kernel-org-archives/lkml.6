Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1DC20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1DC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeFUBxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:53:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38322 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754625AbeFUBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so687068pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eNU51yjQ+sbmP/gaQ7xE6DCoKhrY5SF7m+blOGUlUtA=;
        b=Y4CLRb4RVESdYLRdhxxqczpk4Gz6b13ZFlUn7m/gg/V9ujZ6MLbKNdofAlkGqGtmcz
         6CCBbkgHiXiVJd3feikuHLR/ZpCpWI94BtzoQfAcWV/R46UJqpVpl7KqdP0BhDfIhMNe
         H21vFEz4EmqYv2jM1BeTNtQ8bcLZK0LTYZ2xTatMR6dJqitfqw4yNwjqrDp7i7Vo8l1G
         1ndQP9DrYOK9eWP1gn3xmu2fJ629g8VZAfqHE/es+BXcfgNDzmTFhHil4KelFfxuyInL
         Pah0khO4e1SNORxouYi/7WBYcoTrruSoSbkElPeiQH52vdGW+H3/Kx2F/zymoNRYEeX6
         /XeA==
X-Gm-Message-State: APt69E1VJjN2E00inVuCE8VO6AK3MdaMMPaKkIgTxSIWjHSjZBZ12U58
        kUNd+Lido2dN4orrprmlvsayZQ==
X-Google-Smtp-Source: ADUXVKLq8W+PyONR2JwsWMZfNSqXD8+Xul6LUSPgcIkQ1QBQEy4znZYd7AIEUqmfLH0buGz9yAymhQ==
X-Received: by 2002:a65:6141:: with SMTP id o1-v6mr20520172pgv.409.1529545991617;
        Wed, 20 Jun 2018 18:53:11 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:53:10 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 12/12] mfd: cros_ec: Add throttler sub-device
Date:   Wed, 20 Jun 2018 18:52:37 -0700
Message-Id: <20180621015237.100100-13-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate the CrOS EC throttler if it is enabled in the kernel
configuration.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- register throttler in cros_ec_dev.c instead of cros_ec.c

Changes in v3:
- patch added to series
---
 drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index eafd06f62a3a..9e56c2793075 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -383,6 +383,22 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell ec_throttler_cells[] = {
+	{ .name = "cros-ec-throttler" }
+};
+
+static void cros_ec_throttler_register(struct cros_ec_dev *ec)
+{
+	int ret;
+
+	ret = mfd_add_devices(ec->dev, 0, ec_throttler_cells,
+			      ARRAY_SIZE(ec_throttler_cells),
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec->dev,
+			"failed to add cros-ec-throttler device: %d\n", ret);
+}
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -422,6 +438,9 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER))
+		cros_ec_throttler_register(ec);
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

