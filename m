Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACC3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913A9219EA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDQXsGOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913A9219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeGDRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:31:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39741 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGDRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:31:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so3155625pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jfRnqiYEcWW5d/OP8TNg85XH5b2fSkjSPtC0IX2va5A=;
        b=BDQXsGOfXb9rdN7rugmNmU+mybqowxwDE2a5TveNqAqx8e6NutqKWVmA6wmtGJUt3m
         WUzIWaW8LdZSH2huPMFjGKI/ogEwMd37astVcrzlpTwY+UAFrkI8SriPbLYqt/JFzWng
         b0JTCmOkAlR5tirnsDJCWz1fAMxVp5VkPkML0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jfRnqiYEcWW5d/OP8TNg85XH5b2fSkjSPtC0IX2va5A=;
        b=iG097rT1tC8sFD4PWLbGa3C0LRNgsH78wfmWqaXKJYzzFpIQRTDtlthvawHzCSuvkg
         PZDLMB9i0d07UKGq5wj+MQ+WZHDHJucfEgmJAQ34j7kRPoxRfQwv32/wPBpscldlNO0M
         DOrB5ZWAfkY91QXZhJ+wC9QyVOqcvxPef7fEqnuRbQ9MYbCBfu39013ySCc1v8DtOdrL
         CnpRUFW0Em7+kTK98tBzM+fdy4VOVaUIpSY6GW4JjCSWVGD9B5tD9ItrkWrE7zjcEHPy
         N2Bxnibsvk0ifqd5s0F/QGl6wSDYFIxIDQJfu4r4F0dnBw273ExtWK3G2ph9ujUXyEB6
         a7sQ==
X-Gm-Message-State: APt69E2zZQ2UTPf6LlBbgO5o6tVCQJ+Ti9lV6KO93OiQYo2QbYWM7XUU
        dhTkNF6WUwu96UCrFglV2WpNvg==
X-Google-Smtp-Source: AAOMgpeuVvhNNQoTXaQmVCNH6yv/oxH1jC2RxnOjelzWK/r6i6ydr6ONS+sIaX+Xx+Sz6RCVgBO3Sw==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr3048193pff.211.1530725487605;
        Wed, 04 Jul 2018 10:31:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm3470926pfi.17.2018.07.04.10.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:31:26 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:31:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/gasket: Use 2-factor allocator calls
Message-ID: <20180704173125.GA34354@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done treewide, switch from open-coded multiplication to using
2-factor allocator helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/gasket/gasket_core.c       |  6 +++---
 drivers/staging/gasket/gasket_interrupt.c  | 15 +++++++++------
 drivers/staging/gasket/gasket_page_table.c |  6 +++---
 drivers/staging/gasket/gasket_sysfs.c      | 12 ++++++------
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 6511a33eb658..82b3eca7774e 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1697,9 +1697,9 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 			return -EPERM;
 		}
 		num_map_regions = bar_desc->num_mappable_regions;
-		map_regions = kzalloc(
-			num_map_regions * sizeof(*bar_desc->mappable_regions),
-			GFP_KERNEL);
+		map_regions = kcalloc(num_map_regions,
+				      sizeof(*bar_desc->mappable_regions),
+				      GFP_KERNEL);
 		if (map_regions) {
 			memcpy(map_regions, bar_desc->mappable_regions,
 			       num_map_regions *
diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index b74eefe41d72..1fd7bee5db2f 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -136,23 +136,26 @@ int gasket_interrupt_init(
 	interrupt_data->wire_interrupt_offsets = wire_int_offsets;
 
 	/* Allocate all dynamic structures. */
-	interrupt_data->msix_entries = kzalloc(
-		sizeof(struct msix_entry) * num_interrupts, GFP_KERNEL);
+	interrupt_data->msix_entries = kcalloc(num_interrupts,
+					       sizeof(struct msix_entry),
+					       GFP_KERNEL);
 	if (!interrupt_data->msix_entries) {
 		kfree(interrupt_data);
 		return -ENOMEM;
 	}
 
-	interrupt_data->eventfd_ctxs = kzalloc(
-		sizeof(struct eventfd_ctx *) * num_interrupts, GFP_KERNEL);
+	interrupt_data->eventfd_ctxs = kcalloc(num_interrupts,
+					       sizeof(struct eventfd_ctx *),
+					       GFP_KERNEL);
 	if (!interrupt_data->eventfd_ctxs) {
 		kfree(interrupt_data->msix_entries);
 		kfree(interrupt_data);
 		return -ENOMEM;
 	}
 
-	interrupt_data->interrupt_counts = kzalloc(
-		sizeof(ulong) * num_interrupts, GFP_KERNEL);
+	interrupt_data->interrupt_counts = kcalloc(num_interrupts,
+						   sizeof(ulong),
+						   GFP_KERNEL);
 	if (!interrupt_data->interrupt_counts) {
 		kfree(interrupt_data->eventfd_ctxs);
 		kfree(interrupt_data->msix_entries);
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 6dc10508b15e..c5390a860f86 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1674,9 +1674,9 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	gasket_dev->page_table[index]->num_coherent_pages = num_pages;
 
 	/* allocate the physical memory block */
-	gasket_dev->page_table[index]->coherent_pages = kzalloc(
-		num_pages * sizeof(struct gasket_coherent_page_entry),
-		GFP_KERNEL);
+	gasket_dev->page_table[index]->coherent_pages =
+		kcalloc(num_pages, sizeof(struct gasket_coherent_page_entry),
+			GFP_KERNEL);
 	if (!gasket_dev->page_table[index]->coherent_pages)
 		goto nomem;
 	*dma_address = 0;
diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index d45098c90b4b..40268fb50fc3 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -137,9 +137,9 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 		device = mapping->device;
 		legacy_device = mapping->legacy_device;
 		num_files_to_remove = mapping->attribute_count;
-		files_to_remove = kzalloc(
-			num_files_to_remove * sizeof(*files_to_remove),
-			GFP_KERNEL);
+		files_to_remove = kcalloc(num_files_to_remove,
+					  sizeof(*files_to_remove),
+					  GFP_KERNEL);
 		for (i = 0; i < num_files_to_remove; i++)
 			files_to_remove[i] = mapping->attributes[i].attr;
 
@@ -238,9 +238,9 @@ int gasket_sysfs_create_mapping(
 	kref_init(&mapping->refcount);
 	mapping->device = device;
 	mapping->gasket_dev = gasket_dev;
-	mapping->attributes = kzalloc(
-		GASKET_SYSFS_MAX_NODES * sizeof(*mapping->attributes),
-		GFP_KERNEL);
+	mapping->attributes = kcalloc(GASKET_SYSFS_MAX_NODES,
+				      sizeof(*mapping->attributes),
+				      GFP_KERNEL);
 	mapping->attribute_count = 0;
 	if (!mapping->attributes) {
 		gasket_nodev_error("Unable to allocate sysfs attribute array.");
-- 
2.17.1


-- 
Kees Cook
Pixel Security
