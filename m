Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64356C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351AD2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351AD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKAQBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:01:38 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:18376 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbeKAQBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:01:36 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 6172BE2B6D92EC3E3430;
        Thu,  1 Nov 2018 14:59:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA16xdf3022486;
        Thu, 1 Nov 2018 14:59:39 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110115000954-7973453 ;
          Thu, 1 Nov 2018 15:00:09 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 6/8]  misc/pvpanic: add MMIO support
Date:   Thu, 1 Nov 2018 23:10:00 +0800
Message-Id: <1541085002-42993-6-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-01 15:00:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-01 14:59:27,
        Serialize complete at 2018-11-01 14:59:27
X-MAIL: mse01.zte.com.cn wA16xdf3022486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (e.g. arm64), it's preferable to use MMIO, since
this can be used standalone. Add MMIO support to the pvpanic driver.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index c20fdff..c0b787e 100644
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
@@ -66,8 +66,14 @@
 {
 	struct resource r;
 
-	if (acpi_dev_resource_io(res, &r) {
-		port = r.start;
+	if (acpi_dev_resource_io(res, &r) ||
+	    acpi_dev_resource_memory(res, &r)) {
+		if (r.flags & IORESOURCE_IO)
+			base = (void __iomem *) ioport_map(r.start,
+						r.end - r.start + 1);
+		else
+			base = ioremap(r.start, r.end - r.start + 1);
+
 		return AE_OK;
 	}
 
@@ -89,7 +95,7 @@ static int pvpanic_add(struct acpi_device *device)
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    pvpanic_walk_resources, NULL);
 
-	if (!port)
+	if (!base)
 		return -ENODEV;
 
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -103,6 +109,8 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+
+	iounmap(base);
 	return 0;
 }
 
-- 
1.8.3.1

