Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1442C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7B720843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7B720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJ2MIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:08:31 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:60526 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbeJ2MIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:08:31 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7AF6F133DC33D5439C46;
        Mon, 29 Oct 2018 11:21:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9T3LcqR034097;
        Mon, 29 Oct 2018 11:21:38 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102911214205-7293289 ;
          Mon, 29 Oct 2018 11:21:42 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 3/5]  misc/pvpanic: add MMIO support
Date:   Mon, 29 Oct 2018 19:32:21 +0800
Message-Id: <1540812743-1825-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540812743-1825-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540812743-1825-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-29 11:21:42,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-29 11:21:37,
        Serialize complete at 2018-10-29 11:21:37
X-MAIL: mse01.zte.com.cn w9T3LcqR034097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (e.g. arm64), it's preferable to use MMIO, since
this can be used standalone. Add MMIO support to the pvpanic driver.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 9450376..cfd7fef 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -28,7 +28,7 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 
-static u16 port;
+static void __iomem *base;
 
 static struct acpi_driver pvpanic_driver = {
 	.name =		"pvpanic",
@@ -44,7 +44,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	outb(event, port);
+	iowrite8(event, base);
 }
 
 static int
@@ -64,12 +64,19 @@
 static acpi_status
 pvpanic_walk_resources(struct acpi_resource *res, void *context)
 {
+	struct acpi_resource_fixed_memory32 *fixmem32;
+
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
 
 	case ACPI_RESOURCE_TYPE_IO:
-		port = res->data.io.minimum;
+		base = (void __iomem *) ioport_map(res->data.io.minimum, 1);
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+		fixmem32 = &res->data.fixed_memory32;
+		base = ioremap(fixmem32->address, fixmem32->address_length);
 		return AE_OK;
 
 	default:
@@ -91,7 +98,7 @@ static int pvpanic_add(struct acpi_device *device)
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    pvpanic_walk_resources, NULL);
 
-	if (!port)
+	if (!base)
 		return -ENODEV;
 
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -105,6 +112,9 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+
+	iounmap(base);
+
 	return 0;
 }
 
-- 
1.8.3.1

