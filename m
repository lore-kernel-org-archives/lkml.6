Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A840DC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085C21EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IU3P5Cyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6085C21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeHITnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbeHITnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so3155954pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGB18oxzkly5wV0xhnT3XTd+HEA3r4qogo4Y8GAPYko=;
        b=IU3P5CylPX2U/fGrQNreW0q0j075fB089r3RW5NNFQOxfCB26yay6iOd5cJnqyh+Hk
         0NwWRQBGNtso8xCiEKKOGXct9p49d7BqTqGDMiLD1PivUPZL9YB6Y12J6ZpVbdhYZl8j
         ig7L5tIShZMPnFY5h3iUIwbkKgDO//qr0NxIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGB18oxzkly5wV0xhnT3XTd+HEA3r4qogo4Y8GAPYko=;
        b=ewZtmy8ffBfbti8DmjdkjXIed58X0idwxqtrCnwcWnNHiKpCxxvrPWFyVX2H8E5usK
         jlKCkDa3V/4YRJrBWv55iMJu/xZezSD4ugeuxOKPNHgNpZ7vNrOs+BpBKnGVsEY7x79t
         HEof0a/eJQgsyVfs3zeRoFSVoSqd4mCLCWXVD9/wxqjH3VNHvezygImGbwjcsMikthQ8
         /hNm1apTi9eOlXiESdwXb7VRQzf+FSX9uQQhktw1nb3AzqBswvW8RaLQTkPQ782QNRNL
         +m0B3FGbwBXKEaNN0Ue93WiZ2QwLTq3BFrtpFdv1BcUbcy7hGDhG7zqZl0LH9F28oHlo
         35lQ==
X-Gm-Message-State: AOUpUlHZmJ4Ox6ZyXgPpJDEsYlPsr/ey534Osr4U1ocJfpshVxCUrdH8
        1ubLLWM5T1Dg0kU1ZSmf5tSe9w==
X-Google-Smtp-Source: AA+uWPy/SFU0WnkNUb+O9dQiO+iLsBwnb6N8mRDI+fyEAz0lISWESMzscK+CXtSHFOwYRtOT/uUX0Q==
X-Received: by 2002:a63:e056:: with SMTP id n22-v6mr3029850pgj.205.1533835046191;
        Thu, 09 Aug 2018 10:17:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/7] firmware: coreboot: Make bus registration symmetric
Date:   Thu,  9 Aug 2018 10:17:18 -0700
Message-Id: <20180809171722.144325-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus is registered in module_init() but is unregistered when the
platform driver remove() function calls coreboot_table_exit(). That
isn't symmetric and it causes the bus to appear on systems that compile
this code in, even when there isn't any coreboot firmware on the device.
Let's move the registration to the coreboot_table_init() function so
that it matches the exit path.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 0d3e140444ae..0e461d776ce6 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -70,12 +70,6 @@ static struct bus_type coreboot_bus_type = {
 	.remove		= coreboot_bus_remove,
 };
 
-static int __init coreboot_bus_init(void)
-{
-	return bus_register(&coreboot_bus_type);
-}
-module_init(coreboot_bus_init);
-
 static void coreboot_device_release(struct device *dev)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -113,6 +107,10 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		return -ENODEV;
 	}
 
+	ret = bus_register(&coreboot_bus_type);
+	if (ret)
+		return ret;
+
 	ptr_entry = (void *)ptr_header + header.header_bytes;
 	for (i = 0; i < header.table_entries; i++) {
 		memcpy_fromio(&entry, ptr_entry, sizeof(entry));
@@ -138,8 +136,10 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		ptr_entry += entry.size;
 	}
 
-	if (ret)
+	if (ret) {
+		bus_unregister(&coreboot_bus_type);
 		iounmap(ptr);
+	}
 
 	return ret;
 }
-- 
Sent by a computer through tubes

