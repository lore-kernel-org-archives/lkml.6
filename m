Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455DECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4352082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4352082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeKELsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:48:50 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:60894 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeKELsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:48:50 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BD1D5A0EF0C0DC1B0CB3;
        Mon,  5 Nov 2018 10:30:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA52UCNK028274;
        Mon, 5 Nov 2018 10:30:12 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110510301641-8592985 ;
          Mon, 5 Nov 2018 10:30:16 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V7 3/9]  misc/pvpanic: add MMIO support
Date:   Mon, 5 Nov 2018 18:40:25 +0800
Message-Id: <1541414431-84128-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-05 10:30:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-05 10:30:12,
        Serialize complete at 2018-11-05 10:30:12
X-MAIL: mse01.zte.com.cn wA52UCNK028274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (e.g. arm64), it's preferable to use MMIO, since
this can be used standalone. Add MMIO support to the pvpanic driver.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
[Use acpi_dev_resource_memory API. - Andy] 
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 49c59e1..22fb487 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -41,7 +41,7 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 
-static u16 port;
+static void __iomem *base;
 
 static struct acpi_driver pvpanic_driver = {
 	.name =		"pvpanic",
@@ -57,7 +57,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	outb(event, port);
+	 iowrite8(event, base);
 }
 
 static int
@@ -80,7 +80,11 @@
 	struct resource r;
 
 	if (acpi_dev_resource_io(res, &r)) {
-		port = r.start;
+		base = (void __iomem *) ioport_map(r.start,
+					r.end - r.start + 1);
+		return AE_OK;
+	} else if (acpi_dev_resource_memory(res, &r)) {
+		base = ioremap(r.start, r.end - r.start + 1);
 		return AE_OK;
 	}
 
@@ -101,7 +105,7 @@ static int pvpanic_add(struct acpi_device *device)
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    pvpanic_walk_resources, NULL);
 
-	if (!port)
+	if (!base)
 		return -ENODEV;
 
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -115,6 +119,8 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+	iounmap(base);
+
 	return 0;
 }
 
-- 
1.8.3.1

