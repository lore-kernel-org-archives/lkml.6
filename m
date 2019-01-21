Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DAEC31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52AD20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHoooKSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfAUHTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:19:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfAUHTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:19:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so9694398pfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVxi23+KZwyOYF+hkS3H0vh4j/QzNzCIQI81HIp2KyY=;
        b=IHoooKSWYGmZ9GV6cdCB8Yh1YvRg9u1x5DoVPZMsEmfeiCujPvZ/LTFKnLBlITkMYc
         GXY6mwGRmZcBu50hTdgVATvJfevEIFstACpxGnxs/xpY/sjgclUvgy77EeT0My8T7V7R
         KxE+d2sPkfUsCXVQy2uIsOGyDUdVhTnAS/g2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVxi23+KZwyOYF+hkS3H0vh4j/QzNzCIQI81HIp2KyY=;
        b=ovNjL9/Tix3KVEsqWmtuCBM9jGsErMJLeE19IrTkElf852uBbBdpDHU2DL7UPskak2
         Bhy7eY85wJp89Ie5OrKxk/JdtRVjEws4S361V9SKkKB6FEanRC3wdpA9vXjeVXktbVWb
         RV1bbWDF+iQxEaYaDe5qllV920NM423J+sjQy1Ni5RgsWQ+yDLnM62+EWiWmyBaZvmcy
         NSt5HZUNmoqyTdpkoCNH9TVKGJ6jUGYRQ8Jgr6Hz9Xp9XhRlsmGu3Vu2/zn4lOJLnKXt
         E+TbMo7jLFVBEYDUj7XULCIqe1fGiD25imRO0DTbuG5Wq3sGJDXR8ID6KjtUi69IDzgK
         G3nQ==
X-Gm-Message-State: AJcUukdpZFWvFiWhXKcKJRj4sNb8ymDSjw9+wO2ztNtFAs/D9yenaBib
        HqR9chW8uyOskfQA+n94xaDwLg==
X-Google-Smtp-Source: ALg8bN5qGYbNNGmuc7N3kI2hAPcc4V3QIRR/2IBD7jiFV3/kQZjdpc+X/FNbH2E3EVjCtHR6weqvVA==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr29228414pfa.30.1548055147045;
        Sun, 20 Jan 2019 23:19:07 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id v15sm14941843pfn.94.2019.01.20.23.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 23:19:06 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 5/5] cros_ec: differentiate SCP from EC by feature bit.
Date:   Mon, 21 Jan 2019 15:18:33 +0800
Message-Id: <20190121071833.43443-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190121071833.43443-1-pihsun@chromium.org>
References: <20190121071833.43443-1-pihsun@chromium.org>
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

Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
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
index 2d0fee488c5aa8..67983853413d07 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -414,6 +414,15 @@ static int ec_device_probe(struct platform_device *pdev)
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
index de8b588c8776da..fd297cf8f97295 100644
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
2.20.1.321.g9e740568ce-goog

