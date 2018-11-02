Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA2ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1022081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1022081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKBNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 09:51:48 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:36762 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbeKBNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 09:51:47 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 676D92D7D10B405E27D6;
        Fri,  2 Nov 2018 12:45:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA24jlHi095619;
        Fri, 2 Nov 2018 12:45:47 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110212462419-8146625 ;
          Fri, 2 Nov 2018 12:46:24 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V6 2/8]  misc/pvpanic: simplify the code using acpi_dev_resource_io
Date:   Fri, 2 Nov 2018 20:56:11 +0800
Message-Id: <1541163378-54047-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-02 12:46:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-02 12:45:31,
        Serialize complete at 2018-11-02 12:45:31
X-MAIL: mse01.zte.com.cn wA24jlHi095619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_dev_resource_io API.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index fd86dab..49c59e1 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -77,17 +77,14 @@
 static acpi_status
 pvpanic_walk_resources(struct acpi_resource *res, void *context)
 {
-	switch (res->type) {
-	case ACPI_RESOURCE_TYPE_END_TAG:
-		return AE_OK;
+	struct resource r;
 
-	case ACPI_RESOURCE_TYPE_IO:
-		port = res->data.io.minimum;
+	if (acpi_dev_resource_io(res, &r)) {
+		port = r.start;
 		return AE_OK;
-
-	default:
-		return AE_ERROR;
 	}
+
+	return AE_ERROR;
 }
 
 static int pvpanic_add(struct acpi_device *device)
-- 
1.8.3.1

