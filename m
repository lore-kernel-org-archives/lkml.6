Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B25AC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A62321EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R00RKCB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A62321EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbeHITnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38513 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHITnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so3155148pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvvftdSYZRnGaO1Jik8oBVD5aBHLx689qyFmiuGd8Ms=;
        b=R00RKCB5SY5YVp0F7IzY51jBfH2PziMDIxgZrV3htdqZ1Ms0lyYq9Lka8BZPiqmuWg
         aFX+9kE4oHPxYXe/V8elSn/xgauvLWZHzAyOuBgkk6gVqCmGtBFKHP2uGn4oMCdlskTE
         3Wxf7ZPfm+vp9hx5k/+bLu6r7+1WDR4tos2Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvvftdSYZRnGaO1Jik8oBVD5aBHLx689qyFmiuGd8Ms=;
        b=eElAe+Am24K3nDWRQb8jFkDKG+PmN52fWMsTEYxaFUCrZWgQYUwQxBvBovEDy/HwF+
         aYElwaW6S++mhRccd5/qr0QouGzEVcfH6FKFqI8mUIKorOqOm0ceK5S+xwrp+FjGMKrE
         lUbv9xSwkjZ3mkTczAudqeQZs7//Bz+ZkT79RXAHHR9+zov/nawU13zfzfXScYsRPGHn
         0nWNfXkbyN7TUtIac66uFsmAPy6FOlTtRHbGBuwzKs1xJ1KzuCp7xCY7hU34GYIcB0/Y
         rZm1nZSlB7efPxPDR3MfJjeHPLfXPkkfoxqnHRXodAA1GSEQ+44M+leYmRwwsl7bprkJ
         NI3g==
X-Gm-Message-State: AOUpUlHOXrd5TFnT6pXanxtUPj9f9JvCcZYPpQ8OgyA4+lBBYvUbwkyV
        Yi2AZoDdKku1MH8A9M1Z0E/AoA==
X-Google-Smtp-Source: AA+uWPy92Csk4l3xbTWmL9oS9IKddgkw9ov/iPejQlP+GuVigRd9I6s31Q4F5vg2x4z26Bmd6uITmQ==
X-Received: by 2002:a63:1518:: with SMTP id v24-v6mr2996146pgl.162.1533835048475;
        Thu, 09 Aug 2018 10:17:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 6/7] firmware: coreboot: Only populate devices in coreboot_table_init()
Date:   Thu,  9 Aug 2018 10:17:21 -0700
Message-Id: <20180809171722.144325-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function checks the header for sanity, registers a bus, and
populates devices for each coreboot table entry. Let's just populate
devices here and pull the other bits up into the caller so that this
function can be repurposed for pure device creation and registration. We
can devm()ify the memory mapping at the same time to keep error paths
simpler.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 66 +++++++++++-------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index f343dbe86448..814913606d22 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -32,8 +32,6 @@
 #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
 #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
 
-static struct coreboot_table_header *ptr_header;
-
 static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -94,35 +92,21 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
-static int coreboot_table_init(struct device *dev, void *ptr)
+static int coreboot_table_populate(struct device *dev, void *ptr)
 {
 	int i, ret;
 	void *ptr_entry;
 	struct coreboot_device *device;
 	struct coreboot_table_entry *entry;
-	struct coreboot_table_header *header;
-
-	ptr_header = ptr;
-	header = ptr;
-
-	if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
-		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
-		return -ENODEV;
-	}
-
-	ret = bus_register(&coreboot_bus_type);
-	if (ret)
-		return ret;
+	struct coreboot_table_header *header = ptr;
 
-	ptr_entry = ptr_header + header->header_bytes;
+	ptr_entry = ptr + header->header_bytes;
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
 		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
-		if (!device) {
-			ret = -ENOMEM;
-			break;
-		}
+		if (!device)
+			return -ENOMEM;
 
 		dev_set_name(&device->dev, "coreboot%d", i);
 		device->dev.parent = dev;
@@ -133,18 +117,13 @@ static int coreboot_table_init(struct device *dev, void *ptr)
 		ret = device_register(&device->dev);
 		if (ret) {
 			put_device(&device->dev);
-			break;
+			return ret;
 		}
 
 		ptr_entry += entry->size;
 	}
 
-	if (ret) {
-		bus_unregister(&coreboot_bus_type);
-		memunmap(ptr);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int coreboot_table_probe(struct platform_device *pdev)
@@ -152,7 +131,9 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	resource_size_t len;
 	struct coreboot_table_header *header;
 	struct resource *res;
+	struct device *dev = &pdev->dev;
 	void *ptr;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -162,26 +143,37 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	if (!res->start || !len)
 		return -EINVAL;
 
+	/* Map and check just the header first to make sure things are sane */
 	header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
-	if (header == NULL)
+	if (!header)
 		return -ENOMEM;
 
-	ptr = memremap(res->start, header->header_bytes + header->table_bytes,
-		       MEMREMAP_WB);
+	if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
+		dev_warn(dev, "coreboot table missing or corrupt!\n");
+		return -ENODEV;
+	}
+
+	ptr = devm_memremap(dev, res->start,
+			    header->header_bytes + header->table_bytes,
+			    MEMREMAP_WB);
 	memunmap(header);
 	if (!ptr)
 		return -ENOMEM;
 
-	return coreboot_table_init(&pdev->dev, ptr);
+	ret = bus_register(&coreboot_bus_type);
+	if (ret)
+		return ret;
+
+	ret = coreboot_table_populate(dev, ptr);
+	if (ret)
+		bus_unregister(&coreboot_bus_type);
+
+	return ret;
 }
 
 static int coreboot_table_remove(struct platform_device *pdev)
 {
-	if (ptr_header) {
-		bus_unregister(&coreboot_bus_type);
-		memunmap(ptr_header);
-		ptr_header = NULL;
-	}
+	bus_unregister(&coreboot_bus_type);
 
 	return 0;
 }
-- 
Sent by a computer through tubes

