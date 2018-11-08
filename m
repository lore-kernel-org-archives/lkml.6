Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6501FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1627C20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NItIiraf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1627C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKHLDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:03:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41151 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKHLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:03:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id p16-v6so8717582plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 17:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4pFw2vdIAJVQqz/kIg/xicKAgUdzsboEqQHhul6Xyw=;
        b=NItIirafl+BUiRmWKOg2ujLPSohIb+81UXbkcFWJaX0gqZu4GwBel6khTSnWKxUKyw
         C9X3/P5KGHC6CS399PYYPw4kXYorHKby3Oz2RGD59p8CjsWRcLK1fsY3WZN9rKiDKu0u
         7iZyH+VC8jI/j8+Rm6BZozC9UkDtMT9hpV+BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4pFw2vdIAJVQqz/kIg/xicKAgUdzsboEqQHhul6Xyw=;
        b=B4LCFBAKZjc9VP4LEF28LlFV8SwT9hjTmOUFOJtkWHEkITvHbd7cPK5qRPk9kwUTHy
         v9e/x+jrqnv8cTDg9Twd7lazTOr9eAvZMCWxHQVr5irm5l7nEO/jAYyeOT5ykZya/bAd
         kBGq2TxERqyoCj8NfOnEdUIfjzXtLXEVWbj0L8C8vj3GyuKLFr22ZRWmZYNHrdo1i0UQ
         g6ie3e0F+ufAAo7Gkm4jWYnvrSqsO+Ttc1RdflRpqCZVm4+jo725DyW7QxQ2mijaV6FY
         WLAeH06LhLPBc5NKGzalp/dh/gZWmsWtxPldnpJD439Xv4NML9u929L0bXHuTYVUfaQh
         ZbBQ==
X-Gm-Message-State: AGRZ1gJNpVNFAXbbqoqJkxvJrTC94kStVi5F2UWoTqOK9Y37GecBHi+c
        cSnftXTRD7pOL+XSIBOxq2o4UA==
X-Google-Smtp-Source: AJdET5fbIDq/90MJ6KK2zE0YYz0Rr44nNIINP+F3jDmJVoJskP47ol45xw1/z/QZhl948hY41YIRlw==
X-Received: by 2002:a17:902:a9cb:: with SMTP id b11-v6mr2577029plr.219.1541640631504;
        Wed, 07 Nov 2018 17:30:31 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id l72-v6sm2323193pfi.149.2018.11.07.17.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:30:30 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] platform/chrome: fixup cros_ec_get_next_event() error codes
Date:   Wed,  7 Nov 2018 17:30:04 -0800
Message-Id: <20181108013005.37362-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_get_next_event() is documented to return 0 for success and
negative for errors. It currently returns negative for some errors, and
non-negative (number of bytes received) for success (including some "no
data available" responses as zero). This works out OK, because the
callers were more or less ignoring the documentation, and only treating
positive values as success (and indepdently checking the modification of
'wakeup').

This is difficult to reason about though, and it makes it harder to
refactor cros_ec_get_next_event() without breaking its users. So
instead, I
(a) make cros_ec_get_next_event() match its documentation and
(b) change the users to treat non-negative as success.

This change tries to match a roughly similar pattern to
cros_ec_cmd_xfer_status(), where most non-zero result codes are treated
as an error -- in this case, all protocol errors (including
EC_RES_UNAVAILABLE) are treated as "no data available."

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This barely touches MFD code, but overall this series should probably go
through the platform/chrome maintenance, IMO.
---
 drivers/mfd/cros_ec.c                   |  4 ++--
 drivers/platform/chrome/cros_ec_lpc.c   |  2 +-
 drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index fe6f83766144..807a5870198d 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -67,7 +67,7 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 	if (wake_event && device_may_wakeup(ec_dev->dev))
 		pm_wakeup_event(ec_dev->dev, 0);
 
-	if (ret > 0)
+	if (ret >= 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     0, ec_dev);
 	return IRQ_HANDLED;
@@ -219,7 +219,7 @@ EXPORT_SYMBOL(cros_ec_suspend);
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
 	while (ec_dev->mkbp_event_supported &&
-	       cros_ec_get_next_event(ec_dev, NULL) > 0)
+	       cros_ec_get_next_event(ec_dev, NULL) >= 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     1, ec_dev);
 }
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index e1b75775cd4a..292408eefe43 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -235,7 +235,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 	struct cros_ec_device *ec_dev = data;
 
 	if (ec_dev->mkbp_event_supported &&
-	    cros_ec_get_next_event(ec_dev, NULL) > 0)
+	    cros_ec_get_next_event(ec_dev, NULL) >= 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
 					     ec_dev);
 
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6fd4838f60f..49625836fdd6 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -541,8 +541,12 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 	if (cmd_version == 1) {
 		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
 				sizeof(struct ec_response_get_next_event_v1));
-		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
+		if (ret < 0)
 			return ret;
+		if (msg->result == EC_RES_SUCCESS)
+			return 0;
+		if (msg->result != EC_RES_INVALID_VERSION)
+			return -ENODATA;
 
 		/* Fallback to version 0 for future send attempts */
 		cmd_version = 0;
@@ -550,8 +554,11 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 
 	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
 				  sizeof(struct ec_response_get_next_event));
-
-	return ret;
+	if (ret < 0)
+		return ret;
+	if (msg->result != EC_RES_SUCCESS)
+		return -ENODATA;
+	return 0;
 }
 
 static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
-- 
2.19.1.930.g4563a0d9d0-goog

