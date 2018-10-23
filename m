Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25945207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25945207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJWRhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:37:17 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:53006 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbeJWRhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:37:17 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0ED89DD12B987962E2AD;
        Tue, 23 Oct 2018 17:14:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9N9EcPq003196;
        Tue, 23 Oct 2018 17:14:38 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102317145337-6239517 ;
          Tue, 23 Oct 2018 17:14:53 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH 2/4]  pvpanic: add pvpanic support for arm64
Date:   Wed, 24 Oct 2018 01:25:35 +0800
Message-Id: <1540315537-70007-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540315537-70007-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540315537-70007-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-23 17:14:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-23 17:14:34,
        Serialize complete at 2018-10-23 17:14:34
X-MAIL: mse01.zte.com.cn w9N9EcPq003196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pvpanic device is a qemu-specific emulation device. Pvpanic
devices are now available for ARM64. This patch supports the APCI
way to get device information.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 22 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index fd86dab..bdcff8b 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -35,13 +35,16 @@
 
 static const struct acpi_device_id pvpanic_device_ids[] = {
 	{ "QEMU0001", 0 },
+	{ "PVPANIC01", 0 },
 	{ "", 0 },
 };
 MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
 
 #define PVPANIC_PANICKED	(1 << 0)
 
+
+static void __iomem *base;
 
 static struct acpi_driver pvpanic_driver = {
 	.name =		"pvpanic",
@@ -57,7 +60,10 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	outb(event, port);
+	if (port)
+		outb(event, port);
+	else if (base)
+		writeb(event, base);
 }
 
 static int
@@ -77,6 +83,8 @@
 static acpi_status
 pvpanic_walk_resources(struct acpi_resource *res, void *context)
 {
+	struct acpi_resource_fixed_memory32 *fixmem32;
+
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
@@ -84,7 +92,11 @@
 	case ACPI_RESOURCE_TYPE_IO:
 		port = res->data.io.minimum;
 		return AE_OK;
-
+
+	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+		fixmem32 = &res->data.fixed_memory32;
+		base = ioremap(fixmem32->address, fixmem32->address_length);
+		return AE_OK;
 	default:
 		return AE_ERROR;
 	}
@@ -104,7 +116,7 @@ static int pvpanic_add(struct acpi_device *device)
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    pvpanic_walk_resources, NULL);
 
-	if (!port)
+	if (!port && !base)
 		return -ENODEV;
 
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -118,6 +130,8 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+	if (base)
+		iounmap(base);
 	return 0;
 }
 
-- 
1.8.3.1

