Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9ACECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAAD21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLBWFzY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAAD21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJQPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:47:51 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43185 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:47:51 -0400
Received: by mail-pl1-f179.google.com with SMTP id 30-v6so12270787plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnjz7lH3HZhDbBDVjB+iy6/kTfkrTriNI0YEozLP+/E=;
        b=BLBWFzY9by6EjhaWIIie72pVlBrb6I/rdzTo1QrmbaMNoq/ephkFCr9LikLV3AIHZy
         +6HnDwKs2TUFT8o/MVElI1xUAeXJI2YsJXby5+qA+j7qfnhmQ9JBXwd4t77QTm2dccLk
         KWG9oKiiuIF113sUD1QIMsHa7tQNxEqxYoovk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnjz7lH3HZhDbBDVjB+iy6/kTfkrTriNI0YEozLP+/E=;
        b=e2YcsN++185RYJAD+lciYFjq0uXD2kyQG6MXjRzaSFrIfF0Snd0iMXQiDqir1QRcge
         J/EUW1MaRn8+8aYcXQIOFxu/lRIRYSe6xWW8cIzRrzJesbYDyf7rIhamFvW9DNLUc3NP
         ZfoRrr54N0YMNbrcnD6uznNCWlhIPds6eGzLrtQojERdVUeCNFkvW2vegOaE2aNZ1GuG
         IlT+1Q8LX1w7x/Ubn8eCFFi5E0lc5IY6+6P3vnuSYv2lW2MYEq5FaZ18aGlJ3V2lKT2E
         hma4GvKYfbBECGWBgkRXC/lzL4gHZg/qbcS/z9MrYQugfb/JDeDx0N6cVfFyU6V7nhwr
         Kr6w==
X-Gm-Message-State: ABuFfohv/ii4/xbDTNQzXX6H+hqNwPHQ3cYbM6VfUaQkLozVa/sb1VSK
        zN4pjzEOdX7WTXcixjxDAGGaOw==
X-Google-Smtp-Source: ACcGV61hS6jffPti1COc3y/jSDt1WtCKYPiUdAoO2LLL8aWgP16kYpLNrUWSAQXwn7+Ss4hDd1fvrA==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2-v6mr25209227plt.106.1539762804472;
        Wed, 17 Oct 2018 00:53:24 -0700 (PDT)
Received: from henryhsu-z840.tpe.corp.google.com ([2401:fa00:1:b:d0d:8911:feba:193e])
        by smtp.gmail.com with ESMTPSA id c24-v6sm25430274pgn.60.2018.10.17.00.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 00:53:24 -0700 (PDT)
From:   Heng-Ruey Hsu <henryhsu@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcliang@chromium.org, tfiga@chromium.org,
        Heng-Ruey Hsu <henryhsu@chromium.org>
Subject: [PATCH] media: uvcvideo: Add boottime clock support
Date:   Wed, 17 Oct 2018 15:52:42 +0800
Message-Id: <20181017075242.21790-1-henryhsu@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android requires camera timestamps to be reported with
CLOCK_BOOTTIME to sync timestamp with other sensor sources.

Signed-off-by: Heng-Ruey Hsu <henryhsu@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 4 ++++
 drivers/media/usb/uvc/uvc_video.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index d46dc432456c..a9658f38c586 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2287,6 +2287,8 @@ static int uvc_clock_param_get(char *buffer, const struct kernel_param *kp)
 {
 	if (uvc_clock_param == CLOCK_MONOTONIC)
 		return sprintf(buffer, "CLOCK_MONOTONIC");
+	else if (uvc_clock_param == CLOCK_BOOTTIME)
+		return sprintf(buffer, "CLOCK_BOOTTIME");
 	else
 		return sprintf(buffer, "CLOCK_REALTIME");
 }
@@ -2298,6 +2300,8 @@ static int uvc_clock_param_set(const char *val, const struct kernel_param *kp)
 
 	if (strcasecmp(val, "monotonic") == 0)
 		uvc_clock_param = CLOCK_MONOTONIC;
+	else if (strcasecmp(val, "boottime") == 0)
+		uvc_clock_param = CLOCK_BOOTTIME;
 	else if (strcasecmp(val, "realtime") == 0)
 		uvc_clock_param = CLOCK_REALTIME;
 	else
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 86a99f461fd8..d4248d5cd9cd 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -425,6 +425,8 @@ static inline ktime_t uvc_video_get_time(void)
 {
 	if (uvc_clock_param == CLOCK_MONOTONIC)
 		return ktime_get();
+	else if (uvc_clock_param == CLOCK_BOOTTIME)
+		return ktime_get_boottime();
 	else
 		return ktime_get_real();
 }
-- 
2.19.1.331.ge82ca0e54c-goog

