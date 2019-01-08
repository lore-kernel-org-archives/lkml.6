Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649ED2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVgmwhqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfAHF0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:26:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfAHF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:26:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so1180662pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goWLrpBG2Y75dOn+Zd/80yByFqC7jGRkIE9SI0uzL8o=;
        b=dVgmwhqt8+l4tYfK/ipyPgMUzH3yzB/uoHWfG0/1whmo6oqZdnlJSledcuPnER6Nj3
         FBKNE6vWsZjDPrd9jGUyKtByUcMOC0LMB2nVe7d3REgZuceozm7J16a8H7pcP5QMLfbi
         LMM6WLGAxf5DrIp0MT1ZrMDe3uP+EADNyiajk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goWLrpBG2Y75dOn+Zd/80yByFqC7jGRkIE9SI0uzL8o=;
        b=GVXVbP0MJKBNPso+fyCQZzjQBB8GWhJu27e2pkcJh3a6fMh0odmTiyplx9giiz70WI
         PPHJP/fwZ+qRTIbdun0DFA5F2poC75Y3AWwhRq4+lnTZYZIt6nKNa5rUHF2uCur33b83
         UroF/CbqpJ3g7xiilOBAwN9CHFBbicwI8z6qw3Sy2QxU7ezIrpL7i9nz/feJ56lzBwZB
         Ym5fIvCHuAJVcbDKVEyE6ewsaxSg2tjZH4PQyfPWas5Jxd4fHhysfw5J4Y3pMdHcu8lI
         kP9TmOsmjelGVFmCekNjrBtrVe72/EcZchbtkZzBShCS3wvPNs3uBjk/Z1kQIdj3za1O
         NpWQ==
X-Gm-Message-State: AJcUukeFqYli0j7dj0IenVeHfGMA2qxvU5TZx3OknWvx1VdP9ky5+PYz
        vMX91OeT3Zs99b/AeCVKtlhjPg==
X-Google-Smtp-Source: ALg8bN4ByT55gyObak3HtbeuCWxLm1aLRvVSx+qFIzw1QQ3UiAB4RfBap6BHJN5x0gleQ8hD89YmpA==
X-Received: by 2002:a62:c583:: with SMTP id j125mr386680pfg.37.1546925202738;
        Mon, 07 Jan 2019 21:26:42 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:26:42 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 6/6] cros_ec: differentiate SCP from EC by feature bit.
Date:   Tue,  8 Jan 2019 13:26:06 +0800
Message-Id: <20190108052606.59426-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
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
2.20.1.97.g81188d93c3-goog

