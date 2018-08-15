Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC0C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0DA21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfVvMerX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0DA21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeHOXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:31:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeHOXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:31:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so963364pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJNY+gds9uSorTW61ld303cZnA5bUTx9KsInyKNARKs=;
        b=BfVvMerXu6j/cQN3igs2RznVPPZ4YqwQnmB6upXDFuaMkGdRX9Y5erTk/3RV5cm4ab
         X5l/FcRAdB9uz2ZHS8us2rFskSCyClKIAaaJDzRQUGymPPqpRVaQdHTVOiXbK76aNEVF
         /T2iOdeIxS8hIoA3Bh9FcscEMUtu2xygcFo1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJNY+gds9uSorTW61ld303cZnA5bUTx9KsInyKNARKs=;
        b=kL2BfItA8dSo1fSf+uYPkxYyWoC/Javm8vR/hWQMgZpoUlZ8xnlMpGBwaMzKvxl6BG
         F+boryZ+2jfjRLqHyCDO70154EN6x3JuAof9gJnVLWb2Gl7CxLzox4/2i5db+joXOukO
         yitapIWSUP3uf4cpLREzzCqmYqRo/P2te9SD6PATWIUaWPdOsPmlDhP4dcdpaxz4S+E7
         ns9Xcqe25zYXRRrFV0YZn6454lu73ACART3XwwD8tavNA3FQY68qyM9QURuIy1Zx/eqR
         +CLSCXV+XcGS0PVQnhriZ+6b384h9HbuH29g4M2BBRuKrO3yksz4FNJAy9SMRLfFr0e+
         IpFg==
X-Gm-Message-State: AOUpUlH8kQp7GYEB8iCgAi6jW/VHj+wgCqSDlKFyFBsYoNzcTBR4G88m
        Dr4kuQhSoBDrmBmTol4M+rth5A==
X-Google-Smtp-Source: AA+uWPwHdSX57H1T3Phgb+BHqGnMluqhlwDhAUa4zckkSlvp7TjGX5pYALJH5N8u9hjm9SIPjrCtfw==
X-Received: by 2002:a63:6604:: with SMTP id a4-v6mr25718527pgc.404.1534365437284;
        Wed, 15 Aug 2018 13:37:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 6/6] firmware: coreboot: Only populate devices in coreboot_table_init()
Date:   Wed, 15 Aug 2018 13:37:08 -0700
Message-Id: <20180815203708.67090-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
References: <20180815203708.67090-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function checks the header for sanity, registers a bus, and
populates devices for each coreboot table entry. Let's just populate
devices here and pull the other bits up into the caller so that this
function can be repurposed for pure device creation and registration.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 67 ++++++++++--------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2c6c35f0da32..078d3bbe632f 100644
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
@@ -94,36 +92,21 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
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
+	struct coreboot_table_header *header = ptr;
 
-	if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
-		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	ret = bus_register(&coreboot_bus_type);
-	if (ret)
-		goto out;
-
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
@@ -134,18 +117,13 @@ static int coreboot_table_init(struct device *dev, void *ptr)
 		ret = device_register(&device->dev);
 		if (ret) {
 			put_device(&device->dev);
-			break;
+			return ret;
 		}
 
 		ptr_entry += entry->size;
 	}
 
-	if (ret)
-		bus_unregister(&coreboot_bus_type);
-
-out:
-	memunmap(ptr);
-	return ret;
+	return 0;
 }
 
 static int coreboot_table_probe(struct platform_device *pdev)
@@ -153,7 +131,9 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	resource_size_t len;
 	struct coreboot_table_header *header;
 	struct resource *res;
+	struct device *dev = &pdev->dev;
 	void *ptr;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -163,26 +143,37 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	if (!res->start || !len)
 		return -EINVAL;
 
+	/* Check just the header first to make sure things are sane */
 	header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
-	if (header == NULL)
+	if (!header)
 		return -ENOMEM;
 
-	ptr = memremap(res->start, header->header_bytes + header->table_bytes,
-		       MEMREMAP_WB);
+	len = header->header_bytes + header->table_bytes;
+	ret = strncmp(header->signature, "LBIO", sizeof(header->signature));
 	memunmap(header);
+	if (ret) {
+		dev_warn(dev, "coreboot table missing or corrupt!\n");
+		return -ENODEV;
+	}
+
+	ptr = memremap(res->start, len, MEMREMAP_WB);
 	if (!ptr)
 		return -ENOMEM;
 
-	return coreboot_table_init(&pdev->dev, ptr);
+	ret = bus_register(&coreboot_bus_type);
+	if (!ret) {
+		ret = coreboot_table_populate(dev, ptr);
+		if (ret)
+			bus_unregister(&coreboot_bus_type);
+	}
+	memunmap(ptr);
+
+	return ret;
 }
 
 static int coreboot_table_remove(struct platform_device *pdev)
 {
-	if (ptr_header) {
-		bus_unregister(&coreboot_bus_type);
-		ptr_header = NULL;
-	}
-
+	bus_unregister(&coreboot_bus_type);
 	return 0;
 }
 
-- 
Sent by a computer through tubes

