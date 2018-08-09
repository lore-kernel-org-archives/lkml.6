Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4557A21EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4qMIigN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4557A21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbeHITnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbeHITnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3162469pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fw3qw/9bKXDLnVqbm5YWc6nstTMLCbO4NRVEsh0ZO18=;
        b=m4qMIigNISxGBHLUP7CpDrPhU7vrq2HsYoGWN2hxRojs4go1eToWHyoGlI23jjwQ47
         YRSZfNDAxjkirOQJZACTRhD+eHLmXEeCa9FB64RX8/Xl1xUkNfwmbvMhpwQD5pSzh2wc
         R+/URd3MkOvrhMWLv/DjvbxFYg/YlOchTuZkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fw3qw/9bKXDLnVqbm5YWc6nstTMLCbO4NRVEsh0ZO18=;
        b=BoLoV4ZN4HMj/8JUeywK8IyJ2nHIu7TxERYTDmet7jaxhPVRuWTQ40DfDB0pWl4oT2
         IK8pCszoJc/rvReZrTYwe3AVzc8DR42iNbF1ybH8xg7PXJ43iCzHybGc3oSAay6dfdXS
         ZheqdqVCZQzB3jvPIDbw2MIUjAGGDqFEfxlSJO99NkJT15m7QAvQfwhGUNu8Hx2vJ2Na
         EVOc9d9LuiVo3ZA25KUHpDYAcQ1L1mFNQNSrG4/9FApziyv5wbFxgBxTSrh7xi8+E+4V
         G78b+NLXSt3C3wK5GzpYcW6m59O4BdR367zPVJBJnj30ULv+v/CPn0MF+sEJvYmmQ6Fz
         +iYQ==
X-Gm-Message-State: AOUpUlF1qpVfivUZbsUvxR6eOC/lt6IeWsjgnmwOSEnyrXrKg9AYnwgU
        1f8EOuiOXBAvIp1Rg0pyQSrIgg==
X-Google-Smtp-Source: AA+uWPysj3P2NbwY1lrQV3LaQrzWOczzKDpCONoibLLph6Yj1tO9st3zVWfCVYcQ8cEeXq3PrLhAvQ==
X-Received: by 2002:a63:4a07:: with SMTP id x7-v6mr3049168pga.34.1533835047726;
        Thu, 09 Aug 2018 10:17:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 5/7] firmware: coreboot: Remap RAM with memremap() instead of ioremap()
Date:   Thu,  9 Aug 2018 10:17:20 -0700
Message-Id: <20180809171722.144325-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is all system memory, so we shouldn't be mapping this all with
ioremap() as these aren't I/O regions. Instead, they're memory regions
so we should use memremap(). Pick MEMREMAP_WB so we can map memory from
RAM directly if that's possible, otherwise it falls back to
ioremap_cache() like is being done here already. This also nicely
silences the sparse warnings in this code and reduces the need to copy
anything around anymore.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 42 +++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index feb31502f64b..f343dbe86448 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -32,7 +32,7 @@
 #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
 #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
 
-static struct coreboot_table_header __iomem *ptr_header;
+static struct coreboot_table_header *ptr_header;
 
 static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
 {
@@ -94,18 +94,18 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
-static int coreboot_table_init(struct device *dev, void __iomem *ptr)
+static int coreboot_table_init(struct device *dev, void *ptr)
 {
 	int i, ret;
 	void *ptr_entry;
 	struct coreboot_device *device;
-	struct coreboot_table_entry entry;
-	struct coreboot_table_header header;
+	struct coreboot_table_entry *entry;
+	struct coreboot_table_header *header;
 
 	ptr_header = ptr;
-	memcpy_fromio(&header, ptr_header, sizeof(header));
+	header = ptr;
 
-	if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
+	if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
 		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
 		return -ENODEV;
 	}
@@ -114,11 +114,11 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 	if (ret)
 		return ret;
 
-	ptr_entry = (void *)ptr_header + header.header_bytes;
-	for (i = 0; i < header.table_entries; i++) {
-		memcpy_fromio(&entry, ptr_entry, sizeof(entry));
+	ptr_entry = ptr_header + header->header_bytes;
+	for (i = 0; i < header->table_entries; i++) {
+		entry = ptr_entry;
 
-		device = kzalloc(sizeof(struct device) + entry.size, GFP_KERNEL);
+		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
 		if (!device) {
 			ret = -ENOMEM;
 			break;
@@ -128,7 +128,7 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy_fromio(&device->entry, ptr_entry, entry.size);
+		memcpy(&device->entry, ptr_entry, entry->size);
 
 		ret = device_register(&device->dev);
 		if (ret) {
@@ -136,12 +136,12 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 			break;
 		}
 
-		ptr_entry += entry.size;
+		ptr_entry += entry->size;
 	}
 
 	if (ret) {
 		bus_unregister(&coreboot_bus_type);
-		iounmap(ptr);
+		memunmap(ptr);
 	}
 
 	return ret;
@@ -149,11 +149,10 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 static int coreboot_table_probe(struct platform_device *pdev)
 {
-	phys_addr_t phyaddr;
 	resource_size_t len;
-	struct coreboot_table_header __iomem *header = NULL;
+	struct coreboot_table_header *header;
 	struct resource *res;
-	void __iomem *ptr = NULL;
+	void *ptr;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -163,14 +162,13 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	if (!res->start || !len)
 		return -EINVAL;
 
-	phyaddr = res->start;
-	header = ioremap_cache(phyaddr, sizeof(*header));
+	header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
 	if (header == NULL)
 		return -ENOMEM;
 
-	ptr = ioremap_cache(phyaddr,
-			    header->header_bytes + header->table_bytes);
-	iounmap(header);
+	ptr = memremap(res->start, header->header_bytes + header->table_bytes,
+		       MEMREMAP_WB);
+	memunmap(header);
 	if (!ptr)
 		return -ENOMEM;
 
@@ -181,7 +179,7 @@ static int coreboot_table_remove(struct platform_device *pdev)
 {
 	if (ptr_header) {
 		bus_unregister(&coreboot_bus_type);
-		iounmap(ptr_header);
+		memunmap(ptr_header);
 		ptr_header = NULL;
 	}
 
-- 
Sent by a computer through tubes

