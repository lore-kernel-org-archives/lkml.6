Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D3C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617CC21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hg3WyTlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617CC21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHOXbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:31:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34283 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeHOXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:31:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so1002799pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFKDdbqmiRiSCZgXCs4iRCh+1CSma0t7w9bm3+NWiVw=;
        b=hg3WyTlJfwyWVdsXJNnR5A9G3G6WkrwKzIgL3T1/RszkslopfwRnn3LIaveRC7caee
         UY8ZtxI5FWX0INbO+xiB2rlDCLCHq+QSQKrztPlOiH/UlXwd0wFVLVxtfpW2AFP5+z1/
         WcXr3Mwei+9mq0q3CY7ADdsXbznTAi10fs1uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFKDdbqmiRiSCZgXCs4iRCh+1CSma0t7w9bm3+NWiVw=;
        b=ETX8gD2+wzUyECGTYt85dJXJf1hDD/F40Wmxe2/TM8ldY00dgCwusX+Ybt5RFBEh7d
         sKw+r8F8LXoBKQ1GwAwoHSWLCLyJCcJLi0MYunIFVBW28IP1bqQfBlcUoUvNSjY2WvVL
         C1iHAvDKgsrg8AFVE399o28TE8KDSxZyhbdTPd5O3olVSiYBfHRZBAKG/J+w62VD0eku
         XlxciE+oqtyJ4kFcSE7KUPScE5wouF6FH82jHXpbZXnbUgGk/F7Ew6RT1s2iiDh6KQHA
         f14D+RxRK/rhuxfcj/3AjKru5+LmE8g4p0ufNA9hYXZDTZJ5rh28qFcIXPSjahCPibQJ
         ffxA==
X-Gm-Message-State: AOUpUlEj10XO0ZfKPIvvB0mV4PDCHMnGfWF1i0OQIl38PiP776tUrWgg
        dkfH8yPsbs+Kmnl1d97UsxwBYQ==
X-Google-Smtp-Source: AA+uWPxS+buvWU8UslMUZmPaKhl1tCTl8khVjKVYNxbduYkqPYgzVuE01Yfg8AauNOeOWkMmHwRaSA==
X-Received: by 2002:a63:ff21:: with SMTP id k33-v6mr25839724pgi.38.1534365436287;
        Wed, 15 Aug 2018 13:37:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 5/6] firmware: coreboot: Remap RAM with memremap() instead of ioremap()
Date:   Wed, 15 Aug 2018 13:37:07 -0700
Message-Id: <20180815203708.67090-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
References: <20180815203708.67090-1-swboyd@chromium.org>
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
 drivers/firmware/google/coreboot_table.c | 40 +++++++++++-------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index e9cd4da61404..2c6c35f0da32 100644
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
 		ret = -ENODEV;
 		goto out;
@@ -115,11 +115,11 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 	if (ret)
 		goto out;
 
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
@@ -129,7 +129,7 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy_fromio(&device->entry, ptr_entry, entry.size);
+		memcpy(&device->entry, ptr_entry, entry->size);
 
 		ret = device_register(&device->dev);
 		if (ret) {
@@ -137,24 +137,23 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 			break;
 		}
 
-		ptr_entry += entry.size;
+		ptr_entry += entry->size;
 	}
 
 	if (ret)
 		bus_unregister(&coreboot_bus_type);
 
 out:
-	iounmap(ptr);
+	memunmap(ptr);
 	return ret;
 }
 
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
@@ -164,14 +163,13 @@ static int coreboot_table_probe(struct platform_device *pdev)
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
 
-- 
Sent by a computer through tubes

