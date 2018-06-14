Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41C64C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3C208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E3C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936177AbeFNTrs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:47:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33430 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755484AbeFNTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so3740449pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISSRmyPKSuWq5QIFIhUcq3+8ewVbfHJKL6pkhC1ofXA=;
        b=Bgz+yd5nxih/dPs6OyFY41Yk4mLPlVGfLBL8ZAYaj3XbDCa7PNwTC7WzBYmIL/5SjG
         MBgB6O0Qp1gp+3Pegz07ocjUSQgtQ289Dum0iU/0Z2unAIQAewl3a/+PlHJtoU86+1Bd
         tCCPTqI+ry+VFbKHGUvNinI478d/ec8MsgI47DYYQt0wagKYhVWkaHQyhaE3sMxhAgKe
         6719Q63APoPmE+UqXeeoh8hzXPYbRVkWXZHitX+T3kxIQO9EZM03In5e6uw3o3p8ZMd6
         iXs93TKPzaDE1TUO9ZjZRUSdKpUeeBL0pSiEJmf7/u4BRqYMudHaHPXiJqhZNfUCYmTh
         JC9Q==
X-Gm-Message-State: APt69E2BzhJlWKmUJ2d9RyCX+j8V8Z9K2UgTxeJKDWt+MDn4U/J7JnZ4
        85jJTAzfb9eV5sRF8zyq1MFOZA==
X-Google-Smtp-Source: ADUXVKI3RMMXVRzx3owzez8g7UoAwzZPgLF0G50JszOadvJd3/X/daibZYA1HLVrSVCTxQuaaW4xwA==
X-Received: by 2002:a63:7741:: with SMTP id s62-v6mr3509544pgc.103.1529005660393;
        Thu, 14 Jun 2018 12:47:40 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:39 -0700 (PDT)
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
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Date:   Thu, 14 Jun 2018 12:47:12 -0700
Message-Id: <20180614194712.102134-13-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate the CrOS EC throttler if it is enabled in the kernel
configuration.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to series

 drivers/mfd/cros_ec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 36156a41499c..5f52b6e2c21a 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
 }
 
+static const struct mfd_cell ec_throttler_cell = {
+	.name = "cros-ec-throttler",
+};
+
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
+		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
+				      &ec_throttler_cell, 1, NULL, ec_dev->irq,
+				      NULL);
+		if (err) {
+			dev_err(dev,
+				"Failed to register throttler subdevice %d\n",
+				err);
+			return err;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		err = devm_of_platform_populate(dev);
 		if (err) {
-- 
2.18.0.rc1.242.g61856ae69a-goog

