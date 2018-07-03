Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F619C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C56247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C56247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeGCXr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45922 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753675AbeGCXrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so1720321pfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/chklxYGnds1v6AD2Nh4VsBa5gEuMWGNfrXOybMzQM0=;
        b=narUffdyTN7mcF88Ds9eiaOP1m2dd1RZkN9kd3KCYjcsjrMAzO/qqgfuvkzGImTLw5
         Snk4mWmjuJRzlf+GG+pCH3Dm6J2FaVeK+AkP/1dS9nN3YL9eaKna5WQP3FEzqPINaIX4
         5MSH2VkrkoE/nE7O0uyogYT3gJeKPFKhcCOFH2+m7WamMMDwBOKezV6TN4qQCVnQf7Uo
         oafw7jQsba2up7pNRtchS86COV9hCPF3DBZWOOI1fC9ahb7kF+qkNSwnOTlhXfsr/jr+
         1kmjq3bHB/BiDpAOsKslJorsSa8wtTb9T5DiKyEml6eVcom3ovyUtPSDowxhIKGRfh4z
         WsuA==
X-Gm-Message-State: APt69E0R99ZxiNNabFb6uZQ1+4wrnkO337PjVSBZK9W2dgXZFFMMNlAP
        DCVWshDUFU8SplOX1+evzZojog==
X-Google-Smtp-Source: AAOMgpfEkJPE/bSzUYXj77mTpULFHM7K+ltuKSaZPVt0YU3Vi4tFZ9KLQSjGrgk9FBxF1Fqo7RzTVQ==
X-Received: by 2002:a63:7a43:: with SMTP id j3-v6mr10683080pgn.363.1530661660879;
        Tue, 03 Jul 2018 16:47:40 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:40 -0700 (PDT)
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
Subject: [PATCH v5 12/12] mfd: cros_ec: Add throttler sub-device
Date:   Tue,  3 Jul 2018 16:47:05 -0700
Message-Id: <20180703234705.227473-13-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate the CrOS EC throttler if it is enabled in the kernel
configuration.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

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
2.18.0.203.gfac676dfb9-goog

